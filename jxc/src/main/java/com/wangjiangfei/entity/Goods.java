package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class Goods {

  private Integer goodsId;
  private String goodsCode;
  private String goodsName;
  private Integer inventoryQuantity;
  private double lastPurchasingPrice;
  private Integer minNum;
  private String goodsModel;
  private String goodsProducer;
  private double purchasingPrice;
  private String remarks;
  private double sellingPrice;
  private Integer state;// 0 初始化状态 1 期初库存入仓库  2  有进货或者销售单据
  private String goodsUnit;
  private Integer goodsTypeId;

  private String goodsTypeName;

  private Integer saleTotal;// 销售总量

}
