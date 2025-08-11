<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그아웃 => 세션 해제
	// 		removeAttribute("이름") - 특정 세션만 날리기(?)	/ invalidate() - 전부 날리기
	session.removeAttribute("loginDto");
	
	// 페이지 이동 : loginForm.jsp
	response.sendRedirect("loginForm.jsp");

%>