<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			var formObj = $("form[name='writeForm']");
			
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
					
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
			
			fn_addFile();
			
		})
		
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val().trim() == "" || $(".chk").eq(i).val().trim() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		
		// 파일 추가
			function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<p class='w-100'><input type='file' name='file_"+(fileIndex++)+"'accept='image/*'>"+"</button>"+"<button type='button' id='fileDelBtn' class='btn btn-secondary btn-sm'>"+"삭제"+"</button></p>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
		
		// 글자수 체크
		function fnChkByte(obj) {
		    var maxByte = 1890; //최대 입력 바이트 수
		    var str = obj.value;
		    var str_len = str.length;
		 
		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    var str2 = "";
		 
		    for (var i = 0; i < str_len; i++) {
		        one_char = str.charAt(i);
		 
		        if (escape(one_char).length > 4) {
		            rbyte += 3; //한글3Byte
		        } else {
		            rbyte++; //영문 등 나머지 1Byte
		        }
		 
		        if (rbyte <= maxByte) {
		            rlen = i + 1; //return할 문자열 갯수
		        }
		    }
		 
		    if (rbyte > maxByte) {
		        alert("한글 " + (maxByte / 3) + "자 / 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
		        str2 = str.substr(0, rlen); //문자열 자르기
		        obj.value = str2;
		        fnChkByte(obj, maxByte);
		    } else {
		        document.getElementById('byteInfo').innerText = rbyte;
		    }
		}

	</script>
</head>
<body>

<%-- 네비게이션 바 --%>
<%@include file="../include/nav.jsp" %>

<div class="mb-4"></div>
<c:choose>
	<c:when test="${member.userId == null }">
		<div class="alert alert-secondary" role="alert" style="max-width: 1200px; margin:0 auto;">
			 로그인 후 작성할 수 있습니다.
		</div>
	</c:when>
	<c:otherwise>
		<section class="container border pb-3 write-con">
			<form name="writeForm" method="post" action="/board/write" enctype="multipart/form-data">
				<input type="hidden" id="writer" name="writer" value="${member.userId }" />
				
			<!-- 작성란 START -->
				<%-- 제목 --%>
				<input type="text" id="title" name="title" class="chk h3 w-100 title mt-3" title="제목을 입력하세요." placeholder="제목을 입력하세요." maxlength="30"/>
				<%-- 글쓴이 --%>
				<p class="h6 ml-1 mb-3">
					<span class="text-black-50" style="font-size:0.8em;">글쓴이 </span> ${member.userId }
				</p>
				<%-- 본문 --%>
				<textarea id="content" name="content" class="chk w-100 h-50" title="내용을 입력하세요." onkeyup="fnChkByte(this);" rows="17" placeholder="내용을 입력하세요."></textarea>
				
				<%-- 파일 추가 버튼 --%>
				<button class="fileAdd_btn btn btn-outline-success mb-3" type="button" style="clear:both">파일추가</button>	
				<%-- 파일 추가 버튼 누르면 안에 input-file이 생성될 태그 --%>
				<p id="fileIndex"></p>
				
				<hr style="clear:both;">
				
				<%-- 작성, 취소 버튼 --%>
				<div class="float-right mb-3">
					<button class="write_btn btn btn-primary" type="button">작성</button>
					<a class="btn btn-outline-secondary" href="/board/list">취소</a>
				</div>
			<!-- 작성란 END -->
			</form>
		</section>
	</c:otherwise>
</c:choose>
</body>
</html>