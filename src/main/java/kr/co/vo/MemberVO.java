package kr.co.vo;

import java.util.Date;

public class MemberVO {
	/**
	CREATE TABLE MP_MEMBER(
	  USERID  VARCHAR2(40) NOT NULL,
	  USERPASS  VARCHAR2(100) NOT NULL,
	  USERNAME  VARCHAR2(40) NOT NULL,
	  REGDATE DATE DEFAULT SYSDATE,
	  PRIMARY KEY(USERID)
	);
	*/
	
	private String userId;
	private String userPass;
	private String userName;
	private Date regdate;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", regdate="
				+ regdate + "]";
	}
	
	
	
}
