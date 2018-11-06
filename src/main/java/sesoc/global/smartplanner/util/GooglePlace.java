package sesoc.global.smartplanner.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import sesoc.global.smartplanner.dto.PlaceVO;

public class GooglePlace {
	private final static String apiURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

	/**
	 * 
	 * @param location : 좌표 (34.34234,127.234234 형식)
	 * @return placeVO 형태로 가장 가까운 레스토랑 출력
	 */
	public PlaceVO getNearbyRestaurant(String location) {
		StringBuffer inputData = null;
		try {
			URL url = new URL(apiURL + "?location=" + URLEncoder.encode(location, "UTF-8") + "&language=ja"
					+ "&type=restaurant" +"&radius=50000"+ "&key=" + GoogleMaps.apiKey);
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
			PlaceVO place = new PlaceVO();
			
			// Place 결과 Array
			JsonArray results=root.get("results").getAsJsonArray();
			
			// 가장 첫번째 결과
			JsonObject result=results.get(0).getAsJsonObject();
			
			String place_name=result.get("name").getAsJsonPrimitive().getAsString();
			String place_location=result.get("vicinity").getAsJsonPrimitive().getAsString();
			String place_grade=result.get("rating").getAsJsonPrimitive().getAsString();
			String place_image=result.get("photos").getAsJsonArray().get(0).getAsJsonObject().get("photo_reference").getAsJsonPrimitive().getAsString();
			
			place.setPlace_type("F");
			place.setPlace_name(place_name);
			place.setPlace_location(place_location);
			place.setPlace_grade(place_grade);
			place.setPlace_image(place_image);
			place.setPlace_spendtime("1:00");
			
			return place;
		} else {
			System.out.println("GooglePlaceError:" + root.get("status").getAsJsonPrimitive().getAsString());
			return null;
		}
	}
	
	/**
	 * 
	 * @param place : 기준위치가 되는 PlaceVO 입력
	 * @return 가장 가까운 레스토랑 PlaceVO 형태로 출력
	 */
	public PlaceVO getNearbyRestaurantFromPlaceVO(PlaceVO place) {
		String address=place.getPlace_location()+place.getPlace_name();
		GoogleGeocoding geocoding = new GoogleGeocoding();
		String location=geocoding.getLocationByAddress(address);
		PlaceVO result=getNearbyRestaurant(location);
		return result;
	}
}
