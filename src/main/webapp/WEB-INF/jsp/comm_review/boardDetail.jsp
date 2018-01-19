<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<table>
		<!-- 상단 50, 우측 80 비우기 -->
		<tr><td height="50"/></tr>
		<tr>
			<td style="padding-left:100px"><h2>여행 후기</h2></td>
		</tr>
	</table>
	<table width="100%" border="0">
		<tr>
			<td>
				<table width="100%" border="0">
					<tr>
						<td width="10%"></td>
						<td width="80%" align="center">
							<table width="100%" class="board_view">
								<colgroup>
									<col width="15%"/>
									<col width="35%"/>
									<col width="15%"/>
									<col width="35%"/>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">글 번호</th>
										<td>${map.IDX }</td>
										<th scope="row">조회수</th>
										<td>${map.HITCOUNT }</td>
									</tr>
									<tr>
										<th scope="row">작성자</th>
										<td>${map.WRITER }</td>
										<th scope="row">작성시간</th>
										<td>${map.WRITEDATE }</td>
									</tr>
									<tr>
										<th scope="row" rowspan="2">제목</th>
										<td colspan="3">${map.SUBJECT }</td>
									</tr>
									<tr>
										<td colspan="3" style="color:#abacad; font-size:0.5em;">태그: ${map.TAG }</td>
									</tr>
									<tr>
										<td colspan="4">${map.CONTENT }</td>
									</tr>
									
								</tbody>
							</table>
							<br />
							<a href="#this" class="btn" id="list">목록으로</a>
							<a href="#this"	class="btn" id="update">수정하기</a>
							<br /><br /><br /><br />
						</td>
						<td width="10%"></td>
					</tr>
					<tr>
						<td width="10%"></td>
						<td>
							<!-- 댓글파트 시작 -->
							<table width="100%" class="board_view">
								<tr>
									<td width="15%" id="cBlockTitle" style="font-size:1.2em;">
										<!-- 숫자 넣어야 해서 스크립트로 여기 넣어줌 -->
										<!-- 
										<strong>댓글 ( ${map.TOTAL_COUNT } )</strong>
										 -->
									</td>
									<td width="70%" align="center">
										<div id="COMMENT_NAVI" align="center"></div>
										<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
										<input type="hidden" id="ARTICLEID" name="ARTICLEID" value="${map.IDX }" />
									</td>
									<td width="15%" align="right">
										<a href="#this" class="btn" id="cwrite">댓글작성하기</a>
									</td>
								</tr>
							</table>
							<table width="100%" class="board_view comment_list" style="border-top:0px black solid;">
								<colgroup>
									<col width="15%">
									<col width="70%">
									<col width="15%">
								</colgroup>
								<tbody>
									
								</tbody>
							</table>
							<table width="100%">
								<tr>
									<td colspan="2">
										 <textarea type="text" name="comment_input" id="comment_input" rows="5" cols="60" value="" class="comment_input"></textarea>

									</td>
									<td class="common_input_btn_text">
										<a href="#this" id="cwrite">등록</a>
									</td>
								</tr>
							</table>
							<!-- 댓글파트 종료 -->
						</td>
						<td width="10%"></td>
					</tr>
				</table>
			</td>
			<td width="80"></td>
		</tr>
	</table>
	
	<br/>
	
	
	
	
	
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			fn_selectCommentList(1);
			
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#update").on("click", function(e){ //수정하기 버튼
				e.preventDefault();
				fn_openBoardUpdate();
			});
			
			$("a[name='file']").on("click", function(e){ //파일 이름
				e.preventDefault();
				fn_downloadFile($(this));
			});
			
			$("#cwrite").on("click", function(e){ //댓글쓰기 버튼
				e.preventDefault();
				fn_openBoardWrite();
			});	
			
			$("a[name='reply']").on("click", function(e){ // 대댓글 쓰기 버튼
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/comm/review/openBoardList.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardUpdate(){
			var idx = "${map.IDX}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/comm/review/openBoardUpdate.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
		
		function fn_downloadFile(obj){
			var idx = obj.parent().find("#IDX").val();
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/comm/review/downloadFile.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
		
		function fn_selectCommentList(pageNo){ //댓글리스트 json 으로 요청
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/comm/review/selectCommentList.do' />");
			comAjax.setCallback("fn_selectCommentListCallback");
			comAjax.addParam("PAGE_INDEX",$("#PAGE_INDEX").val());
			comAjax.addParam("ARTICLEID",$("#ARTICLEID").val());
			comAjax.addParam("PAGE_ROW", 15);
			comAjax.ajax();
		}
		
		function fn_selectCommentListCallback(data){ // 받은 json 으로 댓글 쇼잉 처리
			var total = data.TOTAL;
			var body = $(".comment_list>tbody");
			//body.empty();
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4'>조회된 결과가 없습니다.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "COMMENT_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectCommentList",
					recordCount : 1
				};
				gfn_renderPaging(params);
				
				var str = "";
				var imgaddr = '';
								
				$.each(data.list, function(key, value){
					if(!$.trim(value.FILENAME) ){
						imgaddr = value.MEMBER_IMG;
					}else{
						imgaddr = value.FILENAME;
					}
					str +=	"<tr>" + 
								"<td rowspan='3' width='110'>" +
								"<a href='#this' name='title'><img src="+ imgaddr +" width='100' height='100'></a>" +
								"<input type='hidden' id='IDX' value=" + value.IDX + ">" + 
									"</td>" + 
								"<td height='20' class='title' style='padding:5px;'>" +
									value.IDX + "&nbsp;||&nbsp;&nbsp;" +
									"<a href='#this' name='title'><STRONG>" + value.SUBJECT + "</STRONG></a>" +
									"<input type='hidden' id='IDX' value=" + value.IDX + ">" + 
								"</td>" +
								"<td width='30%' height='20' style='padding:5px;'>" + value.WRITEDATE + "&nbsp;||&nbsp;" + value.WRITER + "</td>" +
							"</tr>" +
							"<tr>" +
								"<td colspan='2' style='color:#cccdce;'>" + value.CONTENT + "......</td>" +
							"</tr>" +
							"<tr>" +
								"<td height='10' colspan='2' style='padding:0px;'>" + value.TAG + "</td>" +
							"</tr>";
				});
				body.append(str);
				
				$("a[name='title']").on("click", function(e){     //제목을 클릭하면 상세보기 함수 호출
					e.preventDefault();
					fn_openBoardDetail($(this));
				});
			}
		}
	</script>
</body>
</html>