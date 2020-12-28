<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath }/resources/css/style.css" /> 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원가입</title>
<script type="text/javascript">
	$(document).ready(function() {
		// 취소
		$(".cancel").on("click", function() {
			location.href="/";
		});
		
		// 벨리데이션 체크
		$("#submit").on("click", function() {
			if($("#userId").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				
				return false;
			}
			
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
			
			// 아이디 중복 체크
			var idChkVal = $("#idChk").val();
			if(idChkVal == "N") {
				alert("중복확인 버튼을 눌러주세요.");
				
				return false;
			} else if(idChkVal == "Y") {
				$("#regForm").submit();
			}
			
		 }); // 벨리데이션 체크 끝
	}); // 스크립트 끝
	
	function fn_idChk() {
		$.ajax({
			url : "/member/idChk",
			type : "POST",
			dataType : "json",
			data : {"userId" : $("#userId").val()},
			success : function(data) {
				if(data == 1){
					alert("이미 존재하는 아이디입니다.");
				} else if(data == 0) {
					$("#idChk").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			}
		})
	}
</script>
</head>
<body>
	<!-- 네비게이션 바 -->
	<%@include file="../include/nav.jsp" %>

	<form action="/member/register" method="post" style="width:600px; margin:30px auto;">
		<div class="card" >
			<h5 class="card-header">회원가입</h5>
			<div class="card-body">
				<div class="form-group">
					<label>아이디</label>
					<div class="input-group mb-3">
					  <input type="text" class="form-control" aria-describedby="idChk" id="userId" name="userId">
					  <div class="input-group-append">
					    <button class="idChk btn btn-outline-secondary" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
					  </div>
					</div>
				</div>
				<div class="form-group">
					<label>패스워드</label>
					<input type="password" id="userPass" name="userPass" class="form-control"/>
				</div>
				<div class="form-group">
					<label>이름</label>
					<input type="text" id="userName" name="userName" class="form-control"/>
				</div>
				<div class="form-group mt-6">
					<button type="submit" id="submit" class="btn btn-primary">회원가입</button>
					<button type="button" class="cancel btn btn-secondary">취소</button>
				</div>
			</div>
		</div>
	</form>
	
</body>
</html>