package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.SaleList;

/**
 * @author wangjiangfei
 * @date 2019/8/7 8:57
 * @description
 */
public interface SaleListGoodsService {

    Integer getSaleTotalByGoodsId(Integer goodsId);

    ServiceVO save(SaleList saleList, String saleListGoodsStr);
}
