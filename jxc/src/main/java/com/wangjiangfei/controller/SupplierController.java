package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Supplier;
import com.wangjiangfei.service.SupplierService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/25 8:44
 * @description 供应商Controller控制器
 */
@RestController
@RequestMapping("/supplier")
public class SupplierController {

    @Autowired
    private SupplierService supplierService;

    /**
     * 查询下拉框供应商信息
     * @param q 供应商名称
     * @return
     */
    @RequestMapping("/getComboboxList")
    @RequiresPermissions(value={"进货入库","退货出库","进货单据查询","退货单据查询","供应商统计"},logical= Logical.OR)
    public List<Supplier> getComboboxList(String q) {
        return supplierService.getComboboxList(q);
    }

    /**
     * 分页查询供应商
     * @param page 当前页数
     * @param rows 每页显示的记录数
     * @param supplierName 供应商名
     * @return
     */
    @RequestMapping("/list")
    @RequiresPermissions(value = "供应商管理")// 有供应商管理菜单权限的才给予调用
    public Map<String,Object> list(Integer page, Integer rows, String supplierName) {
        return supplierService.list(page, rows, supplierName);
    }

    /**
     * 添加或修改供应商
     * @param supplier 供应商实体
     * @return
     */
    @RequestMapping("/save")
    @RequiresPermissions(value = "供应商管理")
    public ServiceVO save(Supplier supplier) {
        return supplierService.save(supplier);
    }

    /**
     * 删除供应商
     * @param ids 供应商ids字符串，用逗号分隔
     * @return
     */
    @RequestMapping("/delete")
    @RequiresPermissions(value = "供应商管理")
    public ServiceVO delete(String ids) {
        return supplierService.delete(ids);
    }
}
