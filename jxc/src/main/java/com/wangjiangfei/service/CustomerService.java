package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Customer;

import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/25 16:34
 * @description
 */
public interface CustomerService {

    Map<String,Object> list(Integer page, Integer rows, String customerName);

    ServiceVO save(Customer customer);

    ServiceVO delete(String ids);

    List<Customer> getComboboxList(String q);
}
