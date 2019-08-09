package com.wangjiangfei.dao;

import com.wangjiangfei.entity.SaleList;
import com.wangjiangfei.entity.SaleListGoods;

/**
 * @author wangjiangfei
 * @date 2019/8/7 8:59
 * @description
 */
public interface SaleListGoodsDao {

    Integer getSaleTotalByGoodsId(Integer goodsId);

    Integer saveSaleList(SaleList saleList);

    Integer saveSaleListGoods(SaleListGoods saleListGoods);
}
