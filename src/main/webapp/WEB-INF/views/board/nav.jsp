<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
<%-- <ul>
	<li><a href="/board/list">목록</a></li>
	<li><a href="/board/writeView">글 작성</a></li>
	<li>
		<c:if test="${member != null }"><a href="/member/logout">로그아웃</a></c:if>
		<c:if test="${member == null }"><a href="/">로그인</a></c:if>
	</li>
	<li>
		<c:if test="${member != null }">
			<p>${member.userId }님 안녕하세요.</p>
		</c:if>
	</li>
</ul> --%>
<div class="nav-wrap bg-light">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="/board/list">하은게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
   	<span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="/board/list">게시판</a>
      </li>
      <li class="nav-item">
      	<a class="nav-link" href="/board/writeView">글 작성</a>
      </li>
    </ul>
    <span class="navbar-text">
      <!-- 로그인 상태가 아닐 때 -->
      <c:if test="${member == null }">
			<a class="btn btn-sm btn-primary my-2 my-sm-0" href="/" style="color:#fff">로그인</a>
      </c:if>
      
      <!-- 로그인 상태일 때 -->
      <c:if test="${member != null }">
			${member.userId }님 안녕하세요.  
			<a class="btn btn-sm btn-secondary my-2 my-sm-0 ml-2" href="/member/logout" style="color:#fff">로그아웃</a>
      </c:if>
    </span>
  </div>
</nav>
</div>
</body>
</html>