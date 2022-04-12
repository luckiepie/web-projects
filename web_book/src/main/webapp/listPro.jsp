<%@page import="book.dto.BookDTO"%>
<%@page import="java.util.List"%>
<%@page import="book.dao.BookDAO"%>
<%@page import="book.dao.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//도서 목록 전체 조회 후 화면이동
	//db작업
	Connection con = JdbcUtil.getConnection();
	BookDAO dao = new BookDAO(con);
	List<BookDTO> list = dao.getList();
	
	//페이지 이동
	request.setAttribute("list", list);
	pageContext.forward("list.jsp");
%>