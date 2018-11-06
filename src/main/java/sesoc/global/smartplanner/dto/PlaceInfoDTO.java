package sesoc.global.smartplanner.dto;

public class PlaceInfoDTO {
	private String name;
	private String address;
	private String location;

	public PlaceInfoDTO(String name, String address, String location) {
		super();
		this.name = name;
		this.address = address;
		this.location = location;
	}

	public PlaceInfoDTO() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Override
	public String toString() {
		return "Place [name=" + name + ", address=" + address + ", location=" + location + "]";
	}

}
