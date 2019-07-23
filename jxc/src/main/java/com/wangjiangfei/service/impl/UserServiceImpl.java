package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.RoleDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.dao.UserRoleDao;
import com.wangjiangfei.domain.ErrorCode;
import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.domain.SuccessCode;
import com.wangjiangfei.entity.*;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private LogService logService;
    @Autowired
    private UserRoleDao userRoleDao;

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

    @Override
    public Map<String, Object> list(Integer page, Integer rows, String userName) {
        Map<String,Object> map = new HashMap<>();

        page = page == 0 ? 1 : page;
        int offSet = (page - 1) * rows;
        List<User> users = userDao.getUserList(offSet, rows, userName);

        for (User user : users) {

            List<Role> roles = roleDao.getRoleByUserId(user.getUserId());

            StringBuffer sb = new StringBuffer();

            for(Role role : roles) {

                sb.append(","+role.getRoleName());

            }

            user.setRoles(sb.toString().replaceFirst(",", ""));

        }

        logService.save(new Log(Log.SELECT_ACTION,"分页查询用户信息"));

        map.put("total", userDao.getUserCount(userName));

        map.put("rows", users);

        return map;
    }

    @Override
    public ServiceVO save(User user) {

        // 用户ID为空时，说明是新增操作，需要先判断用户名是否存在
        if(user.getUserId() == null){

            User exUser = userDao.findUserByName(user.getUserName());

            if (exUser != null) {
                return new ServiceVO(ErrorCode.ACCOUNT_EXIST_CODE, ErrorCode.ACCOUNT_EXIST_MESS);
            }

            userDao.addUser(user);
            logService.save(new Log(Log.INSERT_ACTION,"添加用户:"+user.getUserName()));

        } else {

            userDao.updateUser(user);
            logService.save(new Log(Log.UPDATE_ACTION,"修改用户:"+user.getUserName()));

        }

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO delete(Integer userId) {

        logService.save(new Log(Log.DELETE_ACTION,"删除用户:"+userDao.getUserById(userId).getUserName()));

        userRoleDao.deleteUserRoleByUserId(userId);

        userDao.deleteUser(userId);

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO setRole(Integer userId, String roles) {

        // 先删除当前用户的所有角色
        userRoleDao.deleteUserRoleByUserId(userId);

        // 再赋予当前用户新的角色
        String[] roleArray = roles.split(",");

        for(String str : roleArray){

            UserRole ur = new UserRole();

            ur.setRoleId(Integer.parseInt(str));

            ur.setUserId(userId);

            userRoleDao.addUserRole(ur);

        }

        logService.save(new Log(Log.UPDATE_ACTION,"设置用户"+userDao.getUserById(userId).getUserName()+"的角色权限"));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }

    @Override
    public ServiceVO updatePassword(String newPassword, HttpSession session) {
        User user = (User) session.getAttribute("currentUser");

        user.setPassword(newPassword);

        userDao.updateUser(user);

        logService.save(new Log(Log.UPDATE_ACTION,"修改密码"));

        return new ServiceVO<>(SuccessCode.SUCCESS_CODE, SuccessCode.SUCCESS_MESS);
    }
}
