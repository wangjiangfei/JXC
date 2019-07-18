package com.wangjiangfei.dao;


import com.wangjiangfei.entity.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuDao {

    List<Menu> getMenuByRoleId(Integer roleId);

    List<Menu> getMenuByParentId(@Param("parentId") Integer parentId, @Param("roleId") Integer roleId);
}
