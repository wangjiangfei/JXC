package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.service.RoleService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/18 12:09
 * @description 角色Controller控制器
 */
@RestController
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 保存用户登录时所选择的角色
     * @param role
     * @param session
     * @return
     */
    @PostMapping("/saveRole")
    public ServiceVO saveRole(@RequestBody Role role, HttpSession session) {
        return roleService.saveRole(role, session);
    }

    /**
     * 查询所有角色信息
     * @return
     */
    // 这里想表达的意思是当前用户拥有用户管理菜单权限或是角色管理菜单权限就可以访问该方法
    // 但Shiro的该注解默认会把该逻辑表达成'与'的关系，所以我们需要手动指定逻辑关系为'或'
    @RequestMapping("/listAll")
    @RequiresPermissions(value = {"用户管理","角色管理"}, logical = Logical.OR)
    public Map<String,Object> listAll() {
        return roleService.listAll();
    }

    /**
     * 分页查询角色信息
     * @param page 当前页数
     * @param rows 每页显示的记录数
     * @param roleName 角色名
     * @return
     */
    @PostMapping("/list")
    @RequiresPermissions(value = "角色管理")
    public Map<String, Object> list(Integer page, Integer rows, String roleName) {
        return roleService.list(page, rows, roleName);
    }

    /**
     * 添加或修改角色信息
     * @param role 角色信息实体
     * @return
     */
    @RequestMapping("/save")
    @RequiresPermissions(value = "角色管理")
    public ServiceVO save(Role role) {
        return roleService.save(role);
    }

    /**
     * 删除角色
     * @param roleId 角色ID
     * @return
     */
    @RequestMapping("/delete")
    @RequiresPermissions(value = "角色管理")
    public ServiceVO delete(Integer roleId) {
        return roleService.delete(roleId);
    }

    /**
     * 设置菜单权限
     * @param roleId 角色ID
     * @param menus 菜单数组字符串，用逗号分割
     * @return
     */
    @RequestMapping("/setMenu")
    @RequiresPermissions(value = "角色管理")
    public ServiceVO setMenu(Integer roleId, String menus) {
        return roleService.setMenu(roleId, menus);
    }
}
