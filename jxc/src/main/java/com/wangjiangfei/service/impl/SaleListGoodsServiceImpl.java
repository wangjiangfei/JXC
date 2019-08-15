package com.wangjiangfei.service.impl;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.GoodsTypeDao;
import com.wangjiangfei.dao.SaleListGoodsDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.SaleListGoodsService;
import com.wangjiangfei.util.BigDecimalUtil;
import com.wangjiangfei.util.DateUtil;
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
    @Autowired
    private GoodsTypeDao goodsTypeDao;

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

    @Override
    public String count(String sTime, String eTime, Integer goodsTypeId, String codeOrName) {

        JsonArray result = new JsonArray();

        try {

            List<SaleList> saleListList = saleListGoodsDao.getSalelist(null, null, null, sTime, eTime);

            for(SaleList pl : saleListList){

                List<SaleListGoods> saleListGoodsList = saleListGoodsDao
                        .getSaleListGoods(pl.getSaleListId(), goodsTypeId, codeOrName);

                for(SaleListGoods pg : saleListGoodsList){

                    JsonObject obj = new JsonObject();

                    obj.addProperty("number", pl.getSaleNumber());

                    obj.addProperty("date", pl.getSaleDate());

                    obj.addProperty("customerName", pl.getCustomerName());

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

            logService.save(new Log(Log.SELECT_ACTION, "销售商品统计查询"));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result.toString();
    }

    @Override
    public String getSaleDataByDay(String sTime, String eTime) {
        JsonArray result = new JsonArray();

        try {

            // 获取所有的时间段日期
            List<String> dateList = DateUtil.getTimeSlotByDay(sTime, eTime);

            // 查询按日统计的数据
            List<SaleData> obList = saleListGoodsDao.getSaleDataByDay(sTime, eTime);

            // 按日统计的数据，如果该日期没有数据的话，则不会有显示，我们的需求是，如果该日期没有销售数据的话，也应该显示为0，所以需要进行特殊处理
            for (String date : dateList) {

                JsonObject obj = new JsonObject();

                boolean flag = false;

                for(SaleData o : obList) {

                    if(o.getDate().equals(date)){

                        obj.addProperty("date", o.getDate()); //日期

                        obj.addProperty("saleTotal", BigDecimalUtil.keepTwoDecimalPlaces(o.getSaleTotal())); //销售总额

                        obj.addProperty("purchasingTotal", BigDecimalUtil.keepTwoDecimalPlaces(o.getPurchasingTotal())); //成本总额

                        obj.addProperty("profit",BigDecimalUtil.keepTwoDecimalPlaces(o.getSaleTotal() - o.getPurchasingTotal())); //利润

                        flag = true;

                        break;

                    }

                }

                if (!flag) {// 如果没有销售数据，那么也需要设置该日的销售数据默认为0

                    obj.addProperty("date", date); //日期

                    obj.addProperty("saleTotal", 0); //销售总额

                    obj.addProperty("purchasingTotal", 0); //成本总额

                    obj.addProperty("profit",0); //利润

                }

                result.add(obj);

            }

            logService.save(new Log(Log.SELECT_ACTION, "查询按日统计分析数据"));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result.toString();
    }

    @Override
    public String getSaleDataByMonth(String sTime, String eTime) {
        JsonArray result = new JsonArray();

        try {

            // 获取所有的时间段日期
            List<String> dateList = DateUtil.getTimeSlotByMonth(sTime, eTime);

            // 查询按日统计的数据
            List<SaleData> obList = saleListGoodsDao.getSaleDataByMonth(sTime, eTime);

            // 按日统计的数据，如果该日期没有数据的话，则不会有显示，我们的需求是，如果该日期没有销售数据的话，也应该显示为0，所以需要进行特殊处理
            for(String date : dateList){

                JsonObject obj = new JsonObject();

                boolean flag = false;

                for (SaleData o : obList) {

                    if(o.getDate().equals(date)){

                        obj.addProperty("date", o.getDate()); //日期

                        obj.addProperty("saleTotal", BigDecimalUtil.keepTwoDecimalPlaces(o.getSaleTotal())); //销售总额

                        obj.addProperty("purchasingTotal", BigDecimalUtil.keepTwoDecimalPlaces(o.getPurchasingTotal())); //成本总额

                        obj.addProperty("profit",BigDecimalUtil.keepTwoDecimalPlaces(o.getSaleTotal() - o.getPurchasingTotal())); //利润

                        flag = true;

                    }

                }

                if(!flag){// 如果没有销售数据，那么也需要设置该日的销售数据默认为0

                    obj.addProperty("date", date); //日期

                    obj.addProperty("saleTotal", 0); //销售总额

                    obj.addProperty("purchasingTotal", 0); //成本总额

                    obj.addProperty("profit",0); //利润

                }

                result.add(obj);

            }

            logService.save(new Log(Log.SELECT_ACTION, "查询按月统计分析数据"));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result.toString();
    }
}
