/*******************************************
 프로그램명 : json을 이용한 open api 데이터 읽어오는 클래스
 * 작성자 : 임경수
 * 작성일 : 2020-11-10
 * 프로그램 설명 : 다양한 검색기능할때 편하게 하기 위해 한 클래스 안에
 * open api에 접근하는 다양한 함수들을 넣는다
 ***************************************/
package co.df.ds;

import java.io.BufferedInputStream;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class UsingOPENAPI {
	private String key = "f743ae62f9ae08863d48ad50b8e707d3";
	
	//검색한 단어가 포함되는 영화들의 코드를 출력한다
	/***********************
	 * 문자열 배열의 크기는 50으로 하고,
	 * 만약 검색한 숫자가 50개 미만이면, 
	 * 모자란 부분에는 null을 출력한다
	 * 짝수번째에는 영화의 이름을 저장
	 * 홀수번째에는 영화의 코드를 저장한다
	 * 테스트 완료
	 * @param movie_name
	 * @return
	 */
	String[] MovieNameSearch(String movie_name) throws Exception
	{
		String[] movies = new String[50];
		
		String searchURL_text = "http://www.kobis.or.kr"
				+ "/kobisopenapi/webservice/rest/movie/searchMovieList.json?key="
				+ key
				+"&movieNm="
				+movie_name;
		
		URL searchURL = new URL(searchURL_text);
		
		BufferedInputStream reader = new BufferedInputStream(searchURL.openStream());
		StringBuffer buffer = new StringBuffer();
		int k=0;
		byte[] b = new byte[4096];
		while((k = reader.read(b))!=-1) {
			buffer.append(new String(b,0,k));
		}
		
		String jsontext = buffer.toString();
		
		JSONParser jsonparser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonparser.parse(jsontext);
		
		JSONObject movieListResult = (JSONObject)jsonObject.get("movieListResult");
		JSONArray movieList = (JSONArray)movieListResult.get("movieList");
		
		int sizeof_mvList = movieList.size();
		JSONObject one_movie;
		int array_saving_index = 0;
		
		if(sizeof_mvList >= 25)
		{
			for(int i=0;i<25;i++)
			{
				one_movie = (JSONObject)movieList.get(i);
				movies[array_saving_index] = (String)one_movie.get("movieNm");
				movies[array_saving_index+1] = (String)one_movie.get("movieCd");
				array_saving_index += 2;
			}
		}
		else
		{
			for(int i=0;i<sizeof_mvList;i++)
			{
				one_movie = (JSONObject)movieList.get(i);
				movies[array_saving_index] = (String)one_movie.get("movieNm");
				movies[array_saving_index+1] = (String)one_movie.get("movieCd");
				array_saving_index += 2;
			}
			
			for(int i=(sizeof_mvList*2)+1;i<50;i++)
			{
				movies[i] = "null";
			}
		}
		
		
		return movies;
	}
	
	//일별 박스오피스 출력
	/*****************************
	 * 주의 :: 오늘 당일건은 업데이트 안됨
	 * 하루 이전날짜까지만 조회 가능!
	 * 0 영화이름
	 * 1 영화코드
	 * 2 누적관객수
	 * 3 누적매출액
	 * 이런식으로
	 * 0 1 2 3
	 * 4 5 6 7
	 * ....
	 * 36 37 38 39까지
	 * 10개의 순위를
	 * String배열으로 출력
	 * 
	 * 날짜는 20201101 처럼 연속적인 숫자형태의 텍스트로 입력한다
	 * 테스트 완료
	 * 
	 * 오류나면 ERROR를 저장
	 * @param date
	 * @return
	 */
	String[] daily_BoxOffice(String date) throws Exception
	{
		String[] box_offices = new String[40];
		
		String searchURL_text = "http://www.kobis.or.kr/kobisopenapi"
				+ "/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
				+ "?key="
				+ key
				+ "&targetDt="
				+ date;
		
		URL searchURL = new URL(searchURL_text);
		
		BufferedInputStream reader = new BufferedInputStream(searchURL.openStream());
		StringBuffer buffer = new StringBuffer();
		int k=0;
		byte[] b = new byte[4096];
		while((k = reader.read(b))!=-1) {
			buffer.append(new String(b,0,k));
		}
		
		String jsontext = buffer.toString();
		
		JSONParser jsonparser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonparser.parse(jsontext);
		
		//top
		JSONObject infoResult = (JSONObject)jsonObject.get("boxOfficeResult");
		JSONArray bxoffice_array = (JSONArray)infoResult.get("dailyBoxOfficeList");
		JSONObject specific_movie;
		int array_saving_index = 0;
		
		try {
			for(int i=0;i<10;i++)
			{
				specific_movie = (JSONObject)bxoffice_array.get(i);
				
				box_offices[array_saving_index] = (String)specific_movie.get("movieNm");
				box_offices[array_saving_index+1] = (String)specific_movie.get("movieCd");
				box_offices[array_saving_index+2] = (String)specific_movie.get("audiAcc");
				box_offices[array_saving_index+3] = (String)specific_movie.get("salesAcc");
				array_saving_index += 4;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			box_offices[0] = "ERROR";
			return box_offices;
		}
		
		
		
		return box_offices;
	}
	
	//영화 코드를 통해 세부정보 출력한다
	/**************************
	 * 
	 *문자열 배열로 출력
	 *만약 없으면 null이라는 문자열을 저장
	 *0한글영화이름
	 *1영어영화이름
	 *2감독이름
	 *3상영제한연령
	 *4제작국가
	 *5수입사
	 *6.개봉일자
	 *7~11장르 목록
	 *12 ~ 19 출연배우 목록
	 *테스트 완료
	 */
	String[] MovieCodeSearch(String movie_code) throws Exception
	{
		String[] informations = new String[20];
		
		String SearchURL_text = "http://www.kobis.or.kr/kobisopenapi/webservice/"
				+ "rest/movie/searchMovieInfo.json?key="
				+ key
				+ "&movieCd="
				+ movie_code;
		
		URL SearchURL = new URL(SearchURL_text);
				
		
		BufferedInputStream reader = new BufferedInputStream(SearchURL.openStream());
		StringBuffer buffer = new StringBuffer();
		int k=0;
		byte[] b = new byte[4096];
		while((k = reader.read(b))!=-1) {
			buffer.append(new String(b,0,k));
		}
		
		String jsontext = buffer.toString();
		
		JSONParser jsonparser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonparser.parse(jsontext);
		
		
		//top
		JSONObject infoResult = (JSONObject)jsonObject.get("movieInfoResult");
		JSONObject mvInfo = (JSONObject)infoResult.get("movieInfo");
		
		
		informations[0] = (String)mvInfo.get("movieNm");
		informations[1] = (String)mvInfo.get("movieNmEn");
		
		JSONArray directors = (JSONArray)mvInfo.get("directors");
		JSONObject director = (JSONObject)directors.get(0);
		informations[2] = (String)director.get("peopleNm");
		
		JSONArray watch_limits = (JSONArray)mvInfo.get("audits");
		JSONObject watch_limit = (JSONObject)watch_limits.get(0);
		informations[3] = (String)watch_limit.get("watchGradeNm");
		
		
		JSONArray nations = (JSONArray)mvInfo.get("nations");
		JSONObject nation = (JSONObject)nations.get(0);
		informations[4] = (String)nation.get("nationNm");

		
		JSONArray companys = (JSONArray)mvInfo.get("companys");
		JSONObject company = (JSONObject)companys.get(0);
		informations[5] = (String)company.get("companyNm");
		
		informations[6] = (String)mvInfo.get("openDt");
		
		
		JSONArray genres = (JSONArray)mvInfo.get("genres");
		JSONObject genre;
		int sizeof_genre = genres.size();
		int diff_size = 5 - sizeof_genre;
		
		if(diff_size < 0)
		{
			for(int i=0;i<5;i++)
			{
				genre = (JSONObject)genres.get(i);
				informations[i+7] = (String)genre.get("genreNm");
			}
		}
		else
		{
			for(int i=0;i<sizeof_genre;i++)
			{
				genre = (JSONObject)genres.get(i);
				informations[i+7] = (String)genre.get("genreNm");
			}
			
			for(int i=0;i<diff_size;i++)
				informations[i+7+sizeof_genre] = "null";
		}
		
		JSONArray actors = (JSONArray)mvInfo.get("actors");
		JSONObject actor;
		int sizeof_actors = actors.size();
		diff_size = 7 - sizeof_actors;
		
		if(diff_size<0)
		{
			for(int i=0;i<7;i++)
			{
				genre = (JSONObject)actors.get(i);
				informations[i+12] = (String)genre.get("peopleNm");
			}
		}
		else
		{
			for(int i=0;i<sizeof_actors;i++)
			{
				genre = (JSONObject)actors.get(i);
				informations[i+12] = (String)genre.get("peopleNm");
			}
			for(int i=0;i<diff_size;i++)
				informations[i+12+sizeof_genre] = "null";
		}
		
		
		
		
		//jsonarray 크기는 jsonarray.size로 구함
		
		
		return informations;
	}
}
