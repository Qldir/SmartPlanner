<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>旅行日程</title>
<!-- CSS dependencies -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
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
	<div class="row h-auto pt-3 mt-4 bg-light">
		<div class="col-2 p-0 h-100">
			<div class="list-group" id="list-tab" role="tablist">
				<a class="list-group-item font-weight-bold rounded-0 py-3 text-center"
					style="background: #233c7a; color: white;">マイページ</a>
				<a 	class="list-group-item " href="./mypage">TOP</a>
				<a 	class="list-group-item active" href="./myplan">旅行日程</a> 
				<a  class="list-group-item " href="./myfavorite">お気に入り</a>
				<a  class="list-group-item " href="myinfomation">会員情報修正</a>
			</div>
		</div>
		<div class="col-10 h-100">
			<div class="row h-100 bg-light">
				<div class="col-12 p-2">
					<div class="row justify-content-md-center">
						<div class="container">
							<div class="row pt-3">
								<div class="col-md-12">
									<h2 class="text-center m-0">旅行日程</h2>
								</div>
							</div>
						</div>
						<div class="container">
							<div class="row px-2" id="myPlan"></div>
						</div>
					    <div class="col-md-12 mt-2">
							<ul class="pagination justify-content-center" id="pagination">	            
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
		<footer class="text-muted py-5 bg-light">
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
	</div>
	<script type="text/javascript">
			function googleTranslateElementInit() {
				  new google.translate.TranslateElement({pageLanguage: 'ja', 
					  layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: true}, 'google_translate_element');
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
	<script src="./resources/js/session.js"></script>
	<script src="./resources/js/navbar.js"></script>
	<script>
	
	$(function(){
		for(var i=0;i<${planList}.length;i++){
			planCardView(${planList}[i]);
		}
		
		refreshPagination();
	})
	
	// 플랜 뷰 넣기 함수
	function planCardView(plan){
	
		// 플랜 에리어 스트링화
		var planArea="";
		
		if(plan.plan_area==0){
			planArea="東京";
		}else if(plan.plan_area==3){
			planArea="大阪";
		}
		
		// 플랜 날짜 계산
		var planFrom=plan.plan_from;
		var planTo=plan.plan_to;
	
		var fromDate = new Date(planFrom.replace('.','/'));
		var toDate = new Date(planTo.replace('.','/'));
		
		if(dateToTime(fromDate)==dateToTime(toDate)){
			var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) ) + 1;
		}
		else{
			var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) );
		}
		
		// 카드 컴포넌트 넣기
		var card='';
		card+='<div class="col-md-4 p-3">';
		card+='<a href="/smartplanner/detailplan?num='+plan.plan_seq+'">';
		card+='<div class="card select-card h-100" style="box-shadow: 7px 7px 7px #8C8C8C;">';
		card+='<div class="card-img-top image-container"><img class="card-img-top" src="./resources/img/banner/plan/'+plan.plan_img+'.jpg"></div>';
		card+='<div class="card-img-overlay h-75 p-0">';
		card+='<div class="col-12 h-50"></div>';
		card+='<div class="col-12 h-50" style="background: linear-gradient( to bottom, rgba(0,0,0,0), rgba(0,0,0,1));">';
		card+='<div class="col-12 h-50"></div>';
		card+='<div class="col-12 h-50 px-1">';
		card+='<p class="card-text text-white m-0 font-weight-bold">'+days+"DAYS"+'</p>';
		card+='<p class="card-text text-white m-0">'+planFrom+" ~ "+planTo+'</p>';
	    card+='</div>';
		card+='</div>';
		card+='</div>';
		card+='<div class="card-body pb-2">';
		card+='<h5 class="card-title mb-1">'+plan.plan_title+'</h5>';
		card+='<p class="card-text">';
		card+='<i class="fas fa-map-marker-alt mr-1"></i>'+planArea;
		card+='</p>';
		card+='</div>';
		card+='</a>';
		card+='</div>';
		
		$("#myPlan").append(card);
	}
	
	 function refreshPagination(){
			$("#pagination").html("");
			
			// 페이지 네이션
		
			// 이전 그룹으로
			var previousGroup="";
			previousGroup+='<li class="page-item" value="'+((${currentGroup}-1)*5+1)+'">';
			previousGroup+='<a class="page-link" href="javascript:;">';
			previousGroup+='<span>«</span>';
			previousGroup+='</a>';
			previousGroup+='</li>';
			
			$("#pagination").append(previousGroup);
			
			// 첫그룹 일시에 비활성화
			if(${currentGroup}==0){
				$("#pagination li:last-child").addClass("disabled");
			}
			
			// 번호별 페이지네이션 추가
			if(${endPageGroup}==0){
				var toPage="";
				toPage+='<li class="page-item" value="'+1+'">';
				toPage+='<a class="page-link" href="javascript:;">'+1+'</a>';
				toPage+='</li>';
				
				$("#pagination").append(toPage);
				
				// 현재 페이지 선택 표시
				$("#pagination li:last-child").addClass("active");
			}else{
				for(var i=${startPageGroup};i<=${endPageGroup};i++){
					var toPage="";
					toPage+='<li class="page-item" value="'+i+'">';
					toPage+='<a class="page-link" href="javascript:;">'+i+'</a>';
					toPage+='</li>';
					
					$("#pagination").append(toPage);
					
					// 현재 페이지 선택 표시
					if(i==${currentPage}){
						$("#pagination li:last-child").addClass("active");
					}
				}
			}
			
			// 다음 그룹으로
			var nextGroup="";
			nextGroup+='<li class="page-item" value="'+(${currentGroup}*5+6)+'">';
			nextGroup+='<a class="page-link" href="javascript:;">';
			nextGroup+='<span>»</span>';
			nextGroup+='</a>';
			nextGroup+='</li>';
				
			$("#pagination").append(nextGroup);
			
			// 마지막 그룹 일시에 비활성화
			if(${currentGroup}==parseInt(${totalPageCount}/5)){
				$("#pagination li:last-child").addClass("disabled");
			}
			
	 		// 페이지네이션 이벤트 추가
			$(".page-item").on('click', toPagenation); 
		}
	  
		// 페이지 네이션 이동함수
		function toPagenation(){
			var pageNum=$(this).val();
			var url="./myplan?page="+pageNum;
			$(location).attr('href', url);
		}
		
		// 데이트 시간으로 변환
		function dateToTime(date){
		    return ("0" + date.getHours()).slice(-2) + ":" +("0" + date.getMinutes()).slice(-2);
		}
	</script>
</body>
</html>