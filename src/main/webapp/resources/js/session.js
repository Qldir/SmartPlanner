$(function() {
	
	
	$("#SessionCheck").on("click", function() {
		/*$("#checkModal").modal();*/
			
		
	});
	
	// 모달 초기화 이벤트
	$("#SessionCheck").on('hidden.bs.modal', function() {
		
		$("#checkButton").prop("checked", false);
		$("#member_pw").val('');
		
	});

	$('#member_pw').on('keyup', function() {

		var member_pw = $("#member_pw").val();

		$.ajax({

			url : "updatingchecking",
			method : "POST",
			data : {
				"member_pw" : member_pw
			},
			success : function(data) {
				if (data == 0) {
					$("#ch").text("暗証番号を確認してください");
					$("#ch").css("color","red");
					return;				
				} else {
					$("#ch").text("暗証番号が一致します");
					$("#ch").css("color","green");
				}

			}

		});

	});

	$("#memberSession").click(function() {
				
		
		var member_pw=$("#member_pw").val();		
		
		if(member_pw==""){
			$("#ch").text("暗証番号を入力してください");
			return;
		}
		
		
		$.ajax({

			url : "updatingchecking",
			method : "POST",
			data : {"member_pw" : member_pw	},
			success : numberChecking
			});
	

		
	function numberChecking(data) {
		
		if(data!=1){
			$("#ch").text("暗証番号が一致しておりません");
			return;
		}else{
			
			var radioVal=$("input[name=checkButton]").is(":checked") ;
			var url="/smartplanner";
			
			
			if (radioVal != true) {
				
				alert("案内事項をチェックしてください");
				return;
				} 
			
			$.ajax({
								
				url:"GotoSession",
				method:"POST",
				data:{"member_pw" : member_pw},
				success:function(data){
					if(data!=1){
						return;
					}else{
						
						alert("会員脱退完了");
						$(location).attr('href', url);
					}
				}
				
			});
			
			
		}
		
		
	}
	
		
		
		
		
		
		
		
		
		
		
		

		
		
		
	});

});
