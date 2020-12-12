<!-- 
작성자:임경수
작성일자:2020-12-07

프로그램 설명:커뮤니티의 페이지를 출력한다

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
				background-image:url('${pageContext.request.contextPath}/resources/images/star_sky.jpg');
			}
			
			#wrapper{
				width:60%;			
				margin-left:20%;
				padding-top:50px;
				background-color:rgba(160, 160, 160, 0.5);
				
			}
			
			#delete_post{
				width:70px;
				height:60px;
				float:right;
				background-color:red;
				position:absolute;
				right:20%;
				top:0;
				text-align:center;
				color:white;
				font-size:40px;
			}
			
			
			#title{
				width:85%;
				
				margin-top:30px;
				margin-bottom:30px;
				margin-left:7.5%;
				background-color:#dee2e6;
				font-size:70px;
				text-align:center;
			}
			
			#content{
				width:85%;
				height:500px;
				margin-left:7.5%;
				margin-bottom:30px;
				background-color:#dee2e6;
				overflow:scroll;
				box-sizing:border-box;
				padding-top:10px;
				padding-bottom:10px;
				padding-left:30px;
				padding-right:30px;
				font-size:25px;
				
			}
			
			#content::-webkit-scrollbar{
				display:none;
			}
			
			#like_dislike_box{
				width:100%;
				height:60px;
				margin-bottom:10px;
			}
			
			#like_dislike_box form{
				margin:0 auto;
				width:300px;
			}
			
			#like{
				width:80px;
				height:60px;
				font-size:30px;
			}
			
			#dislike{
				width:80px;
				height:60px;
				float:right;
				font-size:30px;
			}
			
			#like_dislike_num{
				width:100%;
				height:60px;
				margin-bottom:30px;
				
			}
			
			#like_dislike_div{
				
				margin:0 auto;
				width:300px;
			}
			
			
			
			#like_num{
				width:150px;
				height:60px;
				font-size:30px;
				float:left;
				display:inline-block;
				text-align:left;
				margin-left:20px;
			}
			
			#dislike_num{
				width:100px;
				height:60px;
				font-size:30px;
				float:left;
				display:inline-block;
				text-align:right;
			}
			
			
			#comment_box{
				width:100%;
				margin-bottom:50px;
				
			}
			
			#comment_delete{
				width:30px;
				height:30px;
				background-color:red;
				color:white;
				font-size:25px;
				position:absolute;
				right:20%;
				text-align:center;
				line-height:20px;
				font-weight:bold;
			}
			
			#one_comment{
				width:100%;
				height:100px;
				background-color:white;
				box-sizing:border-box;
				border-top:solid 1px black;
				border-bottom:solid 1px black;
			}
			
			#one_comment div{
				display:inline-block;
				float:left;
			}
			
			#comment_writer{
				width:20%;
				height:100%;
				background-color:#343a40;
				color:white;
				font-size:25px;
				text-align:center;
				line-height:95px;
			}
			
			#comment_content{
				width:80%;
				height:100%;
				background-color:grey;
				font-size:20px;
				padding:10px;
				box-sizing:border-box;
				overflow:scroll;
				
			}
			#comment_content::-webkit-scrollbar{
				display:none;
			}
			
			#comment_write_box{
				width:90%;
				margin-left:5%;
				height:100px;
				padding-bottom:100px;
			}
			
			
			
			
			
			#write_comment{
				width:100%;
				height:100px;
			}
			
		
			#current_comment_writer{
				background-color:black;
				color:white;
				font-size:30px;
				line-height:90px;
				text-align:center;
				width:20%;
				float:left;
				height:100px;
			}
			
			#comment{
				display:inline-block;
				float:left;
				width:70%;
				height:100px;
				font-size:20px;
				
			}
			
			#submit_comment{
				display:inline-block;
				float:left;
				width:10%;
				height:100px;
				font-weight:bold;
				font-size:30px;
			}
		</style>
	</head>
	<body>
	<%String[] post_information = (String[])request.getAttribute("post_information");  %>
	<%String post_id_equal; %>
		<div id='wrapper'>
		<!-- 이부분 세션 아이디로 변경 필요 -->
			<%if("dlarudtn8".equals((String)post_information[0])){ %>
			<%post_id_equal = "yes"; %>
			<%}else{post_id_equal = "no";} %>
			<button type='button' id='delete_post' onclick='delete_post_function("<%=post_information[1]%>", "<%=post_id_equal%>");'>X</button>
			<div id='title'>
				<%=post_information[1] %>
			</div>
			<div id='content'>
				작성자 : <%=post_information[0] %>
				<br>
				<%=post_information[2] %>
			</div>
			
			<div id='like_dislike_box'>
				<form method='post' accept-charset='utf-8' >
					<button id='like' name='like' value='<%=post_information[1] %>' onclick="javascript: form.action='increase_rate.do';">▲</button>
					<button id='dislike' name='dislike' value='<%=post_information[1] %>' onclick="javascript: form.action='decrease_rate.do';">▼</button>
				</form>
			</div>
			
			<div id='like_dislike_num'>
				<div id='like_dislike_div'>
					<div id='like_num'><%=post_information[3] %></div>
					<div id='dislike_num'><%=post_information[4] %></div>
				</div>
			</div>
			
<%ArrayList comments = (ArrayList)request.getAttribute("comment_information"); %>
<%int comment_size = comments.size(); %>
<%String com_id_equal; %>
			<div id='comment_box'>
			<%for(int i=0;i<comment_size;i+=3){ %>
				<div id='one_comment'>	
					<%int string_size = post_information[1].length(); %>
					
					<!-- 이부분 아이디 세션으로 변경 필요 -->
					<%if("dlarudtn".equals(comments.get(i))){ %>
					<%com_id_equal = "yes"; %>
					<%}else{com_id_equal = "no";} %>
					<%String added = (String)comments.get(i+2) + string_size+ post_information[1]+ (String)comments.get(i+1);%>
					<%added = added.replace(System.getProperty("line.separator").toString(), ""); %>
					<button type='button' id='comment_delete' onclick='javascript:delete_comment_function("<%=added%>", "<%=com_id_equal%>")' >x</button>
					<div id='comment_writer'>
						<%=comments.get(i) %>
					</div>
					<div id='comment_content'>
						<%=comments.get(i+1) %>
						<br>
						<%=comments.get(i+2) %>
					</div>
					
				</div>
				<%} %>
				
				
			</div>
			<div id='comment_write_box'>
				
				<!--name부분 이걸로 바꿔야되 ${sessionScope.id} -->
				<form id='write_comment' method='post' action='write_comment.do'>
					<input type='text' name="comment_writer_name" style="display:none" value='dlarudtn' ></input>
					<div id='current_comment_writer' >dlarudtn</div>
					<textarea name='comment_content' placeholder='댓글을 작성할때는 조심' id='comment'></textarea>
					<button id='submit_comment' name='title' value='<%=post_information[1] %>' type='submit'>작성</button>
				</form>
			</div>
		</div>
	
	<script>
		function delete_post_function(title, isequal){
			if(confirm("글을 삭제하시겠습니까?"))
			{
				if(isequal == "yes")
				{
					var form = document.createElement('form');
					form.setAttribute('method', 'post');
					form.setAttribute('action', 'delete_post.do');
					
				        var hiddenField = document.createElement("input");
				        hiddenField.setAttribute("type", "hidden");
				        hiddenField.setAttribute("name", 'title_name');
				        hiddenField.setAttribute("value", title);
				 
				        form.appendChild(hiddenField);
				    
					document.charset = 'utf-8';
					
					document.body.appendChild(form);
					form.submit();
				}
				else
				{
					alert("글 작성자만 삭제할 수 있습니다.")
				}
			}
			
			
		}
		
		function delete_comment_function(ssstring, isequal){
			if(confirm("댓글을 삭제하시겠습니까?"))
			{
				if(isequal == "yes")
				{
					var form = document.createElement('form');
					form.setAttribute('method', 'post');
					form.setAttribute('action', 'delete_comment.do');
					
				        var hiddenField = document.createElement("input");
				        hiddenField.setAttribute("type", "hidden");
				        hiddenField.setAttribute("name", 'delete_element');
				        hiddenField.setAttribute("value", ssstring);
				 
				        form.appendChild(hiddenField);
				    
					document.charset = 'utf-8';
					
					document.body.appendChild(form);
					form.submit();
				}
				else
				{
					alert("댓글을 쓴 본인만 삭제할 수 있습니다.")
				}
			}
			
		}
		
		
	</script>
			
	</body>
	
</html>