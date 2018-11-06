package sesoc.global.smartplanner.dto;

public class PlaceTypeVO {
	private int place_type_seq;			//place_type 시퀀스
	private int place_seq;				//place 시퀀스
	private int place_type_gender;		//선호하는 성별 	0:무관, 1:남성, 2:여성, 3:커플
	private int place_type_activity;	//활동적 여부	0:no,	1:yes
	private int place_type_restaurant;	//음식점있는지	0:no,	1:yes
	private int place_type_drinking;	//주류가있는지	0:no,	1:yes
	private int place_type_majority;	//유명한곳인지	0:no,	1:yes
	private int place_type_mania;		//오타쿠인지	0:no,	1:yes
	private int place_type_exhibition;	//관람형식인지	0:no,	1:yes
	private int place_type_location;	//교내or교외	0:중심지,	1:외곽,	2:다른지역
	//아래는 db에 없는 컬럼
	private int place_area;				//여행지역		0:도쿄	1:오사카
	private int place_type_shopping;	//쇼핑 여부		0:no,	1:yes
	
	
	public PlaceTypeVO() {
		super();
	}


	public PlaceTypeVO(int place_type_seq, int place_seq, int place_type_gender, int place_type_activity,
			int place_type_restaurant, int place_type_drinking, int place_type_majority, int place_type_mania,
			int place_type_exhibition, int place_type_location, int place_area, int place_type_shopping) {
		super();
		this.place_type_seq = place_type_seq;
		this.place_seq = place_seq;
		this.place_type_gender = place_type_gender;
		this.place_type_activity = place_type_activity;
		this.place_type_restaurant = place_type_restaurant;
		this.place_type_drinking = place_type_drinking;
		this.place_type_majority = place_type_majority;
		this.place_type_mania = place_type_mania;
		this.place_type_exhibition = place_type_exhibition;
		this.place_type_location = place_type_location;
		this.place_area = place_area;
		this.place_type_shopping = place_type_shopping;
	}


	public int getPlace_type_seq() {
		return place_type_seq;
	}


	public void setPlace_type_seq(int place_type_seq) {
		this.place_type_seq = place_type_seq;
	}


	public int getPlace_seq() {
		return place_seq;
	}


	public void setPlace_seq(int place_seq) {
		this.place_seq = place_seq;
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


	public int getPlace_area() {
		return place_area;
	}


	public void setPlace_area(int place_area) {
		this.place_area = place_area;
	}


	public int getPlace_type_shopping() {
		return place_type_shopping;
	}


	public void setPlace_type_shopping(int place_type_shopping) {
		this.place_type_shopping = place_type_shopping;
	}


	@Override
	public String toString() {
		return "PlaceTypeVO [place_type_seq=" + place_type_seq + ", place_seq=" + place_seq + ", place_type_gender="
				+ place_type_gender + ", place_type_activity=" + place_type_activity + ", place_type_restaurant="
				+ place_type_restaurant + ", place_type_drinking=" + place_type_drinking + ", place_type_majority="
				+ place_type_majority + ", place_type_mania=" + place_type_mania + ", place_type_exhibition="
				+ place_type_exhibition + ", place_type_location=" + place_type_location + ", place_area=" + place_area
				+ ", place_type_shopping=" + place_type_shopping + "]";
	}
	

}
