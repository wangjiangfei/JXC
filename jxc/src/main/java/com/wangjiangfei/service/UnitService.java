package com.wangjiangfei.service;

import com.wangjiangfei.domain.ServiceVO;
import com.wangjiangfei.entity.Unit;

import java.util.Map;

/**
 * @author wangjiangfei
 * @date 2019/7/26 17:28
 * @description
 */
public interface UnitService {

    ServiceVO save(Unit unit);

    ServiceVO delete(Integer unitId);

    Map<String,Object> list();
}
