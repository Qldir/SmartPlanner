package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.BoardDTO;
import sesoc.global.smartplanner.dto.FavoriteVO;

@Repository
public class FavoriteRepository{

	@Autowired
	SqlSession session;

	public int insert(FavoriteVO favorite) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		int result = mapper.insert(favorite);
		return result;
	}

	public int delete(FavoriteVO favorite) {
		FavoriteMapper mapper =session.getMapper(FavoriteMapper.class);
		int result = mapper.delete(favorite);
		return result;
	}
	
	public int getTotal(FavoriteVO favorite) {
		FavoriteMapper mapper =session.getMapper(FavoriteMapper.class);
		int result = mapper.getTotal(favorite);
		return result;
	}
	
	public int get(FavoriteVO favorite) {
		FavoriteMapper mapper =session.getMapper(FavoriteMapper.class);
		int result = mapper.get(favorite);
		return result;
	}
	
	public ArrayList<BoardDTO> getMyFavorite(String member_seq, RowBounds rowBounds){
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		ArrayList<BoardDTO> result=mapper.getMyFavorite(member_seq, rowBounds);
		return result;
	}
	
	public int getMyFavoriteTotal(String member_seq) {
		FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
		int result=mapper.getMyFavoriteTotal(member_seq);
		return result;
	}
	
}
