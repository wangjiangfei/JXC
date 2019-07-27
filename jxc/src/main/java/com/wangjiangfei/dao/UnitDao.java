package com.wangjiangfei.dao;

import com.wangjiangfei.entity.Unit;

import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/26 17:39
 * @description
 */
public interface UnitDao {

    Integer saveUnit(Unit unit);

    Integer delete(Integer unitId);

    List<Unit> listAll();

    Unit getUnitByUnitId(Integer unitId);
}
