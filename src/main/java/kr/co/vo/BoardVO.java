package kr.co.vo;

import java.util.Date;

public class BoardVO {
	/**
	CREATE TABLE HE_BOARD(
	    BNO NUMBER NOT NULL,
	    TITLE VARCHAR2(100)     NOT NULL,
	    CONTENT VARCHAR2(2000)  NOT NULL,
	    WRITER VARCHAR2(100)    NOT NULL,
	    REGDATE DATE            DEFAULT SYSDATE,
	    HIT NUMBER DEFAULT 0,
	    PRIMARY KEY(BNO)
	);

	CREATE SEQUENCE HE_BOARD_SEQ
	START WITH 1
	INCREMENT BY 1;
	*/
	
	private int bno;		// 게시판 번호
	private String title;	// 게시판 제목
	private String content;	// 게시판 내용
	private String writer;	// 작성자
	private Date regdate;	// 작성일
	private int hit;		// 조회수
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
}
