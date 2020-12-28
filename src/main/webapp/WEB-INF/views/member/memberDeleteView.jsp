<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>회원탈퇴</title>
<script type="text/javascript">
	$(document).ready(function() {
		
		// 취소
		$(".cancel").on("click", function() {
			location.href="/";
		});
		
		// 벨리데이션 체크
		$("#submit").on("click", function(){
			if($("#userPass").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			
			 $.ajax({
				url : "/member/passChk",
				type : "POST",
				dataType : "json",
				data : $("#delForm").serializeArray(),
				success: function(data){
					
					if(data == 0){
						alert("패스워드가 틀렸습니다.");
						return;
					}else{
						if(confirm("회원탈퇴하시겠습니까?")){
							$("#delForm").submit();
						}
						
					}
				}
			}) 
			
		});
		
	}); // 스크립트 끝
</script>
</head>
<body>
	<section>
		<form action="/member/memberDelete" method="post" id="delForm">
			<div>
				<label for="userId">아이디</label>
				<input type="text" id="userId" name="userId" value="${member.userId }" readonly="readonly" />
			</div>
			<div>
				<label for="userPass">패스워드</label>
				<input type="password" id="userPass" name="userPass" />
			</div>
			<div>
				<label for="userName">이름</label>
				<input type="text" id="userName" name="userName" value="${member.userName }" readonly="readonly"/>
			</div>
			<div>
				<button type="button" id="submit">회원탈퇴</button>
				<button type="button" class="cancel">취소</button>
			</div>
		</form>
		<%-- <div>
			<c:if test="${msg == false }">
				비밀번호가 맞지 않습니다.
			</c:if>
		</div> --%>
	</section>
</body>
</html>