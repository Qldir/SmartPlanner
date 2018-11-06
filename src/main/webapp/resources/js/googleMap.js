
var map;
var directionsDisplayList = [];
var markers = [];
var routeMarkers =[];
// input text index;
var inputIndex = 0;
var innerWindow;
var selectedItem;
var directionResponse;
var routeDirectionsDisplay;

function addClickEvent() {
	// 맵 클릭 이벤트
	map.addListener("click", function(event) {
		// 마커 전부제거
		clearMarkers();
		var marker = placeMarker(event.latLng);
		searchPlace(event.latLng);

		/* var result = geocodeLatLng(geocoder, map, event.latLng); */
	});
}

// 마우스 클릭으로 주소 입력
function addClickEventOnInput(element) {
	// 맵 클릭 이벤트
	map.addListener("click", function(event) {
		// 마커 전부제거
		clearMarkers();
		geocodeLatLngOnInput(map, event.latLng, element);
	});
}

// 인풋 엘리먼트에 주소 입력 geocoding
function geocodeLatLngOnInput(map, latLng, element) {
	var geocoder = new google.maps.Geocoder();
	var loca = {
		lat : parseFloat(latLng.lat()),
		lng : parseFloat(latLng.lng())
	}
	geocoder.geocode({
		'location' : loca
	}, function(results, status) {
		if (status === 'OK') {
			if (results[0]) {
				placeMarker(latLng);
				element.value = results[0].formatted_address;
				console.log(results[0].formatted_address);
			} else {
				alert('No results Found');
			}
		} else {
			alert('Geocoder faild due to: ' + status);
		}

	});
}

function addAutocomplete(element) {
	var autocomplete = new google.maps.places.Autocomplete(element);
	autocomplete.bindTo('bounds', map);
	// autocomplte 가 어떤 data field를 리턴할지 set
	autocomplete.setFields([ 'address_components', 'geometry', 'name',
			'formatted_address' ]);
	autocomplete.addListener('place_changed', function() {

		var place = autocomplete.getPlace();
		if (!place.geometry) {
			// 입력한 질문에 답이 없거나 , 정보 리퀘스트 페일시
			window.alert("No detials available for input : " + place.name);
			return;
		}
		// 해당한 플레이스가 있을떄
		if (place.geometry.viewport) {
			map.setCenter(place.geometry.location);
			map.setZoom(17); // 17이 제일 적당하다고
		}

		clearMarkers();

		// marker set
		placeMarker(place.geometry.location);
	});
}

// autocomplete
function autocomplete(element) {
	// input getElement
	/* var card = document.getElementById('pac-card'); */
	/* var input = document.getElementById(element); */
	/* map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card); */
	// auto complete bind
	var autocomplete = new google.maps.places.Autocomplete(element);
	autocomplete.bindTo('bounds', map);
	// autocomplte 가 어떤 data field를 리턴할지 set
	autocomplete.setFields([ 'address_components', 'geometry', 'name',
			'formatted_address' ]);
	/*
	 * // infowindow 선언 var infowindow = new google.maps.InfoWindow(); var
	 * infowindowContent = document.getElementById('infowindow-content');
	 * infowindow.setContent(infowindowContent);
	 */
	/*
	 * // marker 선언 var marker = new google.maps.Marker({ map : map, anchorPoint :
	 * new google.maps.Point(0, -29) });
	 */
	// autocomplte add listener
	autocomplete.addListener('place_changed', function() {
		/* infowindow.close(); *//*
									 * marker.setVisible(false);
									 */
		var place = autocomplete.getPlace();
		if (!place.geometry) {
			// 입력한 질문에 답이 없거나 , 정보 리퀘스트 페일시
			window.alert("No detials available for input : " + place.name);
			return;
		}
		// 해당한 플레이스가 있을떄
		if (place.geometry.viewport) {/*
										 * map.fitBounds(place.geometry.viewport); }
										 * else {
										 */
			map.setCenter(place.geometry.location);
			map.setZoom(17); // 17이 제일 적당하다고
		}

		clearMarkers();

		// marker set
		placeMarker(place.geometry.location);

		/*
		 * var address = ''; // join : ' ' 공백을 사이에 두고 배열을 합쳐서 스트링으로 넣음 if
		 * (place.address_components) { address = [ (place.address_components[0] &&
		 * place.address_components[0].short_name || ''),
		 * (place.address_components[1] &&
		 * place.address_components[1].short_name || ''),
		 * (place.address_components[2] &&
		 * place.address_components[2].short_name || '') ] .join(' '); }
		 */
		/*
		 * infowindowContent.children['place-icon'].src = place.icon;
		 * infowindowContent.children['place-name'].textContent = place.name;
		 * infowindowContent.children['place-address'].textContent = address;
		 * infowindow.open(map.marker);
		 */
		/* $('#panel').remove(); */
		/*
		 * innerWindow = $("<div id='panel'></div>"); innerWindow.append("<table><tr><th><img
		 * src='" + place.photos + "'></th></tr><tr><th>" + place.name + "</th></tr><tr><th>" +
		 * address + "</th></tr></table>");
		 * $('#mapContainer').append(innerWindow);
		 */

		// 리스트에 추가
		/* addSearchList(place); */
	});
}

// 마커 제거
function clearMarkers() {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

//서브맵 마커 제거
function clearMarkersInRouteMap() {
	for (var i = 0; i < routeMarkers.length; i++) {
		routeMarkers[i].setMap(null);
	}
	routeMarkers = [];
}

// 플레이스 마커 위치
function placeMarker(location) {
	var marker = new google.maps.Marker({
		position : location,
		map : map
	});
	markers.push(marker);
	map.setCenter(location);
}

// 플레이스 마커 아이콘 변경하여 위치
function placeMarkerChangedIcon(location, icon, title) {
	var marker = new google.maps.Marker({
		position : location,
		map : map,
		icon : icon,
		title : title
	});
	markers.push(marker);
}

//서브맵에 플레이스 마커 아이콘 변경하여 위치
function placeMarkerChangedIconInRouteMap(location, icon, title) {
	var marker = new google.maps.Marker({
		position : location,
		map : routeMap,
		icon : icon,
		title : title
	});
	routeMarkers.push(marker);
}

// 모든 루트 계산
function calcRouteAll() {
	initDirectionsDisplay();
	var travelMode = document.querySelector('input[name="travelMode"]:checked').value;
	for (var i = 0; i < inputList.length - 1; i++) {
		var start = inputList[i].value;
		var end = inputList[i + 1].value;
	}
}

// 루트계산
function calcRoute(start, end, travelMode) {
	var request = {
		origin : start,
		destination : end,
		travelMode : travelMode
	// TRANSIT, DRIVING, BICYCLING, WALKING
	};
	// direction Service
	var directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById('right-panel'));
	var returnResult = true;
	directionsService.route(request, function(result, statue) {
		if (statue === "OK") {
			directionsDisplay.setDirections(result);
		} else {
			/* alert('루트가 존재하지 않습니다'); */
			returnResult = false;
			return;
		}
	});

	// directionsDisplayList에 추가
	directionsDisplayList.push(directionsDisplay);
	return returnResult;
}

// 디렉션 디스플레이 제거
function removeAllDirectionsDisplay() {
	for (var i = 0; i < directionsDisplayList.length; i++) {
		directionsDisplayList[i].setMap(null);
	}
}

//가져온 최단결과 지도위에 찍어주기
function setWayPointsDirectionsMinRoute(placeList, startlocation) {
	var wayPts = [];
	var start = startlocation;
	var end = startlocation;
	var travelMode ="DRIVING";
	for (var i = 0; i < placeList.length; i++) {
		wayPts.push({
			location : placeList[i],
			stopover : true
		});
	}

	removeAllDirectionsDisplay();
	clearMarkersInRouteMap();

	var directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(routeMap);
	directionsDisplay.setPanel(document.getElementById('routeResultView'));
	directionsDisplay.setOptions({
		suppressMarkers : true
	});

	directionsDisplayList.push(directionsDisplay);

	var directionsService = new google.maps.DirectionsService();

	directionsService
			.route(
					{
						origin : start,
						destination : end,
						waypoints : wayPts,
						optimizeWaypoints : false,
						travelMode : travelMode
					},
					function(response, status) {
						if (status === 'OK') {
							directionsDisplay.setDirections(response);
							
							var route = response.routes[0].legs;
							
							for (var i = 0; i < route.length - 1; i++) {
								var placeLocation = route[i].end_location;
								console.log("1");
								placeMarkerChangedIconInRouteMap(
										placeLocation,
										"https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red"
												+ (i + 1) + ".png", (i + 1)
												+ "");
							}
							// 마지막 호텔 위치 찍어주기
							var hotelLocation = route[route.length - 1].end_location;
							console.log("2");
							placeMarkerChangedIconInRouteMap(hotelLocation,
									"./resources/img/icon/googlemap/hotel.png",
									"호텔");
						} else {
							window.alert('Directions request failed due to '
									+ status);
						}

					});

}

// 두지점 루트 계산 및 찍어주기
function calculateAndDisplayRoute(start, end, transit) {

	// 초기화
	if (routeDirectionsDisplay != null) {
		routeDirectionsDisplay.setMap(null);
		routeDirectionsDisplay.setPanel(null);
	}
	
	routeMap = new google.maps.Map(document.getElementById('routeMap'), {
		zoom : 10,
		center : {
			lat : 35.6894875,
			lng : 139.6917639999993
		},
		gestureHandling : 'greedy'
	});

	routeDirectionsDisplay = new google.maps.DirectionsRenderer;
	var directionsService = new google.maps.DirectionsService;

	routeDirectionsDisplay.setMap(routeMap);
	routeDirectionsDisplay.setPanel(document.getElementById('routeResultView'));

	var travelMode;
	if (transit == 0) {
		travelMode = "DRIVING";
	} else if (transit == 1) {
		travelMode = "TRANSIT";
	} else if (transit == 2){
		travelMode = "WALKING";
	} else if (transit == 3){
		travelMode = "BICYCLING";
	}

	directionsService.route({
		origin : start,
		destination : end,
		travelMode : travelMode
	}, function(response, status) {
		if (status === 'OK') {
			document.getElementById('routeResultView').innerHTML="";
			routeDirectionsDisplay.setDirections(response);
		} else {
			document.getElementById('routeResultView').innerHTML="<div class='text-center mt-3'>サービスを提供していない地域です。</div>";
		}
	});
}

// 가져온 결과 데이터를 지도위에 찍어주는 메소드
function setWayPointsDirectionsByPlaces(placeList, startlocation, transit) {
	var wayPts = [];
	var start = startlocation;
	var end = startlocation;
	var travelMode;
	if (transit == 0) {
		travelMode = "DRIVING";
	} else if (transit == 1) {
		travelMode = "TRANSIT";
	}
	for (var i = 0; i < placeList.length; i++) {
		wayPts.push({
			location : placeList[i].place_location + placeList[i].place_name,
			stopover : true,
		});
	}

	removeAllDirectionsDisplay();
	clearMarkers();

	var directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);
	directionsDisplay.setOptions({
		suppressMarkers : true
	});

	directionsDisplayList.push(directionsDisplay);

	var directionsService = new google.maps.DirectionsService();

	directionsService
			.route(
					{
						origin : start,
						destination : end,
						waypoints : wayPts,
						optimizeWaypoints : false,
						travelMode : travelMode
					},
					function(response, status) {
						if (status === 'OK') {
							directionsDisplay.setDirections(response);

							var route = response.routes[0].legs;

							directionResponse = route;

							for (var i = 0; i < route.length - 1; i++) {
								var placeLocation = route[i].end_location;
								placeMarkerChangedIcon(
										placeLocation,
										"https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red"
												+ (i + 1) + ".png", (i + 1)
												+ "");
							}
							// 마지막 호텔 위치 찍어주기
							var hotelLocation = route[route.length - 1].end_location;
							placeMarkerChangedIcon(hotelLocation,
									"./resources/img/icon/googlemap/hotel.png",
									"호텔");

							// 콜백 함수 호출
							callbackDirections();
						} else {
							window.alert('Directions request failed due to '
									+ status);
						}

					});

}

// Directions WayPoint 사용 Directions Display 추가
function setWayPointsDirections(placeList, transit) {
	var wayPts = [];
	var start = placeList[0].address;
	var end = placeList[placeList.length - 1].address;
	var travelMode;
	if (transit == 0) {
		travelMode = "DRIVING";
	} else if (transit == 1) {
		travelMode = "TRANSIT";
	}

	for (var i = 1; i < placeList.length - 1; i++) {
		wayPts.push({
			location : placeList[i].address,
			stopover : true
		});
	}
	removeAllDirectionsDisplay();

	var directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);

	directionsDisplayList.push(directionsDisplay);

	var directionsService = new google.maps.DirectionsService();

	directionsService.route({
		origin : start,
		destination : end,
		waypoints : wayPts,
		optimizeWaypoints : false,
		travelMode : travelMode
	}, function(response, status) {
		if (status === 'OK') {
			directionsDisplay.setDirections(response);
			$("#resultRoute").html('');
			var summaryPanel = '';
			for (var i = 0; i < route.legs.length; i++) {
				if (i == 0) {
					summaryPanel += String.fromCharCode(65 + i) + " : "
							+ route.legs[i].start_address + '<br>';
					summaryPanel += String.fromCharCode(66 + i) + " : "
							+ route.legs[i].end_address + '<br>';
				} else {
					summaryPanel += String.fromCharCode(66 + i) + " : "
							+ route.legs[i].end_address + '<br>';
				}
			}
			summaryPanel += '<br>';
			for (var i = 0; i < route.legs.length; i++) {
				summaryPanel += "<b>" + String.fromCharCode(65 + i) + "  >>>  "
						+ String.fromCharCode(66 + i) + " : "
						+ route.legs[i].distance.text + '</b><br>';
			}
			$("#resultRoute").append(summaryPanel);
		} else {
			window.alert('Directions request failed due to ' + status);
		}
	});

}

// DirectionsDisplay 초기화
function initDirectionsDisplay() {
	for (var i = 0; i < directionsDisplayList.length; i++) {
		directionsDisplayList[i].setMap(null);
		directionsDisplayList[i] = null;
	}
	directionsDisplayList = [];
}

// geocode LatLng
function geocodeLatLng(geocoder, map, latLng) {
	var loca = {
		lat : parseFloat(latLng.lat()),
		lng : parseFloat(latLng.lng())
	}
	geocoder.geocode({
		'location' : loca
	}, function(results, status) {
		if (status === 'OK') {
			if (results[0]) {
				console.log(results[0].formatted_address);
			} else {
				alert('No results Found');
			}
		} else {
			alert('Geocoder faild due to: ' + status);
		}

	});
}

// 주 소로 위치정보 가져오기
function geocodeAddress(address) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status === 'OK') {
			map.setCenter(results[0].geometry.location);
			console.log(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location
			});
			markers.push(marker);
		} else {
			alert('Geocode was not successful for the following reason: '
					+ status);
		}
	});
}

//주 소로 위치정보 가져오고 날씨정보 세팅
function geocodeAddressGetWeather(address) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status === 'OK') {
			map.setCenter(results[0].geometry.location);
			console.log(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location
			});
			markers.push(marker);
			setWeather(results[0].geometry.location);
		} else {
			alert('Geocode was not successful for the following reason: '
					+ status);
		}
	});
}

// 주소로 맵 이동
function geocodeAddressSetMap(address) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status === 'OK') {
			map.setCenter(results[0].geometry.location);
			map.setZoom(17);
		} else {
			alert('Geocode was not successful for the following reason: '
					+ status);
		}
	});
}

// 선택된 리스트 데이터 변경
function changeSelectedItem(place) {
	$('.list-group-item.active > div > h5').html(place.name);
	$('.list-group-item.active > p').html(place.formatted_address);
	$('.list-group-item.active > small').html(
			place.geometry.location.toString());
}

// place_id로 위치 찾기
function searchPlaceById(place_id) {
	var placeService = new google.maps.places.PlacesService(map);
	var request = {
		placeId : place_id
	};
	placeService.getDetails(request, function(result, status) {
		if (status === 'OK') {
			addSearchList(result);
		} else {
			console.log('Connection Error');
		}
	});
}

// 플레이스 찾기
function searchPlace(location) {
	var placeService = new google.maps.places.PlacesService(map);
	var request = {
		location : location,
		radius : '500',
		type : [ 'restaurant' ]
	};
	placeService.nearbySearch(request, function(results, status) {
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				var placeResult = results[i];
				placeMarker(placeResult.geometry.location);
			}
		}
	});
}

// location 데이터 latlng 객체로 변환
function parseLocation(location) {
	var lat = location.split(",")[0];
	var lng = location.split(",")[1];
	var latLng = new google.maps.LatLng(lat, lng);
	return latLng;
}