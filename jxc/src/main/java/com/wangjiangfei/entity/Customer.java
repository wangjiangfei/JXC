package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class Customer {

  private Integer customerId;
  private String customerName;
  private String contacts;
  private String phoneNumber;
  private String address;
  private String remarks;

}
