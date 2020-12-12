/***************************************************
 * 프로그램명 :  메인 페이지
 * 작성자 : 임경수
 * 작성일 :2020-12-03
 * 프로그램 설명 : 영화 리뷰 페이지의 메인 웹사이트
 * 
 * 
 ***********************************************/
package co.df.ds;


import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
		
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/help", method = RequestMethod.GET)
	public String YSE(Locale locale, Model model) {
		return "help";
	}
	
	//작성자:임경수
	//세부영화 정보에서 리뷰 작성하여 데이터베이스에 저장
	@RequestMapping(value="write_spe_movie_review.do", method = RequestMethod.GET)
	String write_spe_movie_review(String spe_movie_code, String spe_movie_review_name, String review_password, String spe_movie_review_contents) throws Exception
	{
		System.out.println(spe_movie_code);
		System.out.println(spe_movie_review_name);
		System.out.println(spe_movie_review_contents);
		
		dbSample ds = new dbSample();
		ds.InsertSpeMovieReview(spe_movie_code, spe_movie_review_name, review_password, spe_movie_review_contents);
		
		return "redirect:http://localhost:7569/GYE/spe_movie?spe_movie_code="+spe_movie_code;
		
	}
	
	
	@RequestMapping(value="delete_spe_review.do", method = RequestMethod.GET)
	String delete_spe_movie_review(String username, String real_password, String spe_movie_code, String delete_password) throws Exception
	{
		if(real_password.equals(delete_password))
		{
			dbSample conn = new dbSample();
			
			conn.Delete_specific_review(username, delete_password);
			return "redirect:http://localhost:7569/GYE/spe_movie?spe_movie_code="+spe_movie_code;
			
		}
		else
		{
			return "main_page";
		}
		
		
	}
	
	
	//작성자 : 임경수 
	//영화 세부정보 출력하는 페이지
	@RequestMapping(value = "/spe_movie", method = RequestMethod.GET)
	public String load_spe_movie(String spe_movie_code, Model model) throws Exception
	{
		System.out.println(spe_movie_code);
		
		UsingOPENAPI conn = new UsingOPENAPI();
		dbSample conn_db = new dbSample();
		
		String[] specified_information = new String[21];
		ArrayList reviews = new ArrayList();
		specified_information = conn.MovieCodeSearch(spe_movie_code);
		reviews = conn_db.GetSpecifiedReviews(spe_movie_code);
		
		JsoupConnect jc = new JsoupConnect();
		ArrayList jsoup_movie = jc.GetCurrentMovieList();
		
		if(jc.IsOnTheater(specified_information[0])==true)
			model.addAttribute("is_current_on_theater", "true");
		else
			model.addAttribute("is_current_on_theater", "false");
			
		
		
		model.addAttribute("information", specified_information);
		model.addAttribute("reviews", reviews);
		model.addAttribute("cur_movies", jsoup_movie);
		
		return "detail_page";
	}
	
	
	//작성자 : 임경수
	//영화 검색 쿼리 받아서 검색 결과 출력하는 페이지
	@RequestMapping(value="member.do", method = RequestMethod.GET)
	public String memberRegi(String sear_sel, String search, Model model) throws Exception
	{
		UsingOPENAPI conn = new UsingOPENAPI();
		
		if(sear_sel.equals("mvname"))
		{
			String[] movieNames = new String[50];
			int size = 0;
			
			movieNames = conn.MovieNameSearch(search);
			
			for(int i=0;i<50;i++)
			{
				
				if(movieNames[i].equals("empty"))
					{
						size = i;
						break;
					}
			}
			
			model.addAttribute("movies", movieNames);
			model.addAttribute("size", size);
			
		}
		else if(sear_sel.equals("makername"))
		{
			String[] makerNames = new String[40];
			int size = 0;
			
			makerNames = conn.CompanyNameSearch(search);
			
			for(int i=0;i<50;i++)
			{
				if(makerNames[i].equals("empty"))
					{
						size = i;
						break;
					}
			}
			
			model.addAttribute("movies", makerNames);
			model.addAttribute("size", size);
		}
		
		
		return "main_page";
	}
	
	
	//작성자 : 임경수
	//떼껄룩의 메인 페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		//locale은 그냥 어디서 접속하는지 알도록 준거고 model객체는 jsp와 연동해서 사용하면 편리할듯?
		
		//원래있던 구문. 사용자 접속 위치를 나타냄
		logger.info("Welcome home! The client locale is {}.", locale);
		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		
		JsoupConnect jc = new JsoupConnect();
		ArrayList jsoup_movie = jc.GetCurrentMovieList();
		
		
		
		String formattedDate = dateFormat.format(date);
	
			
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("current_movies", jsoup_movie);
		
		// controller annotation 사용하면 리턴값 + .jsp붙이도록 설정 해서 home.jsp를 실행
		return "main_page";
	}
	
	//현재 일자의 박스오피스 불러오고 넘기는것 구현
	//작성자 : 임경수
	@RequestMapping(value="BoxOffice", method = RequestMethod.GET)
	public String BoxOffice(Model model) throws Exception
	{
		String[] BX_offices = new String[40];
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		
		Calendar to_date = Calendar.getInstance();	
		to_date.add(Calendar.DATE, -1);	
		String yes_date = format.format(to_date.getTime());
		
		UsingOPENAPI conn = new UsingOPENAPI();
		BX_offices = conn.daily_BoxOffice(yes_date);
		
		model.addAttribute("bx_array", BX_offices);
		
		return "box_office";
	}
	
	//작성자 : 임경수
	//커뮤니티 페이지 출력
	@RequestMapping(value="/comunity", method = RequestMethod.GET)
	public String comunity(Model model) throws Exception
	{
		return "comunity";
	}
	
	
	//작성자 : 임경수
	//
	@RequestMapping(value="/test", method = RequestMethod.GET)
	public String TestAPI(Model model) throws Exception
	{
		UsingOPENAPI api = new UsingOPENAPI();
		
		String[] test = new String[50];
		test = api.MovieNameSearch("어벤져스");
		
		
		model.addAttribute("test", test);
		
		
		return "test";
	}
	
	
	
	// 작성자: 황근민
		// db연결 test, 콘솔창을 확인 해주세요
		@RequestMapping(value = "/db", method = RequestMethod.GET)
		public String Testdb(Model model) throws Exception{
				
			dbSample db = new dbSample();
				
			db.testConnetion();
				
			model.addAttribute("test", db);
				
			return "db";
		}
		
	
	
	
	//작성자: 황근민
	//입력한 아이디와 db에서 중복되는 아이디가 없으면 db에 정보를 저장한다.
	//수정 : 임경수
	//수정내역 : 중복 내용이 아니면 아이디 생성 완료 창 띄우고
	//중복이라면 경고 창 띄운후 다시 아이디 생성 페이지로 이동한다
	@RequestMapping(value="register.do", method = RequestMethod.POST)
	String RegisterHandle(String ID, String PW, String PW_repeat, String name, int age, Model model) throws Exception
	{
		
		if(!PW.equals(PW_repeat))
		{
			System.out.println("동일한 비밀번호 입력");
			return "register_page";
		}
		else
		{
			dbSample db = new dbSample();
			
			if(db.checkID(ID)) {
				db.InsertInfo(ID, PW, name, age);
				System.out.println("success");			
				return "register_page";
			}
			
			else
			{
				System.out.println("fail_중복된 아이디입니다.");			
				return "register_page";
			}
		}
	}
	
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String LoginPage(Model model)
	{
		return "login";
	}
	
	
	//작성자: 황근민
	//로그인 페이지 실행, DB와 비교하여 아이디와 비밀번호가 일치하면 세션을 클라이언트에게 제공
	@RequestMapping(value="/login.do", method = RequestMethod.POST)
	String LoginHandle(HttpSession session, @RequestParam(value="ID") String ID, @RequestParam(value="PW") String PW) throws Exception
	{
		dbSample db = new dbSample();
		
		if(db.Login(ID, PW))
			{
				session.setAttribute("loginCheck", true);
				session.setAttribute("id", ID);
				System.out.println("success_로그인 성공.");
				return "main_page";
			}
		
		else
			{
				System.out.println("fail_로그인 실패.");
				return "login";
			}
	}
	
	//작성자: 황근민
	//로그아웃 실행, 로그아웃 클릭하면 세션을 서버로 반환
	@RequestMapping(value="/logout.do", method = RequestMethod.POST)
    public String logoutProcess(HttpSession session) {
                            
        session.setAttribute("loginCheck",null);
        session.setAttribute("id",null);
        
        return "main_page";
    }
	
	
	
	//작성자:임경수
	//커뮤니티 페이지의 글을 출력하는 함수
	@RequestMapping(value="/comunity_post", method = RequestMethod.GET) 
	public String Comunity_(String title, Model model)throws Exception
	{
		dbSample conn = new dbSample();
		String[] post_info = new String[7];
		ArrayList comments = new ArrayList();
		
		post_info = conn.GetPostInfo_from_title(title);
		comments = conn.Get_comments_by_serial_number(post_info[6]);
		
		model.addAttribute("post_information", post_info);
		model.addAttribute("comment_information", comments);
		
		return "comunity_specific";
	}
	
	//작성자:임경수
	//특정 글의 좋아요를 1 증가시킨다
	@RequestMapping(value="/increase_rate.do", method = RequestMethod.POST)
    public String LikeProcess(String like)throws Exception {
        dbSample conn = new dbSample();
		String[] post_info = new String[7];
		
		System.out.println(like);
		
		post_info = conn.GetPostInfo_from_title(like);
		if(conn.Increase_spe_post_rate(like)==false)
		{
			System.out.println("ERROR");
			return "main_page";
		}
		
		
		
		
		like = URLEncoder.encode(like,"UTF-8");
        
        return "redirect:http://localhost:7569/GYE/comunity_post?title=" + like;
    }
	
	//작성자:임경수
		//특정 글의 싫어요를 1 증가시킨다
		@RequestMapping(value="/decrease_rate.do", method = RequestMethod.POST)
	    public String DisLikeProcess(String dislike)throws Exception {
	        dbSample conn = new dbSample();
			String[] post_info = new String[7];
			
			System.out.println(dislike);
			
			post_info = conn.GetPostInfo_from_title(dislike);
			if(conn.Decrease_spe_post_rate(dislike)==false)
			{
				System.out.println("ERROR");
				return "main_page";
			}
			
			dislike = URLEncoder.encode(dislike,"UTF-8");
	        return "redirect:http://localhost:7569/GYE/comunity_post?title=" + dislike;
	    }
		
		
		@RequestMapping(value="/write_comment.do", method = RequestMethod.POST)
		public String WriteCommentProcess(String comment_writer_name, String comment_content, String title)throws Exception
		{
			dbSample conn = new dbSample();
			System.out.println(comment_writer_name);
			System.out.println(comment_content);
			System.out.println(title);
			if(conn.Write_comment_to_spe_review(title, comment_writer_name, comment_content)==false)
			{
				System.out.println("ERROR");
				return "main_page";
			}
			
			
			
			title = URLEncoder.encode(title,"UTF-8");
	        return "redirect:http://localhost:7569/GYE/comunity_post?title=" + title;
		}
		
		@RequestMapping(value="/delete_comment.do", method = RequestMethod.POST)
		public String DeleteCommentProcess(String delete_element)throws Exception
		{
			dbSample conn = new dbSample();
			
			String write_time = delete_element.substring(0,19);
			String number = delete_element.substring(19,20);
			String title = delete_element.substring(20, 20 + Integer.parseInt(number));
			String contents = delete_element.substring(19+Integer.parseInt(number)+1);
			
			
			
			System.out.println(write_time);
			System.out.println(title);
			System.out.println(contents);
			
			if(conn.Delete_comment(write_time, contents)==false)
			{
				return "main_page";
			}
			
			title = URLEncoder.encode(title,"UTF-8");
	        return "redirect:http://localhost:7569/GYE/comunity_post?title=" + title;
		}
		
		@RequestMapping(value="/delete_post.do", method = RequestMethod.POST)
		public String DeleteOnePostProcess(String title_name)throws Exception
		{
			dbSample conn = new dbSample();
			
			if(conn.Delete_post(title_name)==true)
				System.out.println("delete successful");
			else
				System.out.println("delete not completed");
			
			title_name = URLEncoder.encode(title_name,"UTF-8");
	        return "comunity";
		}
		
}

 
