package sesoc.global.smartplanner.dto;

public class PlaceGradeVO {
	private String place_grade_seq;
	private String place_seq;
	private String member_seq;
	private String place_grade_value;
	private String place_grade_regdate;

	public PlaceGradeVO(String place_grade_seq, String place_seq, String member_seq, String place_grade_value,
			String place_grade_regdate) {
		super();
		this.place_grade_seq = place_grade_seq;
		this.place_seq = place_seq;
		this.member_seq = member_seq;
		this.place_grade_value = place_grade_value;
		this.place_grade_regdate = place_grade_regdate;
	}

	public PlaceGradeVO() {
		super();
	}

	public String getPlace_grade_seq() {
		return place_grade_seq;
	}

	public void setPlace_grade_seq(String place_grade_seq) {
		this.place_grade_seq = place_grade_seq;
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

	public String getPlace_grade_value() {
		return place_grade_value;
	}

	public void setPlace_grade_value(String place_grade_value) {
		this.place_grade_value = place_grade_value;
	}

	public String getPlace_grade_regdate() {
		return place_grade_regdate;
	}

	public void setPlace_grade_regdate(String place_grade_regdate) {
		this.place_grade_regdate = place_grade_regdate;
	}

	@Override
	public String toString() {
		return "PlaceGradeVO [place_grade_seq=" + place_grade_seq + ", place_seq=" + place_seq + ", member_seq="
				+ member_seq + ", place_grade_value=" + place_grade_value + ", place_grade_regdate="
				+ place_grade_regdate + "]";
	}
}
