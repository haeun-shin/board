<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fnt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath }/resources/css/style.css" /> 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Home</title>
<script type="text/javascript">
	$(document).ready(function() {
		// 로그아웃
		$("#logoutBtn").on("click", function() {
			location.href="member/logout";
		});
		
		// 회원가입
		$("#registerBtn").on("click", function() {
			location.href="member/register";
		});
		
		// 회원정보 수정
		$("#memberUpdateBtn").on("click", function() {
			location.href = "member/memberUpdateView";
		})
	})
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<%@include file="board/nav.jsp" %>
	
	<form name="homeFrom" method="post" action="/member/login" style="width:600px; margin:30px auto;">
		<c:if test="${msg == false }">
			<div class="alert alert-danger mt-5" role="alert">
				<strong>로그인 실패!</strong> 아이디와 비밀번호를 확인해주세요.
			</div>
		</c:if>
		<div class="card">
			<h5 class="card-header">로그인</h5>
			<div class="card-body">
				<c:if test="${member == null }">
					<div class="form-group">
						<label for="userId">아이디</label>
						<input type="text" id="userId" name="userId" class="form-control" />
					</div>
					<div class="form-group" >
						<label for="userPass">비밀번호</label>
						<input type="password" id="userPass" name="userPass" class="form-control" />
					</div>
					<div class="form-group mt-5">
						<button type="submit" class="btn btn-primary">로그인</button>
						<button type="button" id="registerBtn" class="btn btn-success">회원가입</button>
					</div>
				</c:if>
				
				<c:if test="${member != null }">
					<div>
						<p>${member.userId }님 환영합니다.</p>
						<button id="memberUpdateBtn" type="button" class="btn btn-success">회원정보 수정</button>
						<button id="logoutBtn" type="button" class="btn btn-secondary">로그아웃</button>
					</div>
				</c:if>
			</div>
		</div>
	</form>
</body>
</html>