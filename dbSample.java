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
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 :특정 글의 좋아요를 1 증가시킨다
	 ***************************************/
	public boolean Increase_spe_post_rate(String post_title) throws Exception
	{
		Class.forName(DRIVER);
				
		String[] post_info = this.GetPostInfo_from_title(post_title);
		int increased_like = Integer.parseInt(post_info[3]);
		increased_like++;
		
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			
			
				PreparedStatement ps = conn.prepareStatement(
						"update reviews set like = ? where ID = ?");
				
				ps.setString(1, Integer.toString(increased_like));
				ps.setString(2, post_info[6]);
				
				
				ps.executeUpdate();
								
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 :특정 글의 싫어요를 1 증가시킨다
	 ***************************************/
	public boolean Decrease_spe_post_rate(String post_title) throws Exception
	{
		Class.forName(DRIVER);
		
		String[] post_info = this.GetPostInfo_from_title(post_title);
		int increased_dislike = Integer.parseInt(post_info[4]);
		increased_dislike++;
		
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			
			
				PreparedStatement ps = conn.prepareStatement(
						"update reviews set dislike = ? where ID = ?");
				
				ps.setString(1, Integer.toString(increased_dislike));
				ps.setString(2, post_info[6]);
				
				
				ps.executeUpdate();
								
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 :선택한 타이틀명을 가진 db에 댓글을 작성한다
	 ***************************************/
	public boolean Write_comment_to_spe_review(String title, String writer_name, String content) throws Exception
	{
		Class.forName(DRIVER);
		String[] post_info = this.GetPostInfo_from_title(title);
		content = content.replace(System.getProperty("line.separator").toString(), "");
		
		try(Connection conn = DriverManager.getConnection(dbURL)){
			System.out.println("연결 성공");
			
			
				PreparedStatement ps = conn.prepareStatement(
						"insert into comments(title_number, writer, content) "
						+ "values (?, ?, ?)");
				
				ps.setString(1, post_info[6]);
				ps.setString(2, writer_name);
				ps.setString(3, content);
			
				
				ps.executeUpdate();
				
				System.out.println("dataExecuted");
			
				
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 : 특정 글을 삭제하는 메소드
	 ***************************************/
	public boolean Delete_post(String title_name) throws Exception
	{
		Class.forName(DRIVER);
		ArrayList reviews = new ArrayList();
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{
			
			PreparedStatement ps = conn.prepareStatement(
					"delete * from reviews where title = ?");
			
			
			ps.setString(1, title_name);
			ps.executeUpdate();
			System.out.println(title_name);
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 : 특정 댓글을 삭제하는 메소드
	 ***************************************/
	public boolean Delete_comment(String write_time, String contents) throws Exception
	{
		Class.forName(DRIVER);
		ArrayList reviews = new ArrayList();
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{
			
			PreparedStatement ps = conn.prepareStatement(
					"delete * from comments where content =?");
			
			
			ps.setString(1, contents);
			ps.executeUpdate();
			System.out.println(contents);
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 :reviews테이블에서 지정한 제목과 같은 글을 불러온다
	 * 작성자, 글 제목, 내용, 좋아요 수, 싫어요 수, 작성시간, 일련번호 순으로 불러온다 => size=7
	 ***************************************/
	public String[] GetPostInfo_from_title(String title) throws Exception
	{
		Class.forName(DRIVER);
		String[] reviews = new String[7];
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{
				
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT * from reviews");
			
			while(rs.next())
			{
				if(rs.getString("title").equals(title))
				{
					reviews[0] = rs.getString("writer");
					reviews[1] = rs.getString("title");
					reviews[2] = rs.getString("contents");
					reviews[3] = rs.getString("like");
					reviews[4] = rs.getString("dislike");		
					reviews[5] = rs.getString("write_time").substring(0,19);	
					reviews[6] = rs.getString("ID");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return reviews;
	}
	
	/*******************************************
	 * 작성자 : 임경수
	 * 작성일 : 2020-12-06
	 * 프로그램 설명 :일련번호의 내용에 있는 댓글들을 가져온다
	 * 댓글작성자명, 내용, 작성시간 순으로 가져온다
	 ***************************************/
	public ArrayList Get_comments_by_serial_number(String serial_number) throws Exception
	{
		ArrayList comments = new ArrayList();
		Class.forName(DRIVER);
		
		try(Connection conn = DriverManager.getConnection(dbURL))
		{		
			
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("SELECT * from comments");
			
			while(rs.next())
			{
				if(rs.getString("title_number").equals(serial_number))
				{
					comments.add(rs.getString("writer"));
					comments.add(rs.getNString("content"));
					comments.add(rs.getString("write_time").substring(0,19));
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return comments;
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
		
		// 작성자 황근민
				// 사용자가 입력한 id와 password를 db와 비교하여 로그인을 실행하는 함수
				public boolean Login(String id, String pw) throws Exception
				{
					Class.forName(DRIVER);
					 
					try(Connection conn = DriverManager.getConnection(dbURL))
					{
						System.out.println("연결 성공");
						Statement st = conn.createStatement();
						ResultSet rs = st.executeQuery("SELECT * from userinfo");
						
						while(rs.next())
						{
							if(rs.getString("ID").equals(id))
								if(rs.getString("password").equals(pw))
									return true;
						}
										
						}catch(Exception e) {
							e.printStackTrace();
						}
						
						return false;
					}

}
