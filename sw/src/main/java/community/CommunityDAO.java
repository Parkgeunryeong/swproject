package community;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommunityDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CommunityDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/sw";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			rs = pstmt.executeQuery(); // 실행했을때 나오는 결과
			if (rs.next()) {
				return rs.getString(1); //결과가 있는 경우 현재의 날짜를 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
		}
	public int getNext() { //게시글번호 가져오는 부분
		String SQL = "SELECT com_id FROM community ORDER BY com_id DESC"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return rs.getInt(1) + 1; 
			}
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류  
		
	}
	public int write(String com_title, String userID, String com_content) { 
		String SQL = "INSERT INTO community VALUES(?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			pstmt.setInt(1, getNext());  //db부분에서 값 가져와 보기
			pstmt.setString(2, com_title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate()); // db에서 타임스탬프로 정의해서 넣기(db데이터 넣기) select now로 가져오기 시박 번호물,가져올데이터수
			pstmt.setString(5, com_content);
			pstmt.setInt(6, 1) ; //글이 보여지는 형태 1
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Community> getList(int pageNumber) { 
		String SQL = "SELECT * FROM Community WHERE com_id < ? AND comAvailable = 1 ORDER BY com_id DESC LIMIT 10"; //mysql오프셋이나 쉼표해서 이용
		ArrayList<Community> list = new ArrayList<Community>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Community community = new Community();
				community.setCom_id(rs.getInt(1));
				community.setCom_title(rs.getString(2));
				community.setUserID(rs.getString(3));
				community.setCom_date(rs.getString(4));
				community.setCom_content(rs.getString(5));
				community.setComAvailable(rs.getInt(6));
				list.add(community);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM community WHERE com_id < ? AND comAvailable =1 ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			return true;	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public Community getCommunity(int com_id) {
	    String SQL = "SELECT * FROM community WHERE com_id = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, com_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            Community community = new Community();
	            community.setCom_id(rs.getInt(1));
	            community.setCom_title(rs.getString(2));
	            community.setUserID(rs.getString(3));
	            community.setCom_date(rs.getString(4));
	            community.setCom_content(rs.getString(5));
	            community.setComAvailable(rs.getInt(6));
	            return community;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public int update(int com_id, String com_title, String com_content) {
	    String SQL = "UPDATE community SET com_title = ?, com_content = ? WHERE com_id = ?"; 
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL); 
	        pstmt.setString(1, com_title);
	        pstmt.setString(2, com_content);
	        pstmt.setInt(3, com_id);
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}

	public int delete(int com_id) {
	    String SQL = "UPDATE community SET comAvailable = 0 WHERE com_id = ?"; 
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL); 
	        pstmt.setInt(1, com_id);
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Community> getSearch(String searchField, String searchText) { // 특정한 리스트를 받아서 반환
	    ArrayList<Community> list = new ArrayList<Community>();
	    String SQL = "SELECT * FROM community WHERE comAvailable = 1 and " + searchField.trim();
	    try {
	        if (searchText != null && !searchText.equals("")) { // 검색어를 입력했을때만 코드 실행
	            searchText = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");// 검색어 인코딩
	        	SQL += " LIKE '%" + searchText.trim() + "%' ORDER BY com_id DESC LIMIT 10";//내림차순 정렬
	        }
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery(); // select
	        while (rs.next()) {
	            Community community = new Community();
	            community.setCom_id(rs.getInt(1));
	            community.setCom_title(rs.getString(2));
	            community.setUserID(rs.getString(3));
	            community.setCom_date(rs.getString(4));
	            community.setCom_content(rs.getString(5));
	            community.setComAvailable(rs.getInt(6));
	            list.add(community); // list에 해당 인스턴스를 담는다.
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list; // 게시글 리스트 반환
	}
	
	public int getCount() {
		String SQL = "select count(*) from community";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}



	
	
	
	
	
	
	
	
	

}
