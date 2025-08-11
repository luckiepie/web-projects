package board.service;

import java.sql.Connection;

import board.dao.BoardDAO;
import board.dto.BoardDTO;

import static board.dao.JdbcUtil.*;

public class BoardViewService {
	public BoardDTO read(int bno) {
		Connection con = getConnection();
		
		BoardDAO dao = new BoardDAO(con);
		BoardDTO dto = dao.getRow(bno);
		
		close(con);
		
		return dto;
	}
}