<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>選択プランニング</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
</head>
<link rel="stylesheet"
	href="./resources/css/bootstrap-datetimepicker.min.css">
</head>
<body style="overflow-x:hidden;">
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
	<div class="row justify-content-md-center h-100 pt-5 px-5 mt-2"
		style="background-color: #F0FFF0">
		<div class="col-5 p-0">
			<form action="/smartplanner/planbyselect" method="post" id="dataForm">
					<div class="row w-100 m-0 rounded"
						style="box-shadow: 0px 0px 20px #000;">
						<div class="col-12 text-center text-white rounded-top"
							style="background-color: #192a56;">
							<h2 class="m-2">選択プランニング</h2>
						</div>
	
						<div class="col-12 bg-primary py-3">
							<div class="row">
								<div class="col-3 mt-3 mb-0 p-0 text-right">
									<h4>タイトル</h4>
								</div>
								<div class="col-8 mt-3 mb-0">
									<input type="text" class="form-control" placeholder="タイトルを入力してください"
										id="titleInput" name="plan_title">
								</div>
								<div class="col-3 mt-2 mb-0 p-0 text-right">
									<h4>地域</h4>
								</div>
								<div class="col-8 mt-2 mb-0">
									<select class="custom-select" id="areaInput" name="plan_area">
										<option value="-1" selected>地域を選んでください</option>
										<option value="0">東京</option>
										<option value="3">大阪</option>
									</select>
								</div>
								
								<div class="col-3 mt-2 mb-0 p-0 text-right">
									<h4>人数</h4>
								</div>
								<div class="col-8 mt-2 mb-0">
									<div class="input-group">
										<input type="text" class="form-control"
											placeholder="人数を入力してください" id="peopleInput" name="plan_peoplecount">
										<div class="input-group-append">
											<span class="input-group-text">名</span>
										</div>
									</div>
								</div>
								<div class="col-3 mt-2 mb-0 p-0 text-right">
									<h4>日付</h4>
								</div>
								<div class="col-8 mt-2 mb-0">
									<div class="input-group">
										<input type="text" class="form-control"
											placeholder="日付を入力してください" id="startDate" name="plan_from">
										<div class="input-group-append">
											<span class="input-group-text">から</span>
										</div>
									</div>
								</div>
								<div class="col-3 mt-0 mb-0 pl-3"></div>
								<div class="col-8 mt-0 mb-0">
									<div class="input-group">
										<input type="text" class="form-control"
											placeholder="日付を入力してください" id="endDate" name="plan_to">
										<div class="input-group-append">
											<span class="input-group-text">まで</span>
										</div>
									</div>
								</div>
	
								<div class="col-3 mt-2 mb-0 p-0 text-right">
									<h4>宿所</h4>
								</div>
								<div class="col-8 mt-2 mb-0">
									<div class="input-group">
										<input type="text" class="form-control"
											placeholder="場所を入力してください" readonly="readonly"
											id="locationInput" name="plan_startlocation">
										<div class="input-group-append">
											<button class="btn btn-light" type="button"
												id="locationSearch">探す</button>
										</div>
									</div>
								</div>
								<div class="row w-100 justify-content-md-center pl-4 mt-0 mb-0">
									<div class="col-10 my-3 p-0 text-center">
										<button type="button" class="btn btn-info btn-lg w-100"
											style="box-shadow: 0px 0px 5px #000;" id="submitPlan">日程作り</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
		</div>
	</div>
	<!-- footer -->
	<footer class="text-muted py-5" style="background-color: #F0FFF0">
			<div class="container">
				<p class="float-right">
					<a href="#">TOP</a>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.21.0/moment.min.js"
		type="text/javascript"></script>
	<script src="./resources/js/navbar.js"></script>
	<script src="./resources/js/bootstrap-datetimepicker.min.js"></script>
	<script>
	$(function() {
			// 데이트 타임 피커 달기 함수
			$("#startDate").datetimepicker();
			$("#endDate").datetimepicker();

			// 위치 찾기 팝업창 열기
			$("#locationSearch").on('click',function() {
				window.open("/smartplanner/searchmap", "newWindow", "width=500px, height=300px, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
			});

			// 서브밋 온클릭 이벤트
			$("#submitPlan").on('click', function() {
				var plan_title = $("#titleInput").val();
				if (plan_title == "") {
					alert("タイトルを入力してください");
					return;
				}
				
				var plan_area = $("#areaInput option:selected").val();
				if (plan_area == -1) {
					alert("地域を選択してください");
					return;
				}

				var plan_theme = $('input[name="plan_theme"]:checked').val();

				var plan_peoplecount = $("#peopleInput").val();
				if (plan_peoplecount == "") {
					alert("人数を入力してください");
					return;
				}else{
					if(isNaN(plan_peoplecount)){
						alert("数字だけで入力してください");
						return;
					}
				}

				var plan_from = $("#startDate").val();
				if (plan_from == "") {
					alert("開始日を入力してください");
					return;
				}

				var plan_to = $("#endDate").val();
				if (plan_to == "") {
					alert("終了日を入力してください");
					return;
				}
				
				var from_date=new Date(plan_from);
				var to_date=new Date(plan_to);
				if(from_date>to_date){
					alert("開始日は終了日より先にしてください");
					return;
				}
				
				var plan_startlocation = $("#locationInput").val();
				if (plan_startlocation == "") {
					alert("宿所位置を入力してください");
					return;
				}
		
				$('#dataForm').submit();
			});
	});
	</script>
</body>
</html>