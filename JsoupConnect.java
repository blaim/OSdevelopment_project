/*******************************************
 프로그램명 : jsoup을 이용하여 웹 크롤링 데이터 읽어오는 클래스
 * 작성자 : 임경수
 * 작성일 : 2020-12-02
 * 프로그램 설명 : jsoup를 이용한 웹 크롤링 작업에 사용한다.
 * 현재로서는 네이버의 영화 정보를 가져올 때 사용한다
 ***************************************/
package co.df.ds;

import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class JsoupConnect {
	String Naver_url = "https://movie.naver.com/movie/running/current.nhn";
	
	ArrayList GetCurrentMovieList() throws Exception
	{
		ArrayList movielist = new ArrayList();
		
		Document doc = Jsoup.connect(Naver_url).get();
		String text_url = doc.text();
		
		Elements movie_items = doc.select(".lst_detail_t1>li>.lst_dsc .tit");
		
		for(Element el : movie_items.select("a"))
		{
			System.out.println(el.text());
			movielist.add(el.text());
		}
		
		
		return movielist;
	}
	
	boolean IsOnTheater(String movie_name) throws Exception
	{
		ArrayList movies = this.GetCurrentMovieList();
		String all_movies = " ";
		
		for(int i=0;i<movies.size();i++)
		{
			all_movies += movies.get(i);
		}
		
		if(all_movies.contains(movie_name))
			return true;
		else
			return false;
	}
}
