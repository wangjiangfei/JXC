package com.wangjiangfei.dao;

import com.wangjiangfei.entity.CustomerReturnList;
import com.wangjiangfei.entity.CustomerReturnListGoods;

/**
 * @author wangjiangfei
 * @date 2019/8/7 9:05
 * @description
 */
public interface CustomerReturnListGoodsDao {

    Integer getCustomerReturnTotalByGoodsId(Integer goodsId);

    Integer saveCustomerReturnList(CustomerReturnList customerReturnList);

    Integer saveCustomerReturnListGoods(CustomerReturnListGoods customerReturnListGoods);
}
