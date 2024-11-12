<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title> JSP 게시판 웹 사이트  </title>
</head>
<body>
    <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
        	userID = (String) session.getAttribute("userID");
        }
        int com_id = 0;
        if(request.getParameter("com_id") != null) {
        	com_id = Integer.parseInt(request.getParameter("com_id"));
        }
        if (com_id == 0) {
       	  PrintWriter script = response.getWriter();
     	  script.println("<script>");
     	  script.println("alert('유효하지 않은 글입니다.')");
     	  script.println("location.href = 'bbs.jsp'");
     	  script.println("</script>");
        }
        Community community = new CommunityDAO().getCommunity(com_id);
    
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
	                         <th colspan ="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
	                     </tr>
	              </thead>
	              <tbody>
	                     <tr>
	                          <td style="width: 20%">글 제목</td>
	                          
	                          <td colspan="2">
	                            <div>
	                             <%= community.getCom_title().replaceAll(" ", "&nbsp")
	                                 .replaceAll("<", "&lt")
	                                 .replaceAll(">", "&gt")
	                                 .replaceAll("\n", "<br>") %>
	                            
	                            
	                            </div>
	                     </tr>  
	                     <tr>
                              <td>작성자</td>
	                          <td colspan="2"><%= community.getUserID() %></td>	                     
	                     
	                     </tr>
	                     <tr>
                              <td>작성일자</td>
	                          <td colspan="2"><%= community.getCom_date().substring(0, 11) + community.getCom_date().substring(11, 13) + "시" + community.getCom_date().substring(14, 16) + "분" %></td>
	                                           
	                     
	                     </tr>
	                     <tr>
                              <td>내용</td>
                              <td colspan="2">
	                            <div class="bbs-content" style="min-height: 200px; text-align: left">
	                             <%= community.getCom_content().replaceAll(" ", "&nbsp")
	                                 .replaceAll("<", "&lt")
	                                 .replaceAll(">", "&gt")
	                                 .replaceAll("\n", "<br>") %>
	                            
	                            
	                            </div>                     
	                     
	                     </tr>  
	              
	              </tbody>
	              
	          </table>
	          <a href="bbs.jsp" class="btn btn-primary">목록</a>
	          <%
	              if(userID != null && userID.equals(community.getUserID())) {
	            	  
	          %>
	                <a href="update.jsp?com_id=<%= com_id %>" class="btn btn-primary">수정</a>
	                <a onclick="return confirm('정말로 삭제하겠습니까?')"href="deleteAction.jsp?com_id=<%= com_id %>" class="btn btn-primary">삭제</a>
	          <%
	              }
	          %>
	          
	          
	     </div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>




</body>
</html>