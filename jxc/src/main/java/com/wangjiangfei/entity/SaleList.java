package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class SaleList {

  private Integer saleListId;
  private String saleNumber;
  private double amountPaid;
  private double amountPayable;
  private String saleDate;
  private Integer state;
  private String remarks;
  private Integer customerId;
  private Integer userId;

  private String customerName;
  private String trueName;

}
