package sesoc.global.smartplanner.dto;

import java.util.ArrayList;

public class PlanPageDTO {
	private PlanVO plan;
	private ArrayList<PlanDayDTO> dayPlanList;

	public PlanPageDTO() {
		super();
	}

	public PlanPageDTO(PlanVO plan, ArrayList<PlanDayDTO> dayPlanList) {
		super();
		this.plan = plan;
		this.dayPlanList = dayPlanList;
	}

	public PlanVO getPlan() {
		return plan;
	}

	public void setPlan(PlanVO plan) {
		this.plan = plan;
	}

	public ArrayList<PlanDayDTO> getDayPlanList() {
		return dayPlanList;
	}

	public void setDayPlanList(ArrayList<PlanDayDTO> dayPlanList) {
		this.dayPlanList = dayPlanList;
	}

	@Override
	public String toString() {
		return "PlanPageDTO [plan=" + plan + ", dayPlanList=" + dayPlanList + "]";
	}

}
