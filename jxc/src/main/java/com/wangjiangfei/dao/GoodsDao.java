package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/27 17:21
 * @description
 */
public interface GoodsDao {

    List<Goods> getGoodsList(@Param("offSet") Integer offSet,@Param("pageRow") Integer pageRow,@Param("goodsName") String goodsName,@Param("goodsTypeId") Integer goodsTypeId);

    Integer getGoodsCount(@Param("goodsName") String goodsName,@Param("goodsTypeId") Integer goodsTypeId);

    String getMaxCode();

    Integer saveGoods(Goods goods);

    Integer updateGoods(Goods goods);

    Integer deleteGoods(Integer goodsId);

    Goods findByGoodsId(Integer goodsId);
}
