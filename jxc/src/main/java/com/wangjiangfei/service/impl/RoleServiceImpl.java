package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.RoleMenuDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ErrorCode;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.RoleService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/18 15:09
 * @description
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private LogService logService;
    @Autowired
    private RoleMenuDao roleMenuDao;

    @Override
    public ServiceVO saveRole(Role role, HttpSession session) {
        User user = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());
        Role roleDB = roleDao.getRoleByRoleIdUserId(role.getRoleId(), user.getUserId());
        // 将用户选择的角色信息放入缓存，以便以后加载权限的时候使用
        session.setAttribute("currentRole", roleDB);
        System.out.println("db the role --->" + roleDB);
        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public Map<String, Object> listAll() {
        Map<String,Object> map = new HashMap<>();

        List<Role> roleList = roleDao.findAll();

        logService.save(new Log(Log.SELECT_ACTION, "查询所有角色信息"));

        map.put("rows", roleList);

        return map;
    }

    @Override
    public Map<String, Object> list(Integer page, Integer rows, String roleName) {
        Map<String, Object> map = new HashMap<>();

        int total = roleDao.getRoleCount(roleName);
        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;
        List<Role> roles = roleDao.getRoleList(offSet, rows, roleName);

        logService.save(new Log(Log.SELECT_ACTION, "分页查询角色信息"));

        map.put("total", total);
        map.put("rows", roles);

        return map;
    }

    @Override
    public ServiceVO save(Role role) {

        // 角色ID为空时，说明是新增操作，需要先判断角色名是否存在
        if(role.getRoleId() == null) {

            Role exRole = roleDao.findRoleByName(role.getRoleName());

            if(exRole != null) {

                return new ServiceVO<>(ErrorCode.ROLE_EXIST_CODE, ErrorCode.ROLE_EXIST_MESS);

            }

            logService.save(new Log(Log.INSERT_ACTION, "新增角色:" + role.getRoleName()));

            roleDao.insertRole(role);

        } else {

            logService.save(new Log(Log.UPDATE_ACTION, "修改角色:"+role.getRoleName()));

            roleDao.updateRole(role);

        }

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }

    @Override
    public ServiceVO delete(Integer roleId) {
        int count = roleDao.countUserByRoleId(roleId);
        if (count > 0) {
            return new ServiceVO<>(ErrorCode.ROLE_DEL_ERROR_CODE, ErrorCode.ROLE_DEL_ERROR_MESS);
        }

        roleMenuDao.deleteRoleMenuByRoleId(roleId);

        logService.save(new Log(Log.DELETE_ACTION,"删除角色:"+roleDao.getRoleById(roleId).getRoleName()));

        roleDao.deleteRole(roleId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);

    }

    @Override
    public ServiceVO setMenu(Integer roleId, String menus) {
        // 先删除当前角色的所有菜单
        roleMenuDao.deleteRoleMenuByRoleId(roleId);

        // 再赋予当前角色新的菜单
        String[] menuArray = menus.split(",");

        for(String str : menuArray){

            RoleMenu rm = new RoleMenu();

            rm.setRoleId(roleId);

            rm.setMenuId(Integer.parseInt(str));

            roleMenuDao.save(rm);

        }

        logService.save(new Log(Log.UPDATE_ACTION,"设置"+roleDao.getRoleById(roleId).getRoleName()+"角色的菜单权限"));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }
}
