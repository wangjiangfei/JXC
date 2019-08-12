package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class OverflowList {

  private Integer overflowListId;
  private String overflowNumber;
  private String overflowDate;
  private String remarks;
  private Integer userId;

  private String trueName;

}
