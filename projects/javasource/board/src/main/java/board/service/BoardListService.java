package board.service;

import java.sql.Connection;
import java.util.List;

import board.dao.BoardDAO;
import board.dto.BoardDTO;

import static board.dao.JdbcUtil.*;

public class BoardListService {
	public List<BoardDTO> list(){
		
		Connection con = getConnection();
		BoardDAO dao = new BoardDAO(con);
		
		List<BoardDTO> list = dao.listArticle();
		
		close(con);
		
		return list;
	}
}