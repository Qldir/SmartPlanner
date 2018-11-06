package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import sesoc.global.smartplanner.dto.PlanDayPlaceVO;
import sesoc.global.smartplanner.dto.PlanDayVO;

public interface PlanDayPlaceMapper {
	public int insert(PlanDayPlaceVO planDayPlace);

	public int delete(PlanDayPlaceVO planDayPlace);

	public int update(PlanDayPlaceVO planDayPlace);
	
	public ArrayList<PlanDayPlaceVO> getPlanDayPlace(PlanDayVO dayPlan);	//planDayPlace
}
