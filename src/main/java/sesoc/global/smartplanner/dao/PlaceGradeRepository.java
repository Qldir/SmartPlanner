package sesoc.global.smartplanner.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.PlaceGradeVO;

@Repository
public class PlaceGradeRepository {

	@Autowired
	SqlSession session;

	public String get(String place_seq) {
		PlaceGradeMapper mapper = session.getMapper(PlaceGradeMapper.class);
		String result = mapper.get(place_seq);
		return result;
	}

	public String getUserReview(PlaceGradeVO placeGrade) {
		PlaceGradeMapper mapper = session.getMapper(PlaceGradeMapper.class);
		String result = mapper.getUserReview(placeGrade);
		return result;
	}

	public int update(PlaceGradeVO placeGrade) {

		PlaceGradeMapper mapper = session.getMapper(PlaceGradeMapper.class);
		int result = mapper.update(placeGrade);
		return result;
	}

	public int insert(PlaceGradeVO placeGrade) {
		PlaceGradeMapper mapper = session.getMapper(PlaceGradeMapper.class);
		int result = mapper.insert(placeGrade);
		return result;
	}
}
