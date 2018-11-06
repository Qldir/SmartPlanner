package sesoc.global.smartplanner.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sesoc.global.smartplanner.dto.MemberVO;

@Repository
public class MemberRepository{

	@Autowired
	SqlSession session;

	public int insert(MemberVO member) {
		
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		System.out.println("2"+member);
		
		int result=mapper.insert(member);
		System.out.println(result);
		return result;
	}

	public int update(MemberVO member) {
		System.out.println("업데이트 들어갔다.");
		
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		
		int result=mapper.update(member);
		System.out.println("UPDAte success??"+result);
		
		return result;
	}

	
	
	public MemberVO get(MemberVO member) {
		System.out.println("들어왔지롱"+member);
		
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		MemberVO result=mapper.get(member);
		
		System.out.println(result+"결과 같은 레퍼에서");
		return result;
	}

	
	public MemberVO selectOne(MemberVO member) {
	System.out.println(member);
	MemberMapper mapper=session.getMapper(MemberMapper.class);	
	
	System.out.println("selectOne 레퍼지터리임");	
		
	MemberVO result=mapper.get(member);
		
	System.out.println("get의 레퍼"+result);
		
	return result;
	}

	
	public int checking(MemberVO member) {
		System.out.println("레퍼지터리");
		
		System.out.println("로그인에서 들어온거"+member);
		
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		
		int result=mapper.checking(member);
		
		System.out.println("체킹하는 곳"+result);
		
		return result;
	}

	public MemberVO reWrite(MemberVO member) {
		System.out.println("다시쓰기 레퍼에 들어갔나?");
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		MemberVO result=mapper.reWrite(member);
		System.out.println("다시쓰기 결과가 들어왔나?"+result);
		return result;
	}

	public int deleteUpdate(MemberVO result) {
		System.out.println("탈퇴 레퍼지터리 도착");
		System.out.println("3"+result);
		MemberMapper mapper=session.getMapper(MemberMapper.class);
		
		int resul=mapper.updatingDelete(result);
		
		System.out.println("매퍼에서 탈퇴 변경이 됐나?"+resul);
		return resul;
	}

	

	
	
	

}
