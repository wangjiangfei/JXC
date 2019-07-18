package com.wangjiangfei.service.impl;

import com.wangjiangfei.dao.LogDao;
import com.wangjiangfei.dao.UserDao;
import com.wangjiangfei.entity.Log;
import com.wangjiangfei.entity.User;
import com.wangjiangfei.service.LogService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author wangjiangfei
 * @date 2019/7/14 10:48
 * @description
 */
@Service
public class LogServiceImpl implements LogService {

    @Autowired
    private LogDao logDao;
    @Autowired
    private UserDao userDao;

    @Override
    public void save(Log log) {
        log.setLogDate(new Date());
        User user = userDao.findUserByName((String) SecurityUtils.getSubject().getPrincipal());
        log.setUserId(user.getUserId());
        logDao.save(log);
    }
}
