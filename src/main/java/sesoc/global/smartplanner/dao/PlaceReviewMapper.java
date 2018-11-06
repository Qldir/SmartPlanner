package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.PlaceReviewVO;

public interface PlaceReviewMapper {
	public ArrayList<PlaceReviewVO> get(PlaceReviewVO placeReview, RowBounds rowBounds);
	public int getTotal(PlaceReviewVO placeReview);
	public int insert(PlaceReviewVO placeReview);
	public int update(PlaceReviewVO placeReview);
	public int delete(PlaceReviewVO placeReview);
}
