package sesoc.global.smartplanner.dto;

public class MemberVO {
	private String member_seq;
	private String member_name;
	private String member_pw;
	private String member_email;
	private String member_regdate;
	private String member_img;
	private String member_type;
	private String member_invaild;

	public MemberVO(String member_seq, String member_name, String member_pw, String member_email, String member_regdate,
			String member_img, String member_type, String member_invaild) {
		super();
		this.member_seq = member_seq;
		this.member_name = member_name;
		this.member_pw = member_pw;
		this.member_email = member_email;
		this.member_regdate = member_regdate;
		this.member_img = member_img;
		this.member_type = member_type;
		this.member_invaild = member_invaild;
	}

	public MemberVO() {
		super();
	}

	public String getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(String member_seq) {
		this.member_seq = member_seq;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_regdate() {
		return member_regdate;
	}

	public void setMember_regdate(String member_regdate) {
		this.member_regdate = member_regdate;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	public String getMember_type() {
		return member_type;
	}

	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}

	public String getMember_invaild() {
		return member_invaild;
	}

	public void setMember_invaild(String member_invaild) {
		this.member_invaild = member_invaild;
	}

	@Override
	public String toString() {
		return "MemberVO [member_seq=" + member_seq + ", member_name=" + member_name + ", member_pw=" + member_pw
				+ ", member_email=" + member_email + ", member_regdate=" + member_regdate + ", member_img=" + member_img
				+ ", member_type=" + member_type + ", member_invaild=" + member_invaild + "]";
	}

}
