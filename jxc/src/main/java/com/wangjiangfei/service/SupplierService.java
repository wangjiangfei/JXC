package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Supplier;

import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/25 8:48
 * @description
 */
public interface SupplierService {

    List<Supplier> getComboboxList(String q);

    Map<String,Object> list(Integer page, Integer rows, String supplierName);

    ServiceVO save(Supplier supplier);

    ServiceVO delete(String ids);
}
