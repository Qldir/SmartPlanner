package sesoc.global.smartplanner.dto;

public class FavoriteVO {
	private String favorite_seq;
	private String board_seq;
	private String member_seq;
	private String favorite_regdate;

	public FavoriteVO(String favorite_seq, String board_seq, String member_seq, String favorite_regdate) {
		super();
		this.favorite_seq = favorite_seq;
		this.board_seq = board_seq;
		this.member_seq = member_seq;
		this.favorite_regdate = favorite_regdate;
	}

	public FavoriteVO() {
		super();
	}

	public String getFavorite_seq() {
		return favorite_seq;
	}

	public void setFavorite_seq(String favorite_seq) {
		this.favorite_seq = favorite_seq;
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

	public String getFavorite_regdate() {
		return favorite_regdate;
	}

	public void setFavorite_regdate(String favorite_regdate) {
		this.favorite_regdate = favorite_regdate;
	}

	@Override
	public String toString() {
		return "FavoriteVO [favorite_seq=" + favorite_seq + ", board_seq=" + board_seq + ", member_seq=" + member_seq
				+ ", favorite_regdate=" + favorite_regdate + "]";
	}

}
