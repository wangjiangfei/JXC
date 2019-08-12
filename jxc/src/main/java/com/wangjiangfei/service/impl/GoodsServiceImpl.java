package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.GoodsDao;
import com.wangjiangfei.dao.SaleListGoodsDao;
import com.wangjiangfei.domain.ErrorCode;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.Goods;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.service.CustomerReturnListGoodsService;
import com.wangjiangfei.service.GoodsService;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.SaleListGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/27 17:22
 * @description
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private LogService logService;
    @Autowired
    private GoodsDao goodsDao;
    @Autowired
    private SaleListGoodsService saleListGoodsService;
    @Autowired
    private CustomerReturnListGoodsService customerReturnListGoodsService;

    @Override
    public Map<String, Object> list(Integer page, Integer rows, String goodsName, Integer goodsTypeId) {
        Map<String,Object> map = new HashMap<>();

        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;

        // 查询类别ID为当前ID或父ID为当前类别ID的商品
        List<Goods> goodsList = goodsDao.getGoodsList(offSet, rows, goodsName, goodsTypeId);

        map.put("rows", goodsList);

        map.put("total", goodsDao.getGoodsCount(goodsName, goodsTypeId));

        logService.save(new Log(Log.SELECT_ACTION, "分页查询商品信息"));

        return map;
    }

    @Override
    public Map<String, Object> listInventory(Integer page, Integer rows, String codeOrName, Integer goodsTypeId) {
        Map<String,Object> map = new HashMap<>();

        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;

        List<Goods> goodsList = goodsDao.getGoodsInventoryList(offSet, rows, codeOrName, goodsTypeId);

        for (Goods goods : goodsList) {
            // 销售总量等于销售单据的销售数据减去退货单据的退货数据
            goods.setSaleTotal(saleListGoodsService.getSaleTotalByGoodsId(goods.getGoodsId())
                    - customerReturnListGoodsService.getCustomerReturnTotalByGoodsId(goods.getGoodsId()));

        }

        map.put("rows", goodsList);

        map.put("total", goodsDao.getGoodsInventoryCount(codeOrName, goodsTypeId));

        logService.save(new Log(Log.SELECT_ACTION, "分页查询商品库存信息"));

        return map;
    }

    @Override
    public ServiceVO getCode() {

        // 获取当前商品最大编码
        String code = goodsDao.getMaxCode();

        // 在现有编码上加1
        Integer intCode = Integer.parseInt(code) + 1;

        // 将编码重新格式化为4位数字符串形式
        String unitCode = intCode.toString();

        for(int i = 4;i > intCode.toString().length();i--){

            unitCode = "0"+unitCode;

        }
        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS, unitCode);
    }

    @Override
    public ServiceVO save(Goods goods) {

        if(goods.getGoodsId() == null){

            logService.save(new Log(Log.INSERT_ACTION,"添加商品:"+goods.getGoodsName()));
            // 设置上一次采购价为当前采购价
            goods.setLastPurchasingPrice(goods.getPurchasingPrice());
            goods.setInventoryQuantity(0);
            goods.setState(0);
            goodsDao.saveGoods(goods);

        }else{

            goodsDao.updateGoods(goods);
            logService.save(new Log(Log.UPDATE_ACTION,"修改商品:"+goods.getGoodsName()));

        }

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }

    @Override
    public ServiceVO delete(Integer goodsId) {

        Goods goods = goodsDao.findByGoodsId(goodsId);

        if (goods.getState() == 1) {

            return new ServiceVO<>(ErrorCode.STORED_ERROR_CODE, ErrorCode.STORED_ERROR_MESS);

        } else if (goods.getState() == 2) {

            return new ServiceVO<>(ErrorCode.HAS_FORM_ERROR_CODE, ErrorCode.HAS_FORM_ERROR_MESS);

        } else {

            logService.save(new Log(Log.DELETE_ACTION,"删除商品:"+goods.getGoodsName()));

            goodsDao.deleteGoods(goodsId);

        }

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> getNoInventoryQuantity(Integer page, Integer rows, String nameOrCode) {
        Map<String,Object> map = new HashMap<>();

        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;

        List<Goods> goodsList = goodsDao.getNoInventoryQuantity(offSet, rows, nameOrCode);

        map.put("rows", goodsList);

        map.put("total", goodsDao.getNoInventoryQuantityCount(nameOrCode));

        logService.save(new Log(Log.SELECT_ACTION, "分页查询商品信息（无库存）"));

        return map;
    }

    @Override
    public Map<String, Object> getHasInventoryQuantity(Integer page, Integer rows, String nameOrCode) {
        Map<String,Object> map = new HashMap<>();

        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;

        List<Goods> goodsList = goodsDao.getHasInventoryQuantity(offSet, rows, nameOrCode);

        map.put("rows", goodsList);

        map.put("total", goodsDao.getHasInventoryQuantityCount(nameOrCode));

        logService.save(new Log(Log.SELECT_ACTION, "分页查询商品信息（有库存）"));

        return map;
    }

    @Override
    public ServiceVO saveStock(Integer goodsId, Integer inventoryQuantity, double purchasingPrice) {

        Goods goods = goodsDao.findByGoodsId(goodsId);

        goods.setInventoryQuantity(inventoryQuantity);

        goods.setPurchasingPrice(purchasingPrice);

        goods.setLastPurchasingPrice(purchasingPrice);

        goodsDao.updateGoods(goods);

        logService.save(new Log(Log.UPDATE_ACTION,goods.getGoodsName()+"商品期初入库"));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO deleteStock(Integer goodsId) {

        Goods goods = goodsDao.findByGoodsId(goodsId);

        if (goods.getState() == 2) {

            return new ServiceVO<>(ErrorCode.HAS_FORM_ERROR_CODE, ErrorCode.HAS_FORM_ERROR_MESS);
        }

        goods.setInventoryQuantity(0);
        goodsDao.updateGoods(goods);

        logService.save(new Log(Log.UPDATE_ACTION,goods.getGoodsName()+"商品清除库存"));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> listAlarm() {
        Map<String,Object> map = new HashMap<>();

        List<Goods> goodsList = goodsDao.getGoodsAlarm();

        map.put("rows", goodsList);

        logService.save(new Log(Log.SELECT_ACTION, "查询库存报警商品信息"));

        return map;
    }
}
