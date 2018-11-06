package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import sesoc.global.smartplanner.dto.PlaceVO;

public interface PlaceThemeMapper {
	public ArrayList<PlaceVO> getByFood(int place_area);

	public ArrayList<PlaceVO> getByShopping(int place_area);

	public ArrayList<PlaceVO> getByHistory(int place_area);

	public ArrayList<PlaceVO> getByCouple(int place_area);
	
	public ArrayList<PlaceVO> getByArea(int place_area);
}
