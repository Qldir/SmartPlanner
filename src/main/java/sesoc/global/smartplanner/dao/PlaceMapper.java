package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.AdminPlaceDTO;
import sesoc.global.smartplanner.dto.PlaceVO;

public interface PlaceMapper {
	
	public ArrayList<PlaceVO> get(PlaceVO place, RowBounds rowBounds);
	
	public ArrayList<PlaceVO> getByGrade(PlaceVO place, RowBounds rowBounds);
	
	public int getTotal(PlaceVO place);
	
	public PlaceVO getPlace(String place_seq);
	
	public ArrayList<PlaceVO> getAll();
	
	public ArrayList<AdminPlaceDTO> getAllInfo();
}
