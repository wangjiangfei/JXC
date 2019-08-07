package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.CustomerReturnListGoodsDao;
import com.wangjiangfei.service.CustomerReturnListGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author wangjiangfei
 * @date 2019/8/7 9:00
 * @description
 */
@Service
public class CustomerReturnListGoodsServiceImpl implements CustomerReturnListGoodsService {

    @Autowired
    private CustomerReturnListGoodsDao customerReturnListGoodsDao;

    @Override
    public Integer getCustomerReturnTotalByGoodsId(Integer goodsId) {
        Integer n = customerReturnListGoodsDao.getCustomerReturnTotalByGoodsId(goodsId);

        return n == null ? 0 : n;
    }
}
