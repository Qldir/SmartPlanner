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
<title>${place.place_name}詳細情報</title>
<!-- CSS dependencies -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
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
	<c:if test="${place.place_area ==0}">
		<c:set var="imgsrc" value="tokyo"></c:set>
	</c:if>
	<c:if test="${place.place_area ==1}">
		<c:set var="imgsrc" value="yokohama"></c:set>
	</c:if>
	<c:if test="${place.place_area ==2}">
		<c:set var="imgsrc" value="saitama"></c:set>
	</c:if>
	<c:if test="${place.place_area ==3}">
		<c:set var="imgsrc" value="osaka"></c:set>
	</c:if>
	<c:if test="${place.place_area ==4}">
		<c:set var="imgsrc" value="nara"></c:set>
	</c:if>
	<c:if test="${place.place_area ==5}">
		<c:set var="imgsrc" value="kyoto"></c:set>
	</c:if>
	<c:if test="${place.place_area ==6}">
		<c:set var="imgsrc" value="kobe"></c:set>
	</c:if>
	<c:if test="${place.place_area ==7}">
		<c:set var="imgsrc" value="tokyo"></c:set>
	</c:if>
	<c:if test="${place.place_area ==8}">
		<c:set var="imgsrc" value="osaka"></c:set>
	</c:if>
	<div class="text-center py-5 h-50 w-100 mt-4"
		style="background:url('./resources/img/banner/${imgsrc}.jpg') no-repeat center center; background-size:cover;">
		<div class="container w-50 h-75"
			style="background-color: rgba(0, 0, 0, 0.6) !important;">
			<div class="row h-100">
				<div class="col-sm-2 h-100"></div>
				<div class="col-sm-8 h-100"
					style="display: flex; align-items: center; justify-content: center;">
					<div class="input-group">
						<input type="text" class="form-control"
							placeholder="都市／旅行地を検索してみてください">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary" type="button"
								id="searchPlace">検索</button>
						</div>
					</div>
				</div>
				<div class="col-sm-2 h-100"></div>
			</div>
		</div>
	</div>
	<div class="py-5">
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<div class="col-12">
						<h1>${place.place_name}</h1>
					</div>
					<c:if
						test='${(fn:replace(place.place_opentime,":","")+0) < (fn:replace(place.place_closetime,":","")+0)}'>
						<div class="col-12">
							<h5 class="my-1">営業時間 : ${place.place_opentime} ~
								${place.place_closetime}</h5>
						</div>
					</c:if>
					<c:if
						test='${(fn:replace(place.place_opentime,":","")+0) > (fn:replace(place.place_closetime,":","")+0)}'>
						<div class="col-12">
							<h5 class="my-1">営業時間 : ${place.place_opentime} ~ 翌日
								${place.place_closetime}</h5>
						</div>
					</c:if>
					<c:if
						test='${fn:replace(place.place_opentime,":","") eq 0 and fn:replace(place.place_closetime,":","") eq 0}'>
						<div class="col-12">
							<h5 class="my-1">営業時間 : 24時間</h5>
						</div>
					</c:if>
					<div class="col-12">
						<h5 class="my-1">住所 : ${place.place_location}</h5>
					</div>
					<c:if test="${place.place_homepage != null }">
						<div class="col-12">
							<h5 class="my-1">
								ホームページ : <a href="${place.place_homepage }">${place.place_homepage }</a>
							</h5>
						</div>
					</c:if>
					<div class="col-12">
						<h5 class="my-1" id="gradeView">
							ユーザー点数 : <span class="fa fa-star ml-1 checked"></span><a class="ml-2"></a>
						</h5>
					</div>
					<div class="col-12">
						<h6 class="my-3" style="line-height: 1.5;">${place.place_detail}</h6>
					</div>
					<div class="row">
						<div class="col-6 mt-4 pl-4" id="myGradeView">
						</div>
						<div class="col-6 mt-4">
							<div class="starrating d-flex flex-row-reverse">
								<input type="radio" id="star5" name="rating" value="5" /><label
									for="star5" title="5 star"></label> <input type="radio"
									id="star4" name="rating" value="4" /><label for="star4"
									title="4 star"></label> <input type="radio" id="star3"
									name="rating" value="3" /><label for="star3" title="3 star"></label>
								<input type="radio" id="star2" name="rating" value="2" /><label
									for="star2" title="2 star"></label> <input type="radio"
									id="star1" name="rating" value="1" /><label for="star1"
									title="1 star"></label>
								<p class="mr-1 mt-1">点数を残す :</p>
							</div>
						</div>
					</div>
					<div class="col-12">
						<div class="input-group mb-3" id="commnetInputGroup">
							<textarea class="form-control" id="commentTextArea" rows="2"
								style="resize: none;"></textarea>
							<div class="input-group-append">
								<button type="button" class="btn btn-info w-100 ml-1 rounded"
									id="commentButton">レビューを残す</button>
							</div>
						</div>
					</div>
					<div class="col-12 mt-4" id="comment"></div>
					<div class="col-md-12 mt-2">
						<ul class="pagination justify-content-center" id="pagination">

						</ul>
					</div>
				</div>
				<div class="col-sm-4 border-left border-primary">
					<div class="row">
						<div class="col-12">
							<img class="img-fluid d-block w-100 h-100"
								src="${place.place_image }">
						</div>
					</div>
					<div class="row">
						<div class="col-12 pt-2">
							<div class="h-100 w-100" id="map" style="padding-top: 100%"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 pt-2" id="weatherView">
						
						</div>
					</div>
				</div>
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
	<script src="./resources/js/jquery.autoKana.js"></script>
	<script src="./resources/js/navbar.js"></script>
	<script>
	$(function(){
		
		// 반응형 이미지 확대 축소 이벤트
		$(".select-card").hover(function(){
			$(this).addClass("border border-success selected-board");
		}, function(){
			$(this).removeClass("border border-success selected-board");
		}
		);
		
		// 덧글 평점 불러오기
		refreshPage();
		getGrade();
		
		// 로그인 안했을시 덧글 작성 불가
		if(${sessionScope.member_name==null}){
			$("#commnetInputGroup").on('click',function(){
				alert("レビュー機能はログインユーザーのみ使用可能です");
			});
			$("#commentTextArea").attr("readonly","readonly");
			$("#commentButton").attr("disabled", true);
		}
		
		// 덧글 달기 ajax 이벤트
 		$("#commentButton").on("click",function(){
			var content=$("#commentTextArea").val();
 			if(content==""){
 				alert("内容を入力してください");
 			}else{
 				content=content.replace(/(?:\r\n|\r|\n)/g, '<br/>');
 				$.ajax({
 					url:"detailplace/insertcomment",
 					type:"post",
 					data:{
 						place_review_content:content,
 						place_seq:${place.place_seq}
 					},
 					success:function(result){
 						if(result==1){
 							$("#commentTextArea").val("");
 							refreshPage();
 						}else{
 							alert("通信エラー");
 						}
 					},
 					error:function(){
 						alert("通信エラー");
 					}
 				});
 			}
		});
	});
	
	// 리프레쉬 ajax
	function refreshPage(){
		$.ajax({
			url:"detailplace/getcomment",
			type:"post",
			data:{
				place_seq:${place.place_seq}
			},
			success:function(result){
				if(result!=null){
					refreshComment(result);
					refreshPagination(result);
				}else{
					alert("通信エラー");
				}
			},
			error:function(){
				alert("通信エラー");
			}
		});
	}
	
	function refreshComment(result){
		$("#comment").html("");
		
		var commentCount="";
		commentCount+='<div class="col-12">';
		commentCount+='<h6 class="mb-0">ユーザーレビュー ('+result.totalRecordsCount+')</h6>';
		commentCount+='</div>';
		$("#comment").append(commentCount);
		// 덧글 추가
		for(var i=0;i<result.reviewList.length;i++){
			var commentComponent="";
			commentComponent+='<div class="row">';
			commentComponent+='<div class="col-sm-3 p-2">';
			commentComponent+='<div class="card w-100 mt-2">';
			commentComponent+='<img class="card-img-top" src="./resources/img/profile/'+result.reviewList[i].member_img+'" alt="profile image" style="height:140px; width:157px;">';
			commentComponent+='</div>';
			commentComponent+='</div>';
			commentComponent+='<div class="col-sm-9 p-2">';
			commentComponent+='<div class="card w-100 mt-2">';
			commentComponent+='<div class="card-body">';
			commentComponent+='<h4 class="card-title my-0">'+result.reviewList[i].member_name+'</h4>';
			commentComponent+='<p class="card-text mt-1 mb-0" style="min-height:40px !important;">'+result.reviewList[i].place_review_content+'</p>';
			commentComponent+='<div class="row align-bottom">';
			commentComponent+='<div class="col-sm-9">';
			commentComponent+='<p class="card-text my-0"><small class="text-muted">'+result.reviewList[i].place_review_regdate+'</small></p>';
			commentComponent+='</div>';
			if(result.reviewList[i].member_seq=="${sessionScope.member_seq}"){
				commentComponent+='<div class="col-sm-3">';
				commentComponent+='<a href="javascript:;" class="card-link review-update">修正</a>';
				commentComponent+='<a href="javascript:;" class="card-link review-delete">削除</a>';
				commentComponent+='<input type="hidden" value="'+result.reviewList[i].place_review_seq+'">';
				commentComponent+='</div>';
			}
			commentComponent+='</div>';
			commentComponent+='</div>';
			commentComponent+='</div>';
			commentComponent+='</div>';
			
			$("#comment").append(commentComponent);
		}
		
		// 덧글 수정 삭제 이벤트 추가
		$(".review-delete").on('click', deleteReview);
		$(".review-update").on('click', updateReview);
	}
	
	// 리뷰 삭제
	function deleteReview(){
		var review_seq=$(this).parent().children('input').val();
		$.ajax({
			url:"detailplace/deletecomment",
			type:"post",
			data:{
				place_review_seq:review_seq
			},
			success:function(result){
				if(result==1){
					refreshPage();
				}else{
					alert("通信エラー");
				}
			},
			error:function(){
				alert("通信エラー");
			}
		});
	}
	
	// 리뷰 수정
	function updateReview(){
		var content=$(this).parent().parent().parent().children("p").html();
		content = content.split('<br>').join("\r\n");
		var reviewUpdateForm='';
		reviewUpdateForm+='<h4 class="card-title my-0">'+$(this).parent().parent().parent().children("h4").text()+'</h4>';
		reviewUpdateForm+='<div class="col-12 px-0">';
		reviewUpdateForm+='<div class="input-group mt-2 w-100">';
		reviewUpdateForm+='<textarea class="form-control" rows="3" style="resize: none;">'+content+'</textarea>';
		reviewUpdateForm+='<div class="input-group-append">';
		reviewUpdateForm+='<button type="button" class="btn btn-info w-100 ml-1 rounded update-comment">レビュー修正</button>';
		reviewUpdateForm+='<input type="hidden" value="'+$(this).parent().children('input').val()+'">';
		reviewUpdateForm+='</div>';
		reviewUpdateForm+='</div>';
		reviewUpdateForm+='</div>';
		$(this).parent().parent().parent().html(reviewUpdateForm);
		
		$(".update-comment").on('click', updateReviewEvent);
	}
	
	// 리뷰 수정 AJAX
	function updateReviewEvent(){
		var review_seq=$(this).next().val();
		var review_content=$(this).parent().parent().children("textarea").val();
		review_content=review_content.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		$.ajax({
			url:"detailplace/updatecomment",
			type:"post",
			data:{
				place_review_seq:review_seq,
				place_review_content:review_content
			},
			success:function(result){
				if(result==1){
					refreshPage();
				}else{
					alert("通信エラー");
				}
			},
			error:function(){
				alert("通信エラー");
			}
		});
	}
	
	// 페이지 네이션 리프레쉬
	function refreshPagination(result){
		$("#pagination").html("");
		
		// 페이지 네이션
	
		// 이전 그룹으로
		var previousGroup="";
		previousGroup+='<li class="page-item" value="'+((result.currentGroup-1)*5+1)+'">';
		previousGroup+='<a class="page-link" href="javascript:;">';
		previousGroup+='<span>«</span>';
		previousGroup+='</a>';
		previousGroup+='</li>';
		
		$("#pagination").append(previousGroup);
		
		// 첫그룹 일시에 비활성화
		if(result.currentGroup==0){
			$("#pagination li:last-child").addClass("disabled");
		}
		
		// 번호별 페이지네이션 추가
		if(result.endPageGroup==0){
			var toPage="";
			toPage+='<li class="page-item" value="'+1+'">';
			toPage+='<a class="page-link" href="javascript:;">'+1+'</a>';
			toPage+='</li>';
			
			$("#pagination").append(toPage);
			
			// 현재 페이지 선택 표시
			$("#pagination li:last-child").addClass("active");
		}else{
			for(var i=result.startPageGroup;i<=result.endPageGroup;i++){
				var toPage="";
				toPage+='<li class="page-item" value="'+i+'">';
				toPage+='<a class="page-link" href="javascript:;">'+i+'</a>';
				toPage+='</li>';
				
				$("#pagination").append(toPage);
				
				// 현재 페이지 선택 표시
				if(i==result.currentPage){
					$("#pagination li:last-child").addClass("active");
				}
			}
		}
		
		// 다음 그룹으로
		var nextGroup="";
		nextGroup+='<li class="page-item" value="'+(result.currentGroup*5+6)+'">';
		nextGroup+='<a class="page-link" href="javascript:;">';
		nextGroup+='<span>»</span>';
		nextGroup+='</a>';
		nextGroup+='</li>';
			
		$("#pagination").append(nextGroup);
		
		// 마지막 그룹 일시에 비활성화
		if(result.currentGroup==parseInt(result.totalPageCount/5)){
			$("#pagination li:last-child").addClass("disabled");
		}
		
		// 페이지네이션 이벤트 추가
		$(".page-item").on('click', toPagenation);
		
		
		
		// 평점 남기기 이벤트 추가
		$(".starrating").change(function(){
			var grade=$(".starrating input:checked").val();
			$.ajax({
				url:"detailplace/insertgrade",
				type:"post",
				data:{
					place_seq: ${place.place_seq},
					place_grade_value:grade
				},
				success:function(data){
					if(data==true){
						getGrade();
					}
				},
				error:function(){
					alert("通信エラー");
				}
			});
		});
		
		// 비 로그인시 평점 남기기 비활성화
		if(${sessionScope.member_email==null}){
			$(".starrating input").attr("type","hidden");
			$(".starrating").click(function(){
				alert("点数残し機能はログインユーザーのみ使用可能です");
			});
		}
	}
	
	// 평점 가져오기 함수
	function getGrade(){
		$.ajax({
			url:"detailplace/getgrade",
			type:"post",
			data:{
				place_seq:${place.place_seq}
			},
			success:function(result){
				if(result.place_grade==null){
					$("#gradeView a").html("0.0 / 5.0");
				}
				if(result.place_grade.length==1){
					result.place_grade=result.place_grade+".0";
				}
				$("#gradeView a").html(result.place_grade+" / 5.0");
				
				if(result.place_grade_user!=null){
					$("#myGradeView").html("");
					var myGrade="";
					myGrade+='<h5 class="my-1">';
					myGrade+='マイ点数 : ';
					
					for(var i=0;i<5;i++){
						if(i<result.place_grade_user){
							myGrade+='<span class="fa fa-star mr-1 checked"></span>';
						}else{
							myGrade+='<span class="fa fa-star mr-1"></span>';	
						}
					}
					myGrade+='</h5>';

					$('#myGradeView').append(myGrade);
					
					$('.starrating').children("p").text("点数修正 : ");
				}
			},
			error:function(){
				alert("通信エラー");
			}
		});
	}
	
	// 페이지 네이션 이동함수
	function toPagenation(){
		var pageNum=$(this).val();
		$.ajax({
			url:"detailplace/getcomment",
			type:"post",
			data:{
				place_seq:${place.place_seq},
				currentPage:pageNum
			},
			success:function(result){
				if(result!=null){
					refreshComment(result);
					refreshPagination(result);
				}else{
					alert("通信エラー");
				}
			},
			error:function(){
				alert("通信エラー");
			}
		});
	}
	
	//날씨 보여주기
	function setWeather(locationInfo)
		{
			var location=locationInfo.toString();
			location=location.replace("(","");
			location=location.replace(")","");
			location=location.replace(" ","");
			var lat=location.split(",")[0];
			var lon=location.split(",")[1];
			
			$.ajax({
				method:'get',
				url:"https://api.weatherbit.io/v2.0/forecast/daily?&lat="+lat+"&lon="+lon+"&key=7940493213f04a959b79d7ba99d26edc&days=14",
				dataType:"json",
				success:function(resp)
				{
					var data = '<table class="table">';
					data+='<thead>';
					data+='<tr>';
					data+='<td class="text-center font-weight-bold" colspan="7">';
					data+="現地天気予報";
					data+='</td>';
					data+='</tr>';
					data+='</thead>';
					for (var i=0;i<resp.data.length;i++){
						if(i==0 || i==7){
							data+="<tr>";
						}
						data+='<td class="p-0">';
						data+='<p class="mb-0 pl-1">'+resp.data[i].datetime.split("-")[1]+"/"+resp.data[i].datetime.split("-")[2]+"</p>";
						data+='<img src="./resources/img/icon/weather/'+resp.data[i].weather.icon+'.png" style="width:40px; height:40px;">';
						data+='<p class="mb-0 pl-1" style="color:red;">'+resp.data[i].app_max_temp+"</p>";
						data+='<p class="mb-1 pl-1" style="color:blue;">'+resp.data[i].app_min_temp+"</p>";
						data+="</td>";
						if(i==6 || i==13){
							data+="</tr>";
						}
					}
					data+='</table>'
					
					$('#weatherView').append(data);
				}
			}); 
		}
	
	// 구글맵 콜백함수
	function initMap(){
		
		var lat = ("${place.place_location}").split(",")[0]+0;
		var lng = ("${place.place_location}").split(",")[1]+0;	
		var center = new google.maps.LatLng(lat,lng);
		
		var myOption = {
				zoom : 17,
				center : {
					lat : 35.6894875,
					lng : 139.6917639999993
				},
				gestureHandling : 'greedy'
			};
		
		map = new google.maps.Map(document.getElementById('map'), myOption);

		geocodeAddressGetWeather("${place.place_location}" +" ${place.place_name}");
	}
	</script>
	<script src="./resources/js/googleMap.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBsibtVFd7RMFL3pevLFwrAEut_2hPwmw&libraries=places&language=ja&callback=initMap"
		async defer></script>
</body>

</html>