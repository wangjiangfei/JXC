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
  private Integer state;
  private String goodsUnit;
  private Integer goodsTypeId;

}
