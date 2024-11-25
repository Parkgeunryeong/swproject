package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	
	
	


	

}
