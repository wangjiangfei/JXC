package com.wangjiangfei.dao;

import com.wangjiangfei.entity.UserRole;

/**
 * @author wangjiangfei
 * @date 2019/7/22 8:51
 * @description
 */
public interface UserRoleDao {

    // 根据用户id删除用户角色
    Integer deleteUserRoleByUserId(Integer userId);

    // 为用户添加角色
    Integer addUserRole(UserRole userRole);
}
