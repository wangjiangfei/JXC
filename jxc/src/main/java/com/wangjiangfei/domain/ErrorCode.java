package com.wangjiangfei.domain;

/**
 * @author wangjiangfei
 * @date 2019/5/29 9:20
 * @description 错误码
 */
public interface ErrorCode {

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

    int GOODS_TYPE_ERROR_CODE = 302;
    String GOODS_TYPE_ERROR_MESS = "该商品类别下有商品，无法删除";

    int REQ_ERROR_CODE = 400;
    String REQ_ERROR_MESS = "请求处理异常，请稍后再试";

    int STORED_ERROR_CODE = 401;
    String STORED_ERROR_MESS = "该商品已入库，不能删除";

    int HAS_FORM_ERROR_CODE = 402;
    String HAS_FORM_ERROR_MESS = "该商品有进货或销售单据，不能删除";

    int REQ_METHOD_ERR_CODE = 500;
    String REQ_METHOD_ERR_MESS = "请求方式有误,请检查 GET/POST";

    int NO_EXIST_PATH_CODE = 501;
    String NO_EXIST_PATH_MESS = "请求路径不存在";

    int ROLE_DEL_ERROR_CODE = 10008;
    String ROLE_DEL_ERROR_MESS = "角色删除失败,尚有用户属于此角色";

    int ACCOUNT_EXIST_CODE = 10009;
    String ACCOUNT_EXIST_MESS = "用户名已存在";

    int ROLE_EXIST_CODE = 10010;
    String ROLE_EXIST_MESS = "角色已存在";

    int NO_TOKEN_CODE = 20010;
    String NO_TOKEN_MESS = "无token，请重新登录";

    int LOGIN_EXPIRE_CODE = 20011;
    String LOGIN_EXPIRE_MESS = "登陆已过期,请重新登陆";


}
