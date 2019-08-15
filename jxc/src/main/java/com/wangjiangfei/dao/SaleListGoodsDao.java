package com.wangjiangfei.dao;

import com.wangjiangfei.entity.SaleData;
import com.wangjiangfei.entity.SaleList;
import com.wangjiangfei.entity.SaleListGoods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/8/7 8:59
 * @description
 */
public interface SaleListGoodsDao {

    Integer getSaleTotalByGoodsId(Integer goodsId);

    Integer saveSaleList(SaleList saleList);

    Integer saveSaleListGoods(SaleListGoods saleListGoods);

    List<SaleList> getSalelist(@Param("saleNumber") String saleNumber,
                               @Param("customerId") Integer customerId,
                               @Param("state") Integer state,
                               @Param("sTime") String sTime,
                               @Param("eTime") String eTime);

    List<SaleListGoods> getSaleListGoodsBySaleListId(Integer saleListId);

    SaleList getSaleList(Integer saleListId);

    Integer deleteSaleListById(Integer saleListId);

    Integer deleteSaleListGoodsBySaleListId(Integer saleListId);

    Integer updateState(Integer saleListId);

    List<SaleListGoods> getSaleListGoods(@Param("saleListId") Integer saleListId,
                                         @Param("goodsTypeId") Integer goodsTypeId,
                                         @Param("codeOrName") String codeOrName);

    List<SaleData> getSaleDataByDay(@Param("sTime") String sTime,@Param("eTime") String eTime);

    List<SaleData> getSaleDataByMonth(@Param("sTime") String sTime,@Param("eTime") String eTime);
}
