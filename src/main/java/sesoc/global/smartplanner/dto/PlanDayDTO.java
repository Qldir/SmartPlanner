package sesoc.global.smartplanner.dto;

import java.util.ArrayList;

public class PlanDayDTO {
	private String date;
	private ArrayList<PlaceVO> placeList;

	public PlanDayDTO(String date, ArrayList<PlaceVO> placeList) {
		super();
		this.date = date;
		this.placeList = placeList;
	}

	public PlanDayDTO() {
		super();
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public ArrayList<PlaceVO> getPlaceList() {
		return placeList;
	}

	public void setPlaceList(ArrayList<PlaceVO> placeList) {
		this.placeList = placeList;
	}

	@Override
	public String toString() {
		return "PlanDayDTO [date=" + date + ", placeList=" + placeList + "]";
	}

}
