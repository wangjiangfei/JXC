package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Goods;
import com.wangjiangfei.entity.GoodsType;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/26 10:14
 * @description
 */
public interface GoodsTypeDao {

    List<GoodsType> getAllGoodsTypeByParentId(Integer pId);

    Integer saveGoodsType(GoodsType goodsType);

    GoodsType getGoodsTypeById(Integer goodsTypeId);

    Integer updateGoodsTypeState(GoodsType parentGoodsType);

    List<Goods> getGoodsByTypeId(Integer goodsTypeId);

    Integer delete(Integer goodsTypeId);
}
