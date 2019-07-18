package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.UserLogin;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/14 9:06
 * @description
 */
public interface UserService {

    ServiceVO login(UserLogin userLogin, HttpSession session);

    Map<String,Object> loadUserInfo(HttpSession session);
}
