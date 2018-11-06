package sesoc.global.smartplanner.util;

import java.util.ArrayList;
import java.util.Collections;

import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.RouteInfoDTO;

public class RouteSearcher {
	private ArrayList<PlaceVO> placeList;
	private ArrayList<RouteInfoDTO> resultList;
	private ArrayList<Integer> routeInfo;

	private int[][] distanceList;
	private boolean[] visit;
	private int visitCount;
	private int distance;

	/**
	 * 루트를 계산하는 메소드
	 * 
	 * @param placeList
	 *            : 루트를 계산할 플레이의 리스트, 시작지점과 끝지점은 고정
	 * @param transit
	 *            : 0(자가용으로 이동), 1(대중교통 이용)
	 * @return 계산된 루트를 RouteInfoDTO 형태로 최단루트 순으로 정렬하여 리턴
	 */
	public ArrayList<RouteInfoDTO> calRoutes(ArrayList<PlaceVO> placeList, int transit) {

		this.placeList = placeList;

		GoogleDistanceMatrix googleDistanceMatrix = new GoogleDistanceMatrix();

		distanceList = googleDistanceMatrix.getDistances(placeList, transit);

		visit = new boolean[placeList.size()];
		visitCount = 0;
		distance = 0;

		resultList = new ArrayList<RouteInfoDTO>();
		routeInfo = new ArrayList<Integer>();
		routeInfo.add(0);

		searchRoutes(0);

		Collections.sort(resultList);

		return resultList;
	}

	/**
	 * 해당 순위의 루트순으로 정렬된 PlaceVO의 리스트를 반환하는 함수
	 * 
	 * @param rank
	 *            : 순위 (최단루트 0)
	 * @return 해당 순위의 루트순으로 정렬된 PlaceVO의 ArrayList를 반환
	 */
	public ArrayList<PlaceVO> getRoute(int rank) {
		ArrayList<PlaceVO> resultPlaceList = new ArrayList<PlaceVO>();

		ArrayList<Integer> routeInfo = resultList.get(rank).getRouteInfo();

		for (int i = 0; i < placeList.size(); i++) {
			int node = routeInfo.get(i);
			resultPlaceList.add(placeList.get(node));
		}

		return resultPlaceList;
	}
	
	/**
	 * 해당 순위의 루트순으로 정렬된 PlaceVO의 리스트를 반환하는 함수 (호텔 제외)
	 * 
	 * @param rank
	 *            : 순위 (최단루트 0)
	 * @return 해당 순위의 루트순으로 정렬된 PlaceVO의 ArrayList를 반환(고정된 첫번째와 마지막 인덱스 제외)
	 */
	public ArrayList<PlaceVO> getRouteExceptHotel(int rank) {
		ArrayList<PlaceVO> resultPlaceList = new ArrayList<PlaceVO>();

		ArrayList<Integer> routeInfo = resultList.get(rank).getRouteInfo();

		for (int i = 1; i < placeList.size()-1; i++) {
			int node = routeInfo.get(i);
			resultPlaceList.add(placeList.get(node));
		}

		return resultPlaceList;
	}

	/**
	 * 루트를 검색하는 내부 알고리즘
	 * 
	 * @param node
	 *            현재 노드
	 */
	private void searchRoutes(int node) {

		if (visitCount == placeList.size() - 2) {
			RouteInfoDTO dto = new RouteInfoDTO();

			int resultDistance = distance + distanceList[node][placeList.size() - 1];
			dto.setDistance(resultDistance);

			ArrayList<Integer> resultRouteInfo = new ArrayList<Integer>();
			resultRouteInfo.addAll(routeInfo);
			resultRouteInfo.add(placeList.size() - 1);
			dto.setRouteInfo(resultRouteInfo);
			
			resultList.add(dto);
			return;
		}

		for (int i = 1; i < placeList.size() - 1; i++) {
			if (i == node)
				continue;

			if (!visit[i]) {
				visit[i] = true;
				visitCount++;
				distance += distanceList[node][i];
				routeInfo.add(i);

				searchRoutes(i);

				visit[i] = false;
				visitCount--;
				distance -= distanceList[node][i];
				routeInfo.remove(routeInfo.size() - 1);
			}
		}
	}
}