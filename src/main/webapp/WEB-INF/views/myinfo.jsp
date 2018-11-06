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
<title>会員情報修正</title>
<!-- CSS dependencies -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet" href="./resources/css/wireframe.css">
<style>
#ch{
color: red;

}
#nic{
color: red;
font-size: 1px;
}

</style>


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

	<div class="modal fade" id="SessionCheck" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
  		      
        <h7 class="modal-title" id="exampleModalCenterTitle" >会員脱退</h7>
      
      
      </div>
      
      <div class="modal-body">
              <font size="2">お客様の<strong> ${Member.member_email}</strong> アカウントを脱退する場合、復旧が不可能となります。
               利用記録は全て削除されるので、ご慎重に選択してください。 
        </font>
        </br>
        </br>
        
        会員脱退をするため暗証番号をもう一度入力してください<br>
        <font size="2">
              <input type="password" id="member_pw"><br>
       <span id="ch"></span>
       </font>
       </br>
       
       <input type="checkbox" id="checkButton" name="checkButton"> 
       <font size="2">      
               脱退後、 ${Member.member_email} 会員情報及びサービス利用記録は全て削除させて頂きます。
        </font>
      
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-info mr-3" data-dismiss="modal">閉じる</button>
        <button type="button" class="btn btn-info mr-3" id="memberSession">会員脱退</button>
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
				<a 	class="list-group-item " href="./myplan">旅行日程</a> 
				<a  class="list-group-item " href="./myfavorite">お気に入り</a>
				<a  class="list-group-item active" href="myinfomation">会員情報修正</a>
			</div>
		</div>
		
		
		
		<div class="col-10 h-100">
			<div class="row h-100 bg-light py-3 justify-content-center">
				<div class="col-9 bg-white pt-3 pb-0 rounded border border-dark">
					
					<form action="memberModify" method="POST" id="ModifyForm" enctype="multipart/form-data">
						<h2 class="text-center mb-3 mt-1">会員情報修正</h2>
						
						
						<input type="hidden" name="member_seq" value="${Member.member_seq}">
						<input type="hidden" name="member_email" value="${Member.member_email}">
						
						<table class="table" id="tableNo">
							<tr>
								<th>プロフィール写真</th>
								<td><img id="profile" src="./resources/img/profile/${Member.member_img}" width="300"></td>
							</tr>
						
							
							<tr>
								<th>写真をアップする</th>
								<td><input type="file" name="fileUpload" id="fileUpload" />
								
								
								
								</td>
							</tr>
						
						
						
							<tr>
								<th>メールアドレス</th>
								<td>${Member.member_email}</td>
							</tr>
							<tr>
								<th>暗証番号</th>
								
								
											<td><input type="password" name="member_pw"
												id="password" value="${Member.member_pw}"> <font
												size="1px">数字、英語、特殊文字の組み合わせて8-16字で入力してください </font></td>
								
								</tr>
								<c:if test="${Member.member_pw ne'0'}">
							<tr>
								<th>暗証番号確認</th>
								<td><input type="password" name="Conformpassword" id="Conformpassword"></td>
							</tr>
								</c:if>
							<tr>
								<th>名前</th>
								<td><input type="text" name="member_name" id="member_name"
										value="${Member.member_name}"> 
										<span id="nic"></span>
								<span id="nic"></span>		
								</td>
							</tr>
							<tr>
								<td class="align-content-center pt-3 text-center" colspan="2">
									<!-- Button trigger modal -->
									
									<input type="button" class="btn btn-info mr-3" value="会員情報修正" id="lastButton">
									<button type="button" class="btn btn-info ml-3" data-toggle="modal" data-target="#SessionCheck">会員脱退</button>
									
																		
								
								</td>
							</tr>
						</table>
					</form>
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
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#profile').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	$("#fileUpload").change(function () {
	    readURL(this);
	});
	
	
	
	</script>
	
	
	
	<script>
	
	$(function () {
		
		$('#lastButton').on('click',modi);
		$('#member_name').on('keyup',nicnameChecking);
		
		
	});
	
	function nicnameChecking() {

		var member_name = $("#member_name").val();
		
		if(member_name==''){
			alert("名前を入力してください");
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
					$('#nic').text('使用できる名前です');
					
				} else {
					$('#nic').text('使用できない名前です');
					
					return;
				}
			}

		})

	}
	
	
	function modi() {

		var member_pw = $('#password').val();
		var Conformpassword = $('#Conformpassword').val();
		var member_name = $('#member_name').val();
	
		if (member_pw == '') {
			alert("暗証番号を入力してください");
			return;
		}

		if (!/^[a-zA-Z0-9!@#$%^&*()?_~]{8,16}$/.test(member_pw)) {
			alert("暗証番号は数字、英語、特殊文字の組み合わせて8-16字で入力してください");
			return;
		}

		if (Conformpassword == '') {
			alert("暗証番号確認を入力してください");
			return;
		}

		if (member_pw != Conformpassword) {

			alert('暗証番号確認が一致しておりません');
			
			return;
		}

		if (member_name == '') {
			alert('名前を入力してください');
			return;
		}

		$('#ModifyForm').submit();

	}
	
	</script>
</body>
</html>