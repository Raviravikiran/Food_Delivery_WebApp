package com.DAO.model;

public class OrderItem {

	private int orderItemId;
	private int orderId;
	private int menuID;
	private int quantity;
	private int totalPrice;
	
	public OrderItem(){
		
	}

	public OrderItem(int orderItemId, int orderId, int menuID, int quantity, int totalPrice) {
		super();
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.menuID = menuID;
		this.quantity = quantity;
		this.totalPrice = totalPrice;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId + ", menuID=" + menuID + ", quantity="
				+ quantity + ", totalPrice=" + totalPrice + "]";
	}
	
	
}
