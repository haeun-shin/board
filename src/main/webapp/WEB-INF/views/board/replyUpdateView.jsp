<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="${contextPath }/resources/css/reset.css" />
	<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css" />
 	<link rel="stylesheet" href="${contextPath }/resources/css/style.css" /> 
 	<meta name="viewport" content="width=1200, initial-scale=1, shrink-to-fit=no">
 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<title>게시판</title>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(".cancel_btn").on("click", function(){
				location.href = "/board/readView?bno=${replyUpdate.bno}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
			
		})
	</script>
</head>
<body>
<%-- 네비게이션 바 --%>
<%@include file="nav.jsp" %>

<div class="mb-4"></div>

<section class="container bg-light p-5" style="overflow:hidden;">
	<form name="updateForm" role="form" method="post" action="/board/replyUpdate">
		<input type="hidden" name="bno" value="${replyUpdate.bno}" readonly="readonly"/>
		<input type="hidden" id="rno" name="rno" value="${replyUpdate.rno}" />
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		
		<div class="form-group shadow-sm p-3 bg-white rounded">
			<textarea placeholder="댓글을 입력하세요." id="content" name="content" class="form-control" style="resize: none;" maxlength="333" rows="6"><c:out value="${replyUpdate.content}" /></textarea>
			<button type="submit" class="update_btn btn btn-primary">수정</button>
			<button type="button" class="cancel_btn btn btn-outline-secondary">취소</button>
		</div>
		
	</form>
</section>
</body>
</html>