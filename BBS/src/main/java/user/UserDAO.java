package user;
//ctr + shift + o로 라이브러리 자동 추가 가능.
//db연동, db 이용하는 작업을 정의.
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공.
				}
				else
					return 0;//비밀번호 불일치.
			}
			return -1;//아이디가 없음.
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//db 오류.
	}
	
	public int join(User user) {
		String SQL = "INSERT INRO USER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();		
		}
		return -1;//db 오류.
	}
}
