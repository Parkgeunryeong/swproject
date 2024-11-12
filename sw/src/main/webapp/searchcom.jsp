<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.CommunityDAO" %>    
<%@ page import="community.Community" %>
<%@ page import="java.util.ArrayList" %>
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
        int pageNumber = 1;
        if(request.getParameter("pageNumber") !=null) {
        	pageNumber =Integer.parseInt(request.getParameter("pageNumber"));
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
    <%
        CommunityDAO communityDAO = new CommunityDAO();
        ArrayList<Community> list = communityDAO.getSearch(request.getParameter("searchField"),
                request.getParameter("searchText"));
        if (list.size() == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('검색결과가 없습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        for (int i = 0; i < list.size(); i++) {
    %>
    <tr>
        
        <%-- 현재 게시글에 대한 정보 --%>
        <td><%= list.get(i).getCom_date().substring(0, 11) + list.get(i).getCom_date().substring(11, 13) + "시"
        + list.get(i).getCom_date().substring(14, 16) + "분" %></td>
        <td><a href="viewcom.jsp?com_id=<%= list.get(i).getCom_id() %>"><%= list.get(i).getCom_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
        .replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
        <td><%= list.get(i).getUserID() %></td>
        
    </tr>
    <%
        }
    %>
</tbody>
                       
                      
                </table>
                <a href="write.jsp" class="btn btn--primary pull-right">글쓰기</a>
                </div>
                </div>
                <div class="container">
    <div class="row">
        <form method="post" name="search" action="searchcom.jsp">
            <table class="pull-right">
                <tr>
                    <td>
                        <select class="form-control" name="searchField">
                            <option value="0">선택</option>
                            <option value="com_title">제목</option>
                            <option value="userID">작성자</option>
                        </select>
                    </td>
                    <td>
                        <input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100">
                    </td>
                    <td>
                        <button type="submit" class="btn btn-success">검색</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
                
      
      
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="js/bootstrap.js"></script>
      

</body>

</html>