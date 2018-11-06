package sesoc.global.smartplanner.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import sesoc.global.smartplanner.dao.BoardCommentRepository;
import sesoc.global.smartplanner.dao.BoardMapper;
import sesoc.global.smartplanner.dao.BoardRepository;
import sesoc.global.smartplanner.dao.FavoriteRepository;
import sesoc.global.smartplanner.dao.PlanRepository;
import sesoc.global.smartplanner.dto.BoardCommentDTO;
import sesoc.global.smartplanner.dto.BoardCommentVO;
import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.BoardPageDTO;
import sesoc.global.smartplanner.dto.BoardVO;
import sesoc.global.smartplanner.dto.FavoriteVO;
import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.dto.PlaceDetailDTO;
import sesoc.global.smartplanner.dto.PlaceReviewVO;
import sesoc.global.smartplanner.dto.PlanPageDTO;
import sesoc.global.smartplanner.dto.PlanVO;
import sesoc.global.smartplanner.util.PageNavigator;

@Controller
public class BoardController {

	@Autowired
	BoardRepository repository;
	@Autowired
	BoardCommentRepository boardcommentrepository;
	@Autowired
	FavoriteRepository favoriterepository;
	@Autowired
	PlanRepository planRepository;

	@RequestMapping(value = "/insertboard", method = RequestMethod.POST)
	public String insertBoard(BoardVO board, HttpSession httpSession) {

		board.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = repository.insert(board);

		if (result == 1) {
			return "redirect:/planboard";
		} else {
			return null;
		}
	}
	
	@RequestMapping(value = "/updateboard", method = RequestMethod.POST)
	public String updateBoard(BoardVO board, HttpSession httpSession) {

		board.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = repository.update(board);

		if (result == 1) {
			return "redirect:detailboard?num="+board.getBoard_seq();
		} else {
			return null;
		}
	}

	@RequestMapping(value = "/deleteboard", method = RequestMethod.POST)
	public @ResponseBody int deleteBoard(BoardVO board, HttpSession httpSession) {
		board.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = repository.delete(board);
		return result;
	}

	@RequestMapping(value = "/detailboard", method = RequestMethod.GET)
	public String detailBoard(String num, HttpSession httpSession, Model model) {
		
		repository.addhits(num);
		
		BoardVO board = new BoardVO();
		board.setBoard_seq(num);
		
		BoardDTO resultBoard = repository.selectOne(board);
		
		PlanVO test = new PlanVO();
		test.setPlan_seq(resultBoard.getPlan_seq());

		PlanPageDTO dto = planRepository.getPlan(test);
		if (dto == null)
			return null;
		
		int favorite=0;
		if((String)httpSession.getAttribute("member_seq")!=null) {
			FavoriteVO favoriteVO = new FavoriteVO();
			favoriteVO.setBoard_seq(num);
			favoriteVO.setMember_seq((String)httpSession.getAttribute("member_seq"));
			 favorite = favoriterepository.get(favoriteVO);
		}
		
		BoardPageDTO resultDTO = new BoardPageDTO();
		resultDTO.setBoard(resultBoard);
		resultDTO.setPlanDTO(dto);
		resultDTO.setFavorite(favorite);
		
		Gson gson = new Gson();
		String result = gson.toJson(resultDTO);
		
		model.addAttribute("result", result);
		return "boarddetail";
	}

	@RequestMapping(value = "/detailboard/insertcomment", method = RequestMethod.POST)
	public @ResponseBody int insertComment(BoardCommentVO boardcomment, HttpSession httpSession) {
		boardcomment.setMember_seq((String)httpSession.getAttribute("member_seq"));
		int result = boardcommentrepository.insert(boardcomment);
		return result;
	}

	@RequestMapping(value = "/detailboard/updatecomment", method = RequestMethod.POST)
	public @ResponseBody Integer updateComment(BoardCommentVO boardcomment, HttpSession httpSession) {
		boardcomment.setMember_seq((String)httpSession.getAttribute("member_seq"));
		System.out.println(boardcomment);
		int result = boardcommentrepository.update(boardcomment);
		return result;
	}

	@RequestMapping(value = "/detailboard/deletecomment", method = RequestMethod.POST)
	public @ResponseBody int deleteComment(BoardCommentVO boardcomment, HttpSession httpSession) {
		boardcomment.setMember_seq((String)httpSession.getAttribute("member_seq"));
		int result = boardcommentrepository.delete(boardcomment);
		return result;
	}

	@RequestMapping(value="/detailboard/getcomment",method=RequestMethod.POST)
	public @ResponseBody BoardCommentDTO getComment(BoardVO board, @RequestParam(value="currentPage", required=false, defaultValue="0")int currentPage) {
		BoardCommentDTO resultDTO = new BoardCommentDTO();
		
		System.out.println(board);
		// 페이지네이션
		int countPerPage=5;
		int pagePerGroup=5;
		int totalRecordsCount=boardcommentrepository.getTotal(board);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
		
		// 리뷰데이터 GET
		ArrayList<BoardCommentVO> commentList = boardcommentrepository.get(board, new RowBounds(navi.getStartRecord(), navi.getCountPerPage()));

		// 페이지 DTO에 데이터 셋팅
		resultDTO.setCommentList(commentList);
		resultDTO.setCurrentPage(navi.getCurrentPage());
		resultDTO.setStartPageGroup(navi.getStartPageGroup());
		resultDTO.setEndPageGroup(navi.getEndPageGroup());
		resultDTO.setTotalRecordsCount(navi.getTotalRecordsCount());
		resultDTO.setTotalPageCount(navi.getTotalPageCount());
		resultDTO.setCurrentGroup(navi.getCurrentGroup());
		
		return resultDTO;
	}
	
	@RequestMapping(value = "/detailboard/insertfavorite", method = RequestMethod.POST)
	public @ResponseBody int insertFavorite(FavoriteVO favorite, HttpSession httpSession) {
		favorite.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = favoriterepository.insert(favorite);
		return result;
	}

	@RequestMapping(value = "/detailboard/deletefavorite", method = RequestMethod.POST)
	public @ResponseBody int deleteFavorite(FavoriteVO favorite, HttpSession httpSession) {
		favorite.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = favoriterepository.delete(favorite);
		return result;
	}
	
	@RequestMapping(value = "/detailboard/getfavorite", method = RequestMethod.POST)
	public @ResponseBody int getFavorite(FavoriteVO favorite) {
		int result = favoriterepository.getTotal(favorite);
		return result;
	}
}
