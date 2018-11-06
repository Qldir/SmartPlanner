package sesoc.global.smartplanner.dto;

public class BoardPageDTO {
	private BoardDTO board;
	private PlanPageDTO planDTO;
	private int favorite; // 페이보릿 여부

	public BoardPageDTO(BoardDTO board, PlanPageDTO planDTO, int favorite) {
		super();
		this.board = board;
		this.planDTO = planDTO;
		this.favorite = favorite;
	}

	public BoardPageDTO() {
		super();
	}

	public BoardDTO getBoard() {
		return board;
	}

	public void setBoard(BoardDTO board) {
		this.board = board;
	}

	public PlanPageDTO getPlanDTO() {
		return planDTO;
	}

	public void setPlanDTO(PlanPageDTO planDTO) {
		this.planDTO = planDTO;
	}

	public int getFavorite() {
		return favorite;
	}

	public void setFavorite(int favorite) {
		this.favorite = favorite;
	}

	@Override
	public String toString() {
		return "BoardPageDTO [board=" + board + ", planDTO=" + planDTO + ", favorite=" + favorite + "]";
	}

}
