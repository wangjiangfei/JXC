package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Role;

import java.util.List;

public interface RoleDao {

    List<Role> getRoleByUserId(Integer userId);
}
