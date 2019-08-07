package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.SaleListGoodsDao;
import com.wangjiangfei.service.SaleListGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author wangjiangfei
 * @date 2019/8/7 8:57
 * @description
 */
@Service
public class SaleListGoodsServiceImpl implements SaleListGoodsService {

    @Autowired
    private SaleListGoodsDao saleListGoodsDao;

    @Override
    public Integer getSaleTotalByGoodsId(Integer goodsId) {
        Integer n = saleListGoodsDao.getSaleTotalByGoodsId(goodsId);

        return n == null ? 0 : n;
    }
}
