/*******************************************
 프로그램명 : 유저정보 저장 클래스
 * 작성자 : 임경수
 * 작성일 : 2020-11-10
 * 프로그램 설명 : 유저의 정보를 저장한다
 ***************************************/
package co.df.ds;

public class UserInfo {
	String ID;
	String password;
	String name;
	int age;
	
	UserInfo(String ID, String password, String name, int age)
	{
		this.ID = ID;
		this.password = password;
		this.name = name;
		this.age = age;
	}
	
	String GetID()
	{
		return this.ID;
	}
	
	String GetPW()
	{
		return this.password;
	}
	
	String GetName()
	{
		return this.name;
	}
	
	int GetAge()
	{
		return this.age;
	}
	
}
