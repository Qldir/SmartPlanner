package sesoc.global.smartplanner.dto;

public class PlaceReviewVO {
	private String place_review_seq;
	private String place_seq;
	private String member_seq;
	private String place_review_content;
	private String place_review_regdate;
	private String member_name;
	private String member_img;

	public PlaceReviewVO(String place_review_seq, String place_seq, String member_seq, String place_review_content,
			String place_review_regdate, String member_name, String member_img) {
		super();
		this.place_review_seq = place_review_seq;
		this.place_seq = place_seq;
		this.member_seq = member_seq;
		this.place_review_content = place_review_content;
		this.place_review_regdate = place_review_regdate;
		this.member_name = member_name;
		this.member_img = member_img;
	}

	public PlaceReviewVO() {
		super();
	}

	public String getPlace_review_seq() {
		return place_review_seq;
	}

	public void setPlace_review_seq(String place_review_seq) {
		this.place_review_seq = place_review_seq;
	}

	public String getPlace_seq() {
		return place_seq;
	}

	public void setPlace_seq(String place_seq) {
		this.place_seq = place_seq;
	}

	public String getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(String member_seq) {
		this.member_seq = member_seq;
	}

	public String getPlace_review_content() {
		return place_review_content;
	}

	public void setPlace_review_content(String place_review_content) {
		this.place_review_content = place_review_content;
	}

	public String getPlace_review_regdate() {
		return place_review_regdate;
	}

	public void setPlace_review_regdate(String place_review_regdate) {
		this.place_review_regdate = place_review_regdate;
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
		return "PlaceReviewVO [place_review_seq=" + place_review_seq + ", place_seq=" + place_seq + ", member_seq="
				+ member_seq + ", place_review_content=" + place_review_content + ", place_review_regdate="
				+ place_review_regdate + ", member_name=" + member_name + ", member_img=" + member_img + "]";
	}

}
