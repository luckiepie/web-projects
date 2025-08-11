package board.service;

import java.sql.Connection;

import board.dao.BoardDAO;

import static board.dao.JdbcUtil.*;

public class BoardDeleteService {
	public boolean remove(int bno,String password) {
		Connection con = getConnection();
		
		BoardDAO dao = new BoardDAO(con);
		boolean result = dao.deleteArticle(bno, password);
		
		if(result) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}
}