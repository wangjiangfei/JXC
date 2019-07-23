package com.wangjiangfei.service;

import com.wangjiangfei.entity.Log;

/**
 * @author wangjiangfei
 * @date 2019/7/14 10:47
 * @description
 */
public interface LogService {

    /**
     * 保存日志
     * @param log 日志实体
     */
    void save(Log log);

    String list(String logType,String trueName,String sTime,String eTime,Integer page,Integer rows);
}
