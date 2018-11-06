package sesoc.global.smartplanner.dto;

public class BoardVO {
	private String board_seq;
	private String member_seq;
	private String plan_seq;
	private String board_content;
	private String board_hitcount;
	private String board_regdate;

	public BoardVO(String board_seq, String member_seq, String plan_seq, String board_content, String board_hitcount,
			String board_regdate) {
		super();
		this.board_seq = board_seq;
		this.member_seq = member_seq;
		this.plan_seq = plan_seq;
		this.board_content = board_content;
		this.board_hitcount = board_hitcount;
		this.board_regdate = board_regdate;
	}

	public BoardVO() {
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

	@Override
	public String toString() {
		return "BoardVO [board_seq=" + board_seq + ", member_seq=" + member_seq + ", plan_seq=" + plan_seq
				+ ", board_content=" + board_content + ", board_hitcount=" + board_hitcount + ", board_regdate="
				+ board_regdate + "]";
	}

}
