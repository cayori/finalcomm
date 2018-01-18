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
						<td width="80%">
							<table width="100%" class="board_view">
								<colgroup>
									<col width="15%"/>
									<col width="35%"/>
									<col width="15%"/>
									<col width="35%"/>
								</colgroup>
								<caption>게시글 상세</caption>
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
										<th scope="row">제목</th>
										<td colspan="3">${map.SUBJECT }</td>
									</tr>
									<tr>
										<td colspan="4">${map.CONTENT }</td>
									</tr>
									<tr>
										<th scope="row">첨부파일</th>
										<td colspan="3">				
											<c:forEach var="row" items="${list }">
												<p>
													<input type="hidden" id="IDX" value="${row.IDX }">
													<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> 
													(${row.FILE_SIZE }kb)
												</p>
											</c:forEach>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
						<td width="10%"></td>
					</tr>
				</table>
			</td>
			<td width="80">
		</tr>
	</table>
	
	<br/>
	
	
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
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
	</script>
</body>
</html>