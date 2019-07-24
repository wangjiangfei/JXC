package com.wangjiangfei.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
public class Log {

  private Integer logId;
  private String logType;
  private String content;
  private Date logDate;
  private Integer userId;

  public static final String LOGIN_ACTION = "登录操作";

  public static final String LOGOUT_ACTION = "登出操作";

  public static final String SELECT_ACTION = "查询操作";

  public static final String INSERT_ACTION = "新增操作";

  public static final String UPDATE_ACTION = "修改操作";

  public static final String DELETE_ACTION = "删除操作";

  public Log(String logType, String content) {
      this.logType = logType;
      this.content = content;
  }

}
