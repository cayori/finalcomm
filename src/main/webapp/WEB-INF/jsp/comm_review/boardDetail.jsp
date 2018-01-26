<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<script type="text/javascript" src="/finalcomm/js/ajax.js"></script>
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
										<a href="#comment_input" class="btn" >댓글작성</a>
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
							<form action="" name="addCommentForm"></form>
								<table width="100%">
									<tr>
										<td width="100%" align="center" colspan="3">
											<div id="COMMENT_NAVI2" align="center"></div>
											<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
											<input type="hidden" id="ARTICLEID" name="ARTICLEID" value="${map.IDX }" />
										</td>
									</tr>
									<tr>
										<td colspan="2">
											 <textarea name="comment_input" id="comment_input" rows="5" cols="60" class="comment_input"></textarea>
	
										</td>
										<td class="common_input_btn_text">
											<a href="javascript:fn_commentAdd('작성자', 'comment_input', ${map.IDX}, -1, -1, -1)" id="cwrite" name="cwrite">등록</a>
											<!--  fn_commentAdd(작성자, 글내용ID값, 글IDX, 부모REF, 부모RE_STEP, 부모RE_LEVEL) -->
										</td>
									</tr>
								</table>
							</form>
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
			
		});
		
		function fn_commentAdd(writer, contentid, articleid, p_ref, p_re_step, p_re_level){
			// checkup data start
			console.log(writer, contentid, articleid, p_ref, p_re_step, p_re_level);
			// checkup data end
			var content = $("#"+contentid).val();
			var ref = p_ref ? p_ref : -1;
			var re_step = (p_re_step >= 0) ? p_re_step*1+1 : 0;
			var re_level = (p_re_level >= 0) ? p_re_level*1+1 : 0;
			
			var params = "WRITER="+encodeURIComponent(writer)+"&"+
			             "CONTENT="+encodeURIComponent(content)+"&"+
			             "ARTICLEID="+articleid+"&"+
			             "REF="+ref+"&"+
			             "RE_STEP="+re_step+"&"+
			             "RE_LEVEL="+re_level;
			console.log(params);
			new ajax.xhr.Request('commentAdd.do', params, addResult, 'POST', false);
		}
		function addResult(req) {
			if (req.readyState == 4 && req.status == 200) {
				alert("등록했습니다!");
				fn_selectCommentList($("#PAGE_INDEX"));
				self.location.hash='cBlockTitle';
			}
			console.log('checkup');
		}
		
		function fn_commentDelete(cidx){
			// 글 작성자와 세션아이디가 동일한지 체크할것
			var params = "IDX="+cidx;
			console.log(cidx);
			console.log(params);
			new ajax.xhr.Request('commentDelete.do', params, cDeleteResult, 'POST');
		}
		
		function cDeleteResult(req) {
			if (req.readyState == 4 && req.status == 200) {
				alert("삭제했습니다");
				fn_selectCommentList($("#PAGE_INDEX"));
			}
			console.log('deleteCheckup');
		}
		
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
			comAjax.addParam("PAGE_ROW", 15);		// PAGE_ROW 하고, 20여줄 밑에 recordCount 하고는 값을 맞춰줘야 한다.
			comAjax.ajax();
		}
		
		function fn_selectCommentListCallback(data){ // 받은 json 으로 댓글 쇼잉 처리
			var total = data.TOTAL;
			var body = $(".comment_list>tbody");
			body.empty();
			
			$("#cBlockTitle").empty();
			$("#cBlockTitle").append("<strong>댓글 ("+total+")</strong>");		// 댓글 카테고리 제목란 입력해주기
 
			
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4' align='center'>조회된 댓글이 없습니다.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "COMMENT_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectCommentList",
					recordCount : 15
				};
				gfn_renderPaging(params);
				params.divId = "COMMENT_NAVI2";
				gfn_renderPaging(params);
				
				var str = "";
				var imgaddr = '';
								
				$.each(data.list, function(key, value){
					imgaddr = value.MEMBER_IMG;
					var relevel = value.RE_LEVEL;
					str +=	"<tr>" + 
								"<td rowspan='2' width='65' align='center'>" +
									"<img src="+ imgaddr +" width='60' height='60'>" +
								"</td>" + 
								"<td colspan='2' height='20' class='title' style='padding:1px;'>" +
									value.IDX + "&nbsp;&nbsp;||&nbsp;&nbsp;" + value.WRITER + "&nbsp;&nbsp;||&nbsp;&nbsp;" + value.WRITEDATE +
								"</td>" +
							"</tr>" +
							"<tr>";
					
					if(value.RE_LEVEL > 0){		
						str +=	"<td colspan='2'>" +
								"<table width='100%'>" +
									"<tr>" +
										"<td width='"+18*relevel+"' style='padding:0 0 0 0;vertical-align:top;'>";
											while(relevel--){
												str +=	"<img src='/finalcomm/img/comment.gif' width='15'>";
											}
						str +=			"</td>";
					}
					
					str +=		"<td colspan='2'>" +
									// checkup data start
									// value.REF+" || "+value.RE_STEP+" || "+value.RE_LEVEL+"<br/>" +
									// checkup data end
									value.CONTENT + "&nbsp;&nbsp;" +
									"<a href='javascript:toggleReplyForm("+value.IDX+");'><img src='/finalcomm/img/comment.gif' width='20'>[답글달기]</a>" + "&nbsp;" +
									"<br/><a href='javascript:fn_commentDelete("+value.IDX+")' id='cdelete'><img src='/finalcomm/img/delete.jpg' width='50'>" +
									"<input type='hidden' id='cidx' value="+value.IDX+">" +
								"</td>";													
							
					if(value.RE_LEVEL > 0){			
						str +=		"</tr>" +
								"</table>" +
								"</td>";
					}
								
						str +=	"</tr>" +
								"<tr id='"+value.IDX+"commentReply' style='display:none;'>" +
									"<td colspan='3'>" +
										"<table width='100%'>" +
											"<tr>" +
												"<td colspan='2'>" +
													 "<textarea type='text' name='"+value.IDX+"comment_input' id='"+value.IDX+"comment_input' rows='5' cols='60' value='' class='comment_input'></textarea>" +
												"</td>" +
												"<td class='common_input_btn_text'>" +
													"<a href='javascript:fn_commentAdd(\"작성자\",\""+value.IDX+"comment_input\","+${map.IDX}+","+value.REF+","+value.RE_STEP+","+value.RE_LEVEL+")' name='creply' id='creply'>등록</a>" +
													// fn_commentAdd(작성자, 글내용ID값, 글IDX, 부모REF, 부모RE_STEP, 부모RE_LEVEL)
												"</td>" +
											"</tr>" +
										"</table>" +
									"</td>" +
								"</tr>";
				});
				body.append(str);
			}
			
				$("a[name='title']").on("click", function(e){     //제목을 클릭하면 상세보기 함수 호출
					e.preventDefault();
					fn_openBoardDetail($(this));
				});
				
			}


		function toggleReplyForm(cidx) {
			var commentReplyDiv = document.getElementById(cidx+'commentReply');
			if(commentReplyDiv.style.display == ''){
				commentReplyDiv.style.display = 'none';
			}else{
				commentReplyDiv.style.display = '';
				focus
			}
		}


	</script>
</body>
</html>