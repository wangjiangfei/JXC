package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Supplier;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/25 8:54
 * @description
 */
public interface SupplierDao {

    List<Supplier> getSupplierList(@Param("offSet") Integer offSet, @Param("pageRow") Integer pageRow, @Param("supplierName") String supplierName);

    Integer getSupplierCount(@Param("supplierName") String supplierName);

    Integer saveSupplier(Supplier supplier);

    Integer updateSupplier(Supplier supplier);

    Supplier getSupplierById(Integer supplierId);

    Integer deleteSupplier(Integer supplierId);

    List<Supplier> getSupplierListByNameLike(@Param("q") String q);

}
