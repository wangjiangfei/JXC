package com.wangjiangfei.controller;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.entity.Role;
import com.wangjiangfei.entity.User;
import com.wangjiangfei.entity.UserLogin;
import com.wangjiangfei.service.LogService;
import com.wangjiangfei.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/13 13:55
 * @description 用户信息Controller控制器
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private LogService logService;

    /**
     * 系统登录
     * @param userLogin
     * @param session 用于取出系统生成的验证码
     * @return 登录结果JSON
     */
    @PostMapping("/login")
    @ResponseBody
    public ServiceVO login(@RequestBody UserLogin userLogin, HttpSession session){
        return userService.login(userLogin, session);
    }

    /**
     * 从缓存中获取当前登录的用户相关信息，包括用户真实姓名和角色名称
     * @param session
     * @return
     */
    @GetMapping("/loadUserInfo")
    @ResponseBody
    public Map<String,Object> loadUserInfo(HttpSession session) {
        return userService.loadUserInfo(session);
    }

    /**
     * 安全退出
     * @return
     */
    @GetMapping("/logOut")
    @RequiresPermissions(value = "安全退出")
    public String logOut(HttpSession session){

        logService.save(new Log(Log.LOGOUT_ACTION,"用户注销"));

        //清除shiro用户信息
        SecurityUtils.getSubject().logout();

        return "redirect:login.html";
    }
}
