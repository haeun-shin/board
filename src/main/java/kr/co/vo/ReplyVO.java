package kr.co.vo;

import java.util.Date;

public class ReplyVO {
	/**
	create table he_reply (
	    bno number not null,
	    rno number not null,
	    content varchar2(1000) not null,
	    writer varchar2(50) not null,
	    regdate date default sysdate,
	    primary key(bno, rno)
	);
	
	alter table he_reply add constraint he_reply_bno foreign key(bno)
	references he_board(bno);
	
	create sequence he_reply_seq START WITH 1 MINVALUE 0;
	*/
	
	private int bno;
	private int rno;
	private String content;
	private String writer;
	private Date regdate;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + "]";
	}
	
	
}
