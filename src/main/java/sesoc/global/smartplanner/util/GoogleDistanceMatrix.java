package sesoc.global.smartplanner.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import sesoc.global.smartplanner.dto.PlaceVO;

@Controller
public class GoogleDistanceMatrix {
	private final static String apiURL = "https://maps.googleapis.com/maps/api/distancematrix/json";

	/**
	 * 여러 지점간의 이동시간을 구하는 함수
	 * 
	 * @param placeList
	 *            : 이동시간을 구할 PlaceVO의 ArrayList
	 * @param transit
	 *            : 0(자가용으로 이동), 1(대중교통 이용)
	 * @return 걸리는 시간(단위 seconds), return null : 에러
	 */
	public int[][] getDistances(ArrayList<PlaceVO> placeList, int transit) {
		StringBuffer inputData = null;
		String placeListParameter = "";
		String travelMode = null;
		if (transit == 0) {
			travelMode = "DRIVING";
		} else if (transit == 1) {
			travelMode = "TRANSIT";
		} else {
			System.out.println("GoogleDistanceMatrixError:transit is not vaild");
			return null;
		}
		for (int i = 0; i < placeList.size(); i++) {
			placeListParameter += placeList.get(i).getPlace_location()+placeList.get(i).getPlace_name();
			if (i < (placeList.size() - 1)) {
				placeListParameter += "|";
			}
		}
		try {
			URL url = new URL(apiURL + "?origins=" + URLEncoder.encode(placeListParameter, "UTF-8") + "&destinations=" + URLEncoder.encode(placeListParameter, "UTF-8")
					+ "&mode=" + URLEncoder.encode(travelMode, "UTF-8") + "&key=" + GoogleMaps.apiKey);
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
		int[][] distanceList = new int[placeList.size()][placeList.size()];
		JsonObject root = new JsonParser().parse(json).getAsJsonObject();
		if (root.get("status").getAsJsonPrimitive().getAsString().equals("OK")) {
			JsonArray rows = root.get("rows").getAsJsonArray();
			for (int i = 0; i < rows.size(); i++) {
				JsonArray elements = rows.get(i).getAsJsonObject().get("elements").getAsJsonArray();
				for (int j = 0; j < elements.size(); j++) {
					if (elements.get(j).getAsJsonObject().get("status").getAsJsonPrimitive().getAsString()
							.equals("OK")) {
						distanceList[i][j] = Integer.parseInt(elements.get(j).getAsJsonObject().get("duration")
								.getAsJsonObject().get("value").getAsString());
					} else {
						System.out.println("GoogleDistanceMatrixError:"
								+ elements.get(j).getAsJsonObject().get("status").getAsJsonPrimitive().getAsString());
						return null;
					}
				}
			}
			return distanceList;
		} else {
			System.out.println("GoogleDistanceMatrixError:" + root.get("status").getAsJsonPrimitive().getAsString());
			return null;
		}
	}

	/**
	 * 두 지점사이의 이동시간을 구하는 함수
	 * 
	 * @param start
	 *            : 시작지점 (좌표(33.142,137.234 형식) or 주소)
	 * @param end
	 *            : 도착지점 (좌표(33.142,137.234 형식) or 주소)
	 * @param transit
	 *            : 0(자가용으로 이동), 1(대중교통 이용)
	 * @return 걸리는 시간(단위 seconds), return -1 : 에러
	 */
	public int getDistance(String start, String end, int transit) {
		StringBuffer inputData = null;
		String travelMode = null;
		if (transit == 0) {
			travelMode = "DRIVING";
		} else if (transit == 1) {
			travelMode = "TRANSIT";
		} else {
			System.out.println("GoogleDistanceMatrixError:transit is not vaild");
			return -1;
		}
		try {
			URL url = new URL(apiURL + "?origins=" + URLEncoder.encode(start, "UTF-8") + "&destinations="
					+ URLEncoder.encode(end, "UTF-8") + "&mode=" + URLEncoder.encode(travelMode, "UTF-8") + "&key="
					+ GoogleMaps.apiKey);
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
			if (root.get("rows").getAsJsonArray().get(0).getAsJsonObject().get("elements").getAsJsonArray().get(0)
					.getAsJsonObject().get("status").getAsJsonPrimitive().getAsString().equals("OK")) {
				String result = root.get("rows").getAsJsonArray().get(0).getAsJsonObject().get("elements")
						.getAsJsonArray().get(0).getAsJsonObject().get("duration").getAsJsonObject().get("value")
						.getAsJsonPrimitive().getAsString();
				return Integer.parseInt(result);
			} else {
				System.out.println("GoogleDistanceMatrixError:"
						+ root.get("rows").getAsJsonArray().get(0).getAsJsonObject().get("elements").getAsJsonArray()
								.get(0).getAsJsonObject().get("status").getAsJsonPrimitive().getAsString());
				return -1;
			}
		} else {
			System.out.println("GoogleDistanceMatrixError:" + root.get("status").getAsJsonPrimitive().getAsString());
			return -1;
		}
	}

	/**
	 * 구글맵에서 가져온 좌표 형식을 Location 형식으로 바꿔주는 함수
	 * 
	 * @param location : (33.142,
	 *            137.234)
	 * @return 33.142,137.234
	 */
	public String parseLocation(String location) {
		location = location.replace("(", "");
		location = location.replace(" ", "");
		location = location.replace(")", "");
		return location;
	}
}