<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath }/resources/css/style.css" /> 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원정보 수정</title>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 취소
		$(".cancel").on("click", function() {
			location.href="/";
		});
		
		// 벨리데이션 체크
		$("#submit").on("click", function() {
			if($("#userPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				
				return false;
			}
			if($("#userName").val() == "") {
				alert("이름을 입력해주세요.");
				$("#userName").focus();
				
				return false;
			}
			
		});
		
		
		
	}); // 스크립트 끝
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<%@include file="../board/nav.jsp" %>
	
		<form action="/member/memberUpdate" method="post" id="updateForm" style="width:600px; margin:30px auto;">
		<div class="card" >
			<h5 class="card-header">회원수정</h5>
			
			<div class="card-body">
				<div class="form-group">
					<label for="userId">아이디</label>
					<input type="text" id="userId" name="userId" value="${member.userId }" readonly="readonly"  class="form-control"/>
				</div>
				<div class="form-group">
					<label for="userPass">패스워드</label>
					<input type="password" id="userPass" name="userPass"  class="form-control"/>
				</div>
				<div class="form-group">
					<label for="userName">이름</label>
					<input type="text" id="userName" name="userName" value="${member.userName }"  class="form-control"/>
				</div>
				<div class="form-group mt-6">
					<button type="submit" id="submit" class="btn btn-primary">회원정보 수정</button>
					<button type="button" class="cancel btn btn-secondary">취소</button>
				</div>
			</div>
		</div>
		</form>
</body>
</html>