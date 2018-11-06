<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>日程修正</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
<link rel="stylesheet" href="./resources/css/bootstrap-datetimepicker.min.css">
<style>
	body.dragging, body.dragging * {
	  cursor: move !important;
	}
	
	.dragged {
	  position: absolute;
	  opacity: 0.5;
	  z-index: 2000;
	}
	
	ol.draggableList li.placeholder {
	  position: relative;
	  /** More li styles **/
	}
	ol.draggableList li.placeholder:before {
	  position: absolute;
	  /** Define arrowhead **/
	}
	
	ol{
    	list-style: none;
    	margin:0px; padding:0px;
	}
	
</style>
</head>
</head>
<body>
	<nav
		class="navbar fixed-top navbar-expand-md navbar-dark navbar-shadow">
		<div class="container">
			<a class="navbar-brand" href="/smartplanner"> <img
				src="./resources/img/icon/planstation.png" style="height:25px; width:35px;" class="mr-1"> <b> Plan Station</b>
			</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse text-center justify-content-end"
				id="navbar2">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link font-weight-bold"
						href="/smartplanner/placesearch">旅行地</a></li>
					<li class="nav-item"><a class="nav-link font-weight-bold"
						href="/smartplanner/planning">日程作り</a></li>
					<li class="nav-item"><a class="nav-link font-weight-bold"
						href="/smartplanner/hotel">ホテル</a></li>
					<li class="nav-item"><a class="nav-link font-weight-bold"
						href="/smartplanner/planboard">日程掲示板</a></li>
					<li class="nav-item"><a class="nav-link font-weight-bold"
						href="/smartplanner/howtouse">使用方法</a></li>
				</ul>

				<ul class="navbar-nav">
					<li class="nav-item">
						<div class="input-group">
							<input class="form-control" type="search"
								placeholder="旅行地を探してみてください" aria-label="Search"
								id="searchInputNavbar">
							<div class="input-group-append">
								<button class="btn navbar-btn mr-2 text-white btn-secondary"
									id="searchButtonNavbar">検索</button>
							</div>
						</div>
					</li>
					<c:if test="${sessionScope.member_email==null }">
						<li class="nav-item"><a
							class="btn navbar-btn ml-2 text-white btn-secondary" id="login">
								<i class="fas d-inline fa-lg fa-user-circle"></i> ログイン
						</a></li>
					</c:if>
					<c:if test="${sessionScope.member_email!=null }">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle font-weight-bold btn bg-secondary text-white border-0"
							href="#" id="navbarDropdownMenuLink" role="button"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas d-inline fa-lg fa-user-circle"></i>
								${sessionScope.member_name}
						</a>
							<div class="dropdown-menu dropdown-menu-right"
								aria-labelledby="navbarDropdown">
								<a class="dropdown-item" href="/smartplanner/mypage">マイページ</a>
								<a class="dropdown-item" href="/smartplanner/myplan">旅行日程</a>
								<a class="dropdown-item" href="/smartplanner/myfavorite">お気に入り</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="/smartplanner/GotoLogout">ログアウト</a>
								<c:if test="${sessionScope.member_type==1 }">
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="/smartplanner/adminpage">管理者ページ</a>
								</c:if>
							</div></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Modal -->
	<div class="modal fade" id="loginModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="card border-secondary" id="signinContainer">
					<div class="card-header">
						<h3 class="mb-0 my-2">ログイン</h3>
					</div>
					<div class="card-body">

						<form id="formLogin" action="loginNavbar" method="post">
							<div class="form-group">
								<label for="inputEmail3">メールアドレス</label> <input type="email"
									class="form-control" id="loginEmail"
									placeholder="email@gmail.com" name="member_email">
								<div class="invalid-feedback">a@a.a形式で入力してください</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3">暗証番号</label> <input type="password"
									class="form-control" id="loginPassword" placeholder="password"
									name="member_pw" autocomplete="off">
								<div class="invalid-feedback">暗証番号は8-16字で入力してください</div>
							</div>
						</form>

						<div class="form-group">
							<button type="button"
								class="btn btn-info btn-lg float-right w-100 mt-2" id="signin">ログイン</button>
							<a href="join"><button type="button"
									class="btn btn-light btn-lg float-right w-100 mt-2"
									id="googleSignin">
									<img width="20px" alt="Google &quot;G&quot; Logo"
										src="./resources/img/icon/icon-google.png" /> &nbsp; Google
									アカウントでログイン
								</button></a> <label class="mt-2">まだPLAN STATIONの会員ではございませんか？ <a href="#"
								id="signup">会員登録</a></label>
						</div>
					</div>
				</div>
				<div class="card border-secondary" id="signupContainer"
					style="display: none;">
					<div class="card-header">
						<h3 class="mb-0 my-2">会員登録</h3>
					</div>
					<form>
						<div class="card-body">
							<div class="form-group">
								<label for="inputName">お名前</label> <input type="text"
									class="form-control" id="inputUpName" placeholder="full name"
									required="true">
								<div class="invalid-feedback">お名前は2文字以上で入力してください</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3">メールアドレス</label> <input type="email"
									class="form-control" id="inputUpEmail"
									placeholder="email@gmail.com" required="true">
								<div class="valid-feedback">有効なメールアドレスです</div>
								<div class="invalid-feedback">すでに登録済みのメールアドレス、もしくはメールアドレスの形式ではございません</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3">暗証番号</label> <input type="password"
									class="form-control" id="inputUpPassword"
									placeholder="password" required="true" autocomplete="off">
								<div class="invalid-feedback">数字、英語、特殊文字の組み合わせて8-16字で入力してください</div>
							</div>
							<div class="form-group">
								<label for="inputVerify3">暗証番号確認</label> <input type="password"
									class="form-control" id="inputUpVerify"
									placeholder="password (again)" required="true"
									autocomplete="off">
								<div class="invalid-feedback">入力した暗証番号と一致しておりません</div>
							</div>
							<div class="form-group">
								<button type="button"
									class="btn btn-info btn-lg float-right w-100 mt-2 mb-3"
									id="register">会員登録</button>
								<br />
							</div>
						</div>
					</form>
				</div>
				<div class="card border-secondary" id="successContainer"
					style="display: none;">
					<div class="card-header">
						<h3 class="mb-0 my-2 centered text-center">会員登録完了</h3>
					</div>
					<div class="card-body text-center">
						<button type="button" class="btn btn-info btn-lg" id="toSignin">ログイン画面に</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div class="row flex-xl-nowrap no-gutters h-100">
		<div class="col-6 h-100" style="background-color: #F0FFF0">
			<div class="row flex-xl-nowrap no-gutters h-100">
				<div class="col-6 p-1 h-auto" style="background-color:#F0FFF0; overflow-y: auto; ">
				
				<div class="row w-100 h-auto m-0 p-0 mt-4">
				<!-- 검색창 -->
				<div class="col p-1 mt-3" style="display: flex; align-items: center; justify-content: center;">
	    			<div class="input-group">
	    				<input type="text" class="form-control" placeholder="都市／旅行地を検索" id="searchInput">
	    				<div class="input-group-append">
	    					<button class="btn btn-info" type="button" id="search">検索</button>
	    				</div>
	    			</div>
	    		</div>
				
				<!-- 검색결과창 -->
				
				<ol class='draggableList p-1' id="placeresult">
				
					
				</ol>
				<div class="col-md-12">
					<ul class="pagination justify-content-center" id="pagination">	            
					</ul>
				</div>
				</div>
				</div>
				
				<div class="col-6 p-1 h-auto mt-3" style="background-color: #203341;overflow-y: auto;" id="plandayappend">
					
					<div class="input-group mb-2 mt-4 p-1" >
						<div class="input-group-prepend">
							<label class="input-group-text">日付け</label>
						</div>
						<select class="custom-select" id="daySelect">
						</select>
					</div>
					
					<div class="row flex-xl-nowrap no-gutters border-bottom mb-1"><p class="text-white">旅行地リスト</p></div>
				
					
				</div>				
			</div>
		
		</div>
		<div class="col-6 h-100">
			 <div class="col-12 h-75" id="map" style="background-color: #F0FFF0;"></div>
			 <div class="col-12 h-25 bg-primary">
			 	<div class="col-12 h-50">
			 		<div class="col-12 h-100 pt-2 px-0">
			 			<div class="col-12 p-2 bg-light h-100">
			 				<h6 class="m-0" id="hotelAddress"></h6>
			 			</div>
			 		</div>
			 	</div>
			 	<div class="col-12 h-50">
			 		<div class="row">
				 		<div class="col-6 h-100 p-3">
				 			<button class="btn btn-info w-100" id="routeSearchButton">最短ルート計算</button>
				 		</div>
				 		<div class="col-6 h-100 p-3">
				 			<button class="btn btn-info w-100" id="updatePlanButton">日程修正</button>
				 		</div>
				 	</div>
			 	</div>
			 </div>
		</div>
	</div>

	<!-- RouteViewModal-->
	<div class="modal fade" id="detailRouteModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="row">
					<div class="col-12 p-0" id="routeMap" style="height: 300px"></div>
					<div class="col-12 p-0 bg-white" id="routeResultView" style="overflow-y: scroll; height: 200px;"></div>
					<div class="col-12 bg-white p-1 text-center">
						<button class="btn btn-info" id="sortPlace">ルート順で日程を整列する</button> 
					</div>
				</div>
			</div>
		</div>
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
	<script src='https://johnny.github.io/jquery-sortable/js/jquery-sortable.js'></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.21.0/moment.min.js"
		type="text/javascript"></script>
	<script src="./resources/js/bootstrap-datetimepicker.min.js"></script>
	<script>
		var markerIndex=0;
		var dateN;
		var routeInfo;
		
		$(function() {
			
			$("#hotelAddress").html("宿所位置 : "+${result}.plan.plan_startlocation); 
			/* 일정 날짜 ======================================================================*/
			var yearFrom = ${result}.plan.plan_from.split(" ")[0].split("/")[0];
			var monthFrom = ${result}.plan.plan_from.split(" ")[0].split("/")[1];
			var dayFrom = ${result}.plan.plan_from.split(" ")[0].split("/")[2];
			var dateFrom = new Date(yearFrom,monthFrom,dayFrom);
			
			var yearTo = ${result}.plan.plan_to.split(" ")[0].split("/")[0];
			var monthTo = ${result}.plan.plan_to.split(" ")[0].split("/")[1];
			var dayTo = ${result}.plan.plan_to.split(" ")[0].split("/")[2];
			var dateTo = new Date(yearTo,monthTo,dayTo);
			dateN = (dateTo-dateFrom)/(1000*60*60*24)+1;
			for(var i=0;i<dateN;i++){
				var dayOption ="";
				var planday ="";
				
				dateFrom = new Date(yearFrom,monthFrom,dayFrom);
				dayOption+='<option value="'+i+'">';
				dayOption+=(parseInt(i)+1)+"日目 ("+dateFrom.getFullYear()+'/'+dateFrom.getMonth()+'/'+dateFrom.getDate()+")";
				dayFrom++;
				dayOption+='</option>';
			    
				$("#daySelect").append(dayOption);
				
				if(i==0){
					$("#daySelect option").attr("selected","selected");
					planday += "<form id=planday_"+i+">";
					planday += "<ol class='dropableList'>";
					planday += "</ol>";
					planday += "</form>";
					
				}else{
				
				planday += "<form id=planday_"+i+" style='display: none;'>";
				planday += "<ol class='dropableList'>";
				planday += "</ol>";
				planday += "</form>";
				}
				
				$('#plandayappend').append(planday);
				
			}
			
			
			$("#daySelect").on('change', selectDay);
							
			/* 드래그==================================================== */
			$("ol.draggableList").sortable({
				group:'test',
				drop:false,
				onDragStart: function ($item, container, _super) {
				    // Duplicate items of the no drop area
				    if(!container.options.drop)
				      $item.clone().insertAfter($item);
				    _super($item, container);
				    if(!($item.children().children().children().children().children().hasClass("button"))){
				    	$item.children().children().children().children().append("<input class='button' type='image' src='./resources/img/icon/remove_icon.jpg' align='right' onclick='del(this)'>");
				    	$item.children().children().children().children().append("<input type='hidden' value='"+markerIndex+"'>");
				    	markerIndex++;
				    }		
				    geocodeAddress($item.children().children().children().eq(1).children().children().children().children().attr("title"));
				},
				
			});
			
			$("ol.dropableList").sortable({
				group:'test',
				
			});
			
			var request = $.ajax({
				url : "ajaxPlaceSearch",
				type : "get",
				dataType : "json",
				data :{
					plan_area:${result}.plan.plan_area
				}

			});
			
			request.done(function(data) {
				var resultList = data.resultList;
				for ( var i in resultList) {
					var card ="";
					card += "<li>";
					card += "<div class='card w-100 p-1 mb-1'>";
					card += "<div class='row flex-xl-nowrap no-gutters'>";
					card += "<div class='col-4 w-100'>";
					card += "<img class='w-100 h-100' src='"+resultList[i].place_image+"'>";
					card += "</div>";
					card += "<div class='col-8 p-0 w-100 h-100'>";
					card += "<div class='card-body p-0 w-100'>";
					
					card += "<div class='row-12 w-100'>"
					
					card += "<div class='row-12 w-100' align='right'>"
					card+= '<a class="place-address ml-1" href="javascript:;" title="'+resultList[i].place_location+resultList[i].place_name+'">';
					card+= '<input type="image" src="./resources/img/icon/map.png">';
					card+= '</a>';
					card+= '<a class="place-detail ml-1" href="/smartplanner/detailplaceinfo?num='+resultList[i].place_seq+'">';
					card+= '<input type="image" src="./resources/img/icon/info.png">';
					card+= '</a>';
					card+= '</div>'
					
					card += "<h5 class='card-title p-2' style='display:inline'>"+resultList[i].place_name+"</h5>";
					
					card+= '</div>'
					
					card += "<p class='card-text p-2' style='display:inline'>";
					card += '<span class="fa fa-star mr-1 checked"></span>';
					if(resultList[i].place_grade.length==1){
						card += "<span>"+resultList[i].place_grade+".0/5.0"+"</span>";
					}else if(resultList[i].place_grade.length==null){
						card += "<span>"+"0.0/5.0"+"</span>";
					}else{
						card += "<span>"+resultList[i].place_grade+"/5.0"+"</span>";
					}
					card += "</p>";
					card += "</div>";
					card += "</div>";
					card += "</div>";
					card += '<input type="hidden" value="'+resultList[i].place_seq+'">';
					card += "</div>"
					card += "</li>";
					
					$('#placeresult').append(card);
				}
				// 플레이스 디테일 팝업추가
				$(".place-detail").on('click',popupDetail);
				// 플레이스 주소로 구글맵 이동
				$(".place-address").on('click',setLocation);
				refreshPagination(data);
			});
			
			
			// 일정 수정
			$("#updatePlanButton").on('click',function(){
				var startDate = new Date(${result}.plan.plan_from.split(" ")[0]);
				var dayPlanList=[];
				for(var i=0;i<dateN;i++){
					var date = dateToDate(startDate);
					var placeList=[];
					$("#planday_"+i).children("ol").children("li").each(function(){
						var place_seq=$(this).children("div").children("input").val();
						var place={
								place_seq : place_seq
						}
						placeList.push(place);
					});
					var PlanDayDTO={
							date : date,
							placeList : placeList
					}
					dayPlanList.push(PlanDayDTO);
					startDate.setTime(startDate.getTime()+24*60*60*1000);
				}
				var PlanPageDTO={
						plan:${result}.plan,
						dayPlanList:dayPlanList
				}
				
				// 일정 수정 ajax 이벤트
				$.ajax({
					url:"updateplanaction",
					type:"post",
					dataType : 'json',
					contentType : "application/json; charset=UTF-8",
					data:JSON.stringify(PlanPageDTO),
					success:function(){
						alert("日程修正完了");
						$(location).attr("href",'./myplan');
					},
					error:function(){
						alert("通信エラー");
					}
				});
			});
			
			// 최단 루트 계산 이벤트
			$("#routeSearchButton").on('click', function(){
				var placeList=[]
				placeList.push(${result}.plan.plan_startlocation);
				$(".dropableList:visible li").each(function(){
					var address=$(this).children("div").children("div").children("div").eq(1).children("div").children("div").children("div").children("a").eq(0).attr("title");
					placeList.push(address);
				});
				placeList.push(${result}.plan.plan_startlocation);
				
				$.ajax({
					url:"searchroute",
					type:"post",
					data:{
						addressList:JSON.stringify(placeList)
					},
					success:function(data){
						var resultPlaceList=[];
						$("#routeResultView").html("");
						for(var i=1;i<data.routeInfo.length-1;i++){
							resultPlaceList.push(placeList[data.routeInfo[i]]);
						}
						setWayPointsDirectionsMinRoute(resultPlaceList, ${result}.plan.plan_startlocation);
						
						routeInfo=data.routeInfo;
						$("#detailRouteModal").modal();
					},
					error:function(){
						alert("通信エラー");
					}
				});
			});
			
			
			// 일정 정렬 이벤트
			$("#sortPlace").on('click',function(){
				var viewList=[];
				$(".dropableList:visible li").each(function(){
					viewList.push($(this));
				});
				for(var i=1;i<routeInfo.length-1;i++){
					$(".dropableList:visible").append(viewList[routeInfo[i]-1]);
				}
				
				$("#detailRouteModal").modal('toggle');
			});
		});
		
		var lat = 35.6894875;
		var lng = 139.6917639999993;
		$('#place_type_tokyo').on('click',function () {
			lat = 35.6894875;
			lng = 139.6917639999993;
			map.setZoom(10);
			map.setCenter({lat:lat,lng:lng});
		});
		$('#place_type_osaka').on('click',function () {
			lat = 34.6784656;
			lng = 135.4601305;
			map.setZoom(10);
			map.setCenter({lat:lat,lng:lng});
		});
		
		// 구글맵 콜백함수
		function initMap() {
			var myOption = {
				zoom : 10,
				center : {
					lat : lat,
					lng : lng
				},
				gestureHandling : 'greedy'
			};

			map = new google.maps.Map(document.getElementById('map'), myOption);
			
			
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({
				'address' : ${result}.plan.plan_startlocation
			}, function(results, status) {
				if (status === 'OK') {
					var marker = new google.maps.Marker({
						position : results[0].geometry.location,
						map : map,
						icon : "./resources/img/icon/googlemap/hotel.png",
						title : "ホテル"
					});
				} else {
					alert('Geocode was not successful for the following reason: '
							+ status);
				}
			});	
			
			routeMap = new google.maps.Map(document.getElementById('routeMap'), {
				zoom : 10,
				center : {
					lat : 35.6894875,
					lng : 139.6917639999993
				},
				gestureHandling : 'greedy'
			});
			
			// 가져온 플랜 데이터 세팅
			planSet();
			
		}
		
		function del(d) {
			markers[$(d).next().val()].setMap(null);
			$(d).parents('li').remove();
		}
		
		/* 검색========================================================================= */
		var keyword;
		
		$('#search').on('click',function(){
			pp(1);
		});
		
		function pp(pageNum){
			keyword = $('#searchInput').val();
			var request = $.ajax({
				url : "ajaxPlaceSearch",
				type : "get",
				data : {keyword: keyword,
						page: pageNum,
						plan_area:${result}.plan.plan_area},
				dataType : "json",
				

			});
			
			request.done(function(data) {
				$('#placeresult').empty();
				var resultList = data.resultList;
				for ( var i in resultList) {
					var card ="";
					card += "<li>";
					card += "<div class='card w-100 p-1 mb-1'>";
					card += "<div class='row flex-xl-nowrap no-gutters'>";
					card += "<div class='col-4 w-100'>";
					card += "<img class='w-100 h-100' src='"+resultList[i].place_image+"'>";
					card += "</div>";
					card += "<div class='col-8 p-0 w-100 h-100'>";
					card += "<div class='card-body p-0 w-100'>";
					
					card += "<div class='row-12 w-100'>"
					
					card += "<div class='row-12 w-100' align='right'>"
					card+= '<a class="place-address ml-1" href="javascript:;" title="'+resultList[i].place_location+resultList[i].place_name+'">';
					card+= '<input type="image" src="./resources/img/icon/map.png">';
					card+= '</a>';
					card+= '<a class="place-detail ml-1" href="/smartplanner/detailplaceinfo?num='+resultList[i].place_seq+'">';
					card+= '<input type="image" src="./resources/img/icon/info.png">';
					card+= '</a>';
					card+= '</div>'
					
					card += "<h5 class='card-title p-2' style='display:inline'>"+resultList[i].place_name+"</h5>";
					
					card+= '</div>'
					
					card += "<p class='card-text p-2' style='display:inline'>";
					card += '<span class="fa fa-star mr-1 checked"></span>';
					if(resultList[i].place_grade.length==1){
						card += "<span>"+resultList[i].place_grade+".0/5.0"+"</span>";
					}else if(resultList[i].place_grade.length==null){
						card += "<span>"+"0.0/5.0"+"</span>";
					}else{
						card += "<span>"+resultList[i].place_grade+"/5.0"+"</span>";
					}
					card += "</p>";
					
					card += "</div>";
					card += "</div>";
					card += "</div>";
					card += "</div>"
					card += "</li>";
					
					$('#placeresult').append(card);
				}
				// 플레이스 디테일 팝업추가
				$(".place-detail").on('click',popupDetail);
				// 플레이스 주소로 구글맵 이동
				$(".place-address").on('click',setLocation);
				
				refreshPagination(data);
			});
		}
		
		
		
		function pf(pageNum){
			
			keyword = $('#searchInput').val();
			var request = $.ajax({
				url : "ajaxPlaceSearch",
				type : "get",
				data : {page: pageNum,
					plan_area:${result}.plan.plan_area},
				dataType : "json",
				

			});
			
			request.done(function(data) {
				$('#placeresult').empty();
				var resultList = data.resultList;
				for ( var i in resultList) {
					var card ="";
					card += "<li>";
					card += "<div class='card w-100 p-1 mb-1'>";
					card += "<div class='row flex-xl-nowrap no-gutters'>";
					card += "<div class='col-4 w-100'>";
					card += "<img class='w-100 h-100' src='"+resultList[i].place_image+"'>";
					card += "</div>";
					card += "<div class='col-8 p-0 w-100 h-100'>";
					card += "<div class='card-body p-0 w-100'>";
					
					card += "<div class='row-12 w-100'>"
					
					card += "<div class='row-12 w-100' align='right'>"
					card+= '<a class="place-address ml-1" href="javascript:;" title="'+resultList[i].place_location+resultList[i].place_name+'">';
					card+= '<input type="image" src="./resources/img/icon/map.png">';
					card+= '</a>';
					card+= '<a class="place-detail ml-1" href="/smartplanner/detailplaceinfo?num='+resultList[i].place_seq+'">';
					card+= '<input type="image" src="./resources/img/icon/info.png">';
					card+= '</a>';
					card+= '</div>'
					
					card += "<h5 class='card-title p-2' style='display:inline'>"+resultList[i].place_name+"</h5>";
					
					card+= '</div>'
					
					card += "<p class='card-text p-2' style='display:inline'>";
					card += '<span class="fa fa-star mr-1 checked"></span>';
					if(resultList[i].place_grade.length==1){
						card += "<span>"+resultList[i].place_grade+".0/5.0"+"</span>";
					}else if(resultList[i].place_grade.length==null){
						card += "<span>"+"0.0/5.0"+"</span>";
					}else{
						card += "<span>"+resultList[i].place_grade+"/5.0"+"</span>";
					}
					card += "</p>";
					
					card += "</div>";
					card += "</div>";
					card += "</div>";
					card += "</div>"
					card += "</li>";
					
					$('#placeresult').append(card);
				}
				// 플레이스 디테일 팝업추가
				$(".place-detail").on('click',popupDetail);
				// 플레이스 주소로 구글맵 이동
				$(".place-address").on('click',setLocation);
				
				refreshPagination(data);
			});
		}
		
		
		// 플레이스 상세 정보 눌렀을때 팝업 표시
		function popupDetail(){
			window.open($(this).attr("href"), "detailPopup","width=1000px, height=500px, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
			return false;
		}
		
		// 플레이스 위치 눌렀을때 지도에 위치 이동
		function setLocation(){
			var address=$(this).attr("title");
			geocodeAddressSetMap(address);
			geocodeAddress(address);
			return false;
		}
		
		function refreshPagination(data){
			$("#pagination").html("");
			
			// 페이지 네이션
		
			// 이전 그룹으로
			var previousGroup="";
			previousGroup+='<li class="page-item" value="'+((data.currentGroup-1)*5+1)+'">';
			previousGroup+='<a class="page-link" href="javascript:;">';
			previousGroup+='<span>«</span>';
			previousGroup+='</a>';
			previousGroup+='</li>';
			
			$("#pagination").append(previousGroup);
			
			// 첫그룹 일시에 비활성화
			if(data.currentGroup==0){
				$("#pagination li:last-child").addClass("disabled");
			}
			
			// 번호별 페이지네이션 추가
			if(data.endPageGroup==0){
				var toPage="";
				toPage+='<li class="page-item" value="'+1+'">';
				toPage+='<a class="page-link" href="javascript:;">'+1+'</a>';
				toPage+='</li>';
				
				$("#pagination").append(toPage);
				
				// 현재 페이지 선택 표시
				$("#pagination li:last-child").addClass("active");
			}else{
				for(var i=data.startPageGroup;i<=data.endPageGroup;i++){
					var toPage="";
					toPage+='<li class="page-item" value="'+i+'">';
					toPage+='<a class="page-link" href="javascript:;">'+i+'</a>';
					toPage+='</li>';
					
					$("#pagination").append(toPage);
					
					// 현재 페이지 선택 표시
					if(i==data.currentPage){
						$("#pagination li:last-child").addClass("active");
					}
				}
			}
			
			// 다음 그룹으로
			var nextGroup="";
			nextGroup+='<li class="page-item" value="'+(data.currentGroup*5+6)+'">';
			nextGroup+='<a class="page-link" href="javascript:;">';
			nextGroup+='<span>»</span>';
			nextGroup+='</a>';
			nextGroup+='</li>';
				
			$("#pagination").append(nextGroup);
			
			// 마지막 그룹 일시에 비활성화
			if(data.currentGroup==parseInt(data.totalPageCount/5)){
				$("#pagination li:last-child").addClass("disabled");
			}
			
	 		// 페이지네이션 이벤트 추가
			$(".page-item").on('click', toPagenation); 
		}
	  
		// 페이지 네이션 이동함수
		function toPagenation(){
			var pageNum=$(this).val();
			
			if(keyword){
				pp(pageNum);
			}else{
				pf(pageNum);
			}
		}
		
		function selectDay(){
			for (var i = 0; i < $(this).children().length; i++) {
				var aj = '#planday_';
				aj += i;
				$(aj).hide();
			}
			dayIndex=$(this).children("option:selected").val();
			var dayplanIndex = '#planday_';
			dayplanIndex +=dayIndex;
			$(dayplanIndex).show();
			
			clearMarkers();
			markerIndex=0;
			
			$(dayplanIndex).children().children("li").each(function(){
				geocodeAddress($(this).children().children().children().eq(1).children().children().children().children().attr("title"));
			});		
		}
		
		
		
		// 날짜 스트링형식 변환
		function dateToDate(date){
			var year = date.getFullYear();       
			var month = (1 + date.getMonth());      
			month = month >= 10 ? month : '0' + month;  
			var day = date.getDate();
			day = day >= 10 ? day : '0' + day;  
			return  year + '/' + month + '/' + day;
		}
		
		// 가져온 플랜 데이터 세팅
		function planSet(){
			var dayPlanList=${result}.dayPlanList;
			for(var i=0;i<dayPlanList.length;i++){
				var placeList=dayPlanList[i].placeList;
				markerIndex=0;
				for(var j=0;j<placeList.length;j++){
					var card ="";
					card += "<li>";
					card += "<div class='card w-100 p-1 mb-1'>";
					card += "<div class='row flex-xl-nowrap no-gutters'>";
					card += "<div class='col-4 w-100'>";
					card += "<img class='w-100 h-100' src='./resources/img/place/"+placeList[j].place_image+"'>";
					card += "</div>";
					card += "<div class='col-8 p-0 w-100 h-100'>";
					card += "<div class='card-body p-0 w-100'>";
					card += "<div class='row-12 w-100'>"
					card += "<div class='row-12 w-100' align='right'>"
					card+= '<a class="place-address ml-1" href="javascript:;" title="'+placeList[j].place_location+placeList[j].place_name+'">';
					card+= '<input type="image" src="./resources/img/icon/map.png">';
					card+= '</a>';
					card+= '<a class="place-detail ml-1" href="/smartplanner/detailplaceinfo?num='+placeList[j].place_seq+'">';
					card+= '<input type="image" src="./resources/img/icon/info.png">';
					card+= '</a>';
					card+= '</div>'
					card += "<h5 class='card-title p-2' style='display:inline'>"+placeList[j].place_name+"</h5>";
					card+= '</div>'
					card += "<p class='card-text p-2' style='display:inline'>";
					card += '<span class="fa fa-star mr-1 checked"></span>';
					if(placeList[j].place_grade.length==1){
						card += "<span>"+placeList[j].place_grade+".0/5.0"+"</span>";
					}else if(placeList[j].place_grade.length==null){
						card += "<span>"+"0.0/5.0"+"</span>";
					}else{
						card += "<span>"+placeList[j].place_grade+"/5.0"+"</span>";
					}
					card += "</p>";
					card += "<input class='button' type='image' src='./resources/img/icon/remove_icon.jpg' align='right' onclick='del(this)'>"
					card += "<input type='hidden' value='"+markerIndex+"'>"
					card += "</div>";
					card += "</div>";
					card += "</div>";
					card += '<input type="hidden" value="'+placeList[j].place_seq+'">';
					card += "</div>"
					card += "</li>";
					
					markerIndex++;
					
					$("#planday_"+i+" ol").append(card);
				}
			}
			
			$("#planday_0 ol li").each(function(){
				var addressInfo=$(this).children("div").children("div").children("div").eq(1).children("div").children("div").children("div").children("a").attr("title");
				geocodeAddress(addressInfo);
			});
		}
	</script>
	<script src="./resources/js/googleMap.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBsibtVFd7RMFL3pevLFwrAEut_2hPwmw&libraries=places&language=ja&callback=initMap"
		async defer></script>
</body>
</html>