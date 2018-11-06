package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.PlaceVO;

@Repository
public class PlaceThemeRepository {
	
	@Autowired
	SqlSession session;
	
	public ArrayList<PlaceVO> getByFood(int place_area){
		PlaceThemeMapper mapper = session.getMapper(PlaceThemeMapper.class);
		ArrayList<PlaceVO> result =mapper.getByFood(place_area);
		return result;
	};

	public ArrayList<PlaceVO> getByShopping(int place_area){
		PlaceThemeMapper mapper = session.getMapper(PlaceThemeMapper.class);
		ArrayList<PlaceVO> result =mapper.getByShopping(place_area);
		return result;
	};

	public ArrayList<PlaceVO> getByHistory(int place_area){
		PlaceThemeMapper mapper = session.getMapper(PlaceThemeMapper.class);
		ArrayList<PlaceVO> result =mapper.getByHistory(place_area);
		return result;
	};

	public ArrayList<PlaceVO> getByCouple(int place_area){
		PlaceThemeMapper mapper = session.getMapper(PlaceThemeMapper.class);
		ArrayList<PlaceVO> result =mapper.getByCouple(place_area);
		return result;
	};
	
	public ArrayList<PlaceVO> getByArea(int place_area){
		PlaceThemeMapper mapper = session.getMapper(PlaceThemeMapper.class);
		System.out.println(place_area);
		ArrayList<PlaceVO> result =mapper.getByArea(place_area);
		return result;
	}
}
