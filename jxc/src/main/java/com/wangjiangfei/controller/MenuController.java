package com.wangjiangfei.controller;

import com.wangjiangfei.service.MenuService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

/**
 * @author wangjiangfei
 * @date 2019/7/18 15:50
 * @description 菜单控制器
 */
@RestController
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    /**
     * 查询当前角色的导航菜单
     * @param session 用户从缓冲中取出当前的登录角色
     * @return easyui要求的JSON格式字符串
     */
    @RequestMapping("/loadMenu")
    public String loadMenu(HttpSession session) {
        return menuService.loadMenu(session);
    }

    /**
     * 查询所有菜单，并选中当前角色所拥有的菜单
     * @return easyui要求的JSON格式字符串
     */
    @RequestMapping("/loadCheckMenu")
    @RequiresPermissions(value = "角色管理")
    public String loadCheckMenu(Integer roleId) {
        return menuService.loadCheckMenu(roleId);
    }

}
