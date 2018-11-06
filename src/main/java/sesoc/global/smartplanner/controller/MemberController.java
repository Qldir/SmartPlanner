package sesoc.global.smartplanner.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import sesoc.global.smartplanner.dao.MemberRepository;
import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.util.FileService;

@Controller
public class MemberController {

	@Autowired
	MemberRepository repository;

	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	private OAuth2Operations oauthOperations;

	
	@RequestMapping(value = "/join", method = { RequestMethod.GET, RequestMethod.POST })
	public String join(HttpServletResponse response, Model model) {

		oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		System.out.println("/googleLogin, url : " + url);
		model.addAttribute("google_url", url);

		return "redirect:" + url;
	}
	
	// 회원 가입 페이지
	@RequestMapping(value = "/googleSignInCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String doSessionAssignActionPage(HttpServletRequest request, Model model,HttpSession httpSession) throws Exception {

		String code = request.getParameter("code");

		oauthOperations = googleConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
				null);

		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();

		if (expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
			System.out.printf("accessToken is expired. refresh token = {}", accessToken);

		}

		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
		Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
		System.out.println(connection);

		PlusOperations plusOperations = google.plusOperations();
		Person profile = plusOperations.getGoogleProfile();

		System.out.println("User Uid : " + profile.getId());
		System.out.println("User Name : " + profile.getDisplayName());
		System.out.println("User Email : " + profile.getAccountEmail());
		System.out.println("User Profile : " + profile.getImageUrl());

		// Access Token 취소
		try {
			System.out.println("Closing Token....");
			String revokeUrl = "https://accounts.google.com/o/oauth2/revoke?token=" + accessToken + "";
			URL url = new URL(revokeUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

		} catch (Exception e) {

			e.printStackTrace();
		}

		MemberVO member = new MemberVO();

		String member_email = profile.getAccountEmail();
		String member_name = profile.getDisplayName();

		System.out.println(member_email);
		System.out.println(member_name);

		member.setMember_email(member_email);
		member.setMember_name(member_name);

		MemberVO real = repository.selectOne(member);

		if (real != null) {
			System.out.println("이미 가입 된 아이디입니다." + real);
			
			
			httpSession.setAttribute("member_seq", real.getMember_seq());
			httpSession.setAttribute("member_email", real.getMember_email());
			httpSession.setAttribute("member_name", real.getMember_name());
						
			
			System.out.println("구글 로그인 ");
			
			return "redirect:/";
			
		} else {

			member.setMember_pw("0");

			int insertResult = repository.insert(member);
			System.out.println("구글 가입 완료??" + insertResult);

		}
		System.out.println(member.getMember_seq());
		httpSession.setAttribute("member_seq", member.getMember_seq());
		httpSession.setAttribute("member_email", member.getMember_email());
		httpSession.setAttribute("member_name", member.getMember_name());
				
		
		return "redirect:/";

	}


	@RequestMapping(value = "/GotoSignup", method = RequestMethod.GET)
	public String GoTosignUp() {

		return "SignupForm";
	}

	@RequestMapping(value = "/GotoGoogle", method = RequestMethod.GET)
	public String GotoGoogle() {

		return "google";
	}
	
	@RequestMapping(value = "/GotoFindingNum", method = RequestMethod.GET)
	public String GoTofindingNum() {

		return "findingNum";
	}

	@RequestMapping(value = "/GotoLogin", method = RequestMethod.GET)
	public String GotologIn() {

		return "login";
	}

	@RequestMapping(value = "/loginNavbar", method = RequestMethod.POST)
	public String loginNavbar(MemberVO member, HttpSession httpSession) {
		System.out.println("1");

		System.out.println("로그인 진입" + member);

		MemberVO result = repository.selectOne(member);

		System.out.println("로그인 레퍼까지 끝난거" + result);

		httpSession.setAttribute("member_seq", result.getMember_seq());
		httpSession.setAttribute("member_email", result.getMember_email());
		httpSession.setAttribute("member_name", result.getMember_name());
		httpSession.setAttribute("member_type", result.getMember_type());

		return "redirect:/";
	}

	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public String Login(MemberVO member, HttpSession httpSession) {

		System.out.println("로그인 진입");

		member = repository.get(member);

		httpSession.setAttribute("member_seq", member.getMember_seq());
		httpSession.setAttribute("member_email", member.getMember_email());
		httpSession.setAttribute("member_name", member.getMember_name());
		httpSession.setAttribute("member_type", member.getMember_type());

		return "redirect:/";
	}

	@RequestMapping(value = "/loginForm", method = RequestMethod.POST)
	public String logInForm(MemberVO member, HttpSession http) {

		System.out.println("회원가입" + member);

		member.setMember_email(member.getMember_email());
		member.setMember_pw(member.getMember_pw());

		System.out.println("1" + member);

		int result = repository.insert(member);

		System.out.println("로그인 레퍼까지 끝난거" + result);

		return "redirect:/";
	}

	@RequestMapping(value = "/Loginchecking", method = RequestMethod.POST)
	public @ResponseBody int loginForm(@RequestBody MemberVO member) {
		System.out.println("로그인 체크");

		System.out.println("로그인 체크 객체 확인" + member);
		System.out.println("로그인 검사" + member);
		MemberVO result = repository.get(member);
		System.out.println("로그인 체크 결과" + result);

		if (result != null) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping(value = "/duplicateChecking", method = RequestMethod.POST)
	public @ResponseBody int duplicateChecking(MemberVO member, HttpSession http) {

		System.out.println("이메일 검사" + member);

		MemberVO result1 = repository.get(member);

		System.out.println("닉네임 결과" + result1);

		if (result1 != null) {
			return 1;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "/checking", method = RequestMethod.POST)
	public @ResponseBody int checking(MemberVO member) {

		System.out.println("닉네임 검사" + member);

		int result1 = repository.checking(member);

		System.out.println("닉네임 결과" + result1);

		if (result1 != 0) {
			return 1;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "/updatingchecking", method = RequestMethod.POST)
	public @ResponseBody int checkingUpdating(String member_pw, HttpSession http) {

		System.out.println("비밀번호 들어갑니다.");

		System.out.println(member_pw);

		String userid = (String) http.getAttribute("member_email");

		System.out.println("유저아이디" + userid);

		MemberVO member = new MemberVO();

		member.setMember_email(userid);
		member.setMember_pw(member_pw);

		System.out.println(member);

		MemberVO result = repository.get(member);
		System.out.println("레퍼에서 받은 값" + result);

		if (result != null) {
			return 1;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "/GotoLogout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logOut(HttpSession http) {
		http.invalidate();
		System.out.println("로그아웃");
		return "redirect:/";
	}

	@RequestMapping(value = "/GotoSession", method = RequestMethod.POST)
	public @ResponseBody int GotoSession(HttpSession httpSession, String member_pw) {
		System.out.println("탈퇴시작");

		String member_invaild = "1";
		String member_img = "default.png";

		String userid = (String) httpSession.getAttribute("member_email");

		MemberVO newmember = new MemberVO();

		newmember.setMember_email(userid);
		newmember.setMember_pw(member_pw);

		System.out.println(newmember);

		newmember = repository.selectOne(newmember);

		newmember = repository.reWrite(newmember);

		newmember.setMember_invaild(member_invaild);
		newmember.setMember_img(member_img);

		int resul = repository.deleteUpdate(newmember);
		System.out.println("탈퇴");

		httpSession.invalidate();

		return resul;
	}

	@RequestMapping(value = "/myinfomation", method = RequestMethod.GET)
	public String Memberupdate(HttpSession httpSession, Model model) {

		System.out.println("수정 들어갑니다.");

		String userEmail = (String) httpSession.getAttribute("member_email");

		System.out.println("이메일" + userEmail);

		MemberVO member = new MemberVO();

		member.setMember_email(userEmail);

		MemberVO result = repository.selectOne(member);

		System.out.println("셀렉 거친곳" + result);

		if (result.getMember_pw().equals("0")) {

			String inform = "구글 계정은 비밀 번호를 변경할 수 없습니다.";

			System.out.println("알림글" + inform);

			model.addAttribute("MSG", inform);

		}

		model.addAttribute("Member", result);

		return "myinfo";
	}

	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	public String MemberModify(HttpSession http, HttpServletRequest request, String member_seq, MemberVO member,
			String member_email, Model model, MultipartFile fileUpload, String member_name) {

		System.out.println("수정폼에 정보가 잘 들어 갔나?" + member);
		System.out.println(fileUpload);

		MemberVO newMember = new MemberVO();
		newMember.setMember_seq(member_seq);
		newMember.setMember_name(member_name);

		newMember = repository.reWrite(newMember);

		System.out.println("레퍼에서 받아온 결과" + newMember);

		newMember.setMember_name(member.getMember_name());

		String UPLADPATH = request.getSession().getServletContext().getRealPath("");
		String UPLADPATH2 = request.getSession().getServletContext().getRealPath("/resources/img/profile/");

		System.out.println("오리지날" + UPLADPATH);
		System.out.println("오리지날+두번째거 " + UPLADPATH2);

		newMember.setMember_pw(member.getMember_pw());

		System.out.println(newMember);
		if (!fileUpload.isEmpty()) {
			String savedfile = FileService.saveFile(fileUpload, UPLADPATH2);
			newMember.setMember_img(savedfile);
		}

		int result = repository.update(newMember);

		System.out.println("수정완료" + result);
		
		http.setAttribute("member_name", newMember.getMember_name());

		return "redirect:/";
	}

	@RequestMapping(value = "/GoogleJoin", method = RequestMethod.POST)
	public @ResponseBody MemberVO login(@RequestBody MemberVO member, HttpSession httpSession) {

		System.out.println(member);

		System.out.println("로그인 자료가 들어갔습니다." + member.getMember_email() + member.getMember_name());

		MemberVO real = repository.selectOne(member);

		if (real != null) {
			System.out.println("이미 가입 된 아이디입니다." + real);

		} else {

			member.setMember_name(member.getMember_name());
			member.setMember_email(member.getMember_email());
			member.setMember_pw("0");

			int insertResult = repository.insert(member);
			System.out.println("구글 가입 완료??" + insertResult);

		}
		httpSession.setAttribute("member_email", member.getMember_email());
		httpSession.setAttribute("member_name", member.getMember_name());
		httpSession.setAttribute("user_name", member.getMember_name());

		return member;
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public @ResponseBody boolean ajaxSignUp(MemberVO member) {

		int result = repository.insert(member);
		if (result == 1) {
			return true;
		} else {
			return false;
		}
	}

}