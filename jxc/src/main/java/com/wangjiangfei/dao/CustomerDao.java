package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/25 16:50
 * @description
 */
public interface CustomerDao {

    List<Customer> getCustomerList(@Param("offSet") Integer offSet, @Param("pageRow") Integer pageRow, @Param("customerName") String customerName);

    Integer getCustomerCount(@Param("customerName") String customerName);

    Integer saveCustomer(Customer customer);

    Integer updateCustomer(Customer customer);

    Customer getCustomerById(Integer customerId);

    Integer deleteCustomer(Integer customerId);

    List<Customer> getCustomerListByNameLike(@Param("q") String q);
}
