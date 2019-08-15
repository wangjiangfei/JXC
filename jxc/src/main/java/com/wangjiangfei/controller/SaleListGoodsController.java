package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.SaleList;
import com.wangjiangfei.service.SaleListGoodsService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/7 15:36
 * @description 销售商品Controller层
 */
@RestController
@RequestMapping("/saleListGoods")
public class SaleListGoodsController {

    @Autowired
    private SaleListGoodsService saleListGoodsService;

    /**
     * 保存销售单信息
     * @param saleList 销售单信息实体
     * @param saleListGoodsStr 销售商品信息JSON字符串
     * @return
     */
    @RequestMapping("/save")
    @RequiresPermissions(value = "销售出库")
    public ServiceVO save(SaleList saleList, String saleListGoodsStr) {
        return saleListGoodsService.save(saleList, saleListGoodsStr);
    }

    /**
     * 查询销售单
     * @param saleNumber 单号
     * @param customerId 客户ID
     * @param state 付款状态
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(value={"销售单据查询","客户统计"},logical= Logical.OR)
    public Map<String,Object> list(String saleNumber, Integer customerId, Integer state, String sTime,
                                   String eTime) {
        return saleListGoodsService.list(saleNumber, customerId, state, sTime, eTime);
    }

    /**
     * 查询销售单商品信息
     * @param saleListId 销售单ID
     * @return
     */
    @RequestMapping("/goodsList")
    @RequiresPermissions(value={"销售单据查询","客户统计"},logical=Logical.OR)
    public Map<String,Object> goodsList(Integer saleListId) {
        return saleListGoodsService.goodsList(saleListId);
    }

    /**
     * 删除销售单及商品信息
     * @param saleListId 销售单ID
     * @return
     */
    @RequestMapping("/delete")
    @RequiresPermissions(value = "销售单据查询")
    public ServiceVO delete(Integer saleListId) {
        return saleListGoodsService.delete(saleListId);
    }

    /**
     * 修改销售单付款状态
     * @param saleListId 销售单ID
     * @return
     */
    @RequestMapping("/updateState")
    @RequiresPermissions(value = "供应商统计")
    public ServiceVO updateState(Integer saleListId) {
        return saleListGoodsService.updateState(saleListId);
    }

    /**
     * 销售商品统计
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @param goodsTypeId 商品类别ID
     * @param codeOrName 编号或商品名称
     * @return
     */
    @RequestMapping("/count")
    @RequiresPermissions(value="商品销售统计")
    public String count(String sTime, String eTime ,Integer goodsTypeId, String codeOrName) {
        return saleListGoodsService.count(sTime, eTime, goodsTypeId, codeOrName);
    }

    /**
     * 按日统计销售情况
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     */
    @RequestMapping("/getSaleDataByDay")
    @RequiresPermissions(value = "按日统计分析")
    public String getSaleDataByDay(String sTime, String eTime) {
        return saleListGoodsService.getSaleDataByDay(sTime, eTime);
    }

    /**
     * 按月统计销售情况
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     */
    @RequestMapping("/getSaleDataByMonth")
    @RequiresPermissions(value = "按月统计分析")
    public String getSaleDataByMonth(String sTime, String eTime) {
        return saleListGoodsService.getSaleDataByMonth(sTime, eTime);
    }
}
