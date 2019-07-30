package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Goods;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/27 17:22
 * @description
 */
public interface GoodsService {

    Map<String,Object> list(Integer page, Integer rows, String goodsName, Integer goodsTypeId);

    ServiceVO getCode();

    ServiceVO save(Goods goods);

    ServiceVO delete(Integer goodsId);
}
