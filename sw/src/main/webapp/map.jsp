<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="map.MapDAO" %>
<%@ page import="map.Map" %>
<%@ page import="java.util.ArrayList" %>
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
      <div id="map" style="width: 500px; height: 400px;"></div> 
      <button id="getLocationBtn">내 위치로 이동</button>
    <div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th style="background-color: #eeeeee; text-align: center;">ID</th>
                    <th style="background-color: #eeeeee; text-align: center;">위도</th>
                    <th style="background-color: #eeeeee; text-align: center;">경도</th>
                </tr>
            </thead>
            <tbody>
                <%
                    MapDAO mapDAO = new MapDAO();
                    ArrayList<Map> list = mapDAO.getList(pageNumber);
                    for(int i = 0; i < list.size(); i++) {
                %>
                <tr>
                    <td><%= list.get(i).getMapID() %></td>
                    <td><%= list.get(i).getLatitude() %></td> <!-- 위도 -->
                    <td><%= list.get(i).getLongitude() %></td> <!-- 경도 -->
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
	
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b25b23781322b72673233144779d42f"></script>
	<script type="text/javascript">
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.4484304, 126.6571886), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	<% for (int i = 0; i < list.size(); i++) { %>
    var markerPosition = new kakao.maps.LatLng(<%= list.get(i).getLatitude() %>, <%= list.get(i).getLongitude() %>);
    var marker = new kakao.maps.Marker({
        position: markerPosition,
        title: '<%= list.get(i).getMapID() %>' // 마커에 병원 이름 표시
    });
    marker.setMap(map); // 마커를 지도에 표시
<% } %>
	
	
	
	var geoOptions = {
		    enableHighAccuracy: true, // 정확한 위치 정보 사용
		    timeout: 10000, // 10초 후 타임아웃
		    maximumAge: 0 // 캐시된 위치 정보 사용하지 않음
		};
	document.getElementById('getLocationBtn').addEventListener('click', function() {
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(function(position) {
	            var lat = position.coords.latitude; // 위도
	            var lon = position.coords.longitude; // 경도

	            var locPosition = new kakao.maps.LatLng(lat, lon); // 사용자의 위치
	            map.setCenter(locPosition); // 지도의 중심을 사용자의 위치로 설정
	        }, function(error) {
	            console.error('Error occurred. Error code: ' + error.code);
	        }, geoOptions);
	    } else {
	        alert('Geolocation을 사용할 수 없습니다.');
	    }
	});
	
	
	
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>

</body>
</html>