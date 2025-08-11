<%@page import="web2.dto.MemberDTO"%>
<%@page import="web2.dao.MemberDAO"%>
<%@page import="web2.dao.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼에서 넘긴 값 가져오기 - id
	int id = Integer.parseInt(request.getParameter("id"));

	//db 작업
	Connection con = JdbcUtil.getConnection();
	MemberDAO dao = new MemberDAO(con);
	
	MemberDTO dto = dao.getRow(id);
	
	request.setAttribute("dto", dto);
	
	//페이지 이동
	pageContext.forward("/update.jsp");

%>