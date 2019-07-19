package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.RoleList;
import com.wangjiangfei.service.RoleService;
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
}
