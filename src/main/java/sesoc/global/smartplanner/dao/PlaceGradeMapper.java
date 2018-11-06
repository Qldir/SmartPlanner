package sesoc.global.smartplanner.dao;

import sesoc.global.smartplanner.dto.PlaceGradeVO;

public interface PlaceGradeMapper {
	public String get(String place_seq);

	public String getUserReview(PlaceGradeVO placeGrade);
	
	public int update(PlaceGradeVO placeGrade); 
	
	public int insert(PlaceGradeVO placeGrade);
}
