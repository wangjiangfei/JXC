package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Log;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface LogDao {

    // 保存日志
    Integer save(Log log);

    // 根据条件获取日志列表
    List<Log> getLogList(
            @Param("logType") String logType,
            @Param("trueName") String trueName,
            @Param("sTime") Date sTime,
            @Param("eTime") Date eTime,
            @Param("offSet") Integer offSet,
            @Param("pageRow") Integer pageRow);

    // 根据条件获取日志列表的数量
    Long getLogCount(
            @Param("logType") String logType,
            @Param("trueName") String trueName,
            @Param("sTime") Date sTime,
            @Param("eTime") Date eTime);

    // 根据日志id获取用户真实姓名
    String getTrueNameByLogId(Integer logId);
}
