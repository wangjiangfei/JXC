package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.CustomerReturnList;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/7 9:00
 * @description
 */
public interface CustomerReturnListGoodsService {

    Integer getCustomerReturnTotalByGoodsId(Integer goodsId);

    ServiceVO save(CustomerReturnList customerReturnList, String customerReturnListGoodsStr);

    Map<String,Object> list(String returnNumber, Integer customerId, Integer state, String sTime,
                            String eTime);

    Map<String,Object> goodsList(Integer customerReturnListId);

    ServiceVO delete(Integer customerReturnListId);

    ServiceVO updateState(Integer customerReturnListId);

    String count(String sTime, String eTime, Integer goodsTypeId, String codeOrName);
}
