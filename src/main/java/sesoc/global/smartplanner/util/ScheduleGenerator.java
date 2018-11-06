package sesoc.global.smartplanner.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sesoc.global.smartplanner.dao.PlaceTypeRepository;
import sesoc.global.smartplanner.dto.PlaceDTO;
import sesoc.global.smartplanner.dto.PlaceTypeVO;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.PlanDayDTO;
import sesoc.global.smartplanner.dto.PlanVO;

@Service
public class ScheduleGenerator {
	
	@Autowired
	PlaceTypeRepository repository;
	
	@Autowired
	GoogleDistanceMatrix distance;
	
	private ArrayList<PlaceDTO> placeList;					//option에 맞는 place가 저장
	private ArrayList<PlaceDTO> dayPlan;						//하루 place list가 저장
	//private HashMap<String,ArrayList<PlaceVO>> totalPlan;	//전체 일정이 저장될 map, (key:day,value:dayPlan)
	
	private double totalWeight;
	private boolean shopWeight = false;			//처음 일정에 쇼핑이 안들어가게
	private boolean maniaWeight = true;
	private boolean exhibitionWeight = true;
	
	private static final double highWeight = 100;
	private static final double lowWeight = 0.5;
	
	private static String dayStartTime = "10:00";		//하루 일정 시작시간
	private static String dayEndTime = "22:00";		//하루 일정 종료시간
	
	private static final String startLunchTime = "12:00";	//점심 시작 시간
	private static final String endLunchTime = "15:00";		//점심 종료 시간
	
	private static final String startDinnerTime = "17:30";	//저녁 시작 시간
	private static final String endDinnerTime = "20:00";	//저녁 종료 시간
	
	
	/**
	 * 유저의 입력된 값을 받아 하루 일정을 추천해주는 메소드
	 * @param plan				Plan에 대한 기본 정보(Title, 시작일, 종료일, 여행지역, 인원, cost)
	 * @param placeType			유저가 선택한 plan Option이 들어있는 parameter
	 * @return					하루 일정이 담긴 ArrayList
	 * @throws ParseException
	 */
	public ArrayList<PlanDayDTO> generate(PlanVO plan, PlaceTypeVO placeType) throws ParseException{
		dayEndTime = "22:00";
		placeList = repository.getList(placeType);
		System.out.println(placeList);
		// 결과를 담아둘 리스트
		ArrayList<PlanDayDTO> resultList = new ArrayList<PlanDayDTO>();
		
		// 시작, 종료날짜 date 형태로 변환
		Date fromDate = parseDate(plan.getPlan_from());
		Date toDate = parseDate(plan.getPlan_to());

		// 현재 날짜 세팅
		Date currentDate = (Date) fromDate.clone();

		// 일정 시작, 종료 날짜 일수로 변환
		long fromDay = fromDate.getTime() / (24 * 60 * 60 * 1000);
		long toDay = toDate.getTime() / (24 * 60 * 60 * 1000);

		while (currentDate.getTime() < toDate.getTime()) {
			System.out.println("in");
			// 캘린더로 변환
			long currentDay = currentDate.getTime() / (24 * 60 * 60 * 1000);

			// 현재 날짜가 시작 날짜라면 시작시간 세팅
			if (currentDay == fromDay) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(fromDate);
				int hour = cal.get(Calendar.HOUR_OF_DAY);
				int minute = cal.get(Calendar.MINUTE);
				dayStartTime = hour+":"+minute;
				System.out.println(dayStartTime);
			}

			// 현재날짜가 종료 날짜라면 종료 시간 세팅
			if (currentDay == toDay) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(toDate);
				int hour = cal.get(Calendar.HOUR_OF_DAY);
				int minute = cal.get(Calendar.MINUTE);
				dayEndTime = hour+":"+minute;
			}
			
			//하루 일정 받아옴
			System.out.println(dayEndTime);
			ArrayList<PlaceVO> dayPlan = getDayPlan(plan, placeType);
			dayStartTime = "10:00";
			// 이동시간 계산용 리스트 생성
			ArrayList<PlaceVO> calList = getCalList(dayPlan, plan.getPlan_startlocation());
			// 최적 루트순으로 일정 정렬
			RouteSearcher routeSearcher = new RouteSearcher();
			routeSearcher.calRoutes(calList, 0);
			dayPlan = routeSearcher.getRouteExceptHotel(0);
			

			// 현재날짜 세팅
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			String date = format.format(currentDate);
			System.out.println(date);
			// 결과 맵에 일정 저장
			PlanDayDTO dto = new PlanDayDTO();
			dto.setDate(date);
			dto.setPlaceList(dayPlan);
			resultList.add(dto);
			
			// 시험 출력용
			for(int i=0;i<resultList.size();i++) {
				System.out.println(resultList.get(i));
			}
			
			// currentDate 다음날 10시 세팅
			currentDate.setTime(currentDay*(24 * 60 * 60 * 1000)+((24 + 1) * 60 * 60 * 1000));
			System.out.println(currentDate);
			Date test = new Date();
			test.setTime(fromDay*(24 * 60 * 60 * 1000));
			System.out.println(test);
			test.setTime(toDay*(24 * 60 * 60 * 1000));
			System.out.println(test);
			
			dayStartTime = "10:00";
		
		}
		

		
		return resultList;
	}
	
	
	
	/** 하루 일정을 생성해주는 메소드
	 * 
	 * @param plan
	 * @param placeType
	 * @return
	 * @throws ParseException
	 */
	public ArrayList<PlaceVO> getDayPlan(PlanVO plan, PlaceTypeVO placeType) throws ParseException{

		//하루 일정을 담는 리스트
		dayPlan = new ArrayList<PlaceDTO>();
		
		//PlaceVO로 변경
		ArrayList<PlaceVO> resultPlan = new ArrayList<PlaceVO>();
		
		//가중치 세팅
		weightSet(placeType);
		
		//시간 포맷을 HH:mm으로 설정하기 위한 SimpleDateFormat
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		

		Date startTime = sdf.parse(dayStartTime);		//하루 일정 시작시간
		Date lastTime = sdf.parse(dayEndTime);			//하루 일정 종료시간
		
		/*
		Date sLunchTime = sdf.parse(startLunchTime);	//점심 시작 시간
		Date eLunchTime = sdf.parse(endLunchTime);		//점심 종료 시간
		
		Date sDinnerTime = sdf.parse(startDinnerTime);	//저녁 시작 시간
		Date eDinnerTime = sdf.parse(endDinnerTime);	//저녁 종료 시간
		 */		
		
		
		/**
		 * 입력된 하루 여행지 리스트에서 shopping, exhibition, mania 데이터가 있는지 체크
		 * 있다면 Weight값 false로 전환하여 확률 down
		 */
		for(int r=0;r<placeList.size();r++) {
			
			for(PlaceDTO d:dayPlan) {
				if(d.getPlace_type().equals("S")) {
					shopWeight=false;
					weightSet(placeType);
				}
				if(d.getPlace_type_exhibition()==1) {
					exhibitionWeight=false;
					weightSet(placeType);
				}
				if(d.getPlace_type_mania()==1) {
					maniaWeight=false;
					weightSet(placeType);
				}
			}
			
			Random random = new Random();
			
			double rWeight = (double)random.nextDouble() * totalWeight;
			
			for(int i=0;i<placeList.size();i++){
				if(rWeight<placeList.get(i).getWeight()){
					
					Date openTime = sdf.parse(placeList.get(i).getPlace_opentime());		//place openTime
					Date closeTime = sdf.parse(placeList.get(i).getPlace_closetime());		//place closeTime
					Date endTime = addTime(placeList.get(i).getPlace_spendtime(),startTime);	//예정 종료시간
					
					/**
					 * 여행지의 시간 계산을 해주는 if문
					 * 
					 * openTime : place의 openTime
					 * closeTime : place의 closeTime
					 * endTime : place의 예정 종료시간으로 이 place의 시작시간+소요시간을 더하여 예정 종료시간을 나타냄
					 * 
					 * 
					 * calTime(openTime, startTime) -> openTime | startTime(place시작시간) 비교
					 * calTime(closeTime, startTime) -> closeTime | startTime(place시작시간) 비교
					 * calTime(closeTime, endTime) -> closeTime | endTime 비교
					 * calTime(endTime, lastTime) -> endTime | lastTime(plan 종료시간) 비교
					 * 
					 */
					if( (calTime(openTime, startTime)!=-1 && calTime(closeTime, startTime)==-1 && calTime(closeTime, endTime)==-1 && calTime(endTime,lastTime)!=-1)
							|| (calTime(openTime, startTime)!=-1 && calTime(openTime, closeTime)!=1 && calTime(closeTime, startTime)==1 && calTime(endTime,lastTime)!=-1) ) {
						
						if(dayPlan.size()<1) {
							System.out.println(startTime);
							startTime = addTime(placeList.get(i).getPlace_spendtime(), startTime);
							//sout 출력
						
							System.out.println(placeList.get(i));
							dayPlan.add(placeList.get(i));
							totalWeight -= placeList.get(i).getWeight();
							placeList.remove(i);
							
							shopWeight=true;
							break;
						}else{
							int costSec = distance.getDistance(dayPlan.get(dayPlan.size()-1).getPlace_location()+""+dayPlan.get(dayPlan.size()-1).getPlace_name(),
									placeList.get(i).getPlace_location()+""+placeList.get(i).getPlace_name(), 0);
							System.out.println(costSec);
							
							int costHour = costSec/3600;
							int costMin = costSec/60;
							String costTime = costHour+":"+costMin;
							startTime = addTime(costTime, startTime);
							startTime = addTime(placeList.get(i).getPlace_spendtime(), startTime);
				
							
							
							System.out.println(costTime);
							System.out.println(startTime);
							//sout 출력
							
							System.out.println(placeList.get(i));
							dayPlan.add(placeList.get(i));
							totalWeight -= placeList.get(i).getWeight();
							placeList.remove(i);
							break;
						}
						
					}//시간계산 if문 끝
					
				}//가중치로 데이터 뽑는 부분
				else{
					rWeight -= placeList.get(i).getWeight();
				}
			}//for
			
			
			
		}//for
		
		
		for(PlaceDTO p:dayPlan) {
			PlaceVO place = new PlaceVO();
			place.setPlace_seq(p.getPlace_seq());
			place.setPlace_area(p.getPlace_area());
			place.setPlace_name(p.getPlace_name());
			place.setPlace_type(p.getPlace_type());
			place.setPlace_opentime(p.getPlace_opentime());
			place.setPlace_closetime(p.getPlace_closetime());
			place.setPlace_spendtime(p.getPlace_spendtime());
			place.setPlace_location(p.getPlace_location());
			place.setPlace_detail(p.getPlace_detail());
			place.setPlace_image(p.getPlace_image());
			place.setPlace_cost(p.getPlace_cost());
			place.setPlace_homepage(p.getPlace_homepage());
			place.setPlace_grade(p.getPlace_grade());
			resultPlan.add(place);
		}

		return resultPlan;
	
	}
	
	
	/** 가중치 세팅 메소드
	 * Last Update : 2018-09-04
	 * @param placeType		유저가 선택한 placeType
	 * 
	 * 각 타입(shopping, exhibition, mania타입이 체크되어있는지 확인 후 가중치 부여)
	 * 모든 여행지의 기본 가중치는 1이 주어지며
	 * 체크된 타입에 대해서는 50을 부여, 데이터가 입력된 타입은 0.5로 변경되어 빈도를 낮춤(최소 1개를 뽑기위해)
	 * 단, shopping의 경우 첫 여행지가 쇼핑이 되는걸 막기위해 false로 시작, 이후 true 전환
	 */
	public void weightSet(PlaceTypeVO placeType) {
		
		//가중치 합 초기화
		totalWeight = 0;
		
		for(PlaceDTO p : placeList) {
			p.setWeight(1);
			//Shopping 선택 시 가중치
			if(placeType.getPlace_type_shopping()==1) {
				if(p.getPlace_type().equals("S") && shopWeight==true) {
					p.setWeight(highWeight);
				}
				if(p.getPlace_type().equals("S") && shopWeight==false) {
					p.setWeight(lowWeight);
				}
			}
			//exhibition 선택 시 가중치
			if(placeType.getPlace_type_exhibition()==1) {
				if(p.getPlace_type_exhibition()==1 && exhibitionWeight==true) {
					p.setWeight(highWeight);
				}
				if(p.getPlace_type_exhibition()==1 && exhibitionWeight==false) {
					p.setWeight(highWeight);
				}
			}
			//mania 선택 시 가중치
			if(placeType.getPlace_type_mania()==1) {
				if(p.getPlace_type_mania()==1 && maniaWeight==true) {
					p.setWeight(highWeight);
				}
				if(p.getPlace_type_mania()==1 && maniaWeight==false) {
					p.setWeight(lowWeight);
				}
			}
			//가중치 합산
			totalWeight += p.getWeight();
		}
	
	}
	
	
	/**
	 * Last Update : 2018-09-01
	 * @param Date date1	설정된 시간 값
	 * @param Date date2	비교할 시간 값
	 * @return int 			앞의 시간이 빠르면 1, 같으면 0, 뒤의 시간이 빠르면 -1 리턴
	 */
	public int calTime(Date date1, Date date2) {
		int result=0;
		
		if(date1.before(date2)) {
			result = 1;		//앞의 시간이 빠르면 1
		}
		if(date1.equals(date2)) {
			result = 0;		//시간이 서로 같으면 0
		}
		if(date2.before(date1)) {
			result = -1;		//뒤의 시간이 빠르면 -1
		}
		
		return result;
	}
	
	
	/**
	 * Last Update : 2018-09-01
	 * @param spendTime		여행지 소요시간
	 * @param date			현재 스케줄의 여행지 입력 시간 ex) 10:00 부터 입력이 들어가면 date는 10:00,
	 * 						소요시간이 2:00 이면 10:00~12:00에 데이터가 들어가고 다음 데이터의 입력시간은 12:00부터 설정되어야 함
	 * 
	 * @return				데이터 입력 시간에 소요시간을 더하여 다음 데이터 입력 시간을 return
	 * @throws ParseException
	 */
	public Date addTime(String spendTime, Date date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		Date aTime = sdf.parse(spendTime);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR, aTime.getHours());
		cal.add(Calendar.MINUTE, aTime.getMinutes());
		
		return cal.getTime();
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
	
	// 계산용 호텔포함한 리스트 생성
	private ArrayList<PlaceVO> getCalList(ArrayList<PlaceVO> placeList, String start_location){
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

}
