package sesoc.global.smartplanner.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.SynthesizedAnnotation;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.MemberVO;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.PlanDayDTO;
import sesoc.global.smartplanner.dto.PlanDayPlaceVO;
import sesoc.global.smartplanner.dto.PlanDayVO;
import sesoc.global.smartplanner.dto.PlanPageDTO;
import sesoc.global.smartplanner.dto.PlanVO;

@Repository
public class PlanRepository {

	@Autowired
	SqlSession session;

	public int insert(PlanPageDTO dto) {
		
		PlanVO plan=dto.getPlan();
		ArrayList<PlanDayDTO> placeDayDTOList = dto.getDayPlanList();
		
		// 플랜 이미지 세팅
		if(plan.getPlan_area()==0) {
			int randNum=(int) ((Math.random()*8)+1);
			plan.setPlan_img("tokyo"+randNum);
		}else if(plan.getPlan_area()==3) {
			int randNum=(int) ((Math.random()*8)+1);
			plan.setPlan_img("osaka"+randNum);
		}
		
		// 플랜 insert
		PlanMapper planMapper = session.getMapper(PlanMapper.class);
		System.out.println(plan);
		int result=planMapper.insert(plan);
		
		// 실패시 리턴
		if(result!=1)
			return 0;
		
		PlanDayMapper planDayMapper = session.getMapper(PlanDayMapper.class);
		PlanDayPlaceMapper planDayPlaceMapper = session.getMapper(PlanDayPlaceMapper.class);
		
		for(int i=0;i<placeDayDTOList.size();i++) {
			PlanDayVO dayVO = new PlanDayVO();
			dayVO.setPlan_seq(plan.getPlan_seq());
			dayVO.setPlan_day_date(placeDayDTOList.get(i).getDate());
			
			result=planDayMapper.insert(dayVO);
			
			if(result!=1)
				return 0;
			
			ArrayList<PlaceVO> placeList=placeDayDTOList.get(i).getPlaceList();
			for(int j=0;j<placeList.size();j++) {
				
				PlanDayPlaceVO placeVO = new PlanDayPlaceVO();
				
				placeVO.setPlace_seq(placeList.get(j).getPlace_seq());
				placeVO.setPlan_day_seq(dayVO.getPlan_day_seq());
				
				result=planDayPlaceMapper.insert(placeVO);
				
				if(result!=1)
					return 0;
			}
		}
		
		
		return result;
	}

	public int delete(PlanVO plan) {
		
		PlanMapper mapper = session.getMapper(PlanMapper.class);
		int result = mapper.delete(plan);
		
		return result;
	}

	public int update(PlanPageDTO dto) {
		
		PlanVO plan=dto.getPlan();
		ArrayList<PlanDayDTO> placeDayDTOList = dto.getDayPlanList();
		
		// 플랜 insert
		PlanMapper planMapper = session.getMapper(PlanMapper.class);
		int result=planMapper.update(plan);
		
		// 실패시 리턴
		if(result!=1)
			return 0;
		
		PlanDayMapper planDayMapper = session.getMapper(PlanDayMapper.class);
		PlanDayPlaceMapper planDayPlaceMapper = session.getMapper(PlanDayPlaceMapper.class);
		
		//해당 Plan의 PlanDay 모두 삭제
		planDayMapper.delete(plan);
		
		for(int i=0;i<placeDayDTOList.size();i++) {
			PlanDayVO dayVO = new PlanDayVO();
			dayVO.setPlan_seq(plan.getPlan_seq());
			dayVO.setPlan_day_date(placeDayDTOList.get(i).getDate());
			
			result=planDayMapper.insert(dayVO);
			
			if(result!=1)
				return 0;
			
			ArrayList<PlaceVO> placeList=placeDayDTOList.get(i).getPlaceList();
			for(int j=0;j<placeList.size();j++) {
				
				PlanDayPlaceVO placeVO = new PlanDayPlaceVO();
				
				placeVO.setPlace_seq(placeList.get(j).getPlace_seq());
				placeVO.setPlan_day_seq(dayVO.getPlan_day_seq());
				
				result=planDayPlaceMapper.insert(placeVO);
				
				if(result!=1)
					return 0;
			}
		}
		
		return result;
	}
	
	/**
	 * 하나의 plan의 모든 정보를 가져오는 메소드
	 * Last Update : 2018-09-07
	 * @param plan
	 * @return PlanPageDTO
	 */
	public PlanPageDTO getPlan(PlanVO plan) {
		
		ArrayList<PlanDayDTO> dayPlanList = new ArrayList<PlanDayDTO>();
		
		PlanMapper planMapper = session.getMapper(PlanMapper.class);
		PlanDayMapper planDayMapper = session.getMapper(PlanDayMapper.class);
		PlanDayPlaceMapper planDayPlaceMapper = session.getMapper(PlanDayPlaceMapper.class);
		PlaceMapper placeMapper = session.getMapper(PlaceMapper.class);
		
		//planInfo
		PlanVO planInfo = planMapper.getPlan(plan);
		//하루 plan List를 받아옴
		ArrayList<PlanDayVO> planList = planDayMapper.getPlanDay(planInfo);
		
		if(planList==null) return null;
		
		for(PlanDayVO dayPlan:planList) {
			//place 리스트를 담을 array
			ArrayList<PlaceVO> placeList = new ArrayList<PlaceVO>();
			//하루 place 리스트 (여행지 정보는 없고 SEQ만 존재)
			ArrayList<PlanDayPlaceVO> dayPlaceList = planDayPlaceMapper.getPlanDayPlace(dayPlan);
			
			//받아온 place 리스트의 SEQ로 다시 place 정보를 받아와 placeList에 넣어줌
			for(PlanDayPlaceVO p:dayPlaceList) {
				PlaceVO place = placeMapper.getPlace(p.getPlace_seq());
				placeList.add(place);
			}
			
			//plan의 하루 날짜, 그 날의 여행지 리스트를 넣어줌
			PlanDayDTO oneDayPlan = new PlanDayDTO(dayPlan.getPlan_day_date(), placeList);
			dayPlanList.add(oneDayPlan);	
		}
		
		//총 일정 dto에 저장
		PlanPageDTO result = new PlanPageDTO(planInfo, dayPlanList);
		
		
		return result;
	}
	
	public ArrayList<PlanVO> getMyPlan(MemberVO member, RowBounds rowBounds){
		PlanMapper planMapper = session.getMapper(PlanMapper.class);
		ArrayList<PlanVO> result = planMapper.getMyPlan(member, rowBounds);
		
		return result;
	}
	
	public int getMyPlanTotal(MemberVO member) {
		PlanMapper mapper = session.getMapper(PlanMapper.class);
		int result=mapper.getMyPlanTotal(member);
		return result;
	}
	
	
}
