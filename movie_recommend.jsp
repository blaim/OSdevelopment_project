<!-- 
프로그램명 : 영화 추천 페이지
작성자 :임경수
작성일자 : 2020-12-16
프로그램 설명: 추천하고 싶은 영화들을 보여준다
-->
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
	
	<head>
	<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
		<title>TakeALook</title>
		<style>
			*{
				margin:0px;
				padding:0px;
			}
			body{
				background-color:#0b0c2a;
				font-weight:bold;
			}
			
			.nanumsquare {
             font-family: 'NanumSquare', sans-serif !important;
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
				font-weight:bold;
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
					background-color: #e53637;
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
				
			.slidewrap{
				width:70%;
				margin-left:15%;
				height:500px;
				margin-top:100px;
				margin-bottom:50px
			}
			
			.myslides{
				width:100%;
				height:400px;
			}
			
			.title{
				width:100%;
				height:100px;
				font-size:70px;
				text-align:center;
				color:white;
				border:5px solid white;
				box-sizing:border-box;
			}
			
			.mv_img_box{
				width:20%;
				height:300px;
				background-color:pink;
				float:left;
				box-sizing:border-box;
				
			}
			
			#mv_img{
				width:100%;
				height:300px;
			}
			
			#mv_name a{
				display:none;
			}
			
			#mv_name{
				width:100%;
				height:50px;
				font-size:30px;
				text-align:center;
			}
			
			#mv_name{
				text-decoration:none;
			}
			
			.information{
				float:left;
				width:80%;
				height:300px;
				background-color:#e3dede;
				box-sizing:border-box;
				padding:50px;
				font-size:20px;
			}
			
			#button_div{
				background-color:grey;
			}
			
			
			.right_left_button{
				width:80px;
				height:70px;
				font-size:65px;
				line-height:10px;
				text-align:center;
				
			}
			
			
			#right_button{
				float:right;
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
					<li><a href="/GYE">메인</a></li>
					<li><a href="/GYE/BoxOffice">박스오피스</a></li>
					<li><a class="active" href="/GYE/recommend">추천영화</a></li>
					<li><a href="/GYE/comunity">커뮤니티</a></li>
				</ul>
			</div>
			
			<!--  number one start -->
			<div class='slidewrap'>	
			
			  <div class='myslides 1' >
				<div class='title' style='background-color:#343a40'>최고의 우주 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20149120.jpg'></img>
					<p id='mv_name'><a href='#'>인터스텔라</a></p>
				</div>
				<div class='information'>세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다.
 지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, NASA도 해체되었다.
 이때 시공간에 불가사의한 틈이 열리고, 남은 자들에게는 이 곳을 탐험해 인류를 구해야 하는 임무가 지워진다.
 사랑하는 가족들을 뒤로 한 채 인류라는 더 큰 가족을 위해, 그들은 이제 희망을 찾아 우주로 간다.
 그리고 우린 답을 찾을 것이다. 늘 그랬듯이…</div>
				
			  </div>
			  <div class='myslides 1' >
					<div class='title' style='background-color:#343a40'>최고의 우주 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20175962.jpg'></img>
					<p id='mv_name'><a href='#'>스테이션 7</a></p>
				</div>
				<div class='information'>1985년 냉전 시대, 우주를 향한 국가간의 끝없는 경쟁이 펼쳐졌다.
 소비에트 연방의 전유물인 살류트-7(Salyut-7) 우주 정거장이 궤도를 이탈하게 되고,
 제어할 수 없는 우주선에 도킹을 시도하기 위해 떠나는 블라디미르와 빅토르.
 그들에게 인류 역사상 최대의 미션이 주어진다!</div>
			  </div>
			  <div class='myslides 1' >
					<div class='title' style='background-color:#343a40'>최고의 우주 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20199735.jpg'></img>
					<p id='mv_name'><a href='#'>유랑지구</a></p>
				</div>
				<div class='information'>가까운 미래, 태양계 소멸 위기를 맞은
 지구는 영하 70도의 이상 기후와 함께
 목성과의 충돌이라는 대재앙에 직면한다.
 그러자, 전 세계 연합정부는
 지구 자체를 태양계 밖으로 이동시키기 위한
 범우주적 인류이민계획을 세우는데…
 인류 생존을 위한 마지막 프로젝트가 시작된다!</div>
			  </div>
			  <div class='myslides 1' >
					<div class='title' style='background-color:#343a40'>최고의 우주 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20198041.jpg'></img>
					<p id='mv_name'><a href='#'>우주전쟁 2019</a></p>
				</div>
				<div class='information'>어느 날 전세계의 상공에서 울려 퍼지는 정체불명의 소리!
				 이 소리를 듣는 순간, 기억이 사라져버리는 불가사의한 일들이 연달아 발생한다.
				  라디오 방송국에서 일하는 애니는 이 모든 사건이 지구를 노리는 외계 종족의 계략이라는 제보를 듣고 수사에 착수한다.</div>
			  </div>	
			  <div class='myslides 1' >
					<div class='title' style='background-color:#343a40'>최고의 우주 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20179281.jpg'></img>
					<p id='mv_name'><a href='#'>컨택트</a></p>
				</div>
				<div class='information'>12개의 외계 비행 물체(쉘)가 미국, 중국, 러시아를 비롯한 세계 각지 상공에 등장했다.
 웨버 대령(포레스트 휘태커)은 언어학 전문가 루이스 뱅크스 박사(에이미 아담스)와 과학자 이안 도넬리(제레미 레너)를 통해 외계 비행 물체(쉘) 접촉하기 시작한다.
 두 사람은 18시간마다 아래쪽에서 문이 열리는 외계 비행 물체(쉘) 내부로 진입해 정체 모를 생명체와 마주하게 되고, 이들은 15시간 내 그들이 지구에 온 이유를 밝혀내야 하는데...</div>
			  </div>  
			  
			  <div id='button_div'>
				<button id='left_button' class='right_left_button' onclick="plusDivs(-1)">◀</button>
				<button id='right_button' class='right_left_button' onclick="plusDivs(+1)">▶</button>
			  </div>
			</div>
			<!--  number one end -->
			
			
			<!--  number two start -->
			<div class='slidewrap'>	
			
			  <div class='myslides 2' >
				<div class='title' style='background-color:red'>화끈한 액션 스릴러 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20196655.jpg'></img>
					<p id='mv_name'><a href='#'>존윅3 : 파라벨룸</a></p>
				</div>
				<div class='information'>전설이라 불리던 킬러 ‘존 윅’
				 은퇴한 그를 암살자의 세계로 누군가가 끌어당기고,
				 더 이상 잃을 것 없는 그는 복수와 동시에 함정에 빠지게 된다.
				 킬러에서 암살자의 표적이 된 그,
				 오직 평화를 위한 전쟁을 다시 한번 시작하게 된다.
				 전설의 시작, 역대 최강 액션을 만나라!</div>
				
			  </div>
			  <div class='myslides 2' >
					<div class='title' style='background-color:red'>화끈한 액션 스릴러 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20156564.jpg'></img>
					<p id='mv_name'><a href='#'>부산행</a></p>
				</div>
				<div class='information'>정체불명의 바이러스가 전국으로 확산되고 대한민국 긴급재난경보령이 선포된 가운데,
 열차에 몸을 실은 사람들은 단 하나의 안전한 도시 부산까지
 살아가기 위한 치열한 사투를 벌이게 된다.
 서울에서 부산까지의 거리 442KM
 지키고 싶은, 지켜야만 하는 사람들의 극한의 사투!</div>
			  </div>
			  <div class='myslides 2' >
					<div class='title' style='background-color:red'>화끈한 액션 스릴러 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20193450.jpg'></img>
					<p id='mv_name'><a href='#'>반도</a></p>
				</div>
				<div class='information'>4년 전, 나라 전체를 휩쓸어버린 전대미문의 재난에서 가까스로 탈출했던 ‘정석’(강동원).
 바깥세상으로부터 철저히 고립된 반도에 다시 들어가야 하는 피할 수 없는 제안을 받는다.
 제한 시간 내에 지정된 트럭을 확보해 반도를 빠져 나와야 하는 미션을 수행하던 중
 인간성을 상실한 631부대와 4년 전보다 더욱 거세진 대규모 좀비 무리가 정석 일행을 습격한다.
 절체절명의 순간,
 폐허가 된 땅에서 살아남은 ‘민정’(이정현) 가족의 도움으로 위기를 가까스로 모면하고
 이들과 함께 반도를 탈출할 수 있는 마지막 기회를 잡기로 한다.
 되돌아온 자, 살아남은 자 그리고 미쳐버린 자
 필사의 사투가 시작된다!</div>
			  </div>
			  <div class='myslides 2' >
					<div class='title' style='background-color:red'>화끈한 액션 스릴러 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20190864.jpg'></img>
					<p id='mv_name'><a href='#'>울프 콜</a></p>
				</div>
				<div class='information'>대통령 명령으로 적진에 핵 미사일 발사를 준비하는 ‘무적함’(SSBN)과
 이를 호위하는 핵 추진 공격 잠수함 ‘티탄함’(SSN)
 하지만 음파 탐지(SONAR)를 통해 적의 충격적인 비밀을 알아차린 해군은
 핵 미사일 발사 10초를 남기고 사상 최악의 핵 전쟁을 막기 위해 사투를 벌이는데…</div>
			  </div>
			  <div class='myslides 2' >
					<div class='title' style='background-color:red'>화끈한 액션 스릴러 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20154909.jpg'></img>
					<p id='mv_name'><a href='#'>살인자의 기억법</a></p>
				</div>
				<div class='information'>예전에는 연쇄살인범이었지만 지금은 알츠하이머에 걸린 병수.
 우연히 접촉사고로 만나게 된 남자 태주에게서 자신과 같은 눈빛을 발견하고 그 역시 살인자임을 직감한다.
 병수는 경찰에 그를 연쇄살인범으로 신고하지만 태주가 그 경찰이었고, 아무도 병수의 말을 믿지 않는다.
 태주는 은희 곁을 맴돌며 계속 병수의 주변을 떠나지 않고,
 병수는 혼자 태주를 잡기 위해 필사적으로 기록하고 쫓지만 기억은 자꾸 끊기고,
 오히려 살인 습관들이 되살아나며 병수는 망상과 실제 사이에서 혼란스러워진다.</div>
			  </div>	  
			  
			  <div id='button_div'>
				<button id='left_button' class='right_left_button' onclick="plusDivs_2(-1)">◀</button>
				<button id='right_button' class='right_left_button' onclick="plusDivs_2(+1)">▶</button>
			  </div>
			</div>
			<!--  number two end -->
			
			
			<!--  number three start -->
			<div class='slidewrap'>	
			
			  <div class='myslides 3' >
				<div class='title'>꼭 봐야할 전쟁 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20030371.jpg'></img>
					<p id='mv_name'><a href='#'>태극기 휘날리며</a></p>
				</div>
				<div class='information'>평온한 일상에서 피 튀기는 전쟁터로 내 몰린 ‘진태’와 ‘진석’은 훈련받을 시간조차 없이 국군 최후의 보루인 낙동강 방어선으로 실전 투입이 되고 
				동생과 같은 소대에 배치된 ‘진태’는 동생의 징집해제를 위해 대대장을 만나게 된다. 
				대대장과의 면담을 통해 동생의 제대를 위해 자신이 해야 할 최선의 것이 무엇인지를 느끼게 된 ‘진태’는 그 무엇보다 동생의 생존을 위해 총을 들며 영웅이 되기를 자처하는데.. 
				‘진태’의 혁혁한 전과로 낙동강 방어선을 지키는데 성공한 국군은 인천상륙작전이 성공했다는 소식을 듣고 드디어 북진을 시작한다.
  애국 이념도 민주 사상도 없이 오직, 동생의 생존을 위한다는 이유 하나로 전쟁영웅이 되어가고 있는 ‘진태’와 전쟁을 통해 
  스스로 강해져야만 살아남을 수 있다는 것을 깨달은 ‘진석’은 수많은 전투에서 승리를 거두며 승승장구 평양으로 향하는데, 생각지도 못했던 운명의 덫이 그들 형제를 기다리고 있었다.</div>
				
			  </div>
			  <div class='myslides 3' >
					<div class='title'>꼭 봐야할 전쟁 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20100296.jpg'></img>
					<p id='mv_name'><a href='#'>포화속으로</a></p>
				</div>
				<div class='information'>1950년 6월 25일 새벽 4시. 아무도 예상하지 못했던 한국 전쟁이 시작된다. 압도적인 화력으로 무장한 북한군은 파죽지세로 남쪽으로 진격을 거듭하고, 
				남한군의 패색은 짙어져만 간다. 전 세계가 제 3차대전의 공포에 휩싸이자 UN은 엄청난 수의 연합군을 대한민국에 파병할 것을 결정한다. 
 포항을 지키던 강석대(김승우)의 부대는 낙동강을 사수하기 위해 집결하라는 명령을 받는다. 
 하지만 이제 전선의 최전방이 되어버린 포항을 비워둘 수는 없는 상황. 
 강석대는 유일하게 전투에 따라가 본 적이 있다는 이유로 장범(T.O.P.)이 중대장으로 임명되지만, 
 소년원에 끌려가는 대신 전쟁터에 자원한 갑조(권상우) 무리는 대놓고 장범을 무시한다.
  총알 한 발씩을 쏴보는 것으로 사격 훈련을 마친 71명의 소년들은 피난민도 군인들도 모두 떠난 텅 빈 포항에서 앞으로 어떤 일이 벌어질 지 모른 채 석대의 부대가 다시 돌아오기만을 기다린다.</div>
			  </div>
			  <div class='myslides 3' >
					<div class='title'>꼭 봐야할 전쟁 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20119515.jpg'></img>
					<p id='mv_name'><a href='#'>고지전</a></p>
				</div>
				<div class='information'> 1953년 2월, 휴전협상이 난항을 거듭하는 가운데 교착전이 한창인 동부전선 최전방 애록고지에서 전사한 중대장의 시신에서 아군의 총알이 발견된다. 상부에서는 이번 사건을 적과의 내통과 관련되어 있음을 의심하고 방첩대 중위 ‘강은표’(신하균)에게 동부전선으로 가 조사하라는 임무를 내린다. 애록고지로 향한 은표는 그 곳에서 죽은 줄 알았던 친구 ‘김수혁’(고수)을 만나게 된다. 유약한 학생이었던 ‘수혁’은 2년 사이에 이등병에서 중위로 특진해 악어중대의 실질적 리더가 되어 있고, 그가 함께하는 악어중대는 명성과 달리 춥다고 북한 군복을 덧입는 모습을 보이고 갓 스무살이 된 어린 청년이 대위로 부대를 이끄는 등 뭔가 미심쩍다. 살아 돌아온 친구, 의심스러운 악어중대. 이 모든 것이 혼란스러운 가운데 은표는 오직 병사들의 목숨으로만 지켜낼 수 있는 최후의 격전지 애록고지의 실체와 마주하게 되는데…</div>
			  </div>
			  <div class='myslides 3' >
					<div class='title'>꼭 봐야할 전쟁 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20196272.jpg'></img>
					<p id='mv_name'><a href='#'>미드웨이</a></p>
				</div>
				<div class='information'>1941년 진주만 공습 이후,
 전 세계를 향한 일본의 야욕이 거세지고,
 역사상 최대 규모의 미국 본토 공격을 계획한다.
 미군은 진주만 다음 일본의 공격 목표가 어디인지 암호를 해독하기 위해 애쓰고,
 동시에 긴박하게 전열을 정비해 나간다.
 가까스로 두 번째 타겟이 ‘미드웨이’라는 것을 알아낸 미국은
 반격을 준비하지만, 절대적으로 불리한 상황이다.
 전 세계의 역사를 바꾼 위대한 전투의 이야기가 지금부터 시작된다!</div>
			  </div>	
			  <div class='myslides 3' >
					<div class='title'>꼭 봐야할 전쟁 영화</div>
				<div class='mv_img_box'>
					<img id='mv_img' src='${pageContext.request.contextPath}/resources/images/20168608.jpg'></img>
					<p id='mv_name'><a href='#'>익스트랙션</a></p>
				</div>
				<div class='information'>세계에서 가장 위험한 도시로 납치된 의뢰인의 아들을 구하기 위해
 전직 특수부대 출신 용병이 거대 범죄 조직에 맞서 벌이는 리얼 액션 구출극</div>
			  </div>  
			  
			  <div id='button_div'>
				<button id='left_button' class='right_left_button' onclick="plusDivs_3(-1)">◀</button>
				<button id='right_button' class='right_left_button' onclick="plusDivs_3(+1)">▶</button>
			  </div>
			</div>
			<!--  number three end -->
			
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
	var slideIndex = 1;
	var slideIndex_2 = 1;
	var slideIndex_3 = 1;
	


	showDivs(slideIndex);
	showDivs_2(slideIndex_2);
	showDivs_3(slideIndex_3);

	function plusDivs(n) {
	    showDivs(slideIndex += n);
	}

	function showDivs(n) {
	    var i;
	    var x = document.getElementsByClassName("mySlides 1");
	    if (n > x.length) {slideIndex = 1}
	    if (n < 1) {slideIndex = x.length} ;
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none";
	    }
	    x[slideIndex-1].style.display = "block";
	}
	
	
	function plusDivs_2(n) {
	    showDivs_2(slideIndex_2 += n);
	}

	function showDivs_2(n) {
	    var i;
	    var x = document.getElementsByClassName("mySlides 2");
	    if (n > x.length) {slideIndex_2 = 1}
	    if (n < 1) {slideIndex_2 = x.length} ;
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none";
	    }
	    x[slideIndex_2-1].style.display = "block";
	}
	
	function plusDivs_3(n) {
	    showDivs_3(slideIndex_3 += n);
	}

	function showDivs_3(n) {
	    var i;
	    var x = document.getElementsByClassName("mySlides 3");
	    if (n > x.length) {slideIndex_3 = 1}
	    if (n < 1) {slideIndex_3 = x.length} ;
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none";
	    }
	    x[slideIndex_3-1].style.display = "block";
	}
	</script>
	</body>
	
</html>