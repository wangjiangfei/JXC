package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.PurchaseList;

/**
 * @author wangjiangfei
 * @date 2019/8/2 9:15
 * @description
 */
public interface PurchaseListGoodsService {

    ServiceVO save(PurchaseList purchaseList, String purchaseListGoodsStr);
}
