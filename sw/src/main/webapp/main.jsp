<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<body>
     <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
        	userID = (String) session.getAttribute("userID");
        }
    
    %>
       <nav class="navbar navbar-default">
           <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                
                
                </button>
                 <a class="navbar-brand" href="main.jsp">jsp 게시판 웹사이트</a>
           </div>
           <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
           <ul class="nav navbar-nav">
              <li class="active"><a href="main.jsp">메인</a></li>
              <li><a href="bbs.jsp">게시판</a></li>
           </ul>
            <%
		         if(userID == null) {
 		     %>
		     <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		            <a href="#" class="dropdown-toggle"
		               data-toggle="dropdown" role="button" aria-haspopup="true"
		               aria-expanded="false">접속하기<span class="caret"></span></a>
		            <ul class="dropdown-menu">
		               <li class="active"><a href="login.jsp">로그인</a>
		               <li><a href="join.jsp">회원가입</a>
		            </ul>
		           </li>
		     </ul>
		     <% 
		         } else {
		      %>
		      <ul class="nav navbar-nav navbar-right">
		        <li class="dropdown">
		            <a href="#" class="dropdown-toggle"
		               data-toggle="dropdown" role="button" aria-haspopup="true"
		               aria-expanded="false">회원관리<span class="caret"></span></a>
		            <ul class="dropdown-menu">
		               <li><a href="logoutAction.jsp">로그아웃</a></li>
		            </ul>
		           </li>
		     </ul>
		     <%
		         }		     
		     %>
		     </div>
      </nav>
      <div class="container">
           <div class="jumbotron">
               <div class="container">
                   <h1>HELP HOSPITAL</h1>
                   <p>S/W프로젝트입니다.</p>
                   <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
                   </div> 
           </div>
      </div>
      <div class="container">
         <div class="jumbotron" style="background-color: blue;">
            <div class="container">
            <h1 align="center">
                <a href="map.jsp" style="color: inherit; text-decoration: none;">내 근처 병원 찾아보기</a>
            </h1>
            </div> 
        </div>
    </div>
    <div class="container">
    <div class="jumbotron" style="background-color: green;">
        <div class="container">
            <h1 align="center">
                <a href="" style="color: inherit; text-decoration: none;">병원 검색으로 찾아보기</a>
            </h1>
        </div> 
    </div>
</div>
<div class="container">
    <div class="jumbotron" style="background-color: red;">
        <div class="container">
            <h1 align="center">
                <a href="" style="color: inherit; text-decoration: none;">의료 정보 게시판</a>
            </h1>
        </div> 
    </div>
</div>
           
           
           
      
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="js/bootstrap.js"></script>

</body>
</html>