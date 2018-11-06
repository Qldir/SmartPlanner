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

<style>
span#nic {
	color: red;
}

span#email {
	color: red;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>


	$(function() {

		$('#signUpButton').on('click', todoJoin);
		$('#member_name').on('keyup', nicnameChecking);
		$('#member_email').on('keyup', emailChecking);

	});

	
	
	function emailChecking() {

		var member_email = $("#member_email").val();
	
		
		
		$.ajax({

			url : 'duplicateChecking',
			method : 'POST',
			data : {
				'member_email' : member_email
			},
			success : function(data) {
				if (data == 0) {
					$('#email').text('사용가능한 이메일 주소입니다.');
					
				} else {
					$('#email').text('사용할수 없는 이메일 주소입니다.');
					
					return;
				}
			}

		});

	}

	function nicnameChecking() {

		var member_name = $("#member_name").val();
		
		if(member_name==''){
			alert("이름을 입력해 주세요");
			return;
		}
		$.ajax({

			url : 'checking',
			method : 'POST',
			data : {
				'member_name' : member_name
			},
			success : function(data) {
				if (data == 0) {
					$('#nic').text('사용가능한 닉네임입니다.');
					
				} else {
					$('#nic').text('사용할수 없는 닉네임입니다.');
					
					return;
				}
			}

		})

	}

	function todoJoin() {
			
		
		
		
		var member_email = $("#member_email").val();
		var member_name = $("#member_name").val();
		var member_pw = $("#member_pw").val();
		var conformPassword = $("#member_pw_check").val();
		
		
		 
		 
		if (member_email=='') {
			alert('이메일 주소를  입력해 주세요');
			
			return;
		}

		if (member_name == '') {
			alert('닉네임을  입력해주세요');
			$('#nicname').focus();
			return;
		}

		if (member_pw == '') {
			alert('비밀번호를 입력해주세요');
			$('#password').focus();
			return;
		}

		if (!/^[a-zA-Z0-9!@#$%^&*()?_~]{8,16}$/.test(member_pw)) {
			alert("비밀번호는 숫자, 영문, 특수문자 조합으로 8~16자리를 사용해야 합니다.");
			return;
		}

		if (member_pw != conformPassword) {
			alert("비밀번호가 일치 하지 않습니다.");
			return;
		}

		if (conformPassword == "") {
			alert("재확인 비밀 번호를 입력해 주세요");
			return;
		}

		$('#Login').submit();

	}
</script>
<title>会員登録</title>

<!-- CSS dependencies -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="resources/css/wireframe.css">
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
	<div class="text-center py-4 h-100 w-100" style="background: url('resources/img/banner/loginback.jpg') no-repeat; background-size:cover;">
		<div class="row justify-content-center">
			<div class="col-sm-4 justify-content-center rounded mt-4" style="background-color:rgba(255,255,255,1) !important; border-radius:25px !important;">
				
				<form action="loginForm" method="POST" id="Login">
					<div class="col-sm-12 mt-3 justify-content-center">
						<h1 class="font-weight-bold" style="color:#233c7a"><img
				src="./resources/img/icon/planstation-rev.png" style="height:50px; width:60px;" class="mr-1">Plan Station</h1>
					<span id="#email"></span>
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="text" class="form-control border-info p-2" name="member_email" id="member_email" placeholder="メールアドレス">
						<span id="email"></span>
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="text" class="form-control border-info p-2" name="member_name" id="member_name" placeholder="名前">
						<span id="nic"></span>
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="password" class="form-control border-info p-2" name="member_pw" id="member_pw" placeholder="暗証番号"> 
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="password" class="form-control border-info p-2" name="member_pw_check" id="member_pw_check" placeholder="暗証番号確認"> 
					</div>
					<div class="col-sm-12 my-3 justify-content-center">
						<button type="button" class="btn btn-info btn-lg w-100"  id="signUpButton">
			            	会員登録
			            </button>
					</div>
				</form>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="./resources/js/navbar.js"></script>	
</body>

</html>