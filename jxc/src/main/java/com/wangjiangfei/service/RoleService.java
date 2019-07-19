package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.RoleList;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/18 15:09
 * @description
 */
public interface RoleService {

    ServiceVO saveRole(Role role, HttpSession session);

    Map<String, Object> list(Integer page, Integer rows, String roleName);
}
