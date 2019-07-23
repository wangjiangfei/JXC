package com.wangjiangfei.controller;

import com.wangjiangfei.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wangjiangfei
 * @date 2019/7/22 9:30
 * @description 系统日志
 */
@RestController
@RequestMapping("/log")
public class LogController {

    @Autowired
    private LogService logService;

    /**
     * 分页查询日志信息
     * @param logType 日志类型
     * @param trueName 操作人员
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @param page 当前页数
     * @param rows 每页条数
     * @return
     */
    @RequestMapping("/list")
    public String list(String logType,String trueName,String sTime,String eTime,Integer page,Integer rows) {
        return logService.list(logType, trueName, sTime, eTime, page, rows);
    }

}
