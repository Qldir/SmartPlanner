package sesoc.global.smartplanner.dto;

import java.util.ArrayList;

public class RouteInfoDTO implements Comparable<Object> {
	private ArrayList<Integer> routeInfo;
	private int distance;

	public RouteInfoDTO() {
		super();
	}

	public RouteInfoDTO(ArrayList<Integer> routeInfo, int distance) {
		super();
		this.routeInfo = routeInfo;
		this.distance = distance;
	}

	public ArrayList<Integer> getRouteInfo() {
		return routeInfo;
	}

	public void setRouteInfo(ArrayList<Integer> routeInfo) {
		this.routeInfo = routeInfo;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	@Override
	public String toString() {
		return "TspResultDTO [routeInfo=" + routeInfo + ", distance=" + distance + "]";
	}

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		return this.distance - ((RouteInfoDTO) o).getDistance();
	}

}
