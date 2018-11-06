<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>日程プリント</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
</head>
</head>
<body style="overflow-x:hidden;">
	<div class="row pt-0 mt-0 h-100 w-100 mx-0">
		<div class="col-sm-12 p-1 pt-2 h-100" style="background-color:white;">
			<div class="row w-100 m-0">
				<div class="h-auto w-100" id="planTitleView"></div>
				<div class="col-12 h-auto bg-light p-2 px-3 mt-2" id="moneyView"></div>
				<div class="col-12 pr-0 h-auto">
					<div class="row w-100 mr-1" id="resultView"></div>
				</div>
			</div>
		</div>
		<div class="col-sm-0 p-0">
			<div class="col-12 m-0" id="map"></div>
		</div>
	</div>
	
				
	<!-- 로딩화면 -->
	<div id="load">
		<img src="./resources/img/loading.gif" alt="loading">
	</div>
	

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
	<script src="./resources/js/navbar.js"></script>
	<script>
		var routeMap;
		var dayIndex;
		var placeList;
		var legIndex;
		var currentDate;
		
		$(function() {
			
			// 플랜 날짜 계산
			var planFrom=${result}.plan.plan_from;
			var planTo=${result}.plan.plan_to;
		
			var fromDate = new Date(planFrom.replace('.','/'));
			var toDate = new Date(planTo.replace('.','/'));
			
			if(dateToTime(fromDate)==dateToTime(toDate)){
				var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) ) + 1;
			}
			else{
				var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) );
			}
		
			// 플랜 제목 달기
			var titleComponent='';
			titleComponent+='<div class="row h-100 w-100">';
			titleComponent+='<div class="col-12 h-100 w-100">';
			titleComponent+='<div class="row h-100 w-100">';
			titleComponent+='<div class="col-6 h-100 mx-0 px-5 text-left">';
			titleComponent+='<h5 class="text-dark font-weight-bold mt-1">'+${result}.plan.plan_title+'</h5>';
			titleComponent+='</div>';
			titleComponent+='<div class="col-6 h-100 text-dark font-weight-bold mx-0 mt-2">';
			titleComponent+=planFrom
			titleComponent+=' ~ ';
			titleComponent+=planTo
			titleComponent+="   ("+days+"Days)";
			titleComponent+='</div>';
			titleComponent+='</div>';
			titleComponent+='</div>';
			
			$("#planTitleView").append(titleComponent);
			
			var imgsrc=${result}.plan.plan_img;
			
			// 예상 금액, 여행지 수 넣기
			var costSum=0;
			var placeSum=0;
			for(var i=0;i<${result}.dayPlanList.length;i++){
				var placeList=${result}.dayPlanList[i].placeList;
				for(var j=0;j<placeList.length;j++){
					costSum+=parseInt(placeList[j].place_cost);
					placeSum++;
				}
			}
			
			var costComponent='';
			costComponent+='<div class="col-12">'
			costComponent+='<i class="fas fa-coins mr-1"></i>';
			costComponent+=" 一人ごとに費用 : 最低 " +costSum+" ";
			costComponent+='<i class="fas fa-yen-sign mr-1"></i>';
			costComponent+='</div>';
			costComponent+='<div class="col-12 mt-1">';
			costComponent+='<i class="fas fa-map-marker-alt mr-2"></i>';
			costComponent+=" 総旅行地数 : " +placeSum+"個所";
			costComponent+='</div>';
			
			$("#moneyView").append(costComponent);
			
			
			$('#load').hide();
			
		});
		
		// 위치 찍어주기 콜백 함수
		function callbackDirections(){
			
			var dayComponent = '';
			if(dayIndex==0){
				dayComponent+='<div class="col-3 p-0 text-light text-center mt-2" style="background-color:teal;">';
			}else{
				dayComponent+='<div class="col-3 p-0 text-light text-center mt-5" style="background-color:teal;">';	
			}
			dayComponent+="<h4 class='pt-1'>Day"+(parseInt(dayIndex)+1);+"</h4";
			dayComponent+='</div>';
			if(dayIndex==0){
				dayComponent+='<div class="col-9 mt-2 bg-light">';
			}else{
				dayComponent+='<div class="col-9 mt-5 bg-light">';	
			}
			dayComponent+="<h5 class='pt-2'>"+${result}.dayPlanList[dayIndex].date+"</h4>";
			dayComponent+='</div>';
			dayComponent+='</div>';
			
			$("#resultView").append(dayComponent);
			
			if(dayIndex==0){
				currentDate=new Date(${result}.plan.plan_from);
			}else{
				currentDate.setTime(1*60*60*1000);
			}
			addhotelInList(${result}.plan.plan_startlocation);
			
			for(var i=0;i<placeList.length;i++){
				addLegInList(i);	
				addPlaceInList(placeList[i], i);
			}
				
			if(placeList.length>0){
				addLegInList(placeList.length);
				addhotelInListTo(${result}.plan.plan_startlocation);
			}
			
			
			dayIndex++;
			if(dayIndex<${result}.dayPlanList.length){
				placeList=${result}.dayPlanList[dayIndex].placeList;
				setWayPointsDirectionsByPlaces(${result}.dayPlanList[dayIndex].placeList, ${result}.plan.plan_startlocation, 0);
			}else{
				window.print();
			}
		}
		
		// 중간 루트 추가
		function addLegInList(index){
 			var legComponent = '';
			legComponent+='<div class="col-1 py-1 px-0 text-center">';
			legComponent+='<img src="./resources/img/icon/distance_line.gif">';
			legComponent+='</div>';
			legComponent+='<div class="col-11 py-1 px-0 ">';
			legComponent+='<input type="hidden" value="'+index+'">';
			legComponent+="距離 : "+directionResponse[index].distance.text+", 消耗時間 : "+directionResponse[index].duration.text;
			legComponent+='</div>';
			$("#resultView").append(legComponent);
			
			currentDate.setTime(currentDate.getTime() + parseInt(directionResponse[index].duration.value)*1000);
		}
		
		// 호텔 리스트에 추가
		function addhotelInList(address){
			var resultComponent = '';
			resultComponent+='<div class="col-1 py-1 px-0  text-center bg-primary">';
			resultComponent+='<div class="rounded-circle text-light font-weight-bold ml-1" style="width:30px; height:30px; background-color:teal;">H</div>';
			resultComponent+='</div>';
			resultComponent+='<div class="col-11 py-1 px-0 bg-primary">';
			resultComponent+='<h6 class="mb-1">'+address+'</h6>';
			if(placeList.length>0){
				resultComponent+='<p class="mb-0 text-center" style="font-size:14px;">予想出発時間 : '+dateToTime(currentDate)+'</p>';
			}
			resultComponent+='</div>';
			
			$("#resultView").append(resultComponent);
		}
		
		function addhotelInListTo(address){
			var resultComponent = '';
			resultComponent+='<div class="col-1 py-1 px-0  text-center bg-primary">';
			resultComponent+='<div class="rounded-circle text-light font-weight-bold ml-1" style="width:30px; height:30px; background-color:teal;">H</div>';
			resultComponent+='</div>';
			resultComponent+='<div class="col-11 py-1 px-0 bg-primary">';
			resultComponent+='<h6 class="mb-1">'+address+'</h6>';
			resultComponent+='<p class="mb-0 text-center" style="font-size:14px;">予想到着時間  : '+dateToTime(currentDate)+'</p>';
			resultComponent+='</div>';
			
			$("#resultView").append(resultComponent);
		}
		
		// 플레이스 리스트에 추가
		function addPlaceInList(place, index){
			var resultComponent = '';
			resultComponent+='<div class="col-1 py-1 px-0  text-center bg-primary">';
			resultComponent+='<div class="rounded-circle text-light font-weight-bold ml-1" style="width:30px; height:30px; background-color:teal;">'+(index+1)+'</div>';
			resultComponent+='</div>';
			resultComponent+='<div class="col-3 py-1 px-0 bg-primary">';
			resultComponent+='<img src="./resources/img/place/'+place.place_image+'" style="height:90px; width:120px; ">';
			resultComponent+='</div>';
			resultComponent+='<div class="col-8 py-1 px-0 bg-primary">';
			resultComponent+='<h6 class="mb-1">'+place.place_name+'</h6>';
			resultComponent+='<p class="mb-0" style="font-size:14px;">予想到着時間  : '+dateToTime(currentDate)+'</p>';
			resultComponent+='<p class="mb-0" style="font-size:14px;">予定使用時間  : '+place.place_spendtime+'</p>';
			// 시간 더하기
			currentDate.setTime(currentDate.getTime() + parseInt(place.place_spendtime.split(':')[0])*60*60*1000 + parseInt(place.place_spendtime.split(':')[1])*60*1000);
			resultComponent+='<p class="mb-0" style="font-size:14px;">予想出発時間 : '+dateToTime(currentDate)+'</p>';
			resultComponent+='</div>';
			
			$("#resultView").append(resultComponent);
		}
		
		// 루트 상세정보 모달 표시
		function routeModal(){
			$("#routeResultView").html("");
			var indexRoute = $(this).children("input").val();
			legIndex=indexRoute;
			calculateAndDisplayRoute(directionResponse[indexRoute].start_location, directionResponse[indexRoute].end_location, 0);
			$("#detailRouteModal").modal();
		}

		
		function initMap(){}
		
		// 구글맵 콜백함수
		$(() => {
			initMap = function () {
				var myOption = {
					zoom : 10,
					center : {
						lat : 35.6894875,
						lng : 139.6917639999993
					},
					gestureHandling : 'greedy'
				};
	
				map = new google.maps.Map(document.getElementById('map'), myOption);
				
				dayIndex=0;
				placeList=${result}.dayPlanList[0].placeList;
				setWayPointsDirectionsByPlaces(${result}.dayPlanList[0].placeList, ${result}.plan.plan_startlocation, 0);
			}
		});
		
		
		// 데이트 시간으로 변환
		function dateToTime(date){
		    return ("0" + date.getHours()).slice(-2) + ":" +("0" + date.getMinutes()).slice(-2);
		}
		
	</script>
	<script src="./resources/js/googleMap.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBsibtVFd7RMFL3pevLFwrAEut_2hPwmw&libraries=places&language=ja&callback=initMap"
		async defer></script>
</body>
</html>