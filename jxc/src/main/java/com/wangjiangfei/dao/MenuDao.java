package com.wangjiangfei.dao;


import com.wangjiangfei.entity.Menu;

import java.util.List;

public interface MenuDao {

    List<Menu> getMenuByRoleId(Integer roleId);
}
