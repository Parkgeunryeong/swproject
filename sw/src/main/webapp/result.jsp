<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="hospital.KeywordDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="hospital.Hospital" %>
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
                url: 'select.jsp',
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
              <li><a href="main.jsp">메인</a></li>
              <li><a href="map.jsp">지도로 병원찾기</a></li>
              <li class="active"><a href="">병원 검색하기</a></li>
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
      %>
      병원 검색
      
     <form action="result.jsp" method="get">
        <input type="text" id="keyword" name="keyword" placeholder="증상을 입력하세요"> 
        <div id="keywordList" class="autocomplete-suggestions"></div>
  
        <button type="submit">검색</button>
    </form>
    <div id="result">
         <br><br><br><br>

    <%
        String selectedKeyword = request.getParameter("keyword"); // 선택한 키워드 값 가져오기
        KeywordDAO keywordDAO = new KeywordDAO();
        ArrayList<Hospital> hospitals = keywordDAO.getHospitalsByKeyword(selectedKeyword); // 병원 리스트 가져오기
        session.setAttribute("selectedHospitals", hospitals);
    %>

    <p><b>선택된 키워드:</b> <%= selectedKeyword %></p>

    <ul>
        <%
            if (hospitals.isEmpty()) {
        %>
            <li>검색된 병원이 없습니다.</li>
        <%
            } else {
                for (Hospital hospital : hospitals) {
        %>
            <li><%= hospital.getHospital_name() %> </li>
        <%
                }
            }
        %>
    </ul>
    </div>
    <div class="container">
           <div class="row">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                      <thead>
                             <tr>
                             <th style="background-color: #eeeeee; text-align: center;">병원이름</th>
                             <th style="background-color: #eeeeee; text-align: center;">병원종류</th>
                             <th style="background-color: #eeeeee; text-align: center;">운영시간</th>
                             
                             
                             </tr>
                      </thead>
                      <tbody>
                    <%
                        if (hospitals.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="3">검색된 병원이 없습니다.</td>
                        </tr>
                    <%
                        } else {
                            for (Hospital hospital : hospitals) {
                    %>
                        <tr>
                            <td><a href ="viewhospital.jsp?hospital_id=<%= hospital.getHospital_id() %>"><%= hospital.getHospital_name() %></a></td>
                            <td><%= hospital.getType() %></td>
                            <td><%= hospital.getOpening_hours() %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
                      
                </table>
                 
                
                </div>
                </div>
                

      
      
      
      <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
      <script src="js/bootstrap.js"></script>

</body>
</html>