<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hospital.KeywordDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 세션에서 로그인된 사용자 ID 가져오기
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    // 요청 파라미터에서 키워드 가져오기
    request.setCharacterEncoding("UTF-8");
    String keywordName = request.getParameter("keyword");
    if (keywordName == null || keywordName.trim().isEmpty()) {
        out.println("<script>alert('키워드를 입력해주세요.'); history.back();</script>");
        return;
    }

    // DAO 객체 생성 및 키워드 ID 검색
    KeywordDAO keywordDAO = new KeywordDAO();
    int keywordId = keywordDAO.getKeywordIdByName(keywordName);
    System.out.println("savekeyword로 전달된 키워드: " + keywordName);

    if (keywordId == -1) {
        out.println("<script>alert('해당 키워드를 찾을 수 없습니다.'); history.back();</script>");
        return;
    }
    // 사용자의 현재 키워드 개수 확인
    int keywordCount = keywordDAO.getKeywordCountByUser(userID);
    if (keywordCount >= 3) {
        out.println("<script>alert('키워드가 3개를 초과했습니다!'); history.back();</script>");
        return;
    }
    // u_k_mapping 테이블에 데이터 저장
    int result = keywordDAO.insertMapping(userID, keywordId);

    // 결과 처리
    if (result == 1) {
        out.println("<script>alert('키워드가 성공적으로 저장되었습니다!'); location.href='userpro.jsp';</script>");
    } else if (result ==0){
        out.println("<script>alert('키워드 저장에 실패했습니다.'); history.back();</script>");
    } else if (result == -1) {
    	out.println("<script>alert('해당 키워드는 이미 저장 되어있습니다.'); history.back();</script>");	
    }
%>

</body>
</html>