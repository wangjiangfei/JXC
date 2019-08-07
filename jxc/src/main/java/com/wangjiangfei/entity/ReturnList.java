package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class ReturnList {

  private Integer returnListId;
  private String returnNumber;
  private String returnDate;
  private double amountPaid;
  private double amountPayable;
  private String remarks;
  private Integer state;
  private Integer supplierId;
  private Integer userId;

  private String supplierName;
  private String trueName;

}
