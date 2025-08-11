<%@page import="web2.dao.MemberDAO"%>
<%@page import="web2.dao.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	//폼에서 넘긴 값 가져오기(id,addr)
	int id = Integer.parseInt(request.getParameter("id"));
	String addr = request.getParameter("addr");

	//db작업
	Connection con = JdbcUtil.getConnection();
	MemberDAO dao = new MemberDAO(con);
	boolean result = dao.update(id, addr);
			
	
	//페이지 이동
	String path = "";
	if(result){
		JdbcUtil.commit(con);
		path = "list.jsp";
	}else{
		JdbcUtil.rollback(con);
		path="modifyProcess.jsp";
	}
	JdbcUtil.close(con);
	
	response.sendRedirect(path);

%>












