package sesoc.global.smartplanner.dto;

import java.util.ArrayList;

public class PlaceDetailDTO {
	private String grade; // 평점
	private ArrayList<PlaceReviewVO> reviewList; // 덧글리스트
	private int totalRecordsCount; // 총 댓글 갯수
	private int totalPageCount; // 총 페이지 수
	private int startPageGroup; // 페이지 그룹의 첫번째
	private int endPageGroup; // 페이지 그룹의 마지막
	private int currentPage; // 현재 페이지
	private int currentGroup; // 현재 그룹

	public PlaceDetailDTO(String grade, ArrayList<PlaceReviewVO> reviewList, int totalRecordsCount, int totalPageCount,
			int startPageGroup, int endPageGroup, int currentPage, int currentGroup) {
		super();
		this.grade = grade;
		this.reviewList = reviewList;
		this.totalRecordsCount = totalRecordsCount;
		this.totalPageCount = totalPageCount;
		this.startPageGroup = startPageGroup;
		this.endPageGroup = endPageGroup;
		this.currentPage = currentPage;
		this.currentGroup = currentGroup;
	}

	public PlaceDetailDTO() {
		super();
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public ArrayList<PlaceReviewVO> getReviewList() {
		return reviewList;
	}

	public void setReviewList(ArrayList<PlaceReviewVO> reviewList) {
		this.reviewList = reviewList;
	}

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getStartPageGroup() {
		return startPageGroup;
	}

	public void setStartPageGroup(int startPageGroup) {
		this.startPageGroup = startPageGroup;
	}

	public int getEndPageGroup() {
		return endPageGroup;
	}

	public void setEndPageGroup(int endPageGroup) {
		this.endPageGroup = endPageGroup;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getCurrentGroup() {
		return currentGroup;
	}

	public void setCurrentGroup(int currentGroup) {
		this.currentGroup = currentGroup;
	}

	@Override
	public String toString() {
		return "PlaceDetailDTO [grade=" + grade + ", reviewList=" + reviewList + ", totalRecordsCount="
				+ totalRecordsCount + ", totalPageCount=" + totalPageCount + ", startPageGroup=" + startPageGroup
				+ ", endPageGroup=" + endPageGroup + ", currentPage=" + currentPage + ", currentGroup=" + currentGroup
				+ "]";
	}

}
