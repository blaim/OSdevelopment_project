<!-- 
프로그램명 : 떼껄룩 박스오피스 페이지
작성자 :임경수
작성일자 : 2020-11-26
프로그램 설명: 현재 박스오피스 영화 10개를 출력한다
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	
	<head>
		<style>
			*{
				margin:0px;
				padding:0px;
			}
			body{
				background-color:#0b0c2a;
			}
			
			#userid{
				margin: 8 8;
				height:80%;
				width:150px;
				font-size:20px;
				
			}
			#passwd{
				margin: 8 8;
				height:80%;
				width:150px;
				font-size:20px;
			}
			#id_submit{
				height:80%;
				width:60px;
				font-size:20px;
			}
			h1{
				text-align:center;
				font-size:100px;
				color:yellow;
			}
			.header{
				background-color:yellow;
				width:100%;
				height:60px;
				display:block;
				overflow:hidden;
			}
			.header form{
				width:430px;
				margin: 0;
				float:left;
			}
			.header a{
				position:absolute;
				top:8px;
				font-size:30px;
				text-decoration:none;
				background-color:white;
				border:2px solid black;
			}
			.header a:hover{
				color:purple;
			}
			.container{
				margin:30px 40px;
			}
			ul {
					list-style-type: none;
					margin: 0;
					padding: 0;
					
					background-color: #333;
				}
				ul:after{
					content:'';
					display: block;
					clear:both;
				}
				li {
					float: left;
				}
				li a {
					display: block;
					color: white;
					text-align: center;
					padding: 14px 16px;
					text-decoration: none;
				}
				li a:hover:not(.active) {
					background-color: #111;
				}
				.active {
					background-color: #4CAF50;
				}
		
			
			.footer{
				background-color:yellow;
				width:100%;
				height:60px;
				bottom:0px;
				position:fixed;
			}
			.footer form{
				margin: 0 auto;
				width:500px;
			}
			#search{
				height:70%;
			}
			#search_submit{
				height:70%;
				
			}
			#mv_name{
				position:relative;
				background-color:white;
				text-align:center;
				font-size:20px;
				box-sizing:border-box;
			}
			#mv_name p{
				word-break:break-all;
				display:inline-flex;
			}
			.movies{
				background-color:blue;
			}
			
			.spe_movie{
				display:grid;
				width:100%;
				height:300px;
				grid-template-columns: 1fr 3fr 3fr;
				grid-template-rows : 1fr 1fr;
				grid-gap:10px;
				
				background-color:blue;
			}
			
			.spe_movie *{
				margin:10px;
				text-align:center;
				line-height:125px;
				font-size:35px;
				
			}
			
			#movie_image{
				grid-column-start : 1;
				grid-column-end:2;
				grid-row-start:1;
				grid-row-end:3;
				background-color:green;
				width:200px;
				height:290px;
			}
			
			#movie_name{
				grid-column-start:2;
				grid-column-end:4;
				grid-row-start:1;
				grid-row-start:1;
				background-color:red;
			}
			
			#watcher{
				grid-column-start:2;
				grid-column-end:3;
				grid-row-start:2;
				grid-row-start:2;
				background-color:lime;
			}
			
			#cumul_money{
				grid-column-start:3;
				grid-column-end:4;
				grid-row-start:2;
				grid-row-start:2;
				background-color:yellow;
			}
			
		</style>
	</head>
	<body>
		<div class="header">
			
			<a id='sign_in' href="#sign">회원가입</a>
		</div>
		<h1>Take A Look</h1>
		
		<div class="container">
			<div class="buttons">
				<ul>
					<li><a href="/GYE">메인</a></li>
					<li><a class="active" href="/GYE/BoxOffice">박스오피스</a></li>
					<li><a href="#recom">추천영화</a></li>
					<li><a href="/GYE/comunity">커뮤니티</a></li>
				</ul>
			</div>

			<div class="movies">
<% String[] movies = (String[])request.getAttribute("bx_array"); %>
<%for(int i=0;i<40;i+=4){ %>
				<div class="spe_movie">
					<img id='movie_image' src="${pageContext.request.contextPath}/resources/images/<%=movies[i+1]%>.jpg" />
					<div id='movie_name'><a href='/GYE/spe_movie?spe_movie_code=<%=movies[i+1]%>'><%=movies[i] %></a></div>
					<div id='watcher'>누적관객 : <%=movies[i+2] %></div>
					<div id='cumul_money'>수익 : <%=movies[i+3] %></div>
				</div>	
<%} %>	
				
			</div>
		</div>
		<div class="footer">
			<form action='member.do' method='get'>
			<select name='sear_sel'>
				<option value='mvname'>영화이름검색</option>
				<option value='makername'>영화사이름검색</option>
			</select>
				<input id="search" name='search' type='text' />
				<input id='search_submit' type='submit' />
			</form>
		</div>
		
	</body>
	
</html>