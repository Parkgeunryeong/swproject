<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.Community" %>
<%@ page import="community.CommunityDAO" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1"> 
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
    <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }
        
        int com_id = 0;
        if (request.getParameter("com_id") != null) {
            com_id = Integer.parseInt(request.getParameter("com_id"));
        }
        if (com_id == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'community.jsp'");
            script.println("</script>");
        }
        
        Community community = new CommunityDAO().getCommunity(com_id);
        if (!userID.equals(community.getUserID())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("location.href = 'community.jsp'");
            script.println("</script>");
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
              <li><a href="map.jsp">지도로 병원찾기</a></li>
              <li><a href="">병원 검색하기</a></li>
              <li class="dropdown">
		            <a href="#" class="dropdown-toggle"
		               data-toggle="dropdown" role="button" aria-haspopup="true"
		               aria-expanded="false">의료정보게시판<span class="caret"></span></a>
		            <ul class="dropdown-menu">
		               <li><a href="">의료 공지</a>
		               <li><a href="">의료 커뮤니티 게시판</a>
		            </ul>
		           </li>
    
                    
           </ul>
            
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
		     
		     </div>
      </nav>
	<div class="container">
	     <div class="row">
	          <form method="post" action="updateAction.jsp?com_id=<%= com_id %>">
	          
	          <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
	              <thead>
	                     <tr> 
	                         <th colspan ="2" style="background-color: #eeeeee; text-align: center;">게시판 글수정 양식</th>
	                     </tr>
	              </thead>
	              <tbody>
	                     <tr>
	                         <td><input type="text" class="form-control" placeholder="글 제목" name="com_title" maxlength="50" value="<%= community.getCom_title() %>"></td>
	                     </tr>    
	                     <tr>    
	                         <td><textarea  class="form-control" placeholder="글 내용" name="com_content" maxlength="2048" style="height: 350px;"><%= community.getCom_content() %></textarea></td>
	                     
	                     </tr>
	              
	              </tbody>
	              
	          </table>
	          <input type="submit" class="btn btn-primary pull-right" value="글수정">
	          </form>
	          
	     </div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>




</body>
</html>