<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>


<script type="text/javascript">

		
//===로그인
	$(function(){
		$("#login_btn").on("click",function(){
			$(location).attr("href","../user/login");
			alert("session:"+sessionScope.getUserCode);
		});
//===로그아웃	
	$( "#logout_btn:contains('Log Out')" ).on("click" , function() {
			$(location).attr("href","../user/logout");
			}); 
			
	$( "#myFeed" ).on("click" , function() {
		//Debug..
		$(self.location).attr("href","../myFeed/myFeed.jsp");
		}); 
	});
	</script>	
	
	<style>
	
	#logoTop{
	 width: 90px;
	 height: 40px;
	}
	#login_btn , #logout_btn{
	color: white;
	}
	#fas_ntn{
	color: #ffb74d;
	}
	p{
	color: black;
	}
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark bg-dark py-2" id="toolbar">			
<!-- 로고 -->		
			  <a href="/VIG/main/main.jsp"><img src='/VIG/images/others/VIG_logo.png' id="logoTop" alt="VIG" ></a>
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-4"
				    aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light" id="" href="/VIG/search/getSearchResult.jsp">
	          <i class="fas fa-search" id="fas_ntn"></i>
	        </a>	   
<!-- 알람버튼 -->     
	        <a class="nav-link waves-effect waves-light" id="alarm_btn" href="#">
	          <i class="fas fa-bell" id="fas_ntn"></i>
	        </a>        
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments" id="fas_ntn"></i></a>
<!-- 로그인 버튼 -->   			
			 <c:if test="${ empty user }"> <a class="nav-link waves-effect waves-light" id="login_btn"><i class="far fa-user" id="fas_ntn"></i></a></c:if> 
			
			 <c:if test="${ user.role == 'user' ||  user.role == 'business'}"> 
				 <div class="nav-link dropdown-toggle" id="DropdownMenu" data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-user"></i>
        </div>
		        <div class="dropdown-menu dropdown-menu-right dropdown-default"
		          aria-labelledby="DropdownMenu">
		          <h6 class="dropdown-header">${user.userName}</h6>
		          <div class="dropdown-divider"></div>
		          <a class="dropdown-item" id="myFeed_btn" href="../myFeed/myFeed.jsp">My Feed</a>
		          <a class="dropdown-item" id="" href="../feed/addFeed.jsp"><p>Upload</p></a>
		          <a class="dropdown-item" id="" href="../user/getUserInfo.jsp"><p>Profile</p></a>
		          <a class="dropdown-item" ><p>------</p></a>
		          
		        </div>
		       <div id="logout_btn" >Log Out</div>
			</c:if>	  
			   
			<c:if test="${ user.role == 'admin'}">
				<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
		          aria-haspopup="true" aria-expanded="false">
		          <i class="fas fa-user"></i>
		        </a>
		        <div class="dropdown-menu dropdown-menu-right dropdown-default"
		          aria-labelledby="navbarDropdownMenuLink-333">
		          <h6 class="dropdown-header">${user.userName}</h6>
		          <div class="dropdown-divider"></div>
		          <a class="dropdown-item" id="myFeed_btn" href="">관리자페이지</a>		
		          <div id="logout_btn" ><p>Log Out</p></div>          
		        </div>		      
			</c:if>	     
			
	     	</div>
	      </nav>
		<br/>
		
</body>
</html>