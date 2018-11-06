package sesoc.global.smartplanner.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import oracle.net.aso.g;
import sesoc.global.smartplanner.dao.MemberRepository;
import sesoc.global.smartplanner.dao.PlaceGradeRepository;
import sesoc.global.smartplanner.dao.PlaceRepository;
import sesoc.global.smartplanner.dao.PlaceReviewRepository;
import sesoc.global.smartplanner.dto.AdminPlaceDTO;
import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.dto.PlaceDetailDTO;
import sesoc.global.smartplanner.dto.PlaceGradeDTO;
import sesoc.global.smartplanner.dto.PlaceGradeVO;
import sesoc.global.smartplanner.dto.PlacePageVO;
import sesoc.global.smartplanner.dto.PlaceReviewVO;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.util.GoogleGeocoding;
import sesoc.global.smartplanner.util.GooglePlace;
import sesoc.global.smartplanner.util.PageNavigator;

@Controller

public class PlaceController {
	@Autowired
	PlaceRepository placeRepository;
	@Autowired
	PlaceReviewRepository reviewRepository;
	@Autowired
	PlaceGradeRepository gradeRepository;

	@RequestMapping(value = "/detailplace", method = RequestMethod.GET)
	public String detailPlace(String num, Model model) {
		PlaceVO result=placeRepository.getPlace(num);
		result.parseImgAddress();
		model.addAttribute("place",result);
		return "detailplace";
	}
	
	@RequestMapping(value = "/detailplaceinfo", method = RequestMethod.GET)
	public String detailPlaceInfo(String num, Model model) {
		PlaceVO result=placeRepository.getPlace(num);
		result.parseImgAddress();
		model.addAttribute("place",result);
		return "detailplaceinfo";
	}
	
	// 덧글 추가
	@RequestMapping(value="/detailplace/insertcomment",method=RequestMethod.POST)
	public @ResponseBody int insertComment(HttpSession httpSession, PlaceReviewVO placeReview) {
		placeReview.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = reviewRepository.insert(placeReview);
		return result;
	}
	
	// 덧글 삭제
	@RequestMapping(value="/detailplace/deletecomment",method=RequestMethod.POST)
	public @ResponseBody int deleteComment(HttpSession httpSession, PlaceReviewVO placeReview) {
		placeReview.setMember_seq((String) httpSession.getAttribute("member_seq"));
		System.out.println(placeReview);
		int result = reviewRepository.delete(placeReview);	
		return result;
	}
	
	// 덧글 수정
	@RequestMapping(value="/detailplace/updatecomment",method=RequestMethod.POST)
	public @ResponseBody int updateComment(HttpSession httpSession, PlaceReviewVO placeReview) {
		placeReview.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = reviewRepository.update(placeReview);	
		return result;
	}
	
	@RequestMapping(value="/detailplace/getcomment",method=RequestMethod.POST)
	public @ResponseBody PlaceDetailDTO getComment(PlaceReviewVO placeReview, @RequestParam(value="currentPage", required=false, defaultValue="0")int currentPage) {
		PlaceDetailDTO resultDTO = new PlaceDetailDTO();
		
		// 페이지네이션
		int countPerPage=5;
		int pagePerGroup=5;
		int totalRecordsCount=reviewRepository.getTotal(placeReview);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		
		// 리뷰데이터 GET
		ArrayList<PlaceReviewVO> reviewList = reviewRepository.get(placeReview, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));

		// 페이지 DTO에 데이터 셋팅
		resultDTO.setReviewList(reviewList);
		resultDTO.setCurrentPage(navi.getCurrentPage());
		resultDTO.setStartPageGroup(navi.getStartPageGroup());
		resultDTO.setEndPageGroup(navi.getEndPageGroup());
		resultDTO.setTotalRecordsCount(navi.getTotalRecordsCount());
		resultDTO.setTotalPageCount(navi.getTotalPageCount());
		resultDTO.setCurrentGroup(navi.getCurrentGroup());
		
		return resultDTO;
	}
	
	// 평점 추가
	@RequestMapping(value="/detailplace/insertgrade",method=RequestMethod.POST)
	public @ResponseBody int insertGrade(HttpSession httpSession, PlaceGradeVO placeGrade) {
		placeGrade.setMember_seq((String) httpSession.getAttribute("member_seq"));
		String resultGrade = gradeRepository.getUserReview(placeGrade);
		System.out.println(placeGrade);
		System.out.println(resultGrade);
		int result =-1;
		if(resultGrade==null) {
			result = gradeRepository.insert(placeGrade);
		}else {
			result = gradeRepository.update(placeGrade);
		}
		return result;
	}
	
	// 평점 가져오기
	@RequestMapping(value="/detailplace/getgrade",method=RequestMethod.POST)
	public @ResponseBody PlaceGradeDTO getGrade(HttpSession httpSession, String place_seq) {
		PlaceGradeDTO result = new PlaceGradeDTO();
		
		String resultPlace=gradeRepository.get(place_seq);
		result.setPlace_grade(resultPlace);
		
		String member_seq=(String) httpSession.getAttribute("member_seq");
		if(member_seq!=null) {
			PlaceGradeVO placeGrade = new PlaceGradeVO();
			placeGrade.setMember_seq(member_seq);
			placeGrade.setPlace_seq(place_seq);
			
			String resultUser=gradeRepository.getUserReview(placeGrade);
			result.setPlace_grade_user(resultUser);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/placesearch", method = RequestMethod.GET)
	public String placeSearch(@RequestParam(value="keyword", required=false) String keyword, @RequestParam(value="page", required=false, defaultValue="0") int currentPage, Model model) {
		System.out.println(keyword);
		System.out.println(currentPage);
		
		ArrayList<PlaceVO> resultList=null;
		
		PlaceVO keywordVO = new PlaceVO();
		keywordVO.setPlace_name(keyword);
		
		// 페이지네이션
		int countPerPage=6;
		int pagePerGroup=5;
		int totalRecordsCount=placeRepository.getTotal(keywordVO);
		System.out.println(totalRecordsCount);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		
		
		resultList=placeRepository.getByGrade(keywordVO, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));
		
		for (int i = 0; i < resultList.size(); i++) {
			resultList.get(i).parseImgAddress();
			resultList.get(i).parseDetail();
		}
		
		Gson gson = new Gson();
		String result = gson.toJson(resultList);
		
		// 모델에 결과 세팅
		model.addAttribute("keyword", keyword);
		model.addAttribute("placeList", result);
		model.addAttribute("currentPage", navi.getCurrentPage());
		model.addAttribute("startPageGroup", navi.getStartPageGroup());
		model.addAttribute("endPageGroup", navi.getEndPageGroup());
		model.addAttribute("totalRecordsCount", navi.getTotalRecordsCount());
		model.addAttribute("totalPageCount", navi.getTotalPageCount());
		model.addAttribute("currentGroup", navi.getCurrentGroup());
		
		return "placesearch";
	}
	
	@RequestMapping(value = "/ajaxPlaceSearch", method = RequestMethod.GET)
	public @ResponseBody PlacePageVO ajaxPlaceSearch(@RequestParam(value="keyword", required=false) String keyword, @RequestParam(value="page", required=false, defaultValue="0") int currentPage, String plan_area, Model model) {
		
		PlacePageVO ppv = new PlacePageVO();
		ArrayList<PlaceVO> resultList=null;
		
		PlaceVO keywordVO = new PlaceVO();
		keywordVO.setPlace_name(keyword);
		System.out.println(plan_area);
		
		if(plan_area.equals("0")) {
			keywordVO.setPlace_area(plan_area);
		}else if(plan_area.equals("3")) {
			keywordVO.setPlace_area(plan_area);
		}
		
		// 페이지네이션
		int countPerPage=4;
		int pagePerGroup=5;
		int totalRecordsCount=placeRepository.getTotal(keywordVO);
		System.out.println(totalRecordsCount);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);

		resultList=placeRepository.getByGrade(keywordVO, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));
		
		for (int i = 0; i < resultList.size(); i++) {
			resultList.get(i).parseImgAddress();
		}
		
		// VO에 결과 세팅
		ppv.setResultList(resultList);
		ppv.setCurrentPage(navi.getCurrentPage());
		ppv.setStartPageGroup(navi.getStartPageGroup());
		ppv.setEndPageGroup(navi.getEndPageGroup());
		ppv.setTotalRecordsCount(navi.getTotalRecordsCount());
		ppv.setTotalPageCount(navi.getTotalPageCount());
		ppv.setCurrentGroup(navi.getCurrentGroup());
		
		
		return ppv;
	}
	
	@RequestMapping(value = "/getAllInfo", method = RequestMethod.POST,produces = "application/json; charset=utf8")
	public @ResponseBody String getAllInfo() {
		
		ArrayList<AdminPlaceDTO> getInfo = new ArrayList<AdminPlaceDTO>();
		
		getInfo = placeRepository.getAllInfo();
		
		Gson gson = new Gson();
		String result = gson.toJson(getInfo);
		System.out.println(result);
		return result;
	}
	
}
