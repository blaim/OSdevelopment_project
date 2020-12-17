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

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<html>
	
	<head>
		<title>TakeALook</title>
		<style>
			*{
				margin:0px;
				padding:0px;
			}
            .nanumsquare {
             font-family: 'NanumSquare', sans-serif !important;
            }
			body{
				background-color:#0b0c2a;
                font-weight: bold;
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
				color:white;
				
			}
			.header{
				background-color:#070720;
				width:100%;
				height:60px;
				display:block;
				overflow:hidden;
				color:white;
				font-size:30px;
				text-align:center;
			}
			.header form{
				width:50px;
				margin: 0;
				float:left;
			}
			
			.header form button{
				width:100px;
				height:60px;
				font-size:20px;
				font-weight:bold;
			}
			
			
			.header a{
				position:absolute;
				top:8px;
				font-size:30px;
				text-decoration:none;
				color:white;
				left:50px;
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
					
					background-color:#1A1B28;
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
					background-color: #e53637;
				}
			.movies{
				
				
				background-color:#252642;
				
				
				}
			.spe_movie{
				margin:20px 20px;
				width:150px;
				height:200px;
				background-color:#e3dede;
				display:inline-block;
                padding: 18px 30px 16px 20px;
                border-radius: 10px;
			}
			
			
			.footer{
				background-color:#070720;
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
				color:black;
				text-decoration:none;
			}
			
			#mv_name a:hover{
				color:white;
			}
			
			#title_box{
				background-color:#1d1e39;
				width:100%;
				height:100px;
				font-size:70px;
				text-align:center;
				font-weight:bold;
                color: white;
                border-radius: 10px;
			}
			
			
			
		</style>
	</head>
	<body>
		<div class="header">
			<c:choose>
				<c:when test="${sessionScope.loginCheck eq true}">        	
        			${sessionScope.id} 님이 로그인 되었습니다.  
        			<form action="logout.do" method='post'>
        				<button type="submit" class="site-btn">로그아웃</button>
        			</form>
    			</c:when>
    			<c:otherwise>
					<a id='sign_in' href="/GYE/login">로그인</a>
				</c:otherwise>
			</c:choose>	
		</div>
		<h1>Take A Look</h1>
		
		<div class="container">
			<div class="buttons">
				<ul>
					<li><a class="active" href="/GYE">메인</a></li>
					<li><a href="/GYE/BoxOffice">박스오피스</a></li>
					<li><a href="/GYE/recommend">추천영화</a></li>
					<li><a href="/GYE/comunity">커뮤니티</a></li>
				</ul>
			</div>
			<div class="movies">
			<%! int i; %>
<%if(request.getAttribute("movies")!=null){ %>
<% String[] movies = (String[])request.getAttribute("movies"); %>
<% Integer size = (Integer)request.getAttribute("size"); %>
				
<%for(i=0;i<size; i+=2 ){ %>
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