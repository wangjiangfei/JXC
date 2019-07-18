package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.domain.ErrorCode;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.User;
import com.wangjiangfei.entity.UserLogin;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/14 9:06
 * @description
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private LogService logService;

    @Override
    public ServiceVO login(UserLogin userLogin, HttpSession session) {
        try {
            // 校验图片验证码是否正确
            if(!userLogin.getImageCode().toUpperCase().equals(session.getAttribute("checkcode"))){
                return new ServiceVO(ErrorCode.VERIFY_CODE_ERROR_CODE, ErrorCode.VERIFY_CODE_ERROR_MESS);
            }

            //开始进行登录校验
            Subject subject = SecurityUtils.getSubject();

            UsernamePasswordToken token = new UsernamePasswordToken(userLogin.getUserName(), userLogin.getPassword());

            subject.login(token);

            // 登录成功后，开始查询用户的角色
            User user = userDao.findUserByName(userLogin.getUserName());

            List<Role> roles = roleDao.getRoleByUserId(user.getUserId());

            session.setAttribute("currentUser", user);

            logService.save(new Log(Log.LOGIN_ACTION, "登录系统"));

            return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS, roles);

        } catch (AuthenticationException e) {// 如果抛出AuthenticationException异常，说明登录校验未通过
            e.printStackTrace();
            return new ServiceVO(ErrorCode.NAME_PASSWORD_ERROR_CODE, ErrorCode.NAME_PASSWORD_ERROR_MESS);
        } catch(Exception e){
            e.printStackTrace();
            return new ServiceVO(ErrorCode.REQ_ERROR_CODE, ErrorCode.REQ_ERROR_MESS);
        }
    }

    @Override
    public Map<String, Object> loadUserInfo(HttpSession session) {
        Map<String,Object> map = new HashMap<>();

        User user = (User)session.getAttribute("currentUser");
        Role role = (Role) session.getAttribute("currentRole");

        map.put("userName", user.getTrueName());
        map.put("roleName", role.getRoleName());

        return map;
    }
}
