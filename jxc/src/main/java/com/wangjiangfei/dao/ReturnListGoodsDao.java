package com.wangjiangfei.dao;

import com.wangjiangfei.entity.ReturnList;
import com.wangjiangfei.entity.ReturnListGoods;

/**
 * @author wangjiangfei
 * @date 2019/8/4 10:20
 * @description
 */
public interface ReturnListGoodsDao {


    Integer saveReturnList(ReturnList returnList);

    Integer saveReturnListGoods(ReturnListGoods returnListGoods);
}
