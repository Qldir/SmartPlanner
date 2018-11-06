package sesoc.global.smartplanner.dto;

public class PlanDayVO {
	private String plan_day_seq;
	private String plan_seq;
	private String plan_day_date;

	public PlanDayVO(String plan_day_seq, String plan_seq, String plan_day_date) {
		super();
		this.plan_day_seq = plan_day_seq;
		this.plan_seq = plan_seq;
		this.plan_day_date = plan_day_date;
	}

	public PlanDayVO() {
		super();
	}

	public String getPlan_day_seq() {
		return plan_day_seq;
	}

	public void setPlan_day_seq(String plan_day_seq) {
		this.plan_day_seq = plan_day_seq;
	}

	public String getPlan_seq() {
		return plan_seq;
	}

	public void setPlan_seq(String plan_seq) {
		this.plan_seq = plan_seq;
	}

	public String getPlan_day_date() {
		return plan_day_date;
	}

	public void setPlan_day_date(String plan_day_date) {
		this.plan_day_date = plan_day_date;
	}

	@Override
	public String toString() {
		return "PlanDayVO [plan_day_seq=" + plan_day_seq + ", plan_seq=" + plan_seq + ", plan_day_date=" + plan_day_date
				+ "]";
	}

}
