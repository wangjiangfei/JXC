package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.CustomerReturnList;

/**
 * @author wangjiangfei
 * @date 2019/8/7 9:00
 * @description
 */
public interface CustomerReturnListGoodsService {

    Integer getCustomerReturnTotalByGoodsId(Integer goodsId);

    ServiceVO save(CustomerReturnList customerReturnList, String customerReturnListGoodsStr);
}
