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
  <title>日程掲示板</title>
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
  <link rel="stylesheet" href="resources/css/wireframe.css"> 
   <style>

.google {
  opacity: 0.85;
  text-decoration: none; /* remove underline from anchors */
}

.google:hover {
  opacity: 1;
}

</style>
  
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
  
 <div class="text-center py-5 h-50 w-100 mt-4" style="background:url('./resources/img/banner/planboard.jpg') no-repeat; background-size:cover; background-position: center;">
    <div class="container w-50 h-75" style="background-color:rgba(0,0,0,0.6) !important;">
		<div class="row h-100">
    		<div class="col-sm-2 h-100"></div>
    		<div class="col-sm-8 h-100" style="display: flex; align-items: center; justify-content: center;">
    			<div class="input-group">
    				<input type="text" class="form-control" placeholder="旅行日程を検索してみてください" id="searchInput">
    				<div class="input-group-append">
    					<button class="btn btn-info" type="button" id="search">検索</button>
    				</div>
    			</div>
    		</div>
    		<div class="col-sm-2 h-100"></div>
    	</div>
  	</div>
  </div>
  
  <div class="py-4 bg-light">
    <div class="container">
      <div class="row" id="resultPlan">
      </div>
    </div>
    <div class="col-md-12 mt-2">
		<ul class="pagination justify-content-center" id="pagination">	            
		</ul>
	</div>
  </div>
  
  
  <div id="aa"></div>
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
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="./resources/js/navbar.js"></script>
<script>
  $(function(){
	  
		// 플랜 불러오기
		for(var i=0;i<${boardList}.length;i++){	
			planCardView(${boardList}[i]);
		}
		
 		refreshPagination();
		
		// 검색 온클릭
		$("#search").on('click',function(){
			var searchName=$("#searchInput").val();
			$(location).attr("href", "./placesearch?keyword="+searchName);
		});
  });
  
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
		var keyword="${keyword}";
		if(keyword!=""){
			var url="./planboard?keyword="+keyword+"&page="+pageNum;
		}else{
			var url="./planboard?page="+pageNum;
		}
		$(location).attr('href', url);
	}
	
	// 플랜 뷰 넣기 함수
	function planCardView(boardDTO){
		
		var fromDate = new Date(boardDTO.plan_from.split(' ')[0]);
		var toDate = new Date(boardDTO.plan_to.split(' ')[0]);
		
		if(dateToTime(fromDate)==dateToTime(toDate)){
			var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) ) + 1;
		}
		else{
			var days = Math.ceil( (toDate.getTime()-fromDate.getTime())/(1000*60*60*24) );
		}
		
		var card='';
		card+='<div class="col-md-4 p-3">';
		card+='<a href="/smartplanner/detailboard?num='+boardDTO.board_seq+'">';
		card+='<div class="card select-card h-100" style="box-shadow: 7px 7px 7px #8C8C8C;">';
		card+='<div class="card-img-top image-container"><img class="card-img-top" src="./resources/img/banner/plan/'+boardDTO.plan_img+'.jpg"></div>';
		card+='<div class="card-img-overlay h-75 p-0">';
		card+='<div class="col-12 h-50"></div>';
		card+='<div class="col-12 h-50" style="background: linear-gradient( to bottom, rgba(0,0,0,0), rgba(0,0,0,1));">';
		card+='<div class="col-12 h-50"></div>';
		card+='<div class="col-12 h-50 p-1">';
		card+='<p class="card-text text-white m-0">';
		card+=fromDate.getFullYear()+"-"+(fromDate.getMonth()+1)+"-"+("00" + fromDate.getDate()).slice(-2)+" "+days+"DAYS";
		card+='</p>';
	    card+='<p class="card-text text-white font-weight-bold mx-0">'+boardDTO.plan_title+'</p>';
	    card+='</div>';
		card+='</div>';
		card+='</div>';
		card+='<div class="card-body">';
		card+='<div class="row">';
		card+='<div class="col-6">';
		if(boardDTO.plan_area==0){
			card+='<h6 class="card-title mb-1"><i class="fas fa-map-marker-alt mr-1"></i>'+"東京"+'</h6>';
		}else if(boardDTO.plan_area==3){
			card+='<h6 class="card-title mb-1"><i class="fas fa-map-marker-alt mr-1"></i>'+"大阪"+'</h6>';
		}
		card+='</div>';
		card+='<div class="col-3 p-0">';
		card+='<i class="far fa-thumbs-up mr-1"></i>';
		card+=boardDTO.favorite_sum;
		card+='</div>';
		card+='<div class="col-3 p-0">';
		card+='<i class="far fa-eye mr-1"></i>';
		card+=boardDTO.board_hitcount;
		card+='</div>';
		card+='</div>';
		card+='<p class="card-text">';
		card+='<i class="far fa-user mr-1"></i>'+boardDTO.member_name;
		card+='</p>';
		card+='</div>';
		card+='</a>';
		card+='</div>';
		
		$("#resultPlan").append(card);
	}
	
	// 데이트 시간으로 변환
	function dateToTime(date){
	    return ("0" + date.getHours()).slice(-2) + ":" +("0" + date.getMinutes()).slice(-2);
	}
  </script>
</body>

</html>