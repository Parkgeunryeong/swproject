package map;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MapDAO {
	private Connection conn;
	private ResultSet rs;
	
	public MapDAO() {
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
	public ArrayList<Map> getList(int pageNumber) {
	    ArrayList<Map> list = new ArrayList<Map>();
	    String SQL = "SELECT * FROM map LIMIT ?, 10";
	    
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, (pageNumber - 1) * 10);  // 페이지 단위로 가져옴
	        ResultSet rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            Map map = new Map();
	            map.setMapID(rs.getString(1));      // mapID 설정
	            map.setLatitude(rs.getBigDecimal(2));     // 위도 설정
	            map.setLongitude(rs.getBigDecimal(3));// 경도 설정
	            
	            System.out.println("mapID: " + rs.getString(1));
	            System.out.println("latitude: " + rs.getBigDecimal(2));
	            System.out.println("longitude: " + rs.getBigDecimal(3));
	            list.add(map);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
}