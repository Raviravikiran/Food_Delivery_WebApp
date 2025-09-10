package com.DAO.model;

public class CartItem {
	private int CartitemID;
	private int RestaurantID;
	private String itemName;
	private int Quantity;
	private int Price;
	private String itemimagescr;
	
	
	public CartItem(int cartID,int RestaurantID, String itemName, int quantity, int price,String itemimagescr) {
		super();
		CartitemID = cartID;
		this.RestaurantID=RestaurantID;
		this.itemName = itemName;
		Quantity = quantity;
		Price = price;
		this.itemimagescr = itemimagescr;
	}


	public int getCartitemID() {
		return CartitemID;
	}


	public void setCartitemID(int cartID) {
		CartitemID = cartID;
	}


	public int getRestaurantID() {
		return RestaurantID;
	}


	public void setRestaurantID(int restaurantID) {
		RestaurantID = restaurantID;
	}


	public String getItemName() {
		return itemName;
	}


	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public int getQuantity() {
		return Quantity;
	}


	public void setQuantity(int quantity) {
		Quantity = quantity;
	}


	public int getPrice() {
		return Price;
	}


	public void setPrice(int price) {
		Price = price;
	}


	public String getItemimagescr() {
		return itemimagescr;
	}


	public void setItemimagescr(String itemimagescr) {
		this.itemimagescr = itemimagescr;
	}


	@Override
	public String toString() {
		return "CartItem [CartitemID=" + CartitemID + ", RestaurantID=" + RestaurantID + ", itemName=" + itemName
				+ ", Quantity=" + Quantity + ", Price=" + Price + ", itemimagescr=" + itemimagescr + "]";
	}


	


	
	
	
	
}
