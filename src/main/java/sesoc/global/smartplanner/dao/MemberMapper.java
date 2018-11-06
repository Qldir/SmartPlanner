package sesoc.global.smartplanner.dao;

import sesoc.global.smartplanner.dto.MemberVO;

public interface MemberMapper {

	public int insert(MemberVO member);

	public int update(MemberVO member);

	public int checking(MemberVO member);

	public MemberVO get(MemberVO member);

	public MemberVO reWrite(MemberVO member);

	public int updatingDelete(MemberVO result);

}
