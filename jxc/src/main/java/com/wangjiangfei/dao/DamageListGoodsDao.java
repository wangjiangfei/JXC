package com.wangjiangfei.dao;

import com.wangjiangfei.entity.DamageList;
import com.wangjiangfei.entity.DamageListGoods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/8/11 6:36
 * @description
 */
public interface DamageListGoodsDao {

    Integer saveDamageList(DamageList damageList);

    Integer saveDamageListGoods(DamageListGoods damageListGoods);

    List<DamageList> getDamagelist(@Param("sTime") String sTime,@Param("eTime") String eTime);

    List<DamageListGoods> getDamageListGoodsByDamageListId(Integer damageListId);
}
