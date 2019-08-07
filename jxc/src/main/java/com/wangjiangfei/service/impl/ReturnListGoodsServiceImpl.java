package com.wangjiangfei.service.impl;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.ReturnListGoodsDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.ReturnListGoodsService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/4 9:51
 * @description
 */
@Service
public class ReturnListGoodsServiceImpl implements ReturnListGoodsService {

    @Autowired
    private LogService logService;
    @Autowired
    private UserDao userDao;
    @Autowired
    private ReturnListGoodsDao returnListGoodsDao;
    @Autowired
    private GoodsDao goodsDao;

    @Override
    public ServiceVO save(ReturnList returnList, String returnListGoodsStr) {

        // 使用谷歌Gson将JSON字符串数组转换成具体的集合
        Gson gson = new Gson();

        List<ReturnListGoods> returnListGoodsList = gson.fromJson(returnListGoodsStr,new TypeToken<List<ReturnListGoods>>(){}.getType());

        // 设置当前操作用户
        User currentUser = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());

        returnList.setUserId(currentUser.getUserId());

        // 保存退货单信息
        returnListGoodsDao.saveReturnList(returnList);

        // 保存退货单商品信息
        for(ReturnListGoods returnListGoods : returnListGoodsList){

            returnListGoods.setReturnListId(returnList.getReturnListId());

            returnListGoods.setGoodsTypeId(goodsDao.findByGoodsId(returnListGoods.getGoodsId()).getGoodsTypeId());

            returnListGoodsDao.saveReturnListGoods(returnListGoods);

            // 修改商品库存，状态
            Goods goods = goodsDao.findByGoodsId(returnListGoods.getGoodsId());

            goods.setInventoryQuantity(goods.getInventoryQuantity()-returnListGoods.getGoodsNum());

            goods.setState(2);

            goodsDao.updateGoods(goods);

        }

        // 保存日志
        logService.save(new Log(Log.INSERT_ACTION, "新增退货单："+returnList.getReturnNumber()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> list(String returnNumber, Integer supplierId, Integer state, String sTime, String eTime) {
        Map<String,Object> result = new HashMap<>();

        List<ReturnList> returnListList = returnListGoodsDao.getReturnlist(returnNumber, supplierId, state, sTime, eTime);

        logService.save(new Log(Log.SELECT_ACTION, "退货单据查询"));

        result.put("rows", returnListList);

        return result;
    }

    @Override
    public Map<String, Object> goodsList(Integer returnListId) {
        Map<String,Object> map = new HashMap<>();

        List<ReturnListGoods> returnListGoodsList = returnListGoodsDao.getReturnListGoodsByReturnListId(returnListId);

        logService.save(new Log(Log.SELECT_ACTION, "退货单商品信息查询"));

        map.put("rows", returnListGoodsList);

        return map;
    }

    @Override
    public ServiceVO delete(Integer returnListId) {

        logService.save(new Log(Log.DELETE_ACTION, "删除退货单："+returnListGoodsDao.getReturnList(returnListId).getReturnNumber()));

        returnListGoodsDao.deleteReturnListGoodsByReturnListId(returnListId);

        returnListGoodsDao.deleteReturnListById(returnListId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }
}
