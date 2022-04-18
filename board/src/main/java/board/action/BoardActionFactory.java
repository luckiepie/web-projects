package board.action;

public class BoardActionFactory {
	
	private static BoardActionFactory baf;
	
	private BoardActionFactory() {}
	
	public static BoardActionFactory getInstance() {
		if(baf == null) {
			baf =  new BoardActionFactory();
		}
		return baf;
	}
	
	Action action = null;
	public Action action(String cmd) {
		//Action 생성시 path 지정(작업이 성공할 경우 움직일 페이지)
		if(cmd.equals("/qWrite.do")) {
			action = new BoardInsertAction("/qList.do");
		}else if(cmd.equals("/qList.do")) {
			action = new BoardListAction("/view/qna_board_list.jsp");
		}
		
		return action;
	}
}



