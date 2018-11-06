package sesoc.global.smartplanner.dto;

public class PlanDayPlaceVO {
	private String plan_day_place_seq;
	private String plan_day_seq;
	private String place_seq;

	public PlanDayPlaceVO(String plan_day_place_seq, String plan_day_seq, String place_seq) {
		super();
		this.plan_day_place_seq = plan_day_place_seq;
		this.plan_day_seq = plan_day_seq;
		this.place_seq = place_seq;
	}

	public PlanDayPlaceVO() {
		super();
	}

	public String getPlan_day_place_seq() {
		return plan_day_place_seq;
	}

	public void setPlan_day_place_seq(String plan_day_place_seq) {
		this.plan_day_place_seq = plan_day_place_seq;
	}

	public String getPlan_day_seq() {
		return plan_day_seq;
	}

	public void setPlan_day_seq(String plan_day_seq) {
		this.plan_day_seq = plan_day_seq;
	}

	public String getPlace_seq() {
		return place_seq;
	}

	public void setPlace_seq(String place_seq) {
		this.place_seq = place_seq;
	}

	@Override
	public String toString() {
		return "PlanDayPlaceVO [plan_day_place_seq=" + plan_day_place_seq + ", plan_day_seq=" + plan_day_seq
				+ ", place_seq=" + place_seq + "]";
	}

}
