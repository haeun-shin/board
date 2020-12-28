package kr.co.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;		// 총 게시물 갯수
	private int startPage;		// [■] [n] [n] ... 시작 페이지
	private int endPage;		// ... [n] [n] [■] 끝 페이지
	private boolean prev;		// 이전 버튼
	private boolean next;		// 다음 버튼
	private int displayPageNum = 10;	// 한 번에 보일 페이지 수
	private Criteria cri;		// 페이지 구성을 위한 기본 세팅
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	/* 페이지 세팅 */
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
	  
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}
	
	/* 페이지 링크 생성 */
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
														  .queryParam("page", page)
														  .queryParam("perPageNum", cri.getPerPageNum())
														  .build();
		return uriComponents.toUriString();
	}
	
	
	/* 검색 링크 생성 */
	public String makeSearch(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
														  .queryParam("page", page)
														  .queryParam("perPageNum", cri.getPerPageNum())
														  .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
														  .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
														  .build();
		return uriComponents.toUriString();
	}
	
	/* 검색어 url 인코딩 설정 */
	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) {
			return "";
		}
	}
	
}
