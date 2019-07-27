package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;

/**
 * @author wangjiangfei
 * @date 2019/7/26 9:33
 * @description
 */
public interface GoodsTypeService {

    ServiceVO delete(Integer goodsTypeId);

    ServiceVO save(String goodsTypeName,Integer pId);

    String loadGoodsType();
}
