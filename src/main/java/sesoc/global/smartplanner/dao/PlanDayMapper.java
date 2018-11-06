package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import sesoc.global.smartplanner.dto.PlanDayVO;
import sesoc.global.smartplanner.dto.PlanVO;

public interface PlanDayMapper {
	public int insert(PlanDayVO planDay);

	public int delete(PlanVO planDay);

	public int update(PlanDayVO planDay);
	
	public ArrayList<PlanDayVO> getPlanDay(PlanVO plan);	//planDay
}
