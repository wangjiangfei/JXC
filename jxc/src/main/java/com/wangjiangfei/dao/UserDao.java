package com.wangjiangfei.dao;

import com.wangjiangfei.entity.User;

/**
 * @author wangjiangfei
 * @date 2019/7/14 9:44
 * @description
 */
public interface UserDao {

    // 根据用户名查找用户
    User findUserByName(String userName);
}
