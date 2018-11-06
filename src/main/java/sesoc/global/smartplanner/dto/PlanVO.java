package sesoc.global.smartplanner.dto;

public class PlanVO {
	private String plan_seq;
	private String member_seq;
	private String plan_title;
	private String plan_peoplecount;
	private String plan_from;
	private String plan_to;
	private int plan_area;
	private String plan_startlocation;
	private String plan_img;

	public PlanVO() {
		super();
	}

	public PlanVO(String plan_seq, String member_seq, String plan_title, String plan_peoplecount, String plan_from,
			String plan_to, int plan_area, String plan_startlocation, String plan_img) {
		super();
		this.plan_seq = plan_seq;
		this.member_seq = member_seq;
		this.plan_title = plan_title;
		this.plan_peoplecount = plan_peoplecount;
		this.plan_from = plan_from;
		this.plan_to = plan_to;
		this.plan_area = plan_area;
		this.plan_startlocation = plan_startlocation;
		this.plan_img = plan_img;
	}

	public String getPlan_seq() {
		return plan_seq;
	}

	public void setPlan_seq(String plan_seq) {
		this.plan_seq = plan_seq;
	}

	public String getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(String member_seq) {
		this.member_seq = member_seq;
	}

	public String getPlan_title() {
		return plan_title;
	}

	public void setPlan_title(String plan_title) {
		this.plan_title = plan_title;
	}

	public String getPlan_peoplecount() {
		return plan_peoplecount;
	}

	public void setPlan_peoplecount(String plan_peoplecount) {
		this.plan_peoplecount = plan_peoplecount;
	}

	public String getPlan_from() {
		return plan_from;
	}

	public void setPlan_from(String plan_from) {
		this.plan_from = plan_from;
	}

	public String getPlan_to() {
		return plan_to;
	}

	public void setPlan_to(String plan_to) {
		this.plan_to = plan_to;
	}

	public int getPlan_area() {
		return plan_area;
	}

	public void setPlan_area(int plan_area) {
		this.plan_area = plan_area;
	}

	public String getPlan_startlocation() {
		return plan_startlocation;
	}

	public void setPlan_startlocation(String plan_startlocation) {
		this.plan_startlocation = plan_startlocation;
	}

	public String getPlan_img() {
		return plan_img;
	}

	public void setPlan_img(String plan_img) {
		this.plan_img = plan_img;
	}

	@Override
	public String toString() {
		return "PlanVO [plan_seq=" + plan_seq + ", member_seq=" + member_seq + ", plan_title=" + plan_title
				+ ", plan_peoplecount=" + plan_peoplecount + ", plan_from=" + plan_from + ", plan_to=" + plan_to
				+ ", plan_area=" + plan_area + ", plan_startlocation=" + plan_startlocation + ", plan_img=" + plan_img
				+ "]";
	}

}
