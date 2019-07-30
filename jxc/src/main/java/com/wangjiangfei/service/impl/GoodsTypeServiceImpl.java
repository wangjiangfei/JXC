package com.wangjiangfei.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.wangjiangfei.dao.GoodsTypeDao;
import com.wangjiangfei.domain.ErrorCode;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.Goods;
import com.wangjiangfei.entity.GoodsType;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.service.GoodsTypeService;
import com.wangjiangfei.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/26 9:33
 * @description
 */
@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {

    @Autowired
    private LogService logService;
    @Autowired
    private GoodsTypeDao goodsTypeDao;

    @Override
    public ServiceVO delete(Integer goodsTypeId) {

        // 根据商品类别ID来查询商品信息，如果该类别下有商品信息，则不给予删除
        List<Goods> goodsList = goodsTypeDao.getGoodsByTypeId(goodsTypeId);

        if (goodsList.size() != 0) {

            return new ServiceVO<>(ErrorCode.GOODS_TYPE_ERROR_CODE, ErrorCode.GOODS_TYPE_ERROR_MESS);
        }

        // 这里的逻辑是先根据商品类别ID查询出商品类别的信息，找到商品类别的父级商品类别
        // 如果父商品类别的子商品类别信息等于1，那么再删除商品信息的时候，父级商品类别的状态也应该从根节点改为叶子节点
        GoodsType goodsType = goodsTypeDao.getGoodsTypeById(goodsTypeId);

        List<GoodsType> goodsTypeList = goodsTypeDao.getAllGoodsTypeByParentId(goodsType.getPId());

        if(goodsTypeList.size() == 1){

            GoodsType parentGoodsType = goodsTypeDao.getGoodsTypeById(goodsType.getPId());

            parentGoodsType.setGoodsTypeState(0);

            goodsTypeDao.updateGoodsTypeState(parentGoodsType);

        }

        goodsTypeDao.delete(goodsTypeId);

        logService.save(new Log(Log.DELETE_ACTION,"删除商品类别："+goodsType.getGoodsTypeName()));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }

    @Override
    public ServiceVO save(String goodsTypeName, Integer pId) {

        GoodsType goodsType = new GoodsType(goodsTypeName,0,pId);

        goodsTypeDao.saveGoodsType(goodsType);

        // 根据父类ID来查询父类实体
        GoodsType parentGoodsType = goodsTypeDao.getGoodsTypeById(pId);

        // 如果当前父商品类别是叶子节点，则需要修改为状态为根节点
        if(parentGoodsType.getGoodsTypeState() == 0) {

            parentGoodsType.setGoodsTypeState(1);

            goodsTypeDao.updateGoodsTypeState(parentGoodsType);

        }

        logService.save(new Log(Log.INSERT_ACTION, "新增商品类别:"+goodsTypeName));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public String loadGoodsType() {
        logService.save(new Log(Log.SELECT_ACTION, "查询商品类别信息"));

        return this.getAllGoodsType(-1).toString(); // 根节点默认从-1开始
    }

    /**
     * 递归查询所有商品类别
     * @return
     */
    public JsonArray getAllGoodsType(Integer parentId){

        JsonArray array = this.getGoodSTypeByParentId(parentId);

        for(int i = 0;i < array.size();i++){

            JsonObject obj = (JsonObject) array.get(i);

            if(obj.get("state").getAsString().equals("open")){// 如果是叶子节点，不再递归

                continue;

            }else{// 如果是根节点，继续递归查询

                obj.add("children", this.getAllGoodsType(obj.get("id").getAsInt()));

            }

        }

        return array;
    }

    /**
     * 根据父ID获取所有子商品类别
     * @return
     */
    public JsonArray getGoodSTypeByParentId(Integer parentId){

        JsonArray array = new JsonArray();

        List<GoodsType> goodsTypeList = goodsTypeDao.getAllGoodsTypeByParentId(parentId);

        //遍历商品类别
        for(GoodsType goodsType : goodsTypeList){

            JsonObject obj = new JsonObject();

            obj.addProperty("id", goodsType.getGoodsTypeId());//ID

            obj.addProperty("text", goodsType.getGoodsTypeName());//类别名称

            if(goodsType.getGoodsTypeState() == 1){

                obj.addProperty("state", "closed"); //根节点

            }else{

                obj.addProperty("state", "open");//叶子节点

            }

            obj.addProperty("iconCls", "goods-type");//图标默认为自定义的商品类别图标

            JsonObject attributes = new JsonObject(); //扩展属性

            attributes.addProperty("state", goodsType.getGoodsTypeState());//就加入当前节点的类型

            obj.add("attributes", attributes);

            array.add(obj);

        }

        return array;
    }
}
