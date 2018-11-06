$(function(){
		
		// 로그인창 열기
		$("#login").on("click", function() {
			$("#loginModal").modal();
		});

		// 회원가입창 열기
		$("#signup").on("click", function() {
			$("#signinContainer").toggle();
			$("#signupContainer").toggle();
		});

		// 모달 초기화 이벤트
		$("#loginModal").on('hidden.bs.modal', function() {
			$("#signupContainer").hide();
			$("#signinContainer").show();
			$("#loginEmail").val("");
			$("#loginPassword").val("");
			$("#inputUpName").val("");
			$("#inputUpPassword").val("");
			$("#inputUpVerify").val("");
			$("#inputUpEmail").val("");
		});
		
		// 로그인 이메일 유호성 검사
		$("#loginEmail")
				.on(
						'keyup',
						function() {
							var useremail = $("#loginEmail").val();
							
							
							if (useremail.indexOf('@') == -1
									|| useremail.indexOf('.') == -1
									|| useremail.indexOf('.') == (useremail.length - 1)) {
								$("#loginEmail").removeClass("is-valid");
								$("#loginEmail").addClass("is-invalid");
							} else {
								$("#loginEmail").removeClass("is-invalid");
								$("#loginEmail").addClass("is-valid");
							}
						});

		// 로그인 비밀번호 유효성 검사
		$("#loginPassword").on('keyup', function() {
			var userpw = $("#loginPassword").val();
			
			
			
			if (userpw.length < 8) {
				$("#loginPassword").removeClass("is-valid");
				$("#loginPassword").addClass("is-invalid");
			} else {
				$("#loginPassword").removeClass("is-invalid");
				$("#loginPassword").addClass("is-valid");
			}
		});
		
		// 회원가입 이름 유효성 검사
		$("#inputUpName").on('keyup', function() {
			var username = $('#inputUpName').val();
			if (username.length<2) {
				$("#inputUpName").removeClass("is-valid");
				$("#inputUpName").addClass("is-invalid");
			} else {
				$("#inputUpName").removeClass("is-invalid");
				$("#inputUpName").addClass("is-valid");
			}
		});
		
		// 회원가입 이메일 유효성 검사
		$("#inputUpEmail")
				.on(
						'keyup',
						function() {
							var useremail = $("#inputUpEmail").val();
							if (useremail.indexOf('@') == -1
									|| useremail.indexOf('.') == -1
									|| useremail.indexOf('.') == (useremail.length - 1)) {
								$("#inputUpEmail").removeClass("is-valid");
								$("#inputUpEmail").addClass("is-invalid");
							} else {
								$.ajax({
									url : "duplicateChecking",
									type : "post",
									data : {
										member_email : useremail
									},
									success : function(data) {
										if (data == 0) {
											$("#inputUpEmail").removeClass(
													"is-invalid");
											$("#inputUpEmail").addClass(
													"is-valid");
										} else {
											$("#inputUpEmail").removeClass(
													"is-valid");
											$("#inputUpEmail").addClass(
													"is-invalid");
										}
									},
									error : function() {
										alert("통신에러");
									}
								});
							}
						});
		
		// 회원가입 PW 유효성 검사
		$("#inputUpPassword").on('keyup', function() {
			var userpw = $("#inputUpPassword").val();
			if (/^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/.test(userpw)) {
				$("#inputUpPassword").removeClass("is-invalid");
				$("#inputUpPassword").addClass("is-valid");
			}else{
				$("#inputUpPassword").removeClass("is-valid");
				$("#inputUpPassword").addClass("is-invalid");
			}
		});
		
		//회원가입 PW확인 유효성 검사
		$("#inputUpVerify").on('keyup', function() {
			var userpw = $("#inputUpPassword").val();
			var verify = $("#inputUpVerify").val();
			if (userpw == verify) {
				$("#inputUpVerify").removeClass("is-invalid");
				$("#inputUpVerify").addClass("is-valid");
			} else {
				$("#inputUpVerify").removeClass("is-valid");
				$("#inputUpVerify").addClass("is-invalid");
			}
		});
		
		// 회원가입 버튼 이벤트
		$("#register").on(
				'click',
				function() {
					if ($("#inputUpName").hasClass("is-valid")
							&& $("#inputUpPassword").hasClass("is-valid")
							&& $("#inputUpEmail").hasClass("is-valid")
							&& $("#inputUpVerify").hasClass("is-valid")) {
						var username = $("#inputUpName").val();
						var userpw = $("#inputUpPassword").val();
						var useremail = $("#inputUpEmail").val();
						
						
						
						var submitData = {
							member_name : username,
							member_pw : userpw,
							member_email : useremail
						};
						$.ajax({
							url : "signup",
							type : "post",
							data : submitData,
							success : function(data) {
								if (data == true) {
									$("#successContainer").toggle();
									$("#signupContainer").toggle();

									// 회원가입 카드값 초기화
									$("#inputUpName").val("");
									$("#inputUpPassword").val("");
									$("#inputUpVerify").val("");
									$("#inputUpEmail").val("");
								} else {
									alert("회원가입 실패");
								}
							},
							error : function() {
								alert("통신 에러");
							}
						});
					} else {
						alert("올바른 값을 입력해주세요");
					}
				});

		
		
		// 성공후 로그인 화면으로
		$("#toSignin").on('click', function() {
			$("#successContainer").toggle();
			$("#signinContainer").toggle();
		});
		
		// 로그인 이벤트
		$("#signin").on(
				'click',
				function() {
					if ($("#loginPassword").hasClass("is-valid")
							&& $("#loginEmail").hasClass("is-valid")) {
						$("#formLogin").submit();
					} else {
						alert("올바른 값을 입력해주세요");
					}
				});
		
		// 로그아웃 이벤트
		$("#logout")
				.on(
						'click',
						function() {
							var form = "<form id='logoutForm' action='GotoLogout' method='post'></form>";
							$('body').append(form);
							$("#logoutForm").submit();
						});
		
		// 네비바 검색 기능
		$("#searchButtonNavbar").on('click',function(){
			var searchName=$("#searchInputNavbar").val();
			$(location).attr("href", "./placesearch?keyword="+searchName);
		});
	});