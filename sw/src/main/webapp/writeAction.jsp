<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="community.CommunityDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="community" class="community.Community" scope="page" />
<jsp:setProperty name="community" property="com_title" />
<jsp:setProperty name="community" property="com_content" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
   <%
   String userID = null;
   if(session.getAttribute("userID") != null) {
       userID = (String) session.getAttribute("userID");
   }
   if (userID == null) {
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('로그인을 하세요.')");
       script.println("location.href = 'login.jsp'");
       script.println("</script>");
   } else {
       if (community.getCom_title() == null || community.getCom_content() == null) {
           PrintWriter script = response.getWriter();
           script.println("<script>");
           script.println("alert('입력이 안 된 사항이 있습니다.')");
           script.println("history.back()");
           script.println("</script>");
       } else {
           CommunityDAO communityDAO = new CommunityDAO(); // 하나의 인스턴스를 만들어 준다
           int result = communityDAO.write(community.getCom_title(), userID, community.getCom_content());
           if (result == -1) {
               PrintWriter script = response.getWriter();
               script.println("<script>");
               script.println("alert('글쓰기에 실패했습니다.')");
               script.println("history.back()");
               script.println("</script>");
           } else {
               PrintWriter script = response.getWriter();
               script.println("<script>");
               script.println("location.href = 'community_info.jsp'");
               script.println("</script>");
           }
       }
   }
%>
   
	
</body>
</html>