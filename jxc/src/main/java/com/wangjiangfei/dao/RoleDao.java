package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleDao {

    // 根据用户id查询用户角色
    List<Role> getRoleByUserId(Integer userId);

    // 根据角色id和用户id查询角色
    Role getRoleByRoleIdUserId(@Param("roleId") Integer roleId, @Param("userId") Integer userId);

    // 根据角色名称模糊分页查询角色列表
    List<Role> getRoleList(@Param("offSet") Integer offSet,@Param("pageRow") Integer pageRow,@Param("roleName") String roleName);

    // 根据角色名称模糊查询角色列表的数量
    Integer getRoleCount(@Param("roleName") String roleName);
}
