package board.service;

import static board.dao.JdbcUtil.*;

import java.sql.Connection;

import board.dao.BoardDAO;

public class BoardHitUpdateService {
	
	public void readUpdate(int bno) {
		Connection con = getConnection();
		BoardDAO dao = new BoardDAO(con);
		
		if(dao.hitUpdate(bno)) {
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
	}
}