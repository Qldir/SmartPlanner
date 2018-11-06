package sesoc.global.smartplanner.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sesoc.global.smartplanner.dao.PlaceRepository;
import sesoc.global.smartplanner.dao.PlaceThemeRepository;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.PlanDayDTO;
import sesoc.global.smartplanner.dto.PlanVO;
import sesoc.global.smartplanner.dto.RouteInfoDTO;

@Service
public class ThemeScheduleGenerator {

	@Autowired
	PlaceThemeRepository repository;
	// 하루 시작 및 종료 시간 분으로 표현

	private final static int dayStartTime = 60 * 10; // 하루가 시작하는 시간(분), 10시
	private final static int dayEndTime = 60 * 22; // 하루가 끝나는 시간(분), 22시

	public ArrayList<PlanDayDTO> generate(PlanVO plan, int plan_theme) {

		ArrayList<PlaceVO> placeList=null;
		
		switch (plan_theme) {
		case 0: // 음식 테마 result 
			placeList=repository.getByFood(plan.getPlan_area());
			break;
		case 1: // 쇼핑 테마 result 
			placeList=repository.getByShopping(plan.getPlan_area());
			break;
		case 2: // 역사 테마 result 
			placeList=repository.getByHistory(plan.getPlan_area());
			break;
		case 3: // 커플 테마 result 
			placeList=repository.getByCouple(plan.getPlan_area());
			break;
		}

		// 받아온 리스트 랜덤 돌리기
		Collections.shuffle(placeList);

		// 시작, 종료날짜 date 형태로 변환
		Date fromDate = parseDate(plan.getPlan_from());
		Date toDate = parseDate(plan.getPlan_to());

		// 현재 날짜 세팅
		Date currentDate = (Date) fromDate.clone();

		// 결과를 담아둘 리스트
		ArrayList<PlanDayDTO> resultList = new ArrayList<PlanDayDTO>();

		// 일정 시작, 종료 날짜 일수로 변환
		long fromDay = fromDate.getTime() / (24 * 60 * 60 * 1000);
		long toDay = toDate.getTime() / (24 * 60 * 60 * 1000);

		while (currentDate.getTime() < toDate.getTime()) {
			System.out.println("in");
			// 캘린더로 변환
			long currentDay = currentDate.getTime() / (24 * 60 * 60 * 1000);

			// 하루일정의 시작 및 종료 시간 초기화
			int startTime = dayStartTime;
			int endTime = dayEndTime;

			// 현재 날짜가 시작 날짜라면 시작시간 세팅
			if (currentDay == fromDay) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(fromDate);
				System.out.println(fromDate);
				int hour = cal.get(Calendar.HOUR_OF_DAY);
				int minute = cal.get(Calendar.MINUTE);
				startTime = hour * 60 + minute;
			}

			// 현재날짜가 종료 날짜라면 종료 시간 세팅
			if (currentDay == toDay) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(toDate);
				int hour = cal.get(Calendar.HOUR_OF_DAY);
				int minute = cal.get(Calendar.MINUTE);
				endTime = hour * 60 + minute;
			}

			ArrayList<PlaceVO> dayList = getDayPlan(plan, startTime, endTime, placeList);

			// 이동시간 계산용 리스트 생성
			ArrayList<PlaceVO> calList = getCalList(dayList, plan.getPlan_startlocation());
			// 최적 루트순으로 일정 정렬
			RouteSearcher routeSearcher = new RouteSearcher();
			routeSearcher.calRoutes(calList, 0);
			dayList = routeSearcher.getRouteExceptHotel(0);

			// 현재날짜 세팅
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			String date = format.format(currentDate);

			// 결과 맵에 일정 저장
			PlanDayDTO dto = new PlanDayDTO();
			dto.setDate(date);
			dto.setPlaceList(dayList);
			resultList.add(dto);

			// 시험 출력용
			System.out.println("date:" + dto.getDate());
			for (int i = 0; i < dayList.size(); i++) {
				System.out.println(dayList.get(i));
			}

			// currentDate 다음날 10시 세팅
			currentDate.setTime(currentDay * (24 * 60 * 60 * 1000) + ((24 + 1) * 60 * 60 * 1000));
			System.out.println(currentDate);
			Date test = new Date();
			test.setTime(fromDay * (24 * 60 * 60 * 1000));
			System.out.println(test);
			test.setTime(toDay * (24 * 60 * 60 * 1000));
			System.out.println(test);
		}

		return resultList;
	}

	private ArrayList<PlaceVO> getDayPlan(PlanVO plan, int startTime, int endTime, ArrayList<PlaceVO> placeList) {

		// 하루 일정을 담아두는 리스트
		ArrayList<PlaceVO> dayList = new ArrayList<PlaceVO>();

		// 시작시간이 10시 이상일 경우 빈 리스트 리턴
		if (startTime > 22 * 60) {
			return dayList;
		}

		setPlacesFromTo(placeList, dayList, 1);

		int flag = -1; // 시간 초과 or 부족 판별용 플래그

		// 점심, 저녁식사 여부
		boolean lunch = false;
		boolean dinner = false;

		while (true) {
			int daySumTime = calSpendTimePerDay(dayList, plan.getPlan_startlocation());

			/*
			 * // 현재 시간이 12시에서 3시 사이일 경우 점심식사 추가 if ((startTime + daySumTime) > 60 * 12 &&
			 * startTime + daySumTime < 60 * 15 && lunch == false) { GooglePlace gp = new
			 * GooglePlace();
			 * 
			 * PlaceVO lastPlace = null; if (dayList.size() > 0) { lastPlace =
			 * dayList.get(dayList.size() - 1); } else { PlaceVO hotel = new PlaceVO();
			 * hotel.setPlace_location(plan.getPlan_startlocation());
			 * hotel.setPlace_name(""); lastPlace = hotel; }
			 * 
			 * PlaceVO restaurant = gp.getNearbyRestaurantFromPlaceVO(lastPlace);
			 * dayList.add(restaurant);
			 * 
			 * lunch = true; continue; }
			 * 
			 * // 현재 시간이 17시에서 20시 사이일 경우 저녁식사 추가 if ((startTime + daySumTime) > 60 * 17 &&
			 * startTime + daySumTime < 60 * 20 && dinner == false) { GooglePlace gp = new
			 * GooglePlace();
			 * 
			 * PlaceVO lastPlace = null; if (dayList.size() > 0) { lastPlace =
			 * dayList.get(dayList.size() - 1); } else { PlaceVO hotel = new PlaceVO();
			 * hotel.setPlace_location(plan.getPlan_startlocation());
			 * hotel.setPlace_name(""); lastPlace = hotel; }
			 * 
			 * PlaceVO restaurant = gp.getNearbyRestaurantFromPlaceVO(lastPlace);
			 * dayList.add(restaurant);
			 * 
			 * dinner = true; continue; }
			 */
			System.out.println(startTime + " " + daySumTime + " " + dayEndTime);
			if (flag == 0) {
				if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
					setPlacesFromTo(dayList, placeList, 1); // 플레이스 하나 제거
					flag = 0;
				} else {
					break;
				}
			} else if (flag == 1) {
				if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
					break;
				} else {
					setPlacesFromTo(placeList, dayList, 1); // 플레이스 하나 제거
					flag = 1;
				}
			} else {
				if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
					setPlacesFromTo(dayList, placeList, 1); // 플레이스 하나 제거
					flag = 0;
				} else {
					setPlacesFromTo(placeList, dayList, 1);
					flag = 1;
				}
			}

			System.out.println(placeList.size());
		}

		return dayList;
	}

	// 하루일정 총 소모시간 계산(분)
	private int calSpendTimePerDay(ArrayList<PlaceVO> dayList, String start_location) {

		// 리스트가 비어있을 경수 0분 리턴
		if (dayList.size() == 0) {
			return 0;
		}

		// 이동시간 계산용 리스트 생성
		ArrayList<PlaceVO> calList = getCalList(dayList, start_location);

		// 이동시간 계산 알고리즘
		RouteSearcher routeSearcher = new RouteSearcher();
		ArrayList<RouteInfoDTO> routeResult = routeSearcher.calRoutes(calList, 0);

		// 하루의 총 이동 시간
		int dayMoveTime = (int) routeResult.get(0).getDistance() / 60;

		// 하루의 총 소모 시간
		int daySumTime = 0;
		daySumTime += dayMoveTime;

		// 일정별 소모시간 합치기
		for (int i = 0; i < dayList.size(); i++) {
			daySumTime += parseSpendTime(dayList.get(i).getPlace_spendtime());
		}

		return daySumTime;
	}

	// arrayList 사이의 내부 place 이동
	private void setPlacesFromTo(ArrayList<PlaceVO> from, ArrayList<PlaceVO> to, int num) {
		for (int i = 0; i < num; i++) {
			to.add(from.get(0));
			System.out.println(from.get(0));
			from.remove(0);
		}
	}

	// 받아온 날자 형태를 Date 형태로 변환
	private Date parseDate(String date) {
		Date result = new Date();
		SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy hh:mm aa", Locale.US);
		try {
			result = format.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	// spendtime을 분으로 환산
	private int parseSpendTime(String spendTime) {
		return Integer.parseInt(spendTime.split(":")[0]) * 60 + Integer.parseInt(spendTime.split(":")[1]);
	}

	// 계산용 호텔포함한 리스트 생성
	private ArrayList<PlaceVO> getCalList(ArrayList<PlaceVO> placeList, String start_location) {
		// 호텔위치 VO 생성
		PlaceVO hotel = new PlaceVO();
		hotel.setPlace_location(start_location);
		hotel.setPlace_name("");

		// 소모시간 계산을 위한 List
		ArrayList<PlaceVO> calList = new ArrayList<PlaceVO>();
		calList.add(hotel);
		for (int i = 0; i < placeList.size(); i++) {
			calList.add(placeList.get(i));
		}
		calList.add(hotel);
		return calList;
	}
	
/*	private ArrayList<PlaceVO> checkSpendTime(ArrayList<PlaceVO> placeList,int startTime, int endTime){
		// 하루 일정을 담아두는 리스트
				ArrayList<PlaceVO> dayList = new ArrayList<PlaceVO>();

				// 시작시간이 10시 이상일 경우 빈 리스트 리턴
				if (startTime > 22 * 60) {
					return dayList;
				}

				setPlacesFromTo(placeList, dayList, 1);

				int flag = -1; // 시간 초과 or 부족 판별용 플래그

				// 점심, 저녁식사 여부
				boolean lunch = false;
				boolean dinner = false;

				while (true) {
					int daySumTime = calSpendTimePerDay(dayList, plan.getPlan_startlocation());
					// 리스트가 비어있을 경수 0분 리턴
					if (dayList.size() == 0) {
						return 0;
					}

					// 이동시간 계산용 리스트 생성
					ArrayList<PlaceVO> calList = getCalList(dayList, start_location);

					// 이동시간 계산 알고리즘
					RouteSearcher routeSearcher = new RouteSearcher();
					ArrayList<RouteInfoDTO> routeResult = routeSearcher.calRoutes(calList, 0);

					// 하루의 총 이동 시간
					int dayMoveTime = (int) routeResult.get(0).getDistance() / 60;

					// 하루의 총 소모 시간
					int daySumTime = 0;
					daySumTime += dayMoveTime;

					// 일정별 소모시간 합치기
					for (int i = 0; i < dayList.size(); i++) {
						daySumTime += parseSpendTime(dayList.get(i).getPlace_spendtime());
					}

					return daySumTime;
					
					System.out.println(startTime + " " + daySumTime + " " + dayEndTime);
					if (flag == 0) {
						if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
							setPlacesFromTo(dayList, placeList, 1); // 플레이스 하나 제거
							flag = 0;
						} else {
							break;
						}
					} else if (flag == 1) {
						if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
							break;
						} else {
							setPlacesFromTo(placeList, dayList, 1); // 플레이스 하나 제거
							flag = 1;
						}
					} else {
						if (startTime + daySumTime > dayEndTime) { // 총 시간이 22시를 초과할 경우
							setPlacesFromTo(dayList, placeList, 1); // 플레이스 하나 제거
							flag = 0;
						} else {
							setPlacesFromTo(placeList, dayList, 1);
							flag = 1;
						}
					}

					System.out.println(placeList.size());
				}

				return dayList;
	}*/
}
