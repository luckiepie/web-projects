package web2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web2.dto.MemberDTO;
import static web2.dao.JdbcUtil.*;
// ~~DAO : DB 작업(CRUD)을 모아놓은 클래스

public class MemberDAO {
	private Connection con;

	public MemberDAO(Connection con) {
		super();
		this.con = con;
	}
	
	//전체조회
	//Read : select * from member; => List<MemberDTO> 
	//     : select * from member where id=1;  => MemberDTO
	//     : select * from member where name='홍길동';  => List<MemberDTO>
	
	public List<MemberDTO> getList(){
		List<MemberDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member order by id desc";
		try {			
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getInt("id"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setEmail(rs.getString("email"));
				dto.setAge(rs.getInt("age"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);			
		}		
		
		return list;
	}
	
	//Read : select * from member where id=?;
	public MemberDTO getRow(int id) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member where id=?";
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(id);
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setEmail(rs.getString("email"));
				dto.setAge(rs.getInt("age"));						
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}	
		
		return dto;
	}
	
	
	
	
	//삽입 
	//Create : insert => 숫자(1 - 성공, 0 - 실패)
	public boolean insert(MemberDTO insertDto) {
		
		boolean flag = false;
		PreparedStatement pstmt = null;
		String sql = "insert into member(id,name,addr,email,age) ";
		sql+="values(member_seq.nextval,?,?,?,?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			// ? 해결
			pstmt.setString(1, insertDto.getName());
			pstmt.setString(2, insertDto.getAddr());
			pstmt.setString(3, insertDto.getEmail());
			pstmt.setInt(4, insertDto.getAge());
			// 실행
			int result = pstmt.executeUpdate();
			
			if(result>0) {
				flag = true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}			
		return flag;
	}
	
	
	//삭제 : Delete => 숫자(1 - 성공, 0 - 실패)
	//       delete from member where id=1; 
	public boolean delete(int id) {
		boolean flag=false;
		PreparedStatement pstmt = null;
		String sql = "delete from member where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			int result = pstmt.executeUpdate();
			
			if(result>0) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		return flag;
	}
	
	
	//수정 - Update => 숫자(1 - 성공, 0 - 실패)
	//       update member set addr = '변경할주소' where id=1;
	public boolean update(int id, String addr) {
		boolean result = false;
		PreparedStatement pstmt = null;
		String sql = "update member set addr = ? where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, addr);
			pstmt.setInt(2, id);
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) result = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
}
















