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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public Map<String, Object> list(String saleNumber, Integer customerId, Integer state, String sTime, String eTime) {
        Map<String,Object> result = new HashMap<>();

        try {

            List<SaleList> saleListList = saleListGoodsDao.getSalelist(saleNumber, customerId, state, sTime, eTime);

            logService.save(new Log(Log.SELECT_ACTION, "销售单据查询"));

            result.put("rows", saleListList);

        } catch (Exception e) {

            e.printStackTrace();

        }
        return result;
    }

    @Override
    public Map<String, Object> goodsList(Integer saleListId) {
        Map<String,Object> map = new HashMap<>();

        try {

            List<SaleListGoods> saleListGoodsList = saleListGoodsDao.getSaleListGoodsBySaleListId(saleListId);

            logService.save(new Log(Log.SELECT_ACTION, "销售单商品信息查询"));

            map.put("rows", saleListGoodsList);

        } catch (Exception e) {

            e.printStackTrace();

        }

        return map;
    }

    @Override
    public ServiceVO delete(Integer saleListId) {

        logService.save(new Log(Log.DELETE_ACTION, "删除销售单："+saleListGoodsDao.getSaleList(saleListId).getSaleNumber()));

        saleListGoodsDao.deleteSaleListGoodsBySaleListId(saleListId);

        saleListGoodsDao.deleteSaleListById(saleListId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO updateState(Integer saleListId) {

        saleListGoodsDao.updateState(saleListId);

        logService.save(new Log(Log.DELETE_ACTION, "支付结算销售单："+saleListGoodsDao.getSaleList(saleListId).getSaleNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }
}
