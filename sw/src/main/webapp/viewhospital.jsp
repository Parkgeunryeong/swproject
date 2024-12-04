<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hospital.Hospital" %> 
<%@ page import="java.util.ArrayList" %>

<%
    // 세션에서 병원 객체 가져오기
    ArrayList<Hospital> hospitals = (ArrayList<Hospital>) session.getAttribute("selectedHospitals");
    String hospitalId = request.getParameter("hospital_id");
    Hospital hospital = null;
    for (Hospital h : hospitals) {
        if (h.getHospital_id().equals(hospitalId)) {
            hospital = h;
            break;
        }
    }
%>

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
    if (hospital != null) {
%>
    <h2><%= hospital.getHospital_name() %> 상세 정보</h2>
    <div class="container">
    <div class="row">
        <!-- 지도 부분 -->
        <div class="col-md-6">
            <div id="map" style="width: 100%; height: 300px;"></div>
        </div>

        <!-- 병원 정보 부분 -->
        <div class="col-md-6">
            <h3>병원이름: <%= hospital.getHospital_name() %></h3>
            <p>주소: <%= hospital.getAddress() %></p>
            <p>전화번호: <%= hospital.getPhone_number() %></p>
            <p>병원종류: <%= hospital.getType() %></p>
            <p>운영시간: <%= hospital.getOpening_hours() %></p>
            <img src="<%= hospital.getImage() %>" alt="<%= hospital.getHospital_name() %> 이미지" style="max-width: 100%; height: auto;">
        </div>
    </div>
</div>
<%
    } else {
%>
    <p>해당 병원 정보를 찾을 수 없습니다.</p>
<%
    }
%>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b25b23781322b72673233144779d42f"></script>
<script type="text/javascript">
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(<%= hospital.getLatitude() %>, <%= hospital.getLongitude() %>), //지도의 중심좌표.
		level: 3, //지도의 레벨(확대, 축소 정도)
	    minLevel: 1,
	    maxLevel: 5
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	var markerPosition = new kakao.maps.LatLng(<%= hospital.getLatitude() %>, <%= hospital.getLongitude() %>); 

	// 마커를 생성
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정
	marker.setMap(map);
	
</script>
</body>



</html>