package com.wangjiangfei.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/6/14 20:53
 * @description 用户信息Controller控制器
 */
@Controller
@RequestMapping("/user")
public class UserController {

    /**
     * 系统登录
     * @param request 请求
     * @param session 用于取出系统生成的验证码
     * @return 登录结果JSON
     */
    @RequestMapping("/login")
    @ResponseBody
    public Map<String,Object> login(HttpServletRequest request, HttpSession session){

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String imageCode = request.getParameter("imageCode");

        Map<String,Object> map = new HashMap<String,Object>();

        try {

            if(StringUtil.isEmpty(userName)){

                map.put("resultCode",ResultCode.FAIL);

                map.put("resultContent", "请输入用户名");

                return map;

            }

            if(StringUtil.isEmpty(password)){

                map.put("resultCode",ResultCode.FAIL);

                map.put("resultContent", "请输入密码");

                return map;

            }

            if(StringUtil.isEmpty(imageCode)){

                map.put("resultCode", ResultCode.FAIL);

                map.put("resultContent", "请输入验证码");

                return map;

            }

            if(!imageCode.toUpperCase().equals(session.getAttribute("checkcode"))){

                map.put("resultCode",ResultCode.FAIL);

                map.put("resultContent", "验证码输入有误");

                return map;
            }


            //开始进行登录效验
            Subject subject = SecurityUtils.getSubject();

            UsernamePasswordToken token = new UsernamePasswordToken(userName, password);

            subject.login(token);

            //登录成功后，开始查询用户的角色
            User user = userService.findUserByName(userName);

            List<Role> roles = roleService.getRoleByUserId(user.getId());

            session.setAttribute("currentUser", user);

            logService.save(new Log(Log.LOGIN_ACTION,"登录系统"));

            map.put("roleList", roles);

            map.put("resultCode",ResultCode.SUCCESS);

            map.put("resultContent", "登录成功");

            return map;

        } catch (AuthenticationException e) {//如果抛出AuthenticationException异常，说明登录效验未通过

            e.printStackTrace();

            map.put("resultCode",ResultCode.FAIL);

            map.put("resultContent", "用户名或密码错误");

            return map;

        } catch(Exception e){

            e.printStackTrace();

            map.put("resultCode",ResultCode.ERROR);

            map.put("resultContent", "系统正忙，请稍后重试");

            return map;

        }

    }
}
