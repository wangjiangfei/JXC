package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.PurchaseList;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/2 9:15
 * @description
 */
public interface PurchaseListGoodsService {

    ServiceVO save(PurchaseList purchaseList, String purchaseListGoodsStr);

    Map<String, Object> list(String purchaseNumber,
                            Integer supplierId,
                            Integer state,
                            String sTime,
                            String eTime);

    Map<String, Object> goodsList(Integer purchaseListId);

    ServiceVO delete(Integer purchaseListId);

    ServiceVO updateState(Integer purchaseListId);

    String count(String sTime, String eTime ,Integer goodsTypeId, String codeOrName);
}
