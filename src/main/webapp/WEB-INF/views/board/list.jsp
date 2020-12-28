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
<body>
	<%-- 네비게이션 바 --%>
	<%@include file="../include/nav.jsp" %>
	
	<!-- list.jsp 시작 -->
	<div class="container">
		<h1 class="mt-5">게시판</h1>
		<%-- 글쓰기 버튼 --%>
		<a href="/board/writeView" class="btn btn-primary my-1 float-right">글쓰기</a>
		
		<section>
			<form role="form" method="get" action="/board/list" class="form-list ">
				<!-- 목록 START -->
				<table class="table table-hover">
					<!-- 목록 이름 START-->
					<thead>
						<tr>
							<th scope="col" class="text-center" style="width:5.4%;">번호</th>
							<th scope="col" class="text-center" style="width:48.3%;">제목</th>
							<th scope="col" style="width:21.6%;">글쓴이</th>
							<th scope="col" class="text-center" style="width:15%;">작성일</th>
							<th scope="col" class="text-center" style="width:9.5%;">조회</th>
						</tr>
					</thead>
					<!-- 목록 이름 END -->
					<!-- 목록 리스트 START-->
					<tbody>
						<c:forEach items="${list}" var="list">
						<tr>
							<%-- 번호 --%>
							<th scope="row" class="text-center"><c:out value="${list.bno}" /></th>
							<%-- 제목 --%>
							<td>
								<a href="/board/readView?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">
									<c:out value="${list.title}" />
								</a>
							</td>
							<%-- 작성자 --%>
							<td><c:out value="${list.writer}" /></td>
							<%-- 등록일 --%>
							<td class="text-center"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
							<%-- 조회수 --%>
							<td class="text-center"><c:out value="${list.hit }" /></td>
						</tr>
						</c:forEach>
					</tbody>
					<!-- 목록 리스트 END -->
				</table>
				<!-- 목록 END -->
				
				<!-- 페이징 START -->
				<nav aria-label="Page navigation example" >
				  <ul class="pagination justify-content-center mt-5">
				  	<%-- 이전 버튼 : 생성되지 않을 경우 버튼 비활성화 --%>
			    	<c:if test="${pageMaker.prev}">
			    		<li class="page-item">
				    		<a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}" class="page-link">&laquo;</a>
			    		</li>
				    </c:if>
				    <c:if test="${!pageMaker.prev}">
				    	<li class="page-item disabled">
				    		<span class="page-link">&laquo;</span>
				    	</li>
				    </c:if>
				    
				    <%-- 페이지 버튼 --%>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				    	<c:choose>
				    		<c:when test="${scri.page == idx }">
				    			<li class="page-item active"><a class="page-link" href="list${pageMaker.makeSearch(idx) }">${idx }</a></li>
				    		</c:when>
				    		<c:otherwise>
						    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(idx) }">${idx }</a></li>
				    		</c:otherwise>
				    	</c:choose>
					</c:forEach>
				    
				    
				    <%-- 다음 버튼 : 생성되지 않을 경우 버튼 비활성화 --%>
				    <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
			    		<li class="page-item">
				    		<a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}" class="page-link">&raquo;</a>
			    		</li>
				    </c:if>
				    <c:if test="${!pageMaker.next && pageMaker.endPage > 0 }">
				    	<li class="page-item disabled">
				    		<span class="page-link">&raquo;</span>
				    	</li>
				    </c:if>
				  </ul>
				</nav>
				<!-- 페이징 END -->
				
				<!-- 검색 START -->
				<div class="search form-inline justify-content-center bg-light pt-3 pb-3 mt-5">
					<select name="searchType" class="custom-select my-1 mr-sm-2">
						<%-- 검색 결과가 나왔을 때도, option을 유지하기 위하여 c:out을 사용하여 selected 설정 --%>
						<%-- <option value="n"<c:out value="${scri.searchType == null ? 'selected' : '' }" />>선택</option> --%>
						<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : '' }" />>제목+내용</option>
						<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : '' }" />>제목</option>
						<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : '' }" />>내용</option>
						<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : '' }" />>작성자</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" value="${scri.keyword }" class="form-control mr-sm-2" placeholder="검색어를 입력하세요"/>
					<button id="searchBtn" type="button" class="btn btn-primary my-1">검색</button>
				</div>
				<%-- 검색 버튼을 눌렀을 때 page, perPageNum, searchType, keyword 값이 들어가는 스크립트 --%>
				<script>
					$(function(){
						$('#searchBtn'.click(function() {
							self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() +
											"&keyword=" + encodeURIComponent($('#keywordInput').val());
						}))
					})
				</script>
				<!-- 검색 END -->
			</form>
		</section>
	</div>
</body>
</html>