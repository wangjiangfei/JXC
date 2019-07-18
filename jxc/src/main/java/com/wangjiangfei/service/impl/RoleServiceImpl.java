package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.User;
import com.wangjiangfei.service.RoleService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

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

    @Override
    public ServiceVO saveRole(Role role, HttpSession session) {
        User user = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());
        Role roleDB = roleDao.getRoleByRoleIdUserId(role.getRoleId(), user.getUserId());
        // 将用户选择的角色信息放入缓存，以便以后加载权限的时候使用
        session.setAttribute("currentRole", roleDB);
        System.out.println("db the role --->" + roleDB);
        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }
}
