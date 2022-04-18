package board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.action.Action;
import board.action.ActionForward;
import board.action.BoardActionFactory;




@WebServlet("*.do")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리
		request.setCharacterEncoding("utf-8");
		
		//requestUri 확인
		String cmd = request.getRequestURI();  //  /login.do
		
		//Action 생성 => BookActionFactory 이용
		BoardActionFactory baf = BoardActionFactory.getInstance();
		Action action=baf.action(cmd);
		
		//생성된 action에게 요청 넘기기
		ActionForward af = null;
		try {
			af = action.execute(request, response);
		} catch (Exception e) {			
			e.printStackTrace();
		}
		
		// af => path,이동방식
		if(af.isRedirect()) {
			response.sendRedirect(af.getPath());
		}else {
			RequestDispatcher rd = request.getRequestDispatcher(af.getPath());
			rd.forward(request, response);
		}	
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}