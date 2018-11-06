package sesoc.global.smartplanner.dto;

public class AdminPlaceDTO {
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
	
	private int place_type_gender;		//선호하는 성별 	0:무관, 1:남성, 2:여성, 3:커플
	private int place_type_activity;	//활동적 여부	0:no,	1:yes
	private int place_type_restaurant;	//음식점있는지	0:no,	1:yes
	private int place_type_drinking;	//주류가있는지	0:no,	1:yes
	private int place_type_majority;	//유명한곳인지	0:no,	1:yes
	private int place_type_mania;		//오타쿠인지	0:no,	1:yes
	private int place_type_exhibition;	//관람형식인지	0:no,	1:yes
	private int place_type_location;	//교내or교외	0:중심지,	1:외곽,	2:다른지역
	
	private int PLACE_THEME_SEQ;
	private int PLACE_SEQ;
	private int PLACE_THEME_FOOD;
	private int PLACE_THEME_SHOPPING;
	private int PLACE_THEME_HISTORY;
	private int PLACE_THEME_COUPLE;
	
	public AdminPlaceDTO() {
		super();
	}

	public AdminPlaceDTO(String place_seq, String place_area, String place_name, String place_type,
			String place_opentime, String place_closetime, String place_spendtime, String place_location,
			String place_detail, String place_image, String place_cost, String place_homepage, int place_type_gender,
			int place_type_activity, int place_type_restaurant, int place_type_drinking, int place_type_majority,
			int place_type_mania, int place_type_exhibition, int place_type_location, int pLACE_THEME_SEQ,
			int pLACE_SEQ2, int pLACE_THEME_FOOD, int pLACE_THEME_SHOPPING, int pLACE_THEME_HISTORY,
			int pLACE_THEME_COUPLE) {
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
		this.place_type_gender = place_type_gender;
		this.place_type_activity = place_type_activity;
		this.place_type_restaurant = place_type_restaurant;
		this.place_type_drinking = place_type_drinking;
		this.place_type_majority = place_type_majority;
		this.place_type_mania = place_type_mania;
		this.place_type_exhibition = place_type_exhibition;
		this.place_type_location = place_type_location;
		PLACE_THEME_SEQ = pLACE_THEME_SEQ;
		PLACE_SEQ = pLACE_SEQ2;
		PLACE_THEME_FOOD = pLACE_THEME_FOOD;
		PLACE_THEME_SHOPPING = pLACE_THEME_SHOPPING;
		PLACE_THEME_HISTORY = pLACE_THEME_HISTORY;
		PLACE_THEME_COUPLE = pLACE_THEME_COUPLE;
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

	public int getPlace_type_gender() {
		return place_type_gender;
	}

	public void setPlace_type_gender(int place_type_gender) {
		this.place_type_gender = place_type_gender;
	}

	public int getPlace_type_activity() {
		return place_type_activity;
	}

	public void setPlace_type_activity(int place_type_activity) {
		this.place_type_activity = place_type_activity;
	}

	public int getPlace_type_restaurant() {
		return place_type_restaurant;
	}

	public void setPlace_type_restaurant(int place_type_restaurant) {
		this.place_type_restaurant = place_type_restaurant;
	}

	public int getPlace_type_drinking() {
		return place_type_drinking;
	}

	public void setPlace_type_drinking(int place_type_drinking) {
		this.place_type_drinking = place_type_drinking;
	}

	public int getPlace_type_majority() {
		return place_type_majority;
	}

	public void setPlace_type_majority(int place_type_majority) {
		this.place_type_majority = place_type_majority;
	}

	public int getPlace_type_mania() {
		return place_type_mania;
	}

	public void setPlace_type_mania(int place_type_mania) {
		this.place_type_mania = place_type_mania;
	}

	public int getPlace_type_exhibition() {
		return place_type_exhibition;
	}

	public void setPlace_type_exhibition(int place_type_exhibition) {
		this.place_type_exhibition = place_type_exhibition;
	}

	public int getPlace_type_location() {
		return place_type_location;
	}

	public void setPlace_type_location(int place_type_location) {
		this.place_type_location = place_type_location;
	}

	public int getPLACE_THEME_SEQ() {
		return PLACE_THEME_SEQ;
	}

	public void setPLACE_THEME_SEQ(int pLACE_THEME_SEQ) {
		PLACE_THEME_SEQ = pLACE_THEME_SEQ;
	}

	public int getPLACE_SEQ() {
		return PLACE_SEQ;
	}

	public void setPLACE_SEQ(int pLACE_SEQ) {
		PLACE_SEQ = pLACE_SEQ;
	}

	public int getPLACE_THEME_FOOD() {
		return PLACE_THEME_FOOD;
	}

	public void setPLACE_THEME_FOOD(int pLACE_THEME_FOOD) {
		PLACE_THEME_FOOD = pLACE_THEME_FOOD;
	}

	public int getPLACE_THEME_SHOPPING() {
		return PLACE_THEME_SHOPPING;
	}

	public void setPLACE_THEME_SHOPPING(int pLACE_THEME_SHOPPING) {
		PLACE_THEME_SHOPPING = pLACE_THEME_SHOPPING;
	}

	public int getPLACE_THEME_HISTORY() {
		return PLACE_THEME_HISTORY;
	}

	public void setPLACE_THEME_HISTORY(int pLACE_THEME_HISTORY) {
		PLACE_THEME_HISTORY = pLACE_THEME_HISTORY;
	}

	public int getPLACE_THEME_COUPLE() {
		return PLACE_THEME_COUPLE;
	}

	public void setPLACE_THEME_COUPLE(int pLACE_THEME_COUPLE) {
		PLACE_THEME_COUPLE = pLACE_THEME_COUPLE;
	}

	@Override
	public String toString() {
		return "AdminPlaceDTO [place_seq=" + place_seq + ", place_area=" + place_area + ", place_name=" + place_name
				+ ", place_type=" + place_type + ", place_opentime=" + place_opentime + ", place_closetime="
				+ place_closetime + ", place_spendtime=" + place_spendtime + ", place_location=" + place_location
				+ ", place_detail=" + place_detail + ", place_image=" + place_image + ", place_cost=" + place_cost
				+ ", place_homepage=" + place_homepage + ", place_type_gender=" + place_type_gender
				+ ", place_type_activity=" + place_type_activity + ", place_type_restaurant=" + place_type_restaurant
				+ ", place_type_drinking=" + place_type_drinking + ", place_type_majority=" + place_type_majority
				+ ", place_type_mania=" + place_type_mania + ", place_type_exhibition=" + place_type_exhibition
				+ ", place_type_location=" + place_type_location + ", PLACE_THEME_SEQ=" + PLACE_THEME_SEQ
				+ ", PLACE_SEQ=" + PLACE_SEQ + ", PLACE_THEME_FOOD=" + PLACE_THEME_FOOD + ", PLACE_THEME_SHOPPING="
				+ PLACE_THEME_SHOPPING + ", PLACE_THEME_HISTORY=" + PLACE_THEME_HISTORY + ", PLACE_THEME_COUPLE="
				+ PLACE_THEME_COUPLE + "]";
	}
	
	
}
