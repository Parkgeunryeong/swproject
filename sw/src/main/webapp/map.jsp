<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="hospital.Hospital" %>
<%@ page import="hospital.HospitalDAO" %>
<%@ page import="hospital.DepartmentDAO" %>
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
      <div id="map" style="width: 700px; height: 600px;"></div> 
      <button id="getLocationBtn">내 위치로 이동</button>
   
                <%
                    //MapDAO mapDAO = new MapDAO();
                    //ArrayList<Map> list = mapDAO.getList();
                    
                    HospitalDAO hospitalDAO = new HospitalDAO();
                    ArrayList<Hospital> list = hospitalDAO.getList();
                    
                %>
                
                
            
	
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b25b23781322b72673233144779d42f"></script>
	<script type="text/javascript">
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.4484304, 126.6571886), //지도의 중심좌표.
		level: 3, //지도의 레벨(확대, 축소 정도)
	    minLevel: 1,
	    maxLevel: 5
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	var infowindow = new kakao.maps.InfoWindow();
	
	function getImageWidth() {
        var zoomLevel = map.getLevel(); // 현재 지도 레벨
        return (50 / zoomLevel) * 2; // 레벨에 따른 비율로 이미지 크기 조정
    }
	var imagewidth = getImageWidth();
	
	function getInfoWindowSize() {
	    var zoomLevel = map.getLevel(); // 현재 지도 레벨
	    var baseSize = 300; // 기본 크기
	    var maxLevel = 10; // 최대 레벨 예시
	    return baseSize * (maxLevel - zoomLevel + 1) / maxLevel;
	}
	
	var hospitals =[];



	


    <% for (int i = 0; i < list.size(); i++) { %>
        var markerPosition = new kakao.maps.LatLng(<%= list.get(i).getLatitude() %>, <%= list.get(i).getLongitude() %>);
        var marker = new kakao.maps.Marker({
            position: markerPosition,
            title: '<%= list.get(i).getHospital_id() %>' // 마커에 병원 이름 표시
            
        });
        marker.setMap(map); // 마커를 지도에 표시
        
        
        
        
        
        
        
        (function(marker, data) {
            kakao.maps.event.addListener(marker, 'click', function() {
                var infowindowWidth = getImageWidth()
                var content = `
                    <div style="padding:10px;"> 
                        <img src="<%= list.get(i).getImage() %>" alt="Hospital image" style="width:200px; height: 200px;">
                        <br>
                    	<%= list.get(i).getHospital_name() %><br>
                    	<%= list.get(i).getAddress() %><br>
                    	<%= list.get(i).getType() %><br>
                    	<h4>진료과목</h4>
                    	<ul> <% for (String department : list.get(i).getDepartments()) { %> 
                    	<li><%= department %></li> 
                    	<% } %> </ul>
                    </div>
                `;
                
                infowindow.setContent(content);
                infowindow.open(map, marker);
            });
        })(marker, {
            name: '<%= list.get(i).getHospital_name() %>',
            address: '주소 정보'
        });
        kakao.maps.event.addListener(map, 'click', function() {
            infowindow.close();
        }); //맵을 클릭했을때 마커를 닫히게 하는 이벤트

        kakao.maps.event.addListener(map, 'zoom_changed', function() {
            // 인포윈도우가 열려 있는 상태라면 이미지 크기 업데이트
          //var imagewidth = getImageWidth();
          //var infowindowsize = getInfoWindowSize();
          //var infowindowhsize = getInfoWindowSize();
          //console.log("Updated InfoWindow Size: ", infowindowsize);
          //console.log("Updated InfoWindow hSize: ", infowindowhsize);
          //var message = '현재 지도 레벨은 ' + infowindowsize + ' 입니다';
          //var resultDiv = document.getElementById('result');  
          //resultDiv.innerHTML = message;
          var level =map.getLevel();
          var infowindowWidth;
          var infowindowHeight;
          var imagewidth;
          var imageHeight;
          
          switch(level) {
          case 1:
              infowindowWidth = 250;
              infowindowHeight = 400;
              imagewidth = 200;
              imageHeight = 200;
              break;
          case 2:
              infowindowWidth = 200;
              infowindowHeight = 240;
              imagewidth =140;
              imageHeight =140;
              break;
          case 3:
              infowindowWidth = 190;
              infowindowHeight = 220;
              imagewidth =120;
              imageHeight = 120;
              break;
          case 4:
              infowindowWidth = 180;
              infowindowHeight = 210;
              imagewidth = 100;
              imageHeight = 100;
              break;
          case 5:
              infowindowWidth = 160;
              infowindowHeight = 190;
              imagewidth = 90;
              imageHeight = 90;
              break ;
          default:
              infowindowWidth = 150;
              infowindowHeight = 75;
              imagewidth = 20;
              imageHeight = 20;
              break;
      }

    
            
            if (infowindow.getMap()) {
            	
                var updatedContent = `
                    <div style="padding:10px; width:\${infowindowWidth}px; height:\${infowindowHeight}px;">
                        <img src="<%= list.get(i).getImage() %>" alt="Hospital image " 
                        	style="width:\${imagewidth}px; height:\${imageHeight}px;">
                        	<br>
                        	<%= list.get(i).getHospital_name() %><br>
                        	<%= list.get(i).getAddress() %><br>
                        	<%= list.get(i).getType() %><br>
                        	<h4>진료과목</h4>
                        	<ul> <% for (String department : list.get(i).getDepartments()) { %> 
                        	<li><%= department %></li> 
                        	<% } %> </ul>
                        	
                        
                    </div>
                `;
                infowindow.setContent(updatedContent); // 확대/축소된 이미지 크기 반영
            }
        }); 
        
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