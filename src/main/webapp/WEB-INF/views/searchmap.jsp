<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>宿所入力</title>
<!-- CSS dependencies -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/wireframe.css">
<style>
#floating-panel {
	position: absolute;
	top: 5px;
	left: 5px;
	z-index: 5;
	background-color: #fff;
	border: 1px solid #999;
	text-align: center;
	line-height: 30px;
}
</style>
</head>
<body style="margin: 0px">
	<div class="container w-75 p-2" id="floating-panel">
		<div class="input-group">
			<input type="text" class="form-control"
				placeholder="住所を選択もしくは入力してください" id="addressInput">
			<div class="input-group-append">
				<button class="btn btn-light" type="button" id="locationSearch">入力</button>
			</div>
		</div>
	</div>
	<div id="map"></div>
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
	<script>
		var lat;
		var lng;
		function initMap() {
			
			// 부모창 지역 값 받아오기
			var area;
			area = $(opener.document).find("#areaInput option:selected").val();
			if(area==0 ){
				lat = 35.6894875;
				lng = 139.6917639999993;
			}else if(area==3){
				lat = 34.6784656;
				lng = 135.4601305;
			}else{
				lat = 35.6894875;
				lng = 139.6917639999993;
			}
			
			var myOption = {
				zoom : 10,
				center : {
					lat : lat,
					lng : lng
				},
				gestureHandling : 'greedy'
			};

			map = new google.maps.Map(document.getElementById('map'), myOption);

			$("#map").css("height", $(window).height());
			$("#map").css("width", $(window).width());

			$(window).resize(function() {
				$("#map").css("height", $(window).height());
				$("#map").css("width", $(window).width());
			});

			// 오토 컴플리트 추가
			addAutocomplete(document.getElementById("addressInput"));
			// 마우스 이벤트로 주소 입력 추가
			addClickEventOnInput(document.getElementById("addressInput"));

			// 데이터 부모창으로 입력 이벤트 추가
			$("#locationSearch").on('click', function() {
				var address = $("#addressInput").val();
				if (address == "") {
					alert("住所を入力してください");
				} else {
					$(opener.document).find("#locationInput").val(address);
					window.close();
				}
			});
		}
			
	</script>
	<script src="./resources/js/googleMap.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBsibtVFd7RMFL3pevLFwrAEut_2hPwmw&libraries=places&language=ja&callback=initMap"
		async defer></script>
</body>
</html>