package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class CustomerReturnList {

  private Integer customerReturnListId;
  private String returnNumber;
  private String returnDate;
  private double amountPaid;
  private double amountPayable;
  private Integer state;
  private Integer customerId;
  private Integer userId;
  private String remarks;

  private String customerName;
  private String trueName;

}
