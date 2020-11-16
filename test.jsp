<!-- 
프로그램명 : 폼의 메소드 실행
작성자 :임경수
작성일자 : 2020-11-15
프로그램 설명: 폼에서 컨트롤러로 데이터를 전송할 때 파이썬과 같은 방식으로 전달시 오류가 발생해서
jsp만의 좋은 방법을 찾아보는 테스트 파일
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>none</title>
<%! String calc; %>


<form action="member.do" method="get">
	<select name='sear_sel'>
		<option value='mvname'>영화이름검색</option>
		<option value='makername'>영화사이름검색</option>
	</select>
	검색 : <input type="text" name="search" />
	<input type="submit" />
</form>
</head>
<body>

</body>
</html>