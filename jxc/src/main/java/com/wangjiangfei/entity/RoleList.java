package com.wangjiangfei.entity;

import lombok.Data;

import java.util.List;

@Data
public class RoleList {

    private List<Role> roleList;
    private Integer page;
    private Integer rows;
    private Integer total;

}
