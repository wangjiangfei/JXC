package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Goods;
import com.wangjiangfei.service.GoodsService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/26 10:03
 * @description 商品信息Controller
 */
@RestController
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    /**
     * 分页查询商品库存信息
     * @param page 当前页
     * @param rows 每页显示条数
     * @param codeOrName 商品编码或名称
     * @param goodsTypeId 商品类别ID
     * @return
     */
    @RequestMapping("/listInventory")
    @RequiresPermissions(value="当前库存查询")
    public Map<String,Object> listInventory(Integer page, Integer rows, String codeOrName, Integer goodsTypeId) {
        return goodsService.listInventory(page, rows, codeOrName, goodsTypeId);
    }

    /**
     * 分页查询商品信息
     * @param page 当前页
     * @param rows 每页显示条数
     * @param goodsName 商品名称
     * @param goodsTypeId 商品类别ID
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(value={"商品管理","进货入库","退货出库","销售出库","客户退货","商品报损","商品报溢"},logical= Logical.OR)
    public Map<String,Object> list(Integer page, Integer rows, String goodsName, Integer goodsTypeId) {
        return goodsService.list(page, rows, goodsName, goodsTypeId);
    }

    /**
     * 生成商品编码
     * @return
     */
    @RequestMapping("/getCode")
    @RequiresPermissions(value = "商品管理")
    public ServiceVO getCode() {
        return goodsService.getCode();
    }

    /**
     * 添加或修改商品信息
     * @param goods 商品信息实体
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    @RequiresPermissions(value = "商品管理")
    public ServiceVO save(Goods goods) {
        return goodsService.save(goods);
    }

    /**
     * 删除商品信息
     * @param goodsId 商品ID
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions(value="商品管理")
    public ServiceVO delete(Integer goodsId) {
        return goodsService.delete(goodsId);
    }

    /**
     * 分页查询无库存商品信息
     * @param page 当前页
     * @param rows 每页显示条数
     * @param nameOrCode 商品名称或商品编码
     * @return
     */
    @RequestMapping("/getNoInventoryQuantity")
    @RequiresPermissions(value = "期初库存")
    public Map<String,Object> getNoInventoryQuantity(Integer page,Integer rows,String nameOrCode) {
        return goodsService.getNoInventoryQuantity(page, rows, nameOrCode);
    }

    /**
     * 分页查询有库存商品信息
     * @param page 当前页
     * @param rows 每页显示条数
     * @param nameOrCode 商品名称或商品编码
     * @return
     */
    @RequestMapping("/getHasInventoryQuantity")
    @RequiresPermissions(value = "期初库存")
    public Map<String,Object> getHasInventoryQuantity(Integer page,Integer rows,String nameOrCode) {
        return goodsService.getHasInventoryQuantity(page, rows, nameOrCode);
    }

    /**
     * 添加商品期初库存
     * @param goodsId 商品ID
     * @param inventoryQuantity 库存
     * @param purchasingPrice 成本价
     * @return
     */
    @RequestMapping("/saveStock")
    @ResponseBody
    @RequiresPermissions(value = "期初库存")
    public ServiceVO saveStock(Integer goodsId,Integer inventoryQuantity,double purchasingPrice) {
        return goodsService.saveStock(goodsId, inventoryQuantity, purchasingPrice);
    }

    /**
     * 删除商品库存
     * @param goodsId 商品ID
     * @return
     */
    @RequestMapping("/deleteStock")
    @ResponseBody
    @RequiresPermissions(value = "期初库存")
    public ServiceVO deleteStock(Integer goodsId) {
        return goodsService.deleteStock(goodsId);
    }

    /**
     * 查询库存报警商品信息
     * @return
     */
    @RequestMapping("/listAlarm")
    @RequiresPermissions(value = "库存报警")
    public Map<String,Object> listAlarm() {
        return goodsService.listAlarm();
    }
}
