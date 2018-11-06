package sesoc.global.smartplanner.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.BoardCommentVO;
import sesoc.global.smartplanner.dto.BoardVO;

public interface BoardCommentMapper {
	public int insert(BoardCommentVO boardcomment);

	public int update(BoardCommentVO boardcomment);

	public int delete(BoardCommentVO boardcomment);
	
	public ArrayList<BoardCommentVO> get(BoardVO board, RowBounds rowBounds);
	
	public int getTotal(BoardVO board);
}
