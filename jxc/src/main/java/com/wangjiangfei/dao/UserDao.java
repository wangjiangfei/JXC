package com.wangjiangfei.dao;

import com.wangjiangfei.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/14 9:44
 * @description
 */
public interface UserDao {

    // 根据用户名查找用户
    User findUserByName(String userName);

    // 根据用户名称模糊分页查询用户列表
    List<User> getUserList(@Param("offSet") Integer offSet,@Param("pageRow") Integer pageRow,@Param("userName") String userName);

    // 根据用户名称模糊查询用户列表的数量
    Integer getUserCount(@Param("userName") String userName);

    // 新增用户
    Integer addUser(User user);

    // 更新用户
    Integer updateUser(User user);

    // 根据用户id查询用户
    User getUserById(Integer userId);

    // 根据用户id删除用户
    Integer deleteUser(Integer userId);


}
