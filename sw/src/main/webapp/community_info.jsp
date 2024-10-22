<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
</head>
<style type="text/css">
        a, a:hover {
             color: #000000;
             text-decoration: none;        
        }
</style>
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
		               <li><a href="">내 정보</a></li>
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
           <div class="row">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                      <thead>
                             <tr>
                             <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                             <th style="background-color: #eeeeee; text-align: center;">제목</th>
                             <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                             
                             
                             </tr>
                      </thead>
                      <tbody>
                             <tr>
                                 <td>10/20</td>
                                 <td>안녕하세요</td>
                                 <td>박근령</td>
                                 
                             
                             
                             </tr>
                      </tbody>
                      
                </table>
                <a href="write.jsp" class="btn btn--primary pull-right">글쓰기</a>
                </div>
                </div>
      
      
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="js/bootstrap.js"></script>
      

</body>

</html>