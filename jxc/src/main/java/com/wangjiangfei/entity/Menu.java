package com.wangjiangfei.entity;

import lombok.Data;

@Data
public class Menu {

  private Integer menuId;
  private String menuIcon;
  private String menuName;
  private Integer pId;
  private Integer menuState;
  private String menuUrl;

}
