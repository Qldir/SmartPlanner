package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import sesoc.global.smartplanner.dto.PlaceDTO;
import sesoc.global.smartplanner.dto.PlaceTypeVO;

public interface PlaceTypeMapper {
	public PlaceTypeVO get(PlaceTypeVO placeType);
	public ArrayList<PlaceDTO> getList(PlaceTypeVO placeType);
}
