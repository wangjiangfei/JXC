package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Role;

import javax.servlet.http.HttpSession;

/**
 * @author wangjiangfei
 * @date 2019/7/18 15:09
 * @description
 */
public interface RoleService {

    ServiceVO saveRole(Role role, HttpSession session);
}
