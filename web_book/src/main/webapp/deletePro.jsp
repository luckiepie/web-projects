<%@page import="book.dao.BookDAO"%>
<%@page import="book.dao.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//delete.jsp에서 넘긴 값 가져오기 - code
	int code = Integer.parseInt(request.getParameter("code"));
	//db작업
	Connection con = JdbcUtil.getConnection();
	BookDAO dao = new BookDAO(con);
	boolean result = dao.delete(code);			
	
	//페이지 이동
	String path="";
	if(result){
		//성공시 listPro.jsp
		path = "listPro.jsp";
		JdbcUtil.commit(con);		
	}else{
		//실패시 delete.jsp
		path = "delete.jsp";
		JdbcUtil.rollback(con);	
	}
	response.sendRedirect(path);
%>