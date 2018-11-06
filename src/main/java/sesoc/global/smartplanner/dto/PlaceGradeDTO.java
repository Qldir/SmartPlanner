package sesoc.global.smartplanner.dto;

public class PlaceGradeDTO {
	private String place_grade;
	private String place_grade_user;

	public PlaceGradeDTO(String place_grade, String place_grade_user) {
		super();
		this.place_grade = place_grade;
		this.place_grade_user = place_grade_user;
	}

	public PlaceGradeDTO() {
		super();
	}

	public String getPlace_grade() {
		return place_grade;
	}

	public void setPlace_grade(String place_grade) {
		this.place_grade = place_grade;
	}

	public String getPlace_grade_user() {
		return place_grade_user;
	}

	public void setPlace_grade_user(String place_grade_user) {
		this.place_grade_user = place_grade_user;
	}

	@Override
	public String toString() {
		return "PlaceGradeDTO [place_grade=" + place_grade + ", place_grade_user=" + place_grade_user + "]";
	}

}
