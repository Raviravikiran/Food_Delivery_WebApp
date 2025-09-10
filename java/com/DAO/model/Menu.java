package com.DAO.model;

public class Menu {
	
	private int menuID;
	private int restaurantID;
	private String itemName;
	private String description;
	private int price;
	private float ratings;
	private boolean isAvaliable;
	private String imagepath;
	
	public Menu() {
		
	}

	public Menu(int menuID, int restaurantID, String itemName, String description, int price, float ratings,
			boolean isAvaliable, String imagepath) {
		super();
		this.menuID = menuID;
		this.restaurantID = restaurantID;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.ratings = ratings;
		this.isAvaliable = isAvaliable;
		this.imagepath = imagepath;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public float getRatings() {
		return ratings;
	}

	public void setRatings(float ratings) {
		this.ratings = ratings;
	}

	public boolean isAvaliable() {
		return isAvaliable;
	}

	public void setAvaliable(boolean isAvaliable) {
		this.isAvaliable = isAvaliable;
	}

	public String getImagepath() {
		return imagepath;
	}

	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}

	@Override
	public String toString() {
		return "Menu [menuID=" + menuID + ", restaurantID=" + restaurantID + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", ratings=" + ratings + ", isAvaliable=" + isAvaliable
				+ ", imagepath=" + imagepath + "]";
	}

	
	
	
	
}