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
							<table class="board_list">
								<tbody>
									
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
	
	<div id="PAGE_NAVI" align="center"></div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
	
	<br/>
	<a href="#this" class="btn" id="write">글쓰기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			fn_selectBoardList(1);
			
			$("#write").on("click", function(e){ //글쓰기 버튼
				e.preventDefault();
				fn_openBoardWrite();
			});	
			
			$("a[name='title']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		
		
		function fn_openBoardWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/comm/review/openBoardWrite.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/comm/review/openBoardDetail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		
		function fn_selectBoardList(pageNo){
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/comm/review/selectBoardList.do' />");
			comAjax.setCallback("fn_selectBoardListCallback");
			comAjax.addParam("PAGE_INDEX",$("#PAGE_INDEX").val());
			comAjax.addParam("PAGE_ROW", 10);
			comAjax.addParam("IDX_FE", $("#IDX_FE").val());
			comAjax.ajax();
		}
		
		function fn_selectBoardListCallback(data){
			var total = data.TOTAL;
			var body = $(".board_list>tbody");
			body.empty();
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4'>조회된 결과가 없습니다.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectBoardList",
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