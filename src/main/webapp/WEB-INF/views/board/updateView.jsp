<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		var formObj = $("form[name='updateForm']");
		
		$(document).on("click","#fileDel", function(){
			$(this).parent().remove();
		})
		
		fn_addFile();
		
		
		// 취소
		$(".cancel_btn").on("click", function(){
			event.preventDefault();
			location.href = "/board/readView?bno=${update.bno}"
						   + "&page=${scri.page}"
						   + "&perPageNum=${scri.perPageNum}"
						   + "&searchType=${scri.searchType}"
						   + "&keyword=${scri.keyword}";
		})
		
		// 업데이트
		$(".update_btn").on("click", function(){
			if(fn_valiChk()){
				return false;
			}
			formObj.attr("action", "/board/update");
			formObj.attr("method", "post");
			formObj.submit();
		})
	})
	
	// 벨리데이션 체크
	function fn_valiChk(){
		var updateForm = $("form[name='updateForm'] .chk").length;
		for(var i = 0; i<updateForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
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
			$("#fileIndex").append("<div><input type='file' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' id='fileDelBtn' class='btn btn-secondary btn-sm'>"+"삭제"+"</button></div>");
		});
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
			
		});
	}
	
		var fileNoArry = new Array();
		var fileNameArry = new Array();
		
		// 파일 삭제
		function fn_del(value, name){
			fileNoArry.push(value);
			fileNameArry.push(name);
			$("#fileNoDel").attr("value", fileNoArry);
			$("#fileNameDel").attr("value", fileNameArry);
		}
</script>
<body>

<%-- 네비게이션 바 --%>
<%@include file="nav.jsp" %>

<div class="mb-4"></div>
		
<section class="container border pb-3 write-con">
	<form name="updateForm" role="form" method="post" action="/board/update" enctype="multipart/form-data">
		<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
		<input type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
		<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">
		<input type="hidden" id="writer" name="writer" value="${update.writer }" />
		
	<!-- 작성란 START -->
		<%-- 제목 --%>
		<input type="text" id="title" name="title" value="${update.title}" class="chk h3 w-100 title mt-3" title="제목을 입력하세요." placeholder="제목을 입력하세요." maxlength="30"/>
		<%-- 글쓴이 --%>
		<p class="h6 ml-1 mb-3">
			<span class="text-black-50" style="font-size:0.8em;">글쓴이 </span> ${update.writer }
			<span class="text-black-50 pl-2" style="font-size:0.8em;">작성일 </span><fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd"/>
		</p>
		<%-- 본문 --%>
		<textarea id="content" name="content" class="chk w-100" title="내용을 입력하세요." onkeyup="fnChkByte(this);" rows="17" placeholder="내용을 입력하세요."><c:out value="${update.content}"/></textarea>
		
		<%-- 파일 추가 버튼 --%>
		<button class="fileAdd_btn btn btn-outline-success mb-3 mt-3" type="button" style="clear:both">파일추가</button>	
		<%-- 파일 추가 버튼 누르면 안에 input-file이 생성될 태그 --%>
		<p id="fileIndex">
			<c:forEach var="file" items="${file}" varStatus="var">
			<div class='w-100'>
				<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
				<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
				<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
				<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');" type="button" class="btn btn-secondary btn-sm">삭제</button><br>
			</div>
			</c:forEach>
		</p>
		
		<hr style="clear:both;">
		
		<%-- 작성, 취소 버튼 --%>
		<div class="float-right mb-3">
			<button class="update_btn btn btn-primary" type="button">수정</button>
			<button type="button" class="cancel_btn btn btn-outline-secondary">취소</button>
		</div>
	<!-- 작성란 END -->
	</form>
</section>
</body>
</html>