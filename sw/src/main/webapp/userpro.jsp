<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="hospital.KeywordDAO" %>
<%@ page import="java.util.ArrayList" %>
 <%
   if ("autocomplete".equals(request.getParameter("action"))) {
	   KeywordDAO keyworddao = new KeywordDAO();
	   String keyword = request.getParameter("keyword");
    ArrayList<String> keywords = keyworddao.getKeywordsByKeyword(keyword);
    for (String kw : keywords) {
        out.println("<li class='autocomplete-suggestion'>" + kw + "</li>");
    }
    return; // 자동 완성 요청에 대한 응답만 처리
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
<style>
    .autocomplete-suggestions {
        border: 1px solid #ccc;
        background: #fff;
        max-height: 150px;
        overflow-y: auto;
        position: absolute;
        width: 300px; /* 검색창과 동일한 너비로 설정 */
        margin-top: 5px; /* 검색창과의 간격 */
        z-index: 1000; /* 다른 요소보다 위에 표시 */
    }
    .autocomplete-suggestions li {
        padding: 10px;
        cursor: pointer;
        list-style: none; /* 리스트 스타일 제거 */
    }
    .autocomplete-suggestions li:hover {
        background-color: #f0f0f0;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    $("#keyword").keyup(function(){
        var query = $(this).val();
        if (query != "") {
            $.ajax({
                url: 'userpro.jsp',
                method: 'GET',
                data: { keyword: query, action: 'autocomplete' },
                success: function(data) {
                    $("#keywordList").fadeIn();
                    $("#keywordList").html(data);
                }
            });
        } else {
            $("#keywordList").fadeOut();
            $("#keywordList").html("");
        }
    });
    $(document).on('click', 'li', function(){
        $('#keyword').val($(this).text());
        $('#keywordList').fadeOut();
    });
});
</script>
</head>
<body>
 <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
        	userID = (String) session.getAttribute("userID");
        }
        int pageNumber =1;
    
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
              <li><a href="select.jsp">병원 검색하기</a></li>
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
      <%
        KeywordDAO keyworddao = new KeywordDAO();
        ArrayList<String> list = keyworddao.getkeyword();
        ArrayList<String> userKeywords = keyworddao.getUserKeywords(userID); // ArrayList로 키워드 가져오기
      %>
       
    <ul>
       
    </ul>
     <div class="container">
    <div class="col-lg-8">
        <div class="col-lg-8">
            <!-- 검색창 및 키워드 저장 -->
            <div class="jumbotron" style="padding-top: 20px; padding-bottom: 20px;">
                 <h4 style="text-align: center; margin-bottom: 20px;">
                    안녕하세요, <strong><%= (String) session.getAttribute("userID") %></strong>님!
                </h4>
                <!-- 키워드 저장 폼 -->
                <form method="post" action="savekeyword.jsp">
                    <h3 style="text-align: center; margin-bottom: 20px;">키워드를 저장하세요</h3>
                    <div class="form-group">
                        <input type="text" id="keyword" name="keyword" class="form-control" placeholder="증상을 입력하세요">
                        <div id="keywordList" class="autocomplete-suggestions"></div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">추가</button>
                </form>
                
                <!-- 저장된 키워드 리스트 -->
                <hr>
                <h4 style="text-align: center; margin-top: 20px;">저장된 키워드</h4>
                <ul class="list-group mt-3">
                    <% 
                        if (userKeywords != null && !userKeywords.isEmpty()) {
                            for (String keyword : userKeywords) { 
                    %>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <%= keyword %>
                            <!-- 삭제 버튼 -->
                            <form action="deleteKeyword.jsp" method="post" style="margin: 0;">
                                <input type="hidden" name="keywordName" value="<%= keyword %>">
                                <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                            </form>
                        </li>
                    <% 
                            } 
                        } else { 
                    %>
                        <li class="list-group-item text-center">저장된 키워드가 없습니다.</li>
                    <% 
                        } 
                    %>
                </ul>
            </div>
        </div>
    </div>
</div>
      
    
    
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>

</html>