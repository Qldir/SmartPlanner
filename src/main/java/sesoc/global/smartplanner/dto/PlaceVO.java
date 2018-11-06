package sesoc.global.smartplanner.dto;

public class PlaceVO {
	private String place_seq;
	private String place_area;
	private String place_name;
	private String place_type;
	private String place_opentime;
	private String place_closetime;
	private String place_spendtime;
	private String place_location;
	private String place_detail;
	private String place_image;
	private String place_cost;
	private String place_homepage;
	private String place_grade;

	public PlaceVO() {
		super();
	}

	public PlaceVO(String place_seq, String place_area, String place_name, String place_type, String place_opentime,
			String place_closetime, String place_spendtime, String place_location, String place_detail,
			String place_image, String place_cost, String place_homepage, String place_grade) {
		super();
		this.place_seq = place_seq;
		this.place_area = place_area;
		this.place_name = place_name;
		this.place_type = place_type;
		this.place_opentime = place_opentime;
		this.place_closetime = place_closetime;
		this.place_spendtime = place_spendtime;
		this.place_location = place_location;
		this.place_detail = place_detail;
		this.place_image = place_image;
		this.place_cost = place_cost;
		this.place_homepage = place_homepage;
		this.place_grade = place_grade;
	}

	public String getPlace_seq() {
		return place_seq;
	}

	public void setPlace_seq(String place_seq) {
		this.place_seq = place_seq;
	}

	public String getPlace_area() {
		return place_area;
	}

	public void setPlace_area(String place_area) {
		this.place_area = place_area;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public String getPlace_type() {
		return place_type;
	}

	public void setPlace_type(String place_type) {
		this.place_type = place_type;
	}

	public String getPlace_opentime() {
		return place_opentime;
	}

	public void setPlace_opentime(String place_opentime) {
		this.place_opentime = place_opentime;
	}

	public String getPlace_closetime() {
		return place_closetime;
	}

	public void setPlace_closetime(String place_closetime) {
		this.place_closetime = place_closetime;
	}

	public String getPlace_spendtime() {
		return place_spendtime;
	}

	public void setPlace_spendtime(String place_spendtime) {
		this.place_spendtime = place_spendtime;
	}

	public String getPlace_location() {
		return place_location;
	}

	public void setPlace_location(String place_location) {
		this.place_location = place_location;
	}

	public String getPlace_detail() {
		return place_detail;
	}

	public void setPlace_detail(String place_detail) {
		this.place_detail = place_detail;
	}

	public String getPlace_image() {
		return place_image;
	}

	public void setPlace_image(String place_image) {
		this.place_image = place_image;
	}

	public String getPlace_cost() {
		return place_cost;
	}

	public void setPlace_cost(String place_cost) {
		this.place_cost = place_cost;
	}

	public String getPlace_homepage() {
		return place_homepage;
	}

	public void setPlace_homepage(String place_homepage) {
		this.place_homepage = place_homepage;
	}

	public String getPlace_grade() {
		return place_grade;
	}

	public void setPlace_grade(String place_grade) {
		this.place_grade = place_grade;
	}

	@Override
	public String toString() {
		return "PlaceVO [place_seq=" + place_seq + ", place_area=" + place_area + ", place_name=" + place_name
				+ ", place_type=" + place_type + ", place_opentime=" + place_opentime + ", place_closetime="
				+ place_closetime + ", place_spendtime=" + place_spendtime + ", place_location=" + place_location
				+ ", place_detail=" + place_detail + ", place_image=" + place_image + ", place_cost=" + place_cost
				+ ", place_homepage=" + place_homepage + ", place_grade=" + place_grade + "]";
	}

	public void parseImgAddress() {
		String imgFileLocation = "./resources/img/place/";
		this.place_image = imgFileLocation + this.place_image;
	}

	/**
	 * 긴 Detail을 짧게 해주는 함수
	 */
	public void parseDetail() {
		if (this.place_detail.length() > 50) {
			this.place_detail = this.place_detail.substring(0, 50) + " ...";
		}
	}

}
