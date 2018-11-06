package sesoc.global.smartplanner.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.RouteInfoDTO;

public class GoogleDirection {
	private final static String apiURL = "https://maps.googleapis.com/maps/api/directions/json";

	/**
	 * 루트를 계산하는 메소드
	 * 
	 * @param placeList
	 *            : 루트를 계산할 플레이의 리스트, 시작지점과 끝지점은 고정
	 * @param transit
	 *            : 0(자가용으로 이동), 1(대중교통 이용)
	 * @return 계산된 루트를 RouteInfoDTO 형태로 최단루트 순으로 정렬하여 리턴
	 */
	public RouteInfoDTO getDistanceFromPlaces(ArrayList<PlaceVO> placeList, int transit) {
		StringBuffer inputData = null;
		String travelMode = "";
		if (transit == 0) {
			travelMode = "DRIVING";
		} else if (transit == 1) {
			travelMode = "TRANSIT";
		} else {
			System.out.println("GoogleDistanceMatrixError:transit is not vaild");
			return null;
		}
		try {
			String requestURL = apiURL + "?key=" + GoogleMaps.apiKey + "&language=ja" + "&mode="
					+ URLEncoder.encode(travelMode, "UTF-8");
			requestURL += "&origin=" + URLEncoder
					.encode(placeList.get(0).getPlace_location() + placeList.get(0).getPlace_name(), "UTF-8");
			requestURL += "&destination=" + URLEncoder.encode(placeList.get(placeList.size() - 1).getPlace_location()
					+ placeList.get(placeList.size() - 1).getPlace_name(), "UTF-8");
			String wayPoint = "optimize:true|";
			for (int i = 1; i < placeList.size() - 1; i++) {
				wayPoint += URLEncoder.encode(placeList.get(i).getPlace_location() + placeList.get(i).getPlace_name(),
						"UTF-8");
				if (i < (placeList.size() - 2)) {
					wayPoint += "|";
				}
			}

			requestURL += "&waypoints=" + wayPoint;
			URL url = new URL(requestURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setDoOutput(false);
			con.setDoInput(true);
			con.setUseCaches(false);
			InputStream ist = con.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(ist));
			String input = "";
			inputData = new StringBuffer();
			while ((input = in.readLine()) != null) {
				inputData.append(input);
			}
			in.close();
			con.disconnect();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String json = inputData.toString();
		JsonObject root = new JsonParser().parse(json).getAsJsonObject();

		if (root.get("status").getAsJsonPrimitive().getAsString().equals("OK")) {
			JsonArray routes = root.get("routes").getAsJsonArray();
			JsonObject route = routes.get(0).getAsJsonObject();
			JsonArray legs = route.get("legs").getAsJsonArray();
			// 이동 시간 구하기
			int distance = 0;
			for (int i = 0; i < placeList.size() - 1; i++) {
				distance += legs.get(i).getAsJsonObject().get("duration").getAsJsonObject().get("value")
						.getAsJsonPrimitive().getAsInt();
			}
			// 이동 순서 구하기
			ArrayList<Integer> routeInfo = new ArrayList<Integer>();
			JsonArray waypoint_order = route.get("waypoint_order").getAsJsonArray();
			routeInfo.add(0);
			for (int i = 0; i < placeList.size() - 2; i++) {
				routeInfo.add(waypoint_order.get(i).getAsJsonPrimitive().getAsInt() + 1);
			}
			routeInfo.add(placeList.size() - 1);

			RouteInfoDTO resultDTO = new RouteInfoDTO();
			resultDTO.setDistance(distance);
			resultDTO.setRouteInfo(routeInfo);

			return resultDTO;
		} else {
			System.out.println("GoogleDirection Error :" + root.get("status").getAsJsonPrimitive().getAsString());
			return null;
		}
	}
}
