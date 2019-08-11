package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.DamageList;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/11 6:34
 * @description
 */
public interface DamageListGoodsService {

    ServiceVO save(DamageList damageList, String damageListGoodsStr);

    Map<String,Object> list(String sTime, String eTime);

    Map<String,Object> goodsList(Integer damageListId);
}
