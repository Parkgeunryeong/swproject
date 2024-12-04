package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

public class KeywordDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public KeywordDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/sw";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver"); //mysql드라이버에 접근하게 할수있는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<String> getkeyword() {
	    ArrayList<String> keywords = new ArrayList<>();
	    String SQL = "SELECT name from keyword" ;

	    try {
	    	PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	String keyword = rs.getString("name"); 
	        	System.out.println("Retrieved Keyword: " + keyword); // 디버깅용 출력
	            keywords.add(rs.getString("name"));
	            
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return keywords;
	}
	public ArrayList<Hospital> getHospitalsByKeyword(String keyword) {
	    ArrayList<Hospital> hospitals = new ArrayList<Hospital>();
	    DepartmentDAO departmentDAO = new DepartmentDAO();
	    String SQL = "SELECT DISTINCT h.hospital_id, h.hospital_name, h.address, h.phone_number, h.type, h.opening_hours, h.latitude, h.longitude, h.image " +
                "FROM hospital h " +
                "JOIN h_d_mapping hm ON h.hospital_id = hm.hospital_id " +
                "JOIN departments d ON hm.department_id = d.department_id " +
                "JOIN keyword k ON d.department_id = k.department_id " +
                "WHERE k.name = ?";
	    
	    try {
	    	if (keyword != null) {
	    	    System.out.println("Original Keyword: " + keyword);
	    	    
	    	    
	    	}


	    	System.out.println("DAO로 전달된 키워드: " + keyword);
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, keyword);
	        ResultSet rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            Hospital hospital = new Hospital();
	            hospital.setHospital_id(rs.getString(1));      
	            hospital.setHospital_name(rs.getString(2));
	            hospital.setAddress(rs.getString(3));
	            hospital.setPhone_number(rs.getString(4));
	            hospital.setType(rs.getString(5));
	            hospital.setOpening_hours(rs.getString(6));
	            hospital.setLatitude(rs.getBigDecimal(7));
	            hospital.setLongitude(rs.getBigDecimal(8));
	            hospital.setImage(rs.getString(9));
	            
	            ArrayList<String> departments = departmentDAO.getDepartmentsByHospitalId(hospital.getHospital_id()); 
	            hospital.setDepartments(departments);
	            
	            
	            
	            hospitals.add(hospital);
	        }
	        System.out.println("병원 리스트 조회 결과:");
	        for (Hospital hospital : hospitals) {
	            System.out.println(hospital.getHospital_name() + " (ID: " + hospital.getHospital_id() + ")");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return hospitals;
	}
	public ArrayList<String> getKeywordsByKeyword(String keyword) {
	    ArrayList<String> keywords = new ArrayList<>();
	    String SQL = "SELECT name FROM keyword WHERE name LIKE ?";

	    try {
	    	System.out.println("DAO로 전달된 키워드: " + keyword);
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, keyword + "%");
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            keywords.add(rs.getString("name"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return keywords;
	} // 자동검색 기능을 위한 메서드
	public int getKeywordIdByName(String keyword) { // 키워드를 바탕으로 키워드 id를 찾는 메서드
	    String SQL = "SELECT keyword_id FROM keyword WHERE name = ?";
	    try {
	    	System.out.println("DAO로 전달된 키워드: " + keyword);
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, keyword);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1); // keyword_id 반환
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // keyword_id를 찾지 못했을 경우
	}
	public int getKeywordCountByUser(String userId) { //한 사람당 키워드 저장값이 3개를 초과할없게하는 메서드
	    String SQL = "SELECT COUNT(*) FROM u_k_mapping WHERE userID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1); // 키워드 개수를 반환
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 에러 발생 시 -1 반환
	}
	public boolean isKeywordAlreadySaved(String userId, int keywordId) { // 키워드 중복을 확인하는 메서드
	    String SQL = "SELECT COUNT(*) FROM u_k_mapping WHERE userID = ? AND keyword_id = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userId);
	        pstmt.setInt(2, keywordId);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) > 0; // 이미 저장된 키워드가 있으면 true 반환
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false; // 에러 발생 시 false 반환
	}
	public int insertMapping(String userID, int keywordId) { //사용자id와 키워드 id를 바탕으로 매핑테이블에 저장
	    String SQL = "INSERT INTO u_k_mapping (userID, keyword_id) VALUES (?, ?)";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        pstmt.setInt(2, keywordId);
	        return pstmt.executeUpdate(); // 성공 시 1 반환
	    } catch (SQLIntegrityConstraintViolationException e) {
	        // 유니크 제약 조건 위반 발생 시
	        System.out.println("중복된 키워드입니다: " + e.getMessage());
	        return -1; } // 중복된 키워드인 경우 -1 반환 
	    catch (Exception e) {
	        e.printStackTrace();
	        return 0; // 삽입 실패 시
	    }
	    
	}
	public ArrayList<String> getUserKeywords(String userId) { // 현재 사용자가 저장해둔 키워드를 반환해주는 메서드
	    String SQL = "SELECT k.name " +
	                 "FROM keyword k " +
	                 "JOIN u_k_mapping ukm ON k.keyword_id = ukm.keyword_id " +
	                 "WHERE ukm.userID = ?";
	    ArrayList<String> keywords = new ArrayList<>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            keywords.add(rs.getString("name")); // 키워드 이름 추가
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return keywords; // 키워드 리스트 반환
	}

	


	


	
	
	


	

}
