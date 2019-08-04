package com.wangjiangfei.util;

import java.math.BigDecimal;

/**
 * @author wangjiangfei
 * @date 2019/8/2 10:42
 * @description 数学工具类
 */
public class BigDecimalUtil {

    /**
     * 保留两位小数
     * @param marth 需要处理的数据
     * @return 保留两位小数的浮点型数据
     */
    public static float keepTwoDecimalPlaces(float marth){

        BigDecimal decimal = new BigDecimal(marth);

        return decimal.setScale(2, BigDecimal.ROUND_HALF_EVEN).floatValue();

    }

    /**
     * 保留两位小数
     * @param marth 需要处理的数据
     * @return 保留两位小数的浮点型数据
     */
    public static float keepTwoDecimalPlaces(Double marth){

        BigDecimal decimal = new BigDecimal(marth);

        return decimal.setScale(2, BigDecimal.ROUND_HALF_EVEN).floatValue();

    }

}

