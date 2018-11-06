<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>ホテル</title>
<!-- CSS dependencies -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
</head>
<style type="text/css">
.scale-image {
	transform: scale(1);
	-webkit-transform: scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transition: all 1s ease-in-out;
}

.scale-image:hover {
	transform: scale(1.1);
	-webkit-transform: scale(1.1);
	-moz-transform: scale(1.1);
	-ms-transform: scale(1.1);
	-o-transform: scale(1.1);
}

.image-container {
	overflow: hidden
}

.selected-board {
	border-width: 2px !important;
}

.google {
	opacity: 0.85;
	text-decoration: none; /* remove underline from anchors */
}

.google:hover {
	opacity: 1;
}

a {
	text-decoration: none !important;
}

.table-dark {
	background-color: rgba(0, 0, 0, 0.6);
}

.table-dark td, .table-dark th {
	border: none;
}
</style>
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
	
	<div class="text-center py-5 h-75 w-100 "
		style="background: url('./resources/img/banner/hotel.jpg') no-repeat; background-size: cover;">
		<div class="container w-100 h-75">
			<div class="row my-4 justify-content-center">
				<div class="col-md-12 ">
					<table class="table table-dark w-100 h-75" style="table-layout: fixed;">
						<tr>
							<th scope="col" colspan="4"><h1>ホテル  検索</h1></th>
						</tr>

						<tr >
							<td>地域選択
							<select class="custom-select w-100 " id="area">
									<option selected>area select</option>

							</select></td>
							<td>チェックイン
								<input type="date" class="form-control w-100"
								id="checkin"></td>
							<td>チェックアウト
								<input type="date" class="form-control w-100"
								id="checkout"></td>
							<td rowspan="2"><br/>
									<button type="button"
									class="btn btn-info w-100" id="search" value="1" style="height: 130px;"><h3 class="display-5 w-100">検索</h3></button>
									<input type="hidden" value="1">
							</td>
							
						</tr>
						<tr>
							<td>人数
								<select class="custom-select w-100" id="adultNum">
									<option selected value="1">人数</option>
									<option value="1">One</option>
									<option value="2">Two</option>
									<option value="3">Three</option>
								</select>
							</td>
							<td>最低価格
								<input type="text" class="form-control w-100"
								placeholder="min cost" id="minCharge"></td>
							<td>最高価格
								<input type="text" class="form-control w-100"
								placeholder="max cost" id="maxCharge"></td>
						</tr>
						<tr>
							<td colspan="4"><br /></td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>

	<div class="py-4 bg-light">
		<div class="container">
			<div class="row">
				<div class="col-md-12" id="focus">
					<h1 class="text-center">検索結果</h1>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row" id="hotelcon"></div>
		</div>
		<div class="col-md-12 mt-2">
			<ul class="pagination justify-content-center" id="pagination">

			</ul>
		</div>
		<!-- footer -->
		<footer class="text-muted py-5">
			<div class="container">
				<p class="float-right">
					<a href="#">ページ上へ</a>
				</p>
				<p>
					Copyright ⓒ 2018 SCIT 35th ZanGyoNashi, All Rights Reserved. <br>Are
					you want connect us? Send a e-mail <a href="#">searpier@google.com</a>
					or call our telephone-number <a href="#">02-6000-7138</a>.
				</p>
			</div>
			<div class="container">
			<div id="google_translate_element"></div>
			</div>
		</footer>
	</div>
	<script type="text/javascript">
			function googleTranslateElementInit() {
				  new google.translate.TranslateElement({pageLanguage: 'ja', 
					  layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
				}
	</script>
	<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
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
		var card;
		var appId = "applicationId=1094214897159367253"
		var page;
		var totalpage;
		var res;
		var tempres = 0;
		var checkinDate;
		var checkoutDate;
		var minCharge;
		var maxCharge;
		var adultNum;
		var hotelName;
		var hotelThumbnail;
		var reserveUrl;
		var total;
		var review;
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1;
		var yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd;
		}
		if (mm < 10) {
			mm = '0' + mm;
		}
		today = yyyy + '-' + mm + '-' + dd;

		$(document).ready(function() {

							document.getElementById("checkin").setAttribute("min", today);
							document.getElementById("checkout").setAttribute("min", today);

							var request0 = $
									.ajax({
										url : "https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?applicationId=1094214897159367253&format=json",
										type : "get",
										dataType : "json",
									});
							
							
							request0.done(function(data0) {

										var large = data0.areaClasses.largeClasses[0].largeClass[0].largeClassCode;
										var middlen = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses;
										var smalln;
										var middle;
										var small;
										var detail;
										

										for ( var m in middlen) {
											middle = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[0].middleClassCode;
											middleName = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[0].middleClassName;
											smalln = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses;

											for ( var s in smalln) {
												small = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[0].smallClassCode;
												smallName = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[0].smallClassName;
												var detailcheck = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[1];
												
												
												if(detailcheck){
													var detailn = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[1].detailClasses;
													for(var d in detailn){
														detail = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[1].detailClasses[d].detailClass.detailClassCode;
														detailName = data0.areaClasses.largeClasses[0].largeClass[1].middleClasses[m].middleClass[1].smallClasses[s].smallClass[1].detailClasses[d].detailClass.detailClassName;
														$('#area').append("<option value = "+middle+','+small+','+detail+">" + middleName+ " " + smallName+" "+detailName+"</option>");
														
														
													}
													
													
												}else{
													var val = middle;
													val += ",";
													val += small;
													$('#area').append("<option value ="+val+">" + middleName+ " " + smallName+"</option>");
												}
											}

										}

									});
							
							$('#search').on('click', function () {
								page = 1;
								tempres=0;
								hotelmain();
								
								$('html, body').animate( { scrollTop : $('#focus').offset().top }, 700 );
								
							});
							
						});

		function hotelmain() {
			var split = $('#area').val();
			var counter = (split.match(/,/g) || []).length;
			
			
			checkinDate = $("#checkin").val();
			checkoutDate = $("#checkout").val();
			minCharge = $("#minCharge").val();
			maxCharge = $("#maxCharge").val();
			adultNum = $("#adultNum").val();
			
			
			
			if ($("#area").val() != "area select") {
				if (checkinDate <= checkoutDate) {
					$('#hotelcon').empty();
					$('#pagination').empty();
					if(counter>1){
				
							var request = $.ajax({

								url : "https://app.rakuten.co.jp/services/api/Travel/VacantHotelSearch/20170426?"
										+ appId
										+ "&sort=+roomCharge"
										+ "&hits=6"
										+ "&page="
										+ page
										+ "&format=json&formatVersion=1&checkinDate="
										+ checkinDate
										+ "&checkoutDate="
										+ checkoutDate
										+ "&minCharge="
										+ minCharge
										+ "&maxCharge="
										+ maxCharge
										+ "&adultNum="
										+ adultNum
										+ "&largeClassCode=japan"
										+ "&middleClassCode="
										+ $('#area').val().split(",")[0]
										+ "&smallClassCode="
										+ $('#area').val().split(",")[1]
										+ "&detailClassCode="
										+ $('#area').val().split(",")[2]
										+ "&elements=hotelName,hotelImageUrl,reserveUrl,total,reviewAverage,pageCount",
								type : "get",
								dataType : "json",

							});
						
					}else{
					
					var request = $.ajax({

								url : "https://app.rakuten.co.jp/services/api/Travel/VacantHotelSearch/20170426?"
										+ appId
										+ "&sort=+roomCharge"
										+ "&hits=6"
										+ "&page="
										+ page
										+ "&format=json&formatVersion=1&checkinDate="
										+ checkinDate
										+ "&checkoutDate="
										+ checkoutDate
										+ "&minCharge="
										+ minCharge
										+ "&maxCharge="
										+ maxCharge
										+ "&adultNum="
										+ adultNum
										+ "&largeClassCode=japan"
										+ "&middleClassCode="
										+ $('#area').val().split(",")[0]
										+ "&smallClassCode="
										+ $('#area').val().split(",")[1]
										+ "&elements=hotelName,hotelImageUrl,reserveUrl,total,reviewAverage,pageCount",
								type : "get",
								dataType : "json",

							});
					}
				} else {
					alert("date miss!!");
				}
			} else {
				alert("select area!");
			}
			request.done(function(data) {

						for (i in data.hotels) {

							hotelName = data.hotels[i].hotel[0].hotelBasicInfo.hotelName;

							hotelImageUrl = data.hotels[i].hotel[0].hotelBasicInfo.hotelImageUrl;

							reserveUrl = data.hotels[i].hotel[1].roomInfo[0].roomBasicInfo.reserveUrl;

							total = data.hotels[i].hotel[1].roomInfo[1].dailyCharge.total;

							review = data.hotels[i].hotel[0].hotelBasicInfo.reviewAverage;

							totalpage = parseInt(data.pagingInfo.pageCount);
							res = parseInt((totalpage-0.01)/5);
							if (review == null) {
								review = 0;
							}
							card = '';
							
							card += '<div class="col-md-4 p-3" >';
							card += "<a href=\"javascript:void(window.open('"+ reserveUrl + "','_blank'))\">";
							card += '<div class="card select-card box-shadow h-100" style="box-shadow: 7px 7px 7px #8C8C8C;">';
							card += '<div class="card-img-top image-container" style="height:200px;"><img class="card-img-top scale-image" style="height:100%" src="'+ hotelImageUrl + '"></div>';
							card += '<div class="card-body h-25">';
							card += '<h5 class="card-title">' + hotelName + '</h5>';
							card += '<table class="table">';
							card += '<td>';
							for(var j=0;j<5;j++){
								if(j<parseInt(review)){
									card+='<span class="fa fa-star mr-1 checked"></span>';
								}else{
									card+='<span class="fa fa-star mr-1"></span>';	
								}
							}
							card += '<p class="card-text">' + review + '</p>';
							card += '</td>';
							card += '<td>';
							card += '<p class="card-text row justify-content-end">料金 : '+ total + '円</p>';
							card += '</td>';
							card += '</table>';
							card += '</div>';
							card += '</a>';
							card += '</div>';
							
							$("#hotelcon").append(card);
							
						}
						paging();
						
					});
		
		}

		function paging() {
			var pageFive = parseInt((page-0.01)/5);
			var previousGroup = "";
			previousGroup += '<li class="page-item">';
			previousGroup += '<a class="page-link">';
			previousGroup += '<span>«</span>';
			previousGroup += '</a>';
			previousGroup += '<input type="hidden" value="pr">';
			previousGroup += '</li>';
			$('.page-link').on("click", function () {
				pageMinus +=5;
				
			});
			$("#pagination").append(previousGroup);
			
			if(page<6){
				$("#pagination li:last-child").addClass("disabled");
			}
			if(res==0||((res-tempres)==0&&res!=1&&tempres!=0)||(res==1&&tempres==1)){
				for (var i = (res)*5+1; i < totalpage+1; i++) {
					var toPage = "";
					toPage += '<li class="page-item">';
					toPage += '<a class="page-link">' + i + '</a>';
					toPage += '<input type="hidden" value="'+i+'">';
					toPage += '</li>';
					$("#pagination").append(toPage);
					
					if(i==page){
						$("#pagination li:last-child").addClass("active");
					}
				}
			}else{
				for (var i = pageFive*5+1; i < pageFive*5+6; i++) {
					var toPage = "";
					toPage += '<li class="page-item">';
					toPage += '<a class="page-link">' + i + '</a>';
					toPage += '<input type="hidden" value="'+i+'">';
					toPage += '</li>';
					$("#pagination").append(toPage);
					
					if(i==page){
						$("#pagination li:last-child").addClass("active");
					}
				}
				
			}
			
			

			var nextGroup = "";
			nextGroup += '<li class="page-item">';
			nextGroup += '<a class="page-link">';
			nextGroup += '<span>»</span>';
			nextGroup += '</a>';
			nextGroup += '<input type="hidden" value="ne">';
			nextGroup += '</li>';
			
			$("#pagination").append(nextGroup);
			
			$('.page-link').on("click", function () {
				page = parseInt($(this).next().val());
				if($(this).next().val()=="ne"){
					pageFive +=1;
					page = pageFive*5+1;
					tempres++;
				}
				if($(this).next().val()=="pr"){
					pageFive -=1;
					page = pageFive*5+1;
					tempres--;
				}
				hotelmain();
				
			});
		
			if(page/5>res){
				$("#pagination li:last-child").addClass("disabled");
			}
		}
	</script>
</body>

</html>