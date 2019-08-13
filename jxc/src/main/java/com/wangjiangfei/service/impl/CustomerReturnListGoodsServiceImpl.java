package com.wangjiangfei.service.impl;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.wangjiangfei.dao.CustomerReturnListGoodsDao;
import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.GoodsTypeDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.CustomerReturnListGoodsService;
import com.wangjiangfei.service.LogService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/7 9:00
 * @description
 */
@Service
public class CustomerReturnListGoodsServiceImpl implements CustomerReturnListGoodsService {

    @Autowired
    private CustomerReturnListGoodsDao customerReturnListGoodsDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private LogService logService;
    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private GoodsTypeDao goodsTypeDao;

    @Override
    public Integer getCustomerReturnTotalByGoodsId(Integer goodsId) {
        Integer n = customerReturnListGoodsDao.getCustomerReturnTotalByGoodsId(goodsId);

        return n == null ? 0 : n;
    }

    @Override
    public ServiceVO save(CustomerReturnList customerReturnList, String customerReturnListGoodsStr) {
        // 使用谷歌Gson将JSON字符串数组转换成具体的集合
        Gson gson = new Gson();

        List<CustomerReturnListGoods> customerReturnListGoodsList = gson.fromJson(customerReturnListGoodsStr,new TypeToken<List<CustomerReturnListGoods>>(){}.getType());

        // 设置当前操作用户
        User currentUser = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());

        customerReturnList.setUserId(currentUser.getUserId());

        // 保存客户退货单信息
        customerReturnListGoodsDao.saveCustomerReturnList(customerReturnList);

        // 保存客户退货单商品信息
        for(CustomerReturnListGoods customerReturnListGoods : customerReturnListGoodsList){

            customerReturnListGoods.setCustomerReturnListId(customerReturnList.getCustomerReturnListId());

            customerReturnListGoodsDao.saveCustomerReturnListGoods(customerReturnListGoods);

            // 修改商品库存，状态
            Goods goods = goodsDao.findByGoodsId(customerReturnListGoods.getGoodsId());

            goods.setInventoryQuantity(goods.getInventoryQuantity()+customerReturnListGoods.getGoodsNum());

            goods.setState(2);

            goodsDao.updateGoods(goods);

        }

        // 保存日志
        logService.save(new Log(Log.INSERT_ACTION, "新增客户退货单："+customerReturnList.getReturnNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> list(String returnNumber, Integer customerId, Integer state, String sTime, String eTime) {
        Map<String,Object> result = new HashMap<>();

        try {

            List<CustomerReturnList> customerReturnListList = customerReturnListGoodsDao.getCustomerReturnlist(returnNumber, customerId, state, sTime, eTime);

            logService.save(new Log(Log.SELECT_ACTION, "客户退货单据查询"));

            result.put("rows", customerReturnListList);

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result;
    }

    @Override
    public Map<String, Object> goodsList(Integer customerReturnListId) {
        Map<String,Object> map = new HashMap<>();

        try {

            List<CustomerReturnListGoods> customerReturnListGoodsList = customerReturnListGoodsDao.getCustomerReturnListGoodsByCustomerReturnListId(customerReturnListId);

            logService.save(new Log(Log.SELECT_ACTION, "客户退货单商品信息查询"));

            map.put("rows", customerReturnListGoodsList);

        } catch (Exception e) {

            e.printStackTrace();

        }

        return map;
    }

    @Override
    public ServiceVO delete(Integer customerReturnListId) {

        logService.save(new Log(Log.DELETE_ACTION, "删除客户退货单："+customerReturnListGoodsDao.getCustomerReturnList(customerReturnListId).getReturnNumber()));

        customerReturnListGoodsDao.deleteCustomerReturnListGoodsByCustomerReturnListId(customerReturnListId);

        customerReturnListGoodsDao.deleteCustomerReturnListById(customerReturnListId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO updateState(Integer customerReturnListId) {

        customerReturnListGoodsDao.updateState(customerReturnListId);

        logService.save(new Log(Log.DELETE_ACTION, "支付结算客户退货单："+customerReturnListGoodsDao.getCustomerReturnList(customerReturnListId).getReturnNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }

    @Override
    public String count(String sTime, String eTime, Integer goodsTypeId, String codeOrName) {

        JsonArray result = new JsonArray();

        try {

            List<CustomerReturnList> customerReturnListList = customerReturnListGoodsDao.getCustomerReturnlist(null, null, null, sTime, eTime);

            for(CustomerReturnList pl : customerReturnListList){

                List<CustomerReturnListGoods> customerReturnListGoodsList = customerReturnListGoodsDao
                        .getCustomerReturnListGoods(pl.getCustomerReturnListId(), goodsTypeId, codeOrName);

                for(CustomerReturnListGoods pg : customerReturnListGoodsList){

                    JsonObject obj = new JsonObject();

                    obj.addProperty("number", pl.getReturnNumber());

                    obj.addProperty("date", pl.getReturnDate());

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

            logService.save(new Log(Log.SELECT_ACTION, "客户退货商品统计查询"));

        } catch (Exception e) {

            e.printStackTrace();

        }

        return result.toString();
    }
}
