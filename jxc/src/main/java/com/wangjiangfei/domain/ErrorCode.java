package com.wangjiangfei.domain;

/**
 * @author wangjiangfei
 * @date 2019/5/29 9:20
 * @description 错误码
 */
public interface ErrorCode {

    int SQL_ERROR_CODE = 112;
    String SQL_ERROR_MESS = "此操作不被允许，请联系管理员";

    int PARA_TYPE_ERROR_CODE = 113;
    String PARA_TYPE_ERROR_MESS = "参数类型不合法";

    int NULL_POINTER_CODE = 124;
    String NULL_POINTER_MESS = "空指针异常";

    int TIME_OUT_CODE = 126;
    String TIME_OUT_MESS = "后台处理超时";

    int CONSTRAINT_VIOLATION_CODE = 167;
    String CONSTRAINT_VIOLATION_MESS = "外键约束异常";

    int NO_AUTH_CODE = 250;
    String NO_AUTH_MESS = "无权限访问, 权限不足";

    int NAME_PASSWORD_ERROR_CODE = 300;
    String NAME_PASSWORD_ERROR_MESS = "用户名或密码错误";

    int VERIFY_CODE_ERROR_CODE = 301;
    String VERIFY_CODE_ERROR_MESS = "验证码输入有误";

    int REQ_ERROR_CODE = 400;
    String REQ_ERROR_MESS = "请求处理异常，请稍后再试";

    int REQ_METHOD_ERR_CODE = 500;
    String REQ_METHOD_ERR_MESS = "请求方式有误,请检查 GET/POST";

    int NO_EXIST_PATH_CODE = 501;
    String NO_EXIST_PATH_MESS = "请求路径不存在";

    int ROLE_DEL_ERROR_CODE = 10008;
    String ROLE_DEL_ERROR_MESS = "角色删除失败,尚有用户属于此角色";

    int ACCOUNT_EXIST_CODE = 10009;
    String ACCOUNT_EXIST_MESS = "账户已存在";

    int ROLE_EXIST_CODE = 10010;
    String ROLE_EXIST_MESS = "角色已存在";

    int NO_TOKEN_CODE = 20010;
    String NO_TOKEN_MESS = "无token，请重新登录";

    int LOGIN_EXPIRE_CODE = 20011;
    String LOGIN_EXPIRE_MESS = "登陆已过期,请重新登陆";

    int LACK_PARA_CODE = 90003;
    String LACK_PARA_MESS = "缺少必填参数";

    int DATA_SAVE_ERR_CODE = 90004;
    String DATA_SAVE_ERR_MESS = "数据库存储失败";

}
