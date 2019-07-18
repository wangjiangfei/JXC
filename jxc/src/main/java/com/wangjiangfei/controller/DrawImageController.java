package com.wangjiangfei.controller;

import com.wangjiangfei.service.DrawImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author wangjiangfei
 * @date 2019/6/14 17:31
 * @description 生成图片验证码
 */
@Controller
public class DrawImageController {

    @Autowired
    private DrawImageService drawImageService;

    /**
     * 生成图片验证码
     * @param request 请求
     * @param response 响应
     */
    @GetMapping("/drawImage")
    public void drawImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        drawImageService.drawImage(request, response);
    }

}
