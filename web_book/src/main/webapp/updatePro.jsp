<%@page import="book.dao.JdbcUtil"%>
<%@page import="book.dao.BookDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//update.jsp 넘긴 값 가져오기
	int code = Integer.parseInt(request.getParameter("code"));
	int price = Integer.parseInt(request.getParameter("price"));

	//db작업
	Connection con = JdbcUtil.getConnection();
	BookDAO dao = new BookDAO(con);
	
	boolean result = dao.update(code,price);	
	
	//페이지 이동
	String path="";
	if(result){
		//성공시 listPro.jsp
		path = "listPro.jsp";
		JdbcUtil.commit(con);		
	}else{
		//실패시 update.jsp
		path = "update.jsp";
		JdbcUtil.rollback(con);	
	}
	response.sendRedirect(path);

%>