<!-- 
프로그램명 : jsp홈페이지
작성자 :임경수
작성일자 : 2020-11-1
프로그램 설명: 본격적인 프로젝트에 들어가기 전에 컨트롤러에서 이미지 파일에 접근하는 방법, 
jsp 파일 내부에서 java코드를 이용해 반복문을 실행하는 방법 등에 대해 실행하는 파일
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<p>beautiful</p>
<%! int i, count=0; %>
<%if(request.getAttribute("movies")!=null){ %>
<% String[] movies = (String[])request.getAttribute("movies"); %>
<%for(i=0;i<50;i++){ %>
	<p><%= movies[i] %></p>
<%} %>
<%} %>

<!-- 이미지접근하는 코드. 처음에 설정 해둔 위치에 더해서 찾아줌 -->
<img src = "${pageContext.request.contextPath}/resources/images/test.jpg" />
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
