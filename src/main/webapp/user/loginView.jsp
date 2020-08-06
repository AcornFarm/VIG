<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
<meta name="viewport" content="width=device-width, initial-scale=1">


	<!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">

	
		
	
//=====회원가입 nav         //====로그인 모달에서 회원가입 누르면 풀페이지로 뜸...ajax이용?
	$( function() {
		$("#ty").on("click" , function() {
			//location.href="addUserView";
			location.href="/VIG/user/addUserView";
		});
	});
//=======로그인 이벤트
	$( function() {		
		$("#userCode").focus();	
		$("#login").on("click" , function() {
			var code=$("#userCode").val();
			var pw=$("#password").val();
			
			if(code == null || code.length <1) {
				alert('ID 를 입력하지 않으셨습니다.');
				$("#userCode").focus();
				return;
			}
			if(pw == null || pw.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				$("#password").focus();
				return;
			}
		////ajax 연결 안됨/ 로그인은 되는데 비번이나 아이디 다르면 모달이 다시 리로드 되어서 풀화면으로 나옴 폼에 action때문인가..	
			
			});
		});
	
   
</script>
	<style type="text/css">
	
	 
	 .fail_text { margin:10px; }
	 #top_title{ margin: 20px; }
	 
	</style>

</head>
<body>

<form action="/VIG/user/login" method="POST">
	<div class="lodin_modal">
	<div class="container-fluid" id="login_container">	
	
		<div class="text-center border border-light p-5">
  			<div class="row" id="top_title">
   			 <p class="h4 mb-6">Login</p>
   			</div>
			
    <!-- id -->
	    <input type="text" id="userCode" name="userCode" class="form-control mb-5" placeholder="id" required>
	    <span class="glyphicon glyphicon-ok form-control-feedback"></span>

    <!-- Password -->
   		<input type="password" id="password" name="password" class="form-control mb-2" placeholder="Password" required>
		<c:if test="${msg == 'fail' }">
    		<div class="fail_text" style="color:red">
    		아이디 또는 비밀번호를 확인해주세요.
    		</div>
    	</c:if>

    <!-- Sign in button -->
    	<button  class="btn btn-info btn-block my-4" id="login" >Sign in</button>
   
    <!-- Register -->
	    <p>Not a member?
	        <span id="ty" class="blue-text ml-1"  >Register</span>
	    </p>
	    
			</div>
		</div>
		</div>
</form>


</body>
</html>