<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--
	프로그램명 : 로그인 페이지
	작성자 : 임경수
	작성일 : 2020-11-15
	프로그램설명 : 로그인 기능 구현하기 위한 페이지
-->
<html>
	<head>
		<style>
			*{
				padding:0;
				margin:0;
			}
			h1{
				text-align:center;
				font-size:50px;
			}
			
			.lgin_body{
				margin: 20 40;
				width:100%;
				height:100%;
				position:relative;
				
			}
			
			.lgin_body form{
				width:600px;
				height:800px;
				top:10%;
				left:50%;
				margin: 0 0 0 -350px;
				position:absolute;
				background-color:yellow;
			}
			
			.lgin_body form input{
				display:block;
				width:400px;
				height:100px;
				left:15%;
				position:relative;
				font-size:40px;
				margin:20px;
			}
		</style>
	</head>
	<body>
		<h1>register page</h1>
		<div class='lgin_body'>
		
			<form action='register.do' method='post'>
				<input id='idname' name='ID' type='text' placeholder='아이디 입력'/>
				<input id='psword' name='PW' type='text' placeholder='비밀번호 입력'/>
				<input id='psword_rpt' name='PW_repeat' type='text' placeholder='비밀번호 한번더'/>
				<input id='name' name='name' type='text' placeholder='이름'/>
				<input id='age' name='age' type='number' min='1' max='200' placeholder='나이'/>
				
				<input id='submit_btn' type='submit' />
			</form>
		</div>
	</body>
</html>