package com.wangjiangfei.dao;

import com.wangjiangfei.entity.PurchaseList;
import com.wangjiangfei.entity.PurchaseListGoods;

/**
 * @author wangjiangfei
 * @date 2019/8/2 9:33
 * @description
 */
public interface PurchaseListGoodsDao {

    Integer savePurchaseList(PurchaseList purchaseList);

    Integer savePurchaseListGoods(PurchaseListGoods p);

}
