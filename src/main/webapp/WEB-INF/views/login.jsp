<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>



<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="./resources/img/icon/favicon.ico">
<title>ログイン</title>
<!-- CSS dependencies -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
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
				</ul>
			</div>
		</div>
	</nav>
	
	
	<div class="text-center py-5 h-100 w-100" style="background: url('resources/img/banner/loginback.jpg') no-repeat; background-size:cover;">
		<div class="row justify-content-center">
			<div class="col-sm-4 justify-content-center rounded mt-4" style="background-color:rgba(255,255,255,1) !important; border-radius:25px !important;">
				<form action="Login" method="POST" id="Login">
					<div class="col-sm-12 mt-3 justify-content-center">
						<h1 class="font-weight-bold" style="color:#233c7a"><img
				src="./resources/img/icon/planstation-rev.png" style="height:50px; width:60px;" class="mr-1">Plan Station</h1>
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="text" class="form-control border-info p-2" name="member_email" id="member_email" placeholder=" EmailAddress">
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<input type="password" class="form-control border-info p-2" name="member_pw" id="member_pw" placeholder="password"> 
					</div>
					<div class="col-sm-12 mt-3 justify-content-center">
						<button type="button" class="btn btn-info btn-lg w-100"  id="LoginButton">
			            	ログイン
			            </button>
					</div>
					<div class="col-sm-12 mt-2 justify-content-center" style="height:50px;" >
						<a class="w-100 h-100" href="join"><button type="button"
									class="btn btn-light btn-lg float-right w-100"
									id="googleSignin">
									<img width="20px" alt="Google &quot;G&quot; Logo"
										src="./resources/img/icon/icon-google.png" /> &nbsp; Google
									アカウントでログイン
								</button></a>					
					</div>
					
					<div class="col-sm-12 text-left">
						<h6 style="font-size:14px; color:#233c7a;"><label class="mt-2" style="color:teal;">まだPLAN STATIONの会員ではございませんか？ <a href="./signup" id="signupPage" style="color:teal;">会員登録</a></label></h6>
					</div>
				</form>
			</div>
		</div>
	</div>
<!-- footer -->
		<footer class="text-muted py-5">
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
	$(function() {

		
		
		$('#LoginButton').on('click', TodoLogin);
	
	});

	
	
	
	function TodoLogin() {

		var member_email = $('#member_email').val();
		var member_pw = $('#member_pw').val();

		if (member_email == '' || member_pw == '') {
			alert('メールアドレスと暗証番号を入力してください');
			return;
		}

		var sendData = {
			'member_email' : member_email,
			'member_pw' : member_pw
		};
		
		$.ajax({
							
			url : 'Loginchecking',
			method : 'POST',
			data : JSON.stringify(sendData),
			dataType: 'JSON',
			contentType: "application/JSON; charset=UTF-8",
			success : function(res) {
				if (res == 1) {
					alert('ログインしました');

					$('#Login').submit();
				} else {
					alert('メールアドレスと暗証番号を再び確認してください');
					return;
				}

			}

		});

	}


function onSignIn(googleUser) {
	
  
	var check = confirm('GOOGLEアカウントにログインされています。自動でログイン及び会員登録しますか？');
	if(check == false){
		return false;
	}
	else{
		// Useful data for your client-side scripts:
		var profile = googleUser.getBasicProfile();
		console.log("ID: " + profile.getId()); // Don't send this directly to your server!
		console.log('Full Name: ' + profile.getName());
		console.log('Given Name: ' + profile.getGivenName());
		console.log('Family Name: ' + profile.getFamilyName());
		console.log("Image URL: " + profile.getImageUrl());
		console.log("Email: " + profile.getEmail());

		// The ID token you need to pass to your backend:
		var id_token = googleUser.getAuthResponse().id_token;
		console.log("ID Token: " + id_token);
	 
	    
	    var sendDate={
	    		  
	    		  "member_name":profile.getName(),
	    		  "member_email":profile.getEmail()
	     }
	          $.ajax({
		  		method   : 'POST',
		  		url    : 'GoogleJoin',
		  		data   : JSON.stringify(sendDate),
		  		dataType:"json",
		  		contentType:"application/json; charset=UTF-8",
		  		success: GotoGoogle
		  		  	 
	      });
	}
	
   
}


function GotoGoogle(google) {
	
	var total=google;
	var member_email = google.member_email;
	
	
	var form="";
	form+='<form id="formGoogle" action="loginNavbar" method="POST">';
	form+='<input type="hidden" value="'+member_email+'" name="member_email">';
	form+='</form>'
	
		
	$("#bodyId").append(form);
		
	$("#formGoogle").submit();
}

</script>
</body>
</html>