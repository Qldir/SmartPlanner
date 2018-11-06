package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.dto.PlanVO;

public interface PlanMapper {
	public int insert(PlanVO plan);

	public int delete(PlanVO plan);

	public int update(PlanVO plan);
	
	public PlanVO getPlan(PlanVO plan);		//하나의 plan 전체 정보를 가져옴
	
	public ArrayList<PlanVO> getMyPlan(MemberVO member, RowBounds rowBounds);	//plan의 리스트를 가져옴
	
	public int getMyPlanTotal(MemberVO member);
}