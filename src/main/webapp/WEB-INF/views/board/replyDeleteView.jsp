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
				location.href = "/board/readView?bno=${replyDelete.bno}"
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
		
<section class="container">
	<form name="updateForm" role="form" method="post" action="/board/replyDelete">
		<input type="hidden" name="bno" value="${replyDelete.bno}" readonly="readonly"/>
		<input type="hidden" id="rno" name="rno" value="${replyDelete.rno}" />
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		
		<div class="alert alert-danger" role="alert">
			<p>댓글을 삭제 하시겠습니까?</p>
			<button type="submit" class="delete_btn btn btn-danger">예 삭제합니다.</button>
			<button type="button" class="cancel_btn btn btn-secondary">아니오. 삭제하지 않습니다.</button>
		</div>
	</form>
</section>
</body>
</html>