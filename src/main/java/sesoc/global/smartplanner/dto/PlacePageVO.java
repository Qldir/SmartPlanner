package sesoc.global.smartplanner.dto;

import java.util.ArrayList;

public class PlacePageVO {
	private ArrayList<PlaceVO> resultList;
	private int currentPage;
	private int startPageGroup;
	private int endPageGroup;
	private int totalRecordsCount;
	private int totalPageCount;
	private int currentGroup;

	public PlacePageVO() {
		super();
	}

	public PlacePageVO(ArrayList<PlaceVO> resultList, int currentPage, int startPageGroup, int endPageGroup,
			int totalRecordsCount, int totalPageCount, int currentGroup) {
		super();
		this.resultList = resultList;
		this.currentPage = currentPage;
		this.startPageGroup = startPageGroup;
		this.endPageGroup = endPageGroup;
		this.totalRecordsCount = totalRecordsCount;
		this.totalPageCount = totalPageCount;
		this.currentGroup = currentGroup;
	}

	public ArrayList<PlaceVO> getResultList() {
		return resultList;
	}

	public void setResultList(ArrayList<PlaceVO> resultList) {
		this.resultList = resultList;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
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

	public int getCurrentGroup() {
		return currentGroup;
	}

	public void setCurrentGroup(int currentGroup) {
		this.currentGroup = currentGroup;
	}

	@Override
	public String toString() {
		return "PlacePageVO [resultList=" + resultList + ", currentPage=" + currentPage + ", startPageGroup="
				+ startPageGroup + ", endPageGroup=" + endPageGroup + ", totalRecordsCount=" + totalRecordsCount
				+ ", totalPageCount=" + totalPageCount + ", currentGroup=" + currentGroup + "]";
	}

}
