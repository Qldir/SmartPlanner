package sesoc.global.smartplanner.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.net.SyslogAppender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import sesoc.global.smartplanner.dao.BoardRepository;
import sesoc.global.smartplanner.dao.FavoriteRepository;
import sesoc.global.smartplanner.dao.MemberRepository;
import sesoc.global.smartplanner.dao.PlaceRepository;
import sesoc.global.smartplanner.dao.PlanRepository;
import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.BoardVO;
import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.PlanVO;
import sesoc.global.smartplanner.dto.RouteInfoDTO;
import sesoc.global.smartplanner.util.GoogleDirection;
import sesoc.global.smartplanner.util.PageNavigator;
import sesoc.global.smartplanner.util.RouteSearcher;

@Controller
public class HomeController {

	@Autowired
	PlaceRepository repository;
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	PlanRepository planRepository;
	@Autowired 
	MemberRepository memberRepository;
	@Autowired 
	FavoriteRepository favoriteRepository;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		
		ArrayList<PlaceVO> placeList = repository.getByGrade(null, new RowBounds(0, 6));
		for (int i = 0; i < placeList.size(); i++) {
			placeList.get(i).parseImgAddress();
			placeList.get(i).parseDetail();
		}
		Gson gson = new Gson();
		String result = gson.toJson(placeList);
		
		int placeTotal = repository.getTotal(null);
		
		model.addAttribute("placeList", result);
		model.addAttribute("placeTotal", placeTotal);
		
		ArrayList<BoardDTO> boardList = boardRepository.selectAllOrderByFavorite(new RowBounds(0, 6));
		String boardResult = gson.toJson(boardList);
		
		int boardTotal = boardRepository.getTotal(null);
		
		model.addAttribute("boardList", boardResult);
		model.addAttribute("boardTotal", boardTotal);
		
		return "index";
	}

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String myPage(HttpSession httpSession, Model model) {

		String member_seq = (String) httpSession.getAttribute("member_seq");

		MemberVO member = new MemberVO();
		member.setMember_seq(member_seq);

		MemberVO resultMember = memberRepository.get(member);

		int totalPlan=planRepository.getMyPlanTotal(member);
		ArrayList<PlanVO> planList=planRepository.getMyPlan(member, new RowBounds(0,3));
		
		model.addAttribute("member_img", resultMember.getMember_img());
		model.addAttribute("totalPlan", totalPlan);
		
		Gson gson = new Gson();
		String planListJson = gson.toJson(planList);
		model.addAttribute("planList", planListJson);
		
		ArrayList<BoardDTO> favoriteList=favoriteRepository.getMyFavorite(member_seq, new RowBounds(0,3));
		int totalFavorite = favoriteRepository.getMyFavoriteTotal(member_seq);
		
		model.addAttribute("totalFavorite", totalFavorite);
		
		String favoriteListJson = gson.toJson(favoriteList);
		
		model.addAttribute("favoriteList", favoriteListJson);
		
		return "mypage";
	}
	
	@RequestMapping(value = "/myplan", method = RequestMethod.GET)
	public String myPlan(@RequestParam(value="page", required=false, defaultValue="0") int currentPage,HttpSession httpSession, Model model) {
		
		
		MemberVO member = new MemberVO(); 
		member.setMember_seq((String)httpSession.getAttribute("member_seq"));
		
		// �럹�씠吏��꽕�씠�뀡
		int countPerPage=6;
		int pagePerGroup=5;
		int totalRecordsCount=planRepository.getMyPlanTotal(member);
		System.out.println(totalRecordsCount);
				
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		
		ArrayList<PlanVO> planList=planRepository.getMyPlan(member, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));
		
		Gson gson = new Gson();
		String result=gson.toJson(planList);
		
		model.addAttribute("planList", result);
		model.addAttribute("currentPage", navi.getCurrentPage());
		model.addAttribute("startPageGroup", navi.getStartPageGroup());
		model.addAttribute("endPageGroup", navi.getEndPageGroup());
		model.addAttribute("totalRecordsCount", navi.getTotalRecordsCount());
		model.addAttribute("totalPageCount", navi.getTotalPageCount());
		model.addAttribute("currentGroup", navi.getCurrentGroup());
		
		return "myplan";
	}
	
	@RequestMapping(value = "/myfavorite", method = RequestMethod.GET)
	public String myFavorite(@RequestParam(value="page", required=false, defaultValue="0") int currentPage,HttpSession httpSession, Model model) {

		String member_seq=(String)httpSession.getAttribute("member_seq");
		
		// 페이지네이션
		int countPerPage=6;
		int pagePerGroup=5;
		int totalRecordsCount=favoriteRepository.getMyFavoriteTotal(member_seq);
				
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		
		ArrayList<BoardDTO> favoriteList=favoriteRepository.getMyFavorite(member_seq, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));
		
		Gson gson = new Gson();
		String result=gson.toJson(favoriteList);
		
		model.addAttribute("favoriteList", result);
		model.addAttribute("currentPage", navi.getCurrentPage());
		model.addAttribute("startPageGroup", navi.getStartPageGroup());
		model.addAttribute("endPageGroup", navi.getEndPageGroup());
		model.addAttribute("totalRecordsCount", navi.getTotalRecordsCount());
		model.addAttribute("totalPageCount", navi.getTotalPageCount());
		model.addAttribute("currentGroup", navi.getCurrentGroup());
		
		return "myfavorite";
	}
	
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public void myInfo() {
	}

	@RequestMapping(value = "/planning", method = RequestMethod.GET)
	public String planning() {
		return "plan";
	}
	
	@RequestMapping(value = "/planbyquestion", method=RequestMethod.GET)
	public String planningByQuestion() {
		return "planbyquestion";
	}
	
	@RequestMapping(value = "/planbytheme", method=RequestMethod.GET)
	public String planningByTheme() {
		return "planbytheme";
	}
	
	@RequestMapping(value = "/planbyselectbefore", method=RequestMethod.GET)
	public String planningBySelectBefore() {
		return "planbyselectbefore";
	}
	
	@RequestMapping(value = "/planboard", method = RequestMethod.GET)
	public String planBoard(@RequestParam(value="page", required=false, defaultValue="0") int currentPage, Model model) {
		
		BoardVO vo = new BoardVO();
		
		// �럹�씠吏��꽕�씠�뀡
		int countPerPage=6;
		int pagePerGroup=5;
		int totalRecordsCount=boardRepository.getTotal(vo);
		System.out.println(totalRecordsCount);
						
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
				
		ArrayList<BoardDTO> boardList=boardRepository.selectAll(new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));
		
		Gson gson = new Gson();
		String result = gson.toJson(boardList);
		
		model.addAttribute("boardList", result);
		model.addAttribute("currentPage", navi.getCurrentPage());
		model.addAttribute("startPageGroup", navi.getStartPageGroup());
		model.addAttribute("endPageGroup", navi.getEndPageGroup());
		model.addAttribute("totalRecordsCount", navi.getTotalRecordsCount());
		model.addAttribute("totalPageCount", navi.getTotalPageCount());
		model.addAttribute("currentGroup", navi.getCurrentGroup());
		
		return "planboard";
	}

	@RequestMapping(value = "/howtouse", method = RequestMethod.GET)
	public void howToUse() {
	}

	@RequestMapping(value = "/planboardview", method = RequestMethod.GET)
	public void planboardview() {
	}

	@RequestMapping(value = "/hotel", method = RequestMethod.GET)
	public String hotel() {
		return "hotel";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() {
	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signUp() {
	}

	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public String placeCheck(Model model) {
		ArrayList<PlaceVO> placeList = repository.getAll();
		Gson gson = new Gson();
		String result = gson.toJson(placeList);
		model.addAttribute("placeList", result);
		return "placecheck";
	}

	@RequestMapping(value = "/adminpage", method = RequestMethod.GET)
	public String adminPage() {
		return "adminpage";
	}
	
	@RequestMapping(value = "/plantest", method = RequestMethod.GET)
	public String planningTest() {
		return "planningTest";
	}
}
