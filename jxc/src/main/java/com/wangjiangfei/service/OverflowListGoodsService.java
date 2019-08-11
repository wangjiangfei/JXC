package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.OverflowList;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/11 7:48
 * @description
 */
public interface OverflowListGoodsService {

    ServiceVO save(OverflowList overflowList, String overflowListGoodsStr);

    Map<String,Object> list(String sTime, String eTime);

    Map<String,Object> goodsList(Integer overflowListId);
}
