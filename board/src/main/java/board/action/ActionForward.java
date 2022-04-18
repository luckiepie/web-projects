package board.action;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ActionForward {
	// path, 이동방식
	private String path;
	private boolean redirect;	// ture:sendRedirect	false : forward
	
	
}
