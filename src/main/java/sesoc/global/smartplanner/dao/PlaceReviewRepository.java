package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.PlaceReviewVO;

@Repository
public class PlaceReviewRepository{

	@Autowired
	SqlSession session;

	public ArrayList<PlaceReviewVO> get(PlaceReviewVO placeReview, RowBounds rowBounds) {
		PlaceReviewMapper mapper = session.getMapper(PlaceReviewMapper.class);
		ArrayList<PlaceReviewVO> result=mapper.get(placeReview, rowBounds);
		return result;
	}
	
	public int getTotal(PlaceReviewVO placeReview) {
		PlaceReviewMapper mapper = session.getMapper(PlaceReviewMapper.class);
		int result=mapper.getTotal(placeReview);
		return result;
	}

	public int insert(PlaceReviewVO placeReview) {
		PlaceReviewMapper mapper = session.getMapper(PlaceReviewMapper.class);
		int result =mapper.insert(placeReview);
		return result;
	}

	public int update(PlaceReviewVO placeReview) {
		PlaceReviewMapper mapper = session.getMapper(PlaceReviewMapper.class);
		int result =mapper.update(placeReview);
		return result;
	}

	public int delete(PlaceReviewVO placeReview) {
		PlaceReviewMapper mapper = session.getMapper(PlaceReviewMapper.class);
		int result =mapper.delete(placeReview);
		return result;
	}
}
