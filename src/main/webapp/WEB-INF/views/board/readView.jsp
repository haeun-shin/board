<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<html>
<head>
	<link rel="stylesheet" href="${contextPath }/resources/css/reset.css" />
	<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css" />
 	<link rel="stylesheet" href="${contextPath }/resources/css/style.css" /> 
 	<meta name="viewport" content="width=1200, initial-scale=1, shrink-to-fit=no">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 	<title>게시판</title>
</head>

<script type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form[name='readForm']");
		
		// 수정 
		$(".update_btn").on("click", function(){
			formObj.attr("action", "/board/updateView");
			formObj.attr("method", "get");
			formObj.submit();				
		});
		
		// 삭제
		$(".delete_btn").on("click", function(){
			var deleteYN = confirm("삭제하시겠습니까?");
			
			if(deleteYN == true) {
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
		});
		
		// 목록
		$(".list_btn").on("click", function(){
			location.href = "/board/list?page=${scri.page}"
							+"&perPageNum=${scri.perPageNum}"
							+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
		});
		
		// 댓글 작성 값들이 replyWrite로 전달되게끔 하는 함수
		$(".replyWriteBtn").on("click", function(){
			  var formObj = $("form[name='replyForm']");
			  formObj.attr("action", "/board/replyWrite");
			  formObj.submit();
		});
		
		// 댓글 수정 View
		$(".replyUpdateBtn").on("click", function() {
			location.href = "/board/replyUpdateView?bno=${read.bno}"
							+"&page=${scri.page}"
							+"&perPageNum=${scri.perPageNum}"
							+"&searchType=${scri.searchType}"
							+"&keyword=${scri.keyword}"
							+"&rno="+$(this).attr("data-rno");
		});
		
		// 댓글 삭제 View
		$(".replyDeleteBtn").on("click", function() {
			location.href = "/board/replyDeleteView?bno=${read.bno}"
							+"&page=${scri.page}"
							+"&perPageNum=${scri.perPageNum}"
							+"&searchType=${scri.searchType}"
							+"&keyword=${scri.keyword}"
							+"&rno="+$(this).attr("data-rno");
		});
		
	})
	
	// 파일 다운
	function fn_fileDown(fileNo){
		var formObj = $("form[name='readForm']");
		
		$("#FILE_NO").attr("value", fileNo);
		
		formObj.attr("action", "/board/fileDown");
		formObj.submit();
	}
</script>
<% 
	/* 글 내용 줄바꿈 처리하기 위해 필요 */
	/* Space, Enter */
	pageContext.setAttribute("replaceChar", "\r\n");
	/* br태그 */
	pageContext.setAttribute("br", "<br/>");
%>
<body>
	<%-- 네비게이션바 --%>
	<%@include file="../include/nav.jsp" %>
	<div class="mb-4"></div>
	<section class="container border pb-3">
		
		<form name="readForm" role="form" method="post">
			<input type="hidden" id="bno" name="bno" value="${read.bno}"/>
			<input type="hidden" id="page" name="page" value="${scri.page}"> 
			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
			<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
			<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
			<input type="hidden" id="FILE_NO" name="FILE_NO" value="">
		</form>
		
		<!-- 본문 내용 START -->
			<%-- 제목 --%>
			<h2 class="mt-3">${read.title}</h2>
			<%-- 작성자, 작성일 --%>
			<p class="h6 ml-1">
				<strong>글쓴이</strong>  ${read.writer}   
				<span class="font-weight-light text-secondary"><fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd hh:mm:ss" /></span>
			</p>
			
			<hr>
			
			<%-- 내용 : 개행문자를 br태그로 변경하여 출력 --%>
			<p class="text-justify  ml-1">${fn:replace(read.content, replaceChar, br )}</p>
			
			<%-- 수정, 삭제, 목록 버튼 모음 --%>
			<div class="float-right mb-3">
				<%-- 글 작성자와 로그인 아이디가 같을 경우에만 글 수정 가능 --%>
				<c:if test="${read.writer == member.userId }" >
					<button type="button" class="update_btn btn btn-outline-success">수정</button>
					<button type="button" class="delete_btn btn btn-outline-secondary">삭제</button>
				</c:if>
				<button type="button" class="list_btn btn btn-outline-primary">목록</button>	
			</div>
		<!-- 본문내용 END -->
		
		<div  style="clear:both"></div>
		
		<!-- 첨부파일 START -->
			<%-- 첨부파일이 존재할 경우에만 파일목록 보임 --%>
			<c:if test="${not empty file}">
				<hr>
				<span class="badge badge-primary">
				  파일 목록 <span class="badge badge-light">${file.size() }</span>
				</span>
			</c:if>
			<div>
				<c:forEach var="file" items="${file }">
					<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME }</a>
					(${file.FILE_SIZE }kb)<br>
				</c:forEach>
			</div>
		<!-- 첨부파일 END -->
		
		
		<!-- 댓글 START-->
		<div class="bg-light" >
			
			<!-- 댓글 목록 START -->
			<div id="reply">
				<ul class="replyList list-group list-group-flush p-3 mt-5">
					<c:forEach items="${replyList }" var="replyList">
						<li class="list-group-item" style="background-color:transparent;">
							<%-- 댓글 작성자, 작성일 --%>
							<span class="font-weight-bold pr-2">${replyList.writer }</span>
							<span class="text-black-50" style="font-size:0.8em;"><fmt:formatDate value="${replyList.regdate }" pattern="yyyy-MM-dd" /></span>
							<%-- 수정 삭제 버튼 : 작성자와 로그인 아이디가 일치할 경우 생성--%>
							<c:if test="${replyList.writer == member.userId }">
							<span>
								<button type="button" class="replyUpdateBtn btn btn-success btn-sm" data-rno="${replyList.rno }">수정</button>
								<button type="button" class="replyDeleteBtn btn btn-secondary btn-sm" data-rno="${replyList.rno }">삭제</button>
							</span>
							</c:if>
							<%-- 댓글 내용 : 개행문자를 br태그로 변경하여 출력 --%>
							<p class="text-justify">${fn:replace(replyList.content, replaceChar, br )}</p>
						</li>						
					</c:forEach>
				</ul>
			</div>
			<!-- 댓글 목록 END -->
			
			<!-- 댓글 작성 폼 START -->
			<form name="replyForm" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno}" />
				<input type="hidden" id="page" name="page" value="${scri.page}"> 
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				<input type="hidden" id="writer" name="writer" value="${member.userId }">
				
				<div class="p-4">
				<c:choose>
					<c:when test="${not empty member.userId }">
						<div class="form-group shadow-sm p-3 bg-white rounded">
							<textarea placeholder="댓글을 입력하세요." id="content" name="content" class="form-control" style="border:none;resize: none;" maxlength="333" ></textarea>
							<button type="button" class="replyWriteBtn btn btn-primary ml-auto">작성</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-secondary" role="alert">
						 로그인 후 댓글을 작성할 수 있습니다.
						</div>
					</c:otherwise>
				</c:choose>
				</div>
			</form>
			<!-- 댓글 작성 폼 END -->
		</div>		
		<!-- 댓글 END -->
	</section>
	<hr />
</body>
</html>