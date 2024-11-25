package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DepartmentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public DepartmentDAO() {
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
	public ArrayList<String> getDepartmentsByHospitalId(String hospital_id) {
	    ArrayList<String> departments = new ArrayList<>();
	    String SQL = "SELECT d.department_name " +
	                 "FROM departments d " +
	                 "JOIN h_d_mapping hdm ON d.department_id = hdm.department_id " +
	                 "WHERE hdm.hospital_id = ?";

	    try {
	    	PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, hospital_id);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            departments.add(rs.getString("department_name"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return departments;
	}

	
	

}
