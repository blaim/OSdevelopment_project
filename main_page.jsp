<!-- 
프로그램명 : 떼껄룩 메인 페이지
작성자 :임경수
작성일자 : 2020-11-29
프로그램 설명: 떼껄룩의 메인 페이지 기능 구현. 컨트롤러에서 전달된 영화들을 화면에 출력한다
네이버 문의해서 현재 상영중인 영화 출력
-->
<%@ page import="java.util.*" %>
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
			.movies{
				
				
				background-color:blue;
				
				
				}
			.spe_movie{
				margin:20 20;
				width:150px;
				height:200px;
				background-color:yellow;
				display:inline-block;
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
				margin-top:50px;
				text-align:center;
				font-size:20px;
				box-sizing:border-box;
			}
			#mv_name a{
				word-break:break-all;
				display:inline-flex;
			}
			
			#title_box{
				background-color:red;
				width:100%;
				height:100px;
				font-size:70px;
				text-align:center;
				font-weight:bold;
			}
			
			
			
		</style>
	</head>
	<body>
		<div class="header">
			
			<a id='sign_in' href="#sign">로그인</a>
		</div>
		<h1>Take A Look</h1>
		
		<div class="container">
			<div class="buttons">
				<ul>
					<li><a class="active" href="/GYE">메인</a></li>
					<li><a href="/GYE/BoxOffice">박스오피스</a></li>
					<li><a href="#recom">추천영화</a></li>
					<li><a href="/GYE/comunity">커뮤니티</a></li>
				</ul>
			</div>
			<div class="movies">
			<%! int i; %>
<%if(request.getAttribute("movies")!=null){ %>
<% String[] movies = (String[])request.getAttribute("movies"); %>
<% Integer size = (Integer)request.getAttribute("size"); %>
				
<%for(i=0;i<size;i+=2){ %>
				<div class="spe_movie">
					
					<div id='mv_name'>
						<a href='/GYE/spe_movie?spe_movie_code=<%=movies[i+1]%>'><%= movies[i] %></a>
					</div>
				</div>
				
				<%} %>
<%} %>

<%if(request.getAttribute("current_movies")!=null){ %>
<% ArrayList movies = (ArrayList)request.getAttribute("current_movies"); %>
<% int i = movies.size(); %>
				<div id='title_box'>현재 상영작</div>
<%for(int k=0;k<i;k++){ %>
				<div class="spe_movie">
					
					<div id='mv_name'>
						<a><%=movies.get(k) %></a>
					</div>
				</div>
				
				<%} %>
<%} %>
			</div>
		</div>
		<div class="footer">
			<form action='member.do' method='get'>
			<select name='sear_sel'>
				<option value='mvname'>영화이름검색</option>
				<option value='makername'>영화사이름검색</option>
			</select>
				<input id="search" autocomplete="off" name='search' type='text' />
				<input id='search_submit' type='submit' />
			</form>
		</div>
		
	<script>
		
	</script>
	</body>
	
</html>