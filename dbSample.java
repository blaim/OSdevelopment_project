/*******************************************
 프로그램명 : dbSample.java
 * 작성자 : 황근민, 임경수
 * 작성일 : 2020-12-01
 * 프로그램 설명 :MS Access 와 Spring을 연결하는 클래스
 ***************************************/
package co.df.ds;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;



public class dbSample {
	
	// 드라이버 변수로 선언
	private static final String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
	// 파일 경로를 변수로 선언
	// 파일 경로 개발자마다 다름, jdbc:ucanaccess: 부분은 동일
	private static final String dbURL = "jdbc:ucanaccess://D://Eclipse_workspace//GYE//dataset.accdb";
	
	
	/*******************************************
	 * 작성자 : 황근민
	 * 작성일 : 2020-11-15
	 * 프로그램 설명 : accdb 파일과 연결해서 connection 객체를 생성하는 함수
	 ***************************************/
	public void testConnetion() throws Exception {
		// 드라이버 로드
		Class.forName(DRIVER);
		
		// db 연결, 확인은 콘솔창으로
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
		
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-11-30
	 * 프로그램 설명 :영화 세부정보 리뷰를 db에 넣는 함수
	 ***************************************/
	public void InsertSpeMovieReview(String movieCode, String Name, String password, String contents) throws Exception
	{
Class.forName(DRIVER);
				
		
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			
				PreparedStatement ps = conn.prepareStatement(
						"insert into spe_movie_review(movie_code, writer_name, password, contents) "
						+ "values (?, ?, ?, ?)");
				
				ps.setString(1, movieCode);
				ps.setString(2, Name);
				ps.setNString(3, password);
				ps.setString(4, contents);
				
				ps.executeUpdate();
				
				System.out.println("review for specific movie ("+movieCode+") is completed");
			
				
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-11-30
	 * 프로그램 설명 :특정 영화의 리뷰 작성자명, 리뷰, 작성시간, 비밀번호 순으로 불러온다
	 ***************************************/
	public ArrayList GetSpecifiedReviews(String movieCode) throws Exception
	{
		Class.forName(DRIVER);
		ArrayList reviews = new ArrayList();
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{
			System.out.println("연결 성공");
			
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT * from spe_movie_review");
			
			while(rs.next())
			{
				if(rs.getString("movie_code").equals(movieCode))
				{
					reviews.add(rs.getString("writer_name"));
					reviews.add(rs.getString("contents"));
					reviews.add(rs.getString("write_time").substring(0,19));
					reviews.add(rs.getString("password"));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return reviews;
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-11-30
	 * 프로그램 설명 :이름과 비밀번호가 같은 리뷰를 삭제한다
	 ***************************************/
	public void Delete_specific_review(String username, String password) throws Exception
	{
		Class.forName(DRIVER);
		ArrayList reviews = new ArrayList();
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{
			
			PreparedStatement ps = conn.prepareStatement(
					"delete * from spe_movie_review where writer_name = ? and password = ?");
			
			ps.setString(1, username);
			ps.setString(2, password);
			
			ps.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-11-15
	 * 프로그램 설명 :로그인 정보를 db에 넣은 함수
	 ***************************************/
	public void InsertInfo(String ID, String PW, String UserName, int age) throws Exception
	{
		
		Class.forName(DRIVER);
				
		
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			
				PreparedStatement ps = conn.prepareStatement(
						"insert into userinfo(id, username, password, age) "
						+ "values (?, ?, ?, ?)");
				
				ps.setString(1, ID);
				ps.setString(2, UserName);
				ps.setString(3, PW);
				ps.setInt(4, age);
				
				ps.executeUpdate();
				
				System.out.println("dataExecuted");
			
				
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-11-15
	 * 프로그램 설명 :중복되는 로그인 정보를 받아오는 함수(미완성)
	 ***************************************/
	public String GetSpeID(String ID) throws Exception
	{
		Class.forName(DRIVER);
		
		// db 연결, 확인은 콘솔창으로
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			String SQL = "select id from userinfo where id = "+ID;
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery(SQL);
			
			return rs.getString(1);
			
			
		} catch(Exception e) {
			return " ";
		}
	}
	
	// 황근민
		// 아이디 중복 체크 함수
		public boolean checkID(String id) throws Exception
		{
			Class.forName(DRIVER);
			
			try(Connection conn = DriverManager.getConnection(dbURL))
			{
				System.out.println("연결 성공");
				
				Statement st = conn.createStatement();
				ResultSet rs = st.executeQuery("SELECT ID from userinfo");
				
				while(rs.next())
				{
					if(rs.getString("ID").equals(id))
						return false; 
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
				return true;
			
		}

}
