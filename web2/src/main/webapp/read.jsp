<%@page import="web2.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./layout/header.jsp" %>
<%
	//request 영역에서 값 가져오기
	MemberDTO dto=(MemberDTO)request.getAttribute("dto");
%>

<h1>Read</h1>
<form action="" method="post">
	<div class="form-group row">
		<label for="id" class="col-sm-2 col-form-label">Id</label>
		<div class="col-sm-8">
			<input type="text" name="id" id="id" class="form-control"  value="<%=dto.getId()%>"  readonly/>
		</div>
	</div>
	<div class="form-group row">
		<label for="name" class="col-sm-2 col-form-label">Name</label>
		<div class="col-sm-8">
			<input type="text" name="name" id="name" class="form-control" value="<%=dto.getName()%>"  readonly/>
		</div>
	</div>
	<div class="form-group row">
		<label for="addr" class="col-sm-2 col-form-label">Addr</label>
		<div class="col-sm-8">
			<input type="text" name="addr" id="addr" class="form-control" value="<%=dto.getAddr()%>"  readonly/>
		</div>
	</div>
	<div class="form-group row">
		<label for="email" class="col-sm-2 col-form-label">Email</label>
		<div class="col-sm-8">
			<input type="text" name="email" id="email" class="form-control" value="<%=dto.getEmail()%>"  readonly/>
		</div>
	</div>
	<div class="form-group row">
		<label for="age" class="col-sm-2 col-form-label">Age</label>
		<div class="col-sm-8">
			<input type="text" name="age" id="age" class="form-control" value="<%=dto.getAge()%>"  readonly/>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-10">
			<button type="submit" class="btn btn-primary">수정</button>
			<button type="submit" class="btn btn-danger">삭제</button>
		</div>
	</div>
</form>
<script src="/js/jquery-3.6.0.min.js"></script>
<script>
	
	//전송할 폼 가져오기
	let form = $("form");


	//삭제 클릭 시 removeProcess로 폼 전송
	$(".btn-danger").click(function(e){
		e.preventDefault();
		$(form).attr("action","removeProcess.jsp");
		$(form).submit();
	})
	//수정 클릭 시 modifyProcess로 폼 전송
	$(".btn-primary").click(function(e){
		e.preventDefault();
		$(form).attr("action","modifyProcess.jsp");
		$(form).submit();
	})
</script>
<%@ include file="./layout/footer.jsp" %>












