package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.service.GoodsTypeService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wangjiangfei
 * @date 2019/7/26 9:32
 * @description 商品类别控制器
 */
@RestController
@RequestMapping("/goodsType")
public class GoodsTypeController {

    @Autowired
    private GoodsTypeService goodsTypeService;

    /**
     * 删除商品类别
     * @param goodsTypeId 商品类别ID
     * @return
     */
    @RequestMapping("/delete")
    @RequiresPermissions(value = {"商品管理","进货入库","退货出库","销售出库","客户退货","商品报损","商品报溢"},logical=Logical.OR)
    public ServiceVO delete(Integer goodsTypeId) {
        return goodsTypeService.delete(goodsTypeId);
    }

    /**
     * 添加商品类别
     * @param goodsTypeName 类别名
     * @param pId 父类ID
     * @return
     */
    @RequestMapping("/save")
    @RequiresPermissions(value={"商品管理","进货入库","退货出库","销售出库","客户退货","商品报损","商品报溢"},logical = Logical.OR)
    public ServiceVO save(String goodsTypeName,Integer pId) {
        return goodsTypeService.save(goodsTypeName, pId);
    }

    /**
     * 查询所有商品类别
     * @return easyui要求的JSON格式字符串
     */
    @RequestMapping("/loadGoodsType")
    @RequiresPermissions(value={"商品管理","进货入库","退货出库","销售出库","客户退货","当前库存查询","商品报损","商品报溢","商品采购统计"},logical = Logical.OR)
    public String loadGoodsType() {
        return goodsTypeService.loadGoodsType();
    }

}
