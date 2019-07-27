package com.wangjiangfei.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GoodsType {

  private Integer goodsTypeId;
  private String goodsTypeName;
  private Integer pId;
  private Integer goodsTypeState;

  public GoodsType(String goodsTypeName, Integer goodsTypeState, Integer pId) {
    this.goodsTypeName = goodsTypeName;
    this.goodsTypeState = goodsTypeState;
    this.pId = pId;
  }
}
