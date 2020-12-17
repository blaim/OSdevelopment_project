<!-- 
프로그램명 : find_password_result.jsp
작성자 :황근민
작성일자 : 2020-12-15
프로그램 설명: 비밀번호 찾기 결과 화면
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>TakeALook</title>
    <!--디자인 스타일-->
    <style>
       
        *, ::after, ::before {
            box-sizing: border-box;
        }

        html {
            font-family: sans-serif;
            line-height: 1.15;
            -webkit-text-size-adjust: 100%;
            -webkit-tap-highlight-color: transparent;
        }

        article, aside, figcaption, figure, footer, header, hgroup, main, nav, section {
            display: block;
        }

        body {
            margin: 0;
            font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: left;
            background-color: #fff;
        }

        h1,h2, h3, h4, h5, h6 {
            margin-top: 0;
            margin-bottom: .5rem;
        }
        h3{
            background-color:azure;
        }
        h7 {
            top:15%;
            left:45%;
            font-size: 50px;
            color:white;
         position: fixed;
        }
        h10{
          float:right;
          left:50%;
          color:black;
          width:50px;

        }
        .lgin_body {
            
            position:fixed;
            top:20%;
            margin: 20px 40px;
            width: 100%;
            height: 100%;
        }

            .lgin_body form {
                width: 900px;
                height: 400px;
                top: 5%;
                left: 45%;
                margin: 0 0 0 -350px;
                position: absolute;
                background-color: silver;
            }

                .lgin_body form input {
                    display: block;
                    width: 600px;
                    height: 65px;
                    left: 15%;
                    position: relative;
                    font-size: 30px;
                    margin: 20px;
                }

        p {
            margin-top: 0;
            margin-bottom: 1rem;
        }


        a {
            color: white;
            text-decoration: none;
        }

            a:hover {
                text-decoration: none;
            }

            a:not([href]) {
                color: inherit;
                text-decoration: none;
            }

                a:not([href]):hover {
                    color: inherit;
                    text-decoration: none;
                }
        button {
            border-radius: 3px;
        }


            button:focus {
                outline: 1px dotted;
                outline: 5px auto -webkit-focus-ring-color;
            }

        button, input, optgroup, select, textarea {
            margin: 0;
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
        }

        button, input {
            overflow: visible;
        }

        button, select {
            text-transform: none;
        }

        select {
            word-wrap: normal;
        }

        [type=button], [type=reset], [type=submit], button {
            -webkit-appearance: button;
        }

            [type=button]:not(:disabled), [type=reset]:not(:disabled), [type=submit]:not(:disabled), button:not(:disabled) {
                cursor: pointer;
            }

            [type=button]::-moz-focus-inner, [type=reset]::-moz-focus-inner, [type=submit]::-moz-focus-inner, button::-moz-focus-inner {
                padding: 0;
                border-style: none;
            }

        input[type=checkbox], input[type=radio] {
            box-sizing: border-box;
            padding: 0;
        }

        input[type=date], input[type=datetime-local], input[type=month], input[type=time] {
            -webkit-appearance: listbox;
        }

        textarea {
            overflow: auto;
            resize: vertical;
        }



        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            margin-bottom: .5rem;
            font-weight: 400;
            line-height: 1.2;
        }

        .h1, h1 {
            font-size: 2.5rem;
        }

        .h2, h2 {
            font-size: 2rem;
        }

        .h3, h3 {
            font-size: 1.75rem;
        }

        .h4, h4 {
            font-size: 1.5rem;
        }

        .h5, h5 {
            font-size: 1.25rem;
        }

        .h6, h6 {
            font-size: 1rem;
        }

        @media (min-width:992px) {
            .col-lg {
                -ms-flex-preferred-size: 0;
                flex-basis: 0;
                -ms-flex-positive: 1;
                flex-grow: 1;
                max-width: 100%;
            }

            .col-lg-1 {
                -ms-flex: 0 0 8.333333%;
                flex: 0 0 8.333333%;
                max-width: 8.333333%;
            }

            .col-lg-2 {
                -ms-flex: 0 0 16.666667%;
                flex: 0 0 16.666667%;
                max-width: 16.666667%;
            }

            .col-lg-3 {
                -ms-flex: 0 0 25%;
                flex: 0 0 25%;
                max-width: 25%;
            }

            .col-lg-4 {
                -ms-flex: 0 0 33.333333%;
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }

            .col-lg-5 {
                -ms-flex: 0 0 41.666667%;
                flex: 0 0 41.666667%;
                max-width: 41.666667%;
            }

            .col-lg-6 {
                -ms-flex: 0 0 50%;
                flex: 0 0 50%;
                max-width: 50%;
            }

            .col-lg-7 {
                -ms-flex: 0 0 58.333333%;
                flex: 0 0 58.333333%;
                max-width: 58.333333%;
            }

            .col-lg-8 {
                -ms-flex: 0 0 66.666667%;
                flex: 0 0 66.666667%;
                max-width: 66.666667%;
            }

            .col-lg-9 {
                -ms-flex: 0 0 75%;
                flex: 0 0 75%;
                max-width: 75%;
            }

            .col-lg-10 {
                -ms-flex: 0 0 83.333333%;
                flex: 0 0 83.333333%;
                max-width: 83.333333%;
            }

            .col-lg-11 {
                -ms-flex: 0 0 91.666667%;
                flex: 0 0 91.666667%;
                max-width: 91.666667%;
            }

            .col-lg-12 {
                -ms-flex: 0 0 100%;
                flex: 0 0 100%;
                max-width: 100%;
            }

        html,
        body {
            height: 100%;
            font-family: "Mulish", sans-serif;
            -webkit-font-smoothing: antialiased;
            background: #0b0c2a;
        }

        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            margin: 0;
            color: #111111;
            font-weight: 400;
            font-family: "Mulish", sans-serif;
        }

        h1 {
            text-align: center;
            font-size: 50px;
            color: black;
            line-height: 50px;
            font-weight: bold;
        }

        h2 {
            font-size: 36px;
        }

        h3 {
            font-size: 30px;
        }

        h4 {
            font-size: 24px;
        }

        h5 {
            font-size: 18px;
        }

        h6 {
            font-size: 16px;
        }

        p {
            font-size: 15px;
            font-family: "Mulish", sans-serif;
            color: #3d3d3d;
            font-weight: 400;
            line-height: 25px;
            margin: 0 0 15px 0;
        }

        .slicknav_menu {
            display: none;

            padding-top: 130px;
            padding-bottom: 150px;
        }
        
        /*---------------------
          Login
        -----------------------*/

        .login {
            padding-top: 130px;
            padding-bottom: 120px;
        }

        .login__form {
            position: relative;
            padding-left: 145px;
        }

            .login__form:after {
                position: absolute;
                right: -14px;
                top: -40px;
                height: 330px;
                width: 1px;
                background: rgba(255, 255, 255, 0.2);
                content: "";
            }

            .login__form h3 {
                color: #ffffff;
                font-weight: 700;
                font-family: "Oswald", sans-serif;
                margin-bottom: 30px;
            }

            .login__form form .input__item {
                position: relative;
                width: 370px;
                margin-bottom: 20px;
            }

                .login__form form .input__item:before {
                    position: absolute;
                    left: 50px;
                    top: 10px;
                    height: 30px;
                    width: 1px;
                    background: #b7b7b7;
                    content: "";
                }

                .login__form form .input__item input {
                    height: 50px;
                    width: 100%;
                    font-size: 15px;
                    color: #b7b7b7;
                    background: #ffffff;
                    border: none;
                    padding-left: 76px;
                }

                    .login__form form .input__item input::-webkit-input-placeholder {
                        color: #b7b7b7;
                    }

                    .login__form form .input__item input::-moz-placeholder {
                        color: #b7b7b7;
                    }

                    .login__form form .input__item input:-ms-input-placeholder {
                        color: #b7b7b7;
                    }

                    .login__form form .input__item input::-ms-input-placeholder {
                        color: #b7b7b7;
                    }

                    .login__form form .input__item input::placeholder {
                        color: #b7b7b7;
                    }

                .login__form form .input__item span {
                    color: #b7b7b7;
                    font-size: 20px;
                    position: absolute;
                    left: 15px;
                    top: 13px;
                }

            .login__form form button {
                border-radius: 0;
                margin-top: 10px;
            }

            .login__form .forget_pass {
                font-size: 15px;
                color: #ffffff;
                display: inline-block;
                position: absolute;
                right: 60px;
                bottom: 12px;
            }

        .login__register {
            padding-left: 30px;
        }

            .login__register h3 {
                color: #ffffff;
                font-weight: 700;
                font-family: "Oswald", sans-serif;
                margin-bottom: 30px;
            }

            .login__register .primary-btn {
                background: #e53637;
                padding: 12px 42px;
            }

        .login__social {
            padding-top: 52px;
        }

        .login__social__links {
            text-align: center;
        }

            .login__social__links span {
                color: #ffffff;
                display: block;
                font-size: 13px;
                font-weight: 700;
                letter-spacing: 2px;
                text-transform: uppercase;
                margin-bottom: 30px;
            }

            .login__social__links ul li {
                list-style: none;
                margin-bottom: 15px;
            }

                .login__social__links ul li:last-child {
                    margin-bottom: 0;
                }

                .login__social__links ul li a {
                    color: #ffffff;
                    display: block;
                    font-size: 13px;
                    font-weight: 700;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    width: 460px;
                    padding: 14px 0;
                    position: relative;
                    margin: 0 auto;
                }

                    .login__social__links ul li a.facebook {
                        background: #4267b2;
                    }

                    .login__social__links ul li a.google {
                        background: #ff4343;
                    }

                    .login__social__links ul li a.twitter {
                        background: #1da1f2;
                    }

                    .login__social__links ul li a i {
                        font-size: 20px;
                        position: absolute;
                        left: 32px;
                        top: 14px;
                    }

        /*---------------------
          Sign Up
        -----------------------*/

        .signup {
            padding-top: 130px;
            padding-bottom: 150px;
        }

            .signup .login__form:after {
                height: 450px;
            }

            .signup .login__form h5 {
                font-size: 15px;
                color: #ffffff;
                margin-top: 36px;
            }

                .signup .login__form h5 a {
                    color: #e53637;
                    font-weight: 700;
                }

            .signup .login__social__links {
                text-align: left;
                padding-left: 40px;
            }

                .signup .login__social__links h3 {
                    color: #ffffff;
                    font-weight: 700;
                    font-family: "Oswald", sans-serif;
                    margin-bottom: 30px;
                }

                .signup .login__social__links ul li a {
                    margin: 0;
                    text-align: center;
                }
                
			
			#write_box{
				left:32%;
				top:30%;
				width:40%;
				height:20%;
				background-color:#252642;
				position:absolute;
				display:none;
			}
			
			#write_box *{
				display:block;
			}
			
			#close_button{
                position:relative; 
				width:40px;
				height:40px;
                float:right;
				
			}
			
			
			#write_btn{
                position:relative;
                width:50%;
				height:50%;
			}
			
			form p{
				font-size:40px;
				text-align:center;
				margin-top:150px;
			}
			
			form a{
				font-size:30px;
				text-align:center;
				display:block;
				margin-top:70px;
				
			}
			
			a:hover{
				color:black;
			}
			
			p p{
				font-weight:bold;
			}
			
    </style>
</head>
<body>
    <!-- Page Preloder -->
    <div id="preloder" style="display: none;">
        <div class="loader" style="display: none;"></div>
    </div>
    <!-- 헤더 -->
    <header class="header">
        <div class="container">
            <div class="row">
                    <div class="col-lg-1">
                        <h3></h3>
                        <h1><a href="/GYE">떼껄룩</a></h1> <!--로고 -->
                    </div>
            </div>
            <div id="mobile-menu-wrap">
                <!--하단부 -->
                <div class="slicknav_menu">
                    <a href="#" aria-haspopup="true" role="button" tabindex="0" class="slicknav_btn slicknav_collapsed" style="outline: none;"><span class="slicknav_menutxt">MENU</span><span class="slicknav_icon"><span class="slicknav_icon-bar"></span><span class="slicknav_icon-bar"></span><span class="slicknav_icon-bar"></span></span></a><nav class="slicknav_nav slicknav_hidden" aria-hidden="true" role="menu" style="display: none;">
                    </nav>
                </div>
            </div>
        </div>
        </header>
        <!-- 헤더 끝 -->
        <!-- 비밀번호 결과 Begin -->
        <h7>비밀번호 찾기</h7>
        <% String result = (String)request.getAttribute("result"); %>
        <div class='lgin_body'>
        	<form>
        		<% if(result.equals("틀린 회원 정보입니다.")) 
				{%>
					<p><%=result %></p>
					<a href="/GYE/find_password">비밀번호 찾기 화면으로 돌아가기</a>					
				<%}	
        		else
				{%>
        			<p>회원가입시 비밀번호는 <%=result %>입니다.</p>
                	<a href="/GYE/login">로그인 화면으로 돌아가기</a>
                <%}	
				%>
        	</form>
        </div>
</body>


</html>