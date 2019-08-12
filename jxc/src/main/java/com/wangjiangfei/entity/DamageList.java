package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class DamageList {

  private Integer damageListId;
  private String damageNumber;
  private String damageDate;
  private String remarks;
  private Integer userId;

  private String trueName;

}
