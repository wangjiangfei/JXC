package com.wangjiangfei.service.impl;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.SaleListGoodsDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.SaleListGoodsService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/8/7 8:57
 * @description
 */
@Service
public class SaleListGoodsServiceImpl implements SaleListGoodsService {

    @Autowired
    private SaleListGoodsDao saleListGoodsDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private LogService logService;
    @Autowired
    private GoodsDao goodsDao;

    @Override
    public Integer getSaleTotalByGoodsId(Integer goodsId) {
        Integer n = saleListGoodsDao.getSaleTotalByGoodsId(goodsId);

        return n == null ? 0 : n;
    }

    @Override
    public ServiceVO save(SaleList saleList, String saleListGoodsStr) {
        // 使用谷歌Gson将JSON字符串数组转换成具体的集合
        Gson gson = new Gson();

        List<SaleListGoods> saleListGoodsList = gson.fromJson(saleListGoodsStr,new TypeToken<List<SaleListGoods>>(){}.getType());

        // 设置当前操作用户
        User currentUser = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());

        saleList.setUserId(currentUser.getUserId());

        // 保存销售单信息
        saleListGoodsDao.saveSaleList(saleList);

        // 保存销售单商品信息
        for(SaleListGoods saleListGoods : saleListGoodsList){

            saleListGoods.setSaleListId(saleList.getSaleListId());

            saleListGoodsDao.saveSaleListGoods(saleListGoods);

            // 修改商品库存，状态
            Goods goods = goodsDao.findByGoodsId(saleListGoods.getGoodsId());

            goods.setInventoryQuantity(goods.getInventoryQuantity()-saleListGoods.getGoodsNum());

            goods.setState(2);

            goodsDao.updateGoods(goods);

        }

        // 保存日志
        logService.save(new Log(Log.INSERT_ACTION, "新增销售单："+saleList.getSaleNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }
}
