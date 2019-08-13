package com.wangjiangfei.service.impl;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.GoodsTypeDao;
import com.wangjiangfei.dao.PurchaseListGoodsDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.PurchaseListGoodsService;
import com.wangjiangfei.util.BigDecimalUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/2 9:15
 * @description
 */
@Service
public class PurchaseListGoodsServiceImpl implements PurchaseListGoodsService {

    @Autowired
    private LogService logService;
    @Autowired
    private UserDao userDao;
    @Autowired
    private PurchaseListGoodsDao purchaseListGoodsDao;
    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private GoodsTypeDao goodsTypeDao;

    @Override
    public ServiceVO save(PurchaseList purchaseList, String purchaseListGoodsStr) {

        // 使用谷歌Gson将JSON字符串数组转换成具体的集合
        Gson gson = new Gson();

        List<PurchaseListGoods> purchaseListGoodsList = gson.fromJson(purchaseListGoodsStr,new TypeToken<List<PurchaseListGoods>>(){}.getType());

        // 设置当前操作用户
        User currentUser = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());

        purchaseList.setUserId(currentUser.getUserId());

        // 保存进货清单
        purchaseListGoodsDao.savePurchaseList(purchaseList);

        // 保存进货商品列表
        for (PurchaseListGoods p : purchaseListGoodsList) {
            p.setPurchaseListId(purchaseList.getPurchaseListId());
            p.setGoodsTypeId(goodsDao.findByGoodsId(p.getGoodsId()).getGoodsTypeId());
            purchaseListGoodsDao.savePurchaseListGoods(p);

            // 修改商品上一次进货价，进货均价，库存，状态
            Goods goods = goodsDao.findByGoodsId(p.getGoodsId());

            goods.setLastPurchasingPrice(p.getPrice());

            goods.setInventoryQuantity(goods.getInventoryQuantity() + p.getGoodsNum());

            goods.setPurchasingPrice(BigDecimalUtil.keepTwoDecimalPlaces((goods.getPurchasingPrice()+p.getPrice())/2));

            goods.setState(2);

            goodsDao.updateGoods(goods);
        }

        // 保存日志
        logService.save(new Log(Log.INSERT_ACTION, "新增进货单："+purchaseList.getPurchaseNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> list(String purchaseNumber, Integer supplierId, Integer state, String sTime, String eTime) {
        Map<String,Object> result = new HashMap<>();


        List<PurchaseList> purchaseListList = purchaseListGoodsDao.getPurchaselist(purchaseNumber, supplierId, state, sTime, eTime);

        logService.save(new Log(Log.SELECT_ACTION, "进货单据查询"));

        result.put("rows", purchaseListList);

        return result;
    }

    @Override
    public Map<String, Object> goodsList(Integer purchaseListId) {
        Map<String, Object> map = new HashMap<>();

        List<PurchaseListGoods> purchaseListGoodsList = purchaseListGoodsDao.getPurchaseListGoodsByPurchaseListId(purchaseListId);

        logService.save(new Log(Log.SELECT_ACTION, "进货单商品信息查询"));

        map.put("rows", purchaseListGoodsList);

        return map;
    }

    @Override
    public ServiceVO delete(Integer purchaseListId) {

        logService.save(new Log(Log.DELETE_ACTION, "删除进货单："+purchaseListGoodsDao.getPurchaseListById(purchaseListId).getPurchaseNumber()));

        purchaseListGoodsDao.deletePurchaseListGoodsByPurchaseListId(purchaseListId);

        purchaseListGoodsDao.deletePurchaseListById(purchaseListId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO updateState(Integer purchaseListId) {
        purchaseListGoodsDao.updateState( purchaseListId);

        logService.save(new Log(Log.DELETE_ACTION, "支付结算进货单："+purchaseListGoodsDao.getPurchaseListById(purchaseListId).getPurchaseNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public String count(String sTime, String eTime, Integer goodsTypeId, String codeOrName) {

        JsonArray result = new JsonArray();

        try {

            List<PurchaseList> purchaseListList = purchaseListGoodsDao.getPurchaselist(null, null, null, sTime, eTime);

            for(PurchaseList pl : purchaseListList){

                List<PurchaseListGoods> purchaseListGoodsList = purchaseListGoodsDao
                        .getPurchaseListGoods(pl.getPurchaseListId(), goodsTypeId, codeOrName);

                for(PurchaseListGoods pg : purchaseListGoodsList){

                    JsonObject obj = new JsonObject();

                    obj.addProperty("number", pl.getPurchaseNumber());

                    obj.addProperty("date", pl.getPurchaseDate());

                    obj.addProperty("supplierName", pl.getSupplierName());

                    obj.addProperty("code", pg.getGoodsCode());

                    obj.addProperty("name", pg.getGoodsName());

                    obj.addProperty("model", pg.getGoodsModel());

                    obj.addProperty("goodsType", goodsTypeDao.getGoodsTypeById(pg.getGoodsTypeId()).getGoodsTypeName());

                    obj.addProperty("unit", pg.getGoodsUnit());

                    obj.addProperty("price", pg.getPrice());

                    obj.addProperty("num", pg.getGoodsNum());

                    obj.addProperty("total", pg.getTotal());

                    result.add(obj);

                }
            }

            logService.save(new Log(Log.SELECT_ACTION, "进货商品统计查询"));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result.toString();
    }
}
