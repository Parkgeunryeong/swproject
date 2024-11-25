package hospital;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import hospital.DepartmentDAO;



public class HospitalDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public HospitalDAO() {
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
	public ArrayList<Hospital> getList() {
	    ArrayList<Hospital> list = new ArrayList<Hospital>();
	    DepartmentDAO departmentDAO = new DepartmentDAO();
	    String SQL = "SELECT * FROM hospital ";
	    
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        
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
	            
	            
	            list.add(hospital);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	

}
