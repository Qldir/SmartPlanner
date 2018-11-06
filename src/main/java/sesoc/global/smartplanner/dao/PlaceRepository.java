package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.AdminPlaceDTO;
import sesoc.global.smartplanner.dto.PlaceVO;

@Repository
public class PlaceRepository {

	@Autowired
	SqlSession session;

	// Place의 리스트를 가져옴
	public ArrayList<PlaceVO> get(PlaceVO place, RowBounds rowBounds) {
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		ArrayList<PlaceVO> result = mapper.get(place, rowBounds);
		return result;
	}
	
	public ArrayList<PlaceVO> getByGrade(PlaceVO place, RowBounds rowBounds){
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		ArrayList<PlaceVO> result = mapper.getByGrade(place, rowBounds);
		return result;
	}

	public int getTotal(PlaceVO place) {
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		int result = mapper.getTotal(place);
		return result;
	}
	
	

	public PlaceVO getPlace(String place_seq) {
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		PlaceVO result = mapper.getPlace(place_seq);
		return result;
	}
	
	public ArrayList<PlaceVO> getAll() {
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		ArrayList<PlaceVO> result = mapper.getAll();
		return result;
	}
	
	public ArrayList<AdminPlaceDTO> getAllInfo(){
		PlaceMapper mapper = session.getMapper(PlaceMapper.class);
		ArrayList<AdminPlaceDTO> result = mapper.getAllInfo();
		return result;
	}
}
