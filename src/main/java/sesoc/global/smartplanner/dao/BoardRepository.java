package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.BoardVO;
import sesoc.global.smartplanner.dto.PlaceVO;

@Repository
public class BoardRepository{

	@Autowired
	SqlSession session;

	public int insert(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insert(board);
		return result;
	}

	public int delete(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.delete(board);
		return result;
	}
	
	public int update(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.update(board);
		return result;
	}
	
	public int addhits(String board_seq)
	{
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.addhits(board_seq);
		return result;
	}
	
	public BoardVO get(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		BoardVO result=mapper.get(board);
		return result;
	}
	
	public int getTotal(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.getTotal(board);
		return result;
	}
	
	public ArrayList<BoardVO> get(BoardVO place, RowBounds rowBounds) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<BoardVO> result = mapper.get(place, rowBounds);
		return result;
	}
	
	public ArrayList<BoardVO> getByGrade(BoardVO place, RowBounds rowBounds){
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<BoardVO> result = mapper.getByGrade(place, rowBounds);
		return result;
	}
	
	public ArrayList<BoardDTO> selectAll(RowBounds rowBounds)
	{
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<BoardDTO> result = mapper.selectAll(rowBounds);
		return result;
	}

	public BoardDTO selectOne(BoardVO board)
	{
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		BoardDTO selectOne = mapper.selectOne(board);
		return selectOne;
	}
	
	public ArrayList<BoardDTO> selectAllOrderByFavorite(RowBounds rowBounds)
	{
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<BoardDTO> result = mapper.selectAllOrderByFavorite(rowBounds);
		return result;
	}
}
