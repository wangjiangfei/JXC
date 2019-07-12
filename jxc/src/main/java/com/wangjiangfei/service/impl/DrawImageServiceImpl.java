package com.wangjiangfei.service.impl;

import com.wangjiangfei.service.DrawImageService;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * @author wangjiangfei
 * @date 2019/6/14 20:39
 * @description
 */
@Service
public class DrawImageServiceImpl implements DrawImageService {

    private static final int WIDTH = 120;
    private static final int HEIGHT = 30;

    // 验证码字符集
    private static final char[] chars = {
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
            'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

    @Override
    public void drawImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        // 创建缓存
        BufferedImage bi = new BufferedImage(WIDTH, HEIGHT,
                BufferedImage.TYPE_INT_RGB);
        // 获得画布
        Graphics g = bi.getGraphics();

        // 设置背影色
        setBackGround(g);
        // 设置边框
        setBorder(g);
        // 画干扰线
        drawRandomLine(g);
        // 写随机数
        String random = drawRandomNum((Graphics2D) g);
        // 将随机汉字存在session中
        request.getSession().setAttribute("checkcode", random);
        // 将图形写给浏览器
        response.setContentType("image/jpeg");
        // 发头控制浏览器不要缓存
        response.setDateHeader("expries", -1);
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");
        // 将图片写给浏览器
        ImageIO.write(bi, "jpg", response.getOutputStream());
    }

    /**
     * 设置背景色
     *
     * @param g
     */
    private void setBackGround(Graphics g) {
        // 设置颜色
        g.setColor(new Color(22, 160, 133));
        // 填充区域
        g.fillRect(0, 0, WIDTH, HEIGHT);

    }

    /**
     * 设置边框
     *
     * @param g
     */
    private void setBorder(Graphics g) {
        // 设置边框颜色
        g.setColor(new Color(22, 160, 133));
        // 边框区域
        g.drawRect(1, 1, WIDTH - 2, HEIGHT - 2);
    }

    /**
     * 画随机线条
     *
     * @param g
     */
    private void drawRandomLine(Graphics g) {
        // 设置颜色
        g.setColor(Color.WHITE);
        // 设置线条个数并画线
        for (int i = 0; i < 5; i++) {
            int x1 = new Random().nextInt(WIDTH);
            int y1 = new Random().nextInt(HEIGHT);
            int x2 = new Random().nextInt(WIDTH);
            int y2 = new Random().nextInt(HEIGHT);
            g.drawLine(x1, y1, x2, y2);
        }

    }

    /**
     * 画随机字符
     * @param g
     * @return
     */
    private String drawRandomNum(Graphics2D g) {
        StringBuffer sb = new StringBuffer();
        // 设置颜色
        g.setColor(Color.WHITE);
        // 设置字体
        g.setFont(new Font("宋体", Font.BOLD, 20));

        int x = 5;
        // 控制字数
        for (int i = 0; i < 4; i++) {
            // 设置字体旋转角度
            int degree = new Random().nextInt() % 30;
            // 截取随机字符索引
            int n = new Random().nextInt(chars.length);
            sb.append(chars[n]);
            // 正向角度
            g.rotate(degree * Math.PI / 180, x, 20);
            g.drawString(chars[n] + "", x, 20);
            // 反向角度
            g.rotate(-degree * Math.PI / 180, x, 20);
            x += 30;
        }
        return sb.toString();
    }
}
