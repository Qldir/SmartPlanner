package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.FavoriteVO;

public interface FavoriteMapper {
	public int insert(FavoriteVO favorite);

	public int delete(FavoriteVO favorite);
	
	public int getTotal(FavoriteVO favorite);
	
	public int get(FavoriteVO favorite);
	
	public ArrayList<BoardDTO> getMyFavorite(String member_seq, RowBounds rowBounds);
	
	public int getMyFavoriteTotal(String member_seq);
}
