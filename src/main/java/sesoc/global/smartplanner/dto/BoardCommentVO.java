package sesoc.global.smartplanner.dto;

public class BoardCommentVO {
	private String board_comment_seq;
	private String board_seq;
	private String member_seq;
	private String board_comment_content;
	private String board_comment_regdate;
	private String member_name;
	private String member_img;

	public BoardCommentVO(String board_comment_seq, String board_seq, String member_seq, String board_comment_content,
			String board_comment_regdate, String member_name, String member_img) {
		super();
		this.board_comment_seq = board_comment_seq;
		this.board_seq = board_seq;
		this.member_seq = member_seq;
		this.board_comment_content = board_comment_content;
		this.board_comment_regdate = board_comment_regdate;
		this.member_name = member_name;
		this.member_img = member_img;
	}

	public BoardCommentVO() {
		super();
	}

	public String getBoard_comment_seq() {
		return board_comment_seq;
	}

	public void setBoard_comment_seq(String board_comment_seq) {
		this.board_comment_seq = board_comment_seq;
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

	public String getBoard_comment_content() {
		return board_comment_content;
	}

	public void setBoard_comment_content(String board_comment_content) {
		this.board_comment_content = board_comment_content;
	}

	public String getBoard_comment_regdate() {
		return board_comment_regdate;
	}

	public void setBoard_comment_regdate(String board_comment_regdate) {
		this.board_comment_regdate = board_comment_regdate;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	@Override
	public String toString() {
		return "BoardCommentVO [board_comment_seq=" + board_comment_seq + ", board_seq=" + board_seq + ", member_seq="
				+ member_seq + ", board_comment_content=" + board_comment_content + ", board_comment_regdate="
				+ board_comment_regdate + ", member_name=" + member_name + ", member_img=" + member_img + "]";
	}

}
