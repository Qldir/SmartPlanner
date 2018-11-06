package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.BoardVO;

public interface BoardMapper {
	public int insert(BoardVO board);

	public int delete(BoardVO board);
	
	public int update(BoardVO board);
	
	public int addhits(String board_seq);
	
	public BoardVO get(BoardVO board);
	
	public int getTotal(BoardVO board);
	
	public ArrayList<BoardVO> get(BoardVO placeReview, RowBounds rowBounds);
	
	public ArrayList<BoardVO> getByGrade(BoardVO board, RowBounds rowBounds);
	
	public ArrayList<BoardDTO> selectAll(RowBounds rowBounds);
	
	public BoardDTO selectOne(BoardVO board);
	
	public ArrayList<BoardDTO> selectAllOrderByFavorite(RowBounds rowBounds);
}
