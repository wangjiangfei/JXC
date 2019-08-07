package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.ReturnList;
import com.wangjiangfei.service.ReturnListGoodsService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/8/4 9:46
 * @description 退货商品Controller层
 */
@RestController
@RequestMapping("/returnListGoods")
public class ReturnListGoodsController {

    @Autowired
    private ReturnListGoodsService returnListGoodsService;


    /**
     * 保存退货单信息
     * @param returnList 退货单信息实体
     * @param returnListGoodsStr 退货商品信息JSON字符串
     * @return
     */
    @RequestMapping("/save")
    @RequiresPermissions(value = "退货出库")
    public ServiceVO save(ReturnList returnList, String returnListGoodsStr) {
        return returnListGoodsService.save(returnList, returnListGoodsStr);
    }

    /**
     * 查询退货单
     * @param returnNumber 单号
     * @param supplierId 供应商ID
     * @param state 付款状态
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(value={"退货单据查询","供应商统计"},logical= Logical.OR)
    public Map<String,Object> list(String returnNumber,
                                   Integer supplierId,
                                   Integer state,
                                   String sTime,
                                   String eTime) {
        return returnListGoodsService.list(returnNumber, supplierId, state, sTime, eTime);
    }

    /**
     * 查询退货单商品信息
     * @param returnListId 退货单ID
     * @return
     */
    @RequestMapping("/goodsList")
    @RequiresPermissions(value={"退货单据查询","供应商统计"},logical = Logical.OR)
    public Map<String,Object> goodsList(Integer returnListId) {
        return returnListGoodsService.goodsList(returnListId);
    }

    /**
     * 删除退货单及商品信息
     * @param returnListId 退货单ID
     * @return
     */
    @RequestMapping("/delete")
    @RequiresPermissions(value = "退货单据查询")
    public ServiceVO delete(Integer returnListId) {
        return returnListGoodsService.delete(returnListId);
    }

    /**
     * 修改进货单付款状态
     * @param id 进货单ID
     * @return
     */
//    @RequestMapping("/updateState")
//    @RequiresPermissions(value="供应商统计")
//    public Map<String,Object> updateState(Integer id){
//
//        Map<String,Object> map = new HashMap<String,Object>();
//
//        try {
//
//            returnListGoodsService.updateState(1, id);
//
//            logService.save(new Log(Log.DELETE_ACTION, "支付结算退货单："+returnListGoodsService.getReturnList(id).getReturnNumber()));
//
//            map.put("resultCode", ResultCode.SUCCESS);
//
//            map.put("resultContent", "退货单结算成功");
//
//        } catch (Exception e) {
//
//            map.put("resultCode", ResultCode.FAIL);
//
//            map.put("resultContent", "退货单结算失败");
//
//            e.printStackTrace();
//
//        }
//
//        return map;
//
//    }

    /**
     * 进货商品统计
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @param goodsTypeId 商品类别ID
     * @param codeOrName 编号或商品名称
     * @return
     */
//    @RequestMapping("/count")
//    @RequiresPermissions(value="商品采购统计")
//    public String count(String sTime, String eTime ,Integer goodsTypeId, String codeOrName){
//
//        JsonArray result = new JsonArray();
//
//        try {
//
//            List<ReturnList> returnListList = returnListGoodsService.getReturnlist(null, null, null, sTime, eTime);
//
//            for(ReturnList pl : returnListList){
//
//                List<ReturnListGoods> returnListGoodsList = returnListGoodsService
//                        .getReturnListGoodsByReturnListId(pl.getId(), goodsTypeId, codeOrName);
//
//                for(ReturnListGoods pg : returnListGoodsList){
//
//                    JsonObject obj = new JsonObject();
//
//                    obj.addProperty("number", pl.getReturnNumber());
//
//                    obj.addProperty("date", pl.getReturnDate());
//
//                    obj.addProperty("supplierName", pl.getSupplier().getName());
//
//                    obj.addProperty("code", pg.getCode());
//
//                    obj.addProperty("name", pg.getName());
//
//                    obj.addProperty("model", pg.getModel());
//
//                    obj.addProperty("goodsType", pg.getType().getName());
//
//                    obj.addProperty("unit", pg.getUnit());
//
//                    obj.addProperty("price", pg.getPrice());
//
//                    obj.addProperty("num", pg.getNum());
//
//                    obj.addProperty("total", pg.getTotal());
//
//                    result.add(obj);
//
//                }
//            }
//
//            logService.save(new Log(Log.SELECT_ACTION, "退货商品统计查询"));
//
//        } catch (Exception e) {
//
//            e.printStackTrace();
//
//        }
//
//        return result.toString();
//
//    }
}
