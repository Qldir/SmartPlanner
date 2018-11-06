package sesoc.global.smartplanner.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.BoardCommentVO;
import sesoc.global.smartplanner.dto.BoardVO;

@Repository
public class BoardCommentRepository {

	@Autowired
	SqlSession session;

	public int insert(BoardCommentVO boardcomment) {
		BoardCommentMapper mapper = session.getMapper(BoardCommentMapper.class);
		int result = mapper.insert(boardcomment);
		return result;
	}

	public int update(BoardCommentVO boardcomment) {
		BoardCommentMapper mapper = session.getMapper(BoardCommentMapper.class);
		int result = mapper.update(boardcomment);
		return result;
	}

	public int delete(BoardCommentVO boardcomment) {
		BoardCommentMapper mapper = session.getMapper(BoardCommentMapper.class);
		int result = mapper.delete(boardcomment);
		return result;
	}

	public ArrayList<BoardCommentVO> get(BoardVO board, RowBounds rowBounds) {
		BoardCommentMapper mapper = session.getMapper(BoardCommentMapper.class);
		ArrayList<BoardCommentVO> list = mapper.get(board, rowBounds);
		return list;
	}

	public int getTotal(BoardVO board) {
		BoardCommentMapper mapper = session.getMapper(BoardCommentMapper.class);
		int result = mapper.getTotal(board);
		return result;
	}

}
