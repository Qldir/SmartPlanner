package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.PlaceDTO;
import sesoc.global.smartplanner.dto.PlaceTypeVO;

@Repository
public class PlaceTypeRepository{

	@Autowired
	SqlSession session;

	public PlaceTypeVO get(PlaceTypeVO placeType) {
		return null;
	}
	
	public ArrayList<PlaceDTO> getList(PlaceTypeVO placeType){
		System.out.println("시작");
		PlaceTypeMapper mapper = session.getMapper(PlaceTypeMapper.class);
		
		return mapper.getList(placeType);
	}
}
