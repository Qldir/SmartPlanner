package sesoc.global.smartplanner.dto;

public class BoardDTO {
	private String board_seq;
	private String member_seq;
	private String plan_seq;
	private String board_content;
	private String board_hitcount;
	private String board_regdate;
	private String plan_title;
	private String plan_from;
	private String plan_to;
	private String plan_area;
	private String plan_img;
	private String member_name;
	private String favorite_sum;

	public BoardDTO(String board_seq, String member_seq, String plan_seq, String board_content, String board_hitcount,
			String board_regdate, String plan_title, String plan_from, String plan_to, String plan_area,
			String plan_img, String member_name, String favorite_sum) {
		super();
		this.board_seq = board_seq;
		this.member_seq = member_seq;
		this.plan_seq = plan_seq;
		this.board_content = board_content;
		this.board_hitcount = board_hitcount;
		this.board_regdate = board_regdate;
		this.plan_title = plan_title;
		this.plan_from = plan_from;
		this.plan_to = plan_to;
		this.plan_area = plan_area;
		this.plan_img = plan_img;
		this.member_name = member_name;
		this.favorite_sum = favorite_sum;
	}

	public BoardDTO() {
		super();
	}

	public String getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(String board_seq) {
		this.board_seq = board_seq;
	}

	public String getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(String member_seq) {
		this.member_seq = member_seq;
	}

	public String getPlan_seq() {
		return plan_seq;
	}

	public void setPlan_seq(String plan_seq) {
		this.plan_seq = plan_seq;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_hitcount() {
		return board_hitcount;
	}

	public void setBoard_hitcount(String board_hitcount) {
		this.board_hitcount = board_hitcount;
	}

	public String getBoard_regdate() {
		return board_regdate;
	}

	public void setBoard_regdate(String board_regdate) {
		this.board_regdate = board_regdate;
	}

	public String getPlan_title() {
		return plan_title;
	}

	public void setPlan_title(String plan_title) {
		this.plan_title = plan_title;
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

	public String getPlan_area() {
		return plan_area;
	}

	public void setPlan_area(String plan_area) {
		this.plan_area = plan_area;
	}

	public String getPlan_img() {
		return plan_img;
	}

	public void setPlan_img(String plan_img) {
		this.plan_img = plan_img;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getFavorite_sum() {
		return favorite_sum;
	}

	public void setFavorite_sum(String favorite_sum) {
		this.favorite_sum = favorite_sum;
	}

	@Override
	public String toString() {
		return "BoardDTO [board_seq=" + board_seq + ", member_seq=" + member_seq + ", plan_seq=" + plan_seq
				+ ", board_content=" + board_content + ", board_hitcount=" + board_hitcount + ", board_regdate="
				+ board_regdate + ", plan_title=" + plan_title + ", plan_from=" + plan_from + ", plan_to=" + plan_to
				+ ", plan_area=" + plan_area + ", plan_img=" + plan_img + ", member_name=" + member_name
				+ ", favorite_sum=" + favorite_sum + "]";
	}

}
