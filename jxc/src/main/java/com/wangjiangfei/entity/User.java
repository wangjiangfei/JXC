package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class User {

  private Integer userId;
  private String userName;
  private String password;
  private String trueName;
  private String roles;
  private String remarks;

}
