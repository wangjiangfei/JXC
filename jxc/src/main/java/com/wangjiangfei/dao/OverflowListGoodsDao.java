package com.wangjiangfei.dao;

import com.wangjiangfei.entity.OverflowList;
import com.wangjiangfei.entity.OverflowListGoods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/8/11 8:21
 * @description
 */
public interface OverflowListGoodsDao {

    Integer saveOverflowList(OverflowList overflowList);

    Integer saveOverflowListGoods(OverflowListGoods overflowListGoods);

    List<OverflowList> getOverflowlist(@Param("sTime") String sTime, @Param("eTime") String eTime);

    List<OverflowListGoods> getOverflowListGoodsByOverflowListId(Integer overflowListId);
}
