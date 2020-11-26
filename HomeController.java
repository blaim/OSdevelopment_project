/***************************************************
 * 프로그램명 :  메인 페이지
 * 작성자 : 임경수
 * 작성일 :2020-11-26
 * 프로그램 설명 : 영화 리뷰 페이지의 메인 웹사이트
 * 
 * 
 ***********************************************/
package co.df.ds;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	
	/*검색창 구현 */
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
				System.out.println(movieNames[i]);
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
	
	
	/**
	 * 떼껄룩 메인 페이지
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//locale은 그냥 어디서 접속하는지 알도록 준거고 model객체는 jsp와 연동해서 사용하면 편리할듯?
		
		//원래있던 구문. 사용자 접속 위치를 나타냄
		logger.info("Welcome home! The client locale is {}.", locale);
		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		
		String formattedDate = dateFormat.format(date);
	
		
		
		model.addAttribute("serverTime", formattedDate );
		
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
	
	@RequestMapping(value="/comunity", method = RequestMethod.GET)
	public String comunity(Model model) throws Exception
	{
		return "comunity";
	}
	
	
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
		
	//작성자 : 임경수
	//id만드는 창 출력
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String LoginPage(Model model)
	{
		return "register_page";
	}
	
	//작성자 : 임경수
	//같은 비밀번호 인지 확인후 db에 정보 저장한다
	@RequestMapping(value="register.do", method = RequestMethod.POST)
	String RegisterHandle(String ID, String PW, String PW_repeat, String name, int age) throws Exception
	{
		
		if(!PW.equals(PW_repeat))
		{
			System.out.println("동일한 비밀번호 입력");
			return "register_page";
		}
		else
		{
			dbSample db = new dbSample();
			db.InsertInfo(ID, PW, name, age);
			
			System.out.println("success");
			
			return "register_page";
		}
	}
}

 
