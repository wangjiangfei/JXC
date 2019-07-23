package com.wangjiangfei.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author wangjiangfei
 * @date 2019/7/22 9:37
 * @description
 */
public class DateUtil {

    /**
     * 将时间字符串按指定的格式转换成Date
     * @param date 时间字符串
     * @param format 时间字符串的格式
     * @return
     * @throws ParseException
     */
    public static Date StringToDate(String date,String format) throws ParseException{

        SimpleDateFormat sdf = new SimpleDateFormat(format);

        if(StringUtil.isNotEmpty(date)){

            return sdf.parse(date);

        }else{

            return null;

        }
    }

    /**
     * 将Date按指定格式转换成时间字符串
     * @param date 要转化的Date
     * @param format 要转化的格式
     * @return
     */
    public static String DateToString(Date date,String format){

        SimpleDateFormat sdf = new SimpleDateFormat(format);

        if(date!=null){

            return sdf.format(date);

        }else{

            return "";
        }

    }

    /**
     * 按传入的时间段，获得所有时间日期集合  格式按yyyy-MM-dd
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     * @throws Exception
     */
    public static List<String> getTimeSlotByDay(String sTime, String eTime) throws Exception{

        List<String> timeSlotList = new ArrayList<String>();

        Calendar cs = Calendar.getInstance();

        Calendar ce = Calendar.getInstance();

        cs.setTime(StringToDate(sTime,"yyyy-MM-dd"));

        ce.setTime(StringToDate(eTime,"yyyy-MM-dd"));

        while(cs.before(ce)){// 如果时间段在结束时间之前，那么则放入集合后天数加1，再次循环，否则跳出循环

            timeSlotList.add(DateToString(cs.getTime(),"yyyy-MM-dd"));

            cs.add(Calendar.DAY_OF_MONTH, 1);

        }

        timeSlotList.add(eTime); // Calendar的before方法是不包含当前比较时间的，所以我们需要把当前的结束时间最后单独放入集合中

        return timeSlotList;
    }

    /**
     * 按传入的时间段，获得所有时间日期集合 格式按yyyy-MM
     * @param sTime 开始时间
     * @param eTime 结束时间
     * @return
     * @throws Exception
     */
    public static List<String> getTimeSlotByMonth(String sTime, String eTime) throws Exception{

        List<String> timeSlotList = new ArrayList<String>();

        Calendar cs = Calendar.getInstance();

        Calendar ce = Calendar.getInstance();

        cs.setTime(StringToDate(sTime,"yyyy-MM"));

        ce.setTime(StringToDate(eTime,"yyyy-MM"));

        while(cs.before(ce)){// 如果时间段在结束时间之前，那么则放入集合后天数加1，再次循环，否则跳出循环

            timeSlotList.add(DateToString(cs.getTime(),"yyyy-MM"));

            cs.add(Calendar.MONTH, 1);

        }

        timeSlotList.add(eTime); // Calendar的before方法是不包含当前比较时间的，所以我们需要把当前的结束时间最后单独放入集合中

        return timeSlotList;
    }
}
