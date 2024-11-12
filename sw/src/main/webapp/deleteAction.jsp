<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="community.Community" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
   }  
   int com_id = 0;
   if(request.getParameter("com_id") != null) {
      com_id = Integer.parseInt(request.getParameter("com_id"));
   }
   if (com_id == 0) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('유효하지 않은 글입니다.')");
      script.println("location.href = 'community_info.jsp'");
      script.println("</script>");
   }

   Community community = new CommunityDAO().getCommunity(com_id);
   if (!userID.equals(community.getUserID())) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('권한이 없습니다.')");
      script.println("location.href = 'community_info.jsp'");
      script.println("</script>");
   } else {
      CommunityDAO communityDAO = new CommunityDAO();  // 하나의 인스턴스를 만들어 준다
      int result = communityDAO.delete(com_id);
      if (result == -1) {
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('글 삭제에 실패했습니다.')");
         script.println("history.back()");
         script.println("</script>");
      } else {
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("location.href = 'community_info.jsp'");
         script.println("</script>");
      } 
   }
%>
   
	
</body>
</html>