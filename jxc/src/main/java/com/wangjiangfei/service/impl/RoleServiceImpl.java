package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.UserDao;
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
}
