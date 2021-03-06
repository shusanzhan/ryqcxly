package com.ystech.cust.model;

// Generated 2014-5-31 19:07:12 by Hibernate Tools 4.0.0

/**
 * Decorenoticeitem generated by hbm2java
 */
public class OrderContractDecoreItem implements java.io.Serializable {
	//商品类型 1为销售
	public static final Integer TYPEXS=1;
	//2赠送
	public static final Integer TYPEZS=2;
	private Integer dbid;
	private Integer type;
	private String serNo;
	private String itemName;
	private Long price;
	private Product product;
	private Integer quality;
	private OrderContractDecore orderContractDecore;

	public OrderContractDecoreItem() {
	}

	public OrderContractDecoreItem(Integer type1, String serNo1, String itemName1,
			Long price1, Integer type2, String serNo2, String itemName2,
			Long price2, Integer decoreNoticeId) {
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}


	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getSerNo() {
		return serNo;
	}

	public void setSerNo(String serNo) {
		this.serNo = serNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public Integer getQuality() {
		return quality;
	}

	public void setQuality(Integer quality) {
		this.quality = quality;
	}

	public OrderContractDecore getOrderContractDecore() {
		return orderContractDecore;
	}

	public void setOrderContractDecore(OrderContractDecore orderContractDecore) {
		this.orderContractDecore = orderContractDecore;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}



}
