/***************************************************
 * 프로그램명 :  메인 페이지
 * 작성자 : 임경수
 * 작성일 :2020-11-10
 * 프로그램 설명 : 개발전 스프링 프레임워크 대해 내가 공부한것들 
 * 정리해서 같이 사용할 수 있도록 함
 * 나중에 없앨 예정
 * 
 ***********************************************/
package co.df.ds;


import java.io.BufferedInputStream;
import java.net.URL;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
	 * Simply selects the home view to render by returning its name.
	 * annotation이용한 get/post 설정, url설정
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
		return "home";
	}
	
	@RequestMapping(value = "/jsoup", method = RequestMethod.GET)
	public String jsoup(Model model)
	{
		//그냥 아무사이트나 선택
		String URL = "https://dict.naver.com/";
		String text = "none";
		//text()와 toString의 차이를 보기 위해 두개 사용
		String classtest1 = "none";
		String classtest2 = "none";
		
		try {
			//url 연결
			Document doc = Jsoup.connect(URL).get();
			text = doc.text();
			//class view_dic에 속한 div안에 속한 ul에 속한 li들의 속성을 element객체에 저장
			Elements items = doc.select(".view_dic div ul li");
			//text와 tostring이 무슨 차이가 있는지 페이지 실행하고서 /jsoup
			classtest1 = items.text();
			classtest2 = items.toString();
		}catch(Exception e)
		{
			//에러있으면 출력
			e.printStackTrace();
		}
		
		//model객체에 전달 (장고에서 했던거랑 같은거라고 생각하면 됨)
		model.addAttribute("text",text);
		model.addAttribute("test1", classtest1);
		model.addAttribute("test2", classtest2);
		
		return "jsoup";
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
	
	@RequestMapping(value="/api", method = RequestMethod.GET)
	//exception throw하면 try catch 구문 안써도 된다고 함
	//원래는 try catch쓰는게 오류검출에서 좋은데 테스트라서 그냥 씀
	public String OpenApi(Model model) throws Exception
	{
	
		//자꾸 오류나서 되는지 확인
		System.out.println("JSON처리 진행중");
		//openapi페이지 들어가면 듀토리얼 있으니 그거보고 얻어올 url생성하면 됨 key는 따로 알려줌
		//하단의 url은 9/22 박스오피스 불러오는 open api
		String jsonUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f743ae62f9ae08863d48ad50b8e707d3&targetDt=20200922";
		//string -> url객체
		URL url = new URL(jsonUrl);
		
		//그냥 읽어오면 자꾸 오류나서 버퍼 이용해서 조금씩 읽어옴
		BufferedInputStream reader = new BufferedInputStream(url.openStream());
		StringBuffer buffer = new StringBuffer();
		int k=0;
		byte[] b = new byte[4096];
		while((k = reader.read(b))!=-1) {
			//하나씩 뒤에 붙인다
			buffer.append(new String(b,0,k));
		}
		
		//stringbuffer를 string으로 변경
		//처음부터 string안쓴 이유는 string은 선언시마다 메모리 새로 allocation(변경불가)
		//jsontext에 들어있는 값은 open api의 전체문서
		String jsontext = buffer.toString();

		//jsonparser이용해 필요한 데이터만 얻는다
		JSONParser jsonp = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonp.parse(jsontext);
		//api 링크 들어가보면 boxOfficeResult에 영화이름 저장, 그 내부인
		//dailyboxofficelist에 영화 순위 저장해 있으므로 두번 parsing, jsonarray에 저장
		JSONObject json = (JSONObject)jsonObject.get("boxOfficeResult");
		JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
		//불러온 영화들 순서대로 접근, 1,2,3번째 영화 출력
		for(int i=0;i<array.size();i++)
		{
			//jsonarray내부의 한 데이터 (jsonobject)를 string으로 바꿔서 얻으면 끝
			JSONObject row = (JSONObject)array.get(i);
			String movie = (String)row.get("movieNm");
			System.out.println(movie);
			
			//1,2,3번째만 model객체에 추가
			if(i==0)
			{
				model.addAttribute("movie1", movie);
			}
			if(i==1)
			{
				model.addAttribute("movie2", movie);
			}
			if(i==2)
			{
				model.addAttribute("movie3", movie);
			}
		}
		
		return "api";
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

 
