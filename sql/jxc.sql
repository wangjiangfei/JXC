/*
 Navicat Premium Data Transfer

 Source Server         : wangjiangfei
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : jxc

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 16/08/2019 07:23:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer`  (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户编号id，主键',
  `customer_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contacts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户地址',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES (1, '家乐福（青石桥店）', '张三', '13555555555', '成都市锦江区大业路6号COSMO财富中心F3', '家乐福超市稳定客户');
INSERT INTO `t_customer` VALUES (3, '永辉超市（温江光华大道店）', '李四', '13888888888', '成都市温江区永兴路51号中森·光华1号1-2层', '永辉超市稳定客户');
INSERT INTO `t_customer` VALUES (4, '北京华联空港购物中心', '王五', '028-89460961', '成都市双流区锦华路二段166号北京华联空港购物中心B1', '华联稳定客户');

-- ----------------------------
-- Table structure for t_customer_return_list
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_return_list`;
CREATE TABLE `t_customer_return_list`  (
  `customer_return_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户退货单id，主键',
  `return_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货单号',
  `return_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货日期',
  `amount_paid` float NOT NULL COMMENT '实付金额',
  `amount_payable` float NOT NULL COMMENT '应付金额',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态，是否付款',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT '客户编号id，外键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '操作员，用户id，外键',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`customer_return_list_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_customer_return_list_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_customer_return_list_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_return_list
-- ----------------------------
INSERT INTO `t_customer_return_list` VALUES (1, 'XT1550220103291', '2019-02-15', 42.5, 42.5, 1, 1, 1, '');

-- ----------------------------
-- Table structure for t_customer_return_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_return_list_goods`;
CREATE TABLE `t_customer_return_list_goods`  (
  `customer_return_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户退货单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_num` int(11) NULL DEFAULT NULL COMMENT '客户退货数量',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `customer_return_list_id` int(11) NULL DEFAULT NULL COMMENT '客户退货单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`customer_return_list_goods_id`) USING BTREE,
  INDEX `FKtqt67mbn96lxn8hvtl4piblhi`(`customer_return_list_id`) USING BTREE,
  INDEX `FK32ijokbrx3j6h0p6aa9hcccbq`(`goods_type_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `t_customer_return_list_goods_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_customer_return_list_goods_ibfk_2` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_customer_return_list_goods_ibfk_3` FOREIGN KEY (`customer_return_list_id`) REFERENCES `t_customer_return_list` (`customer_return_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_return_list_goods
-- ----------------------------
INSERT INTO `t_customer_return_list_goods` VALUES (1, 1, '0001', '陶华碧老干妈香辣脆油辣椒', '红色装', 10, '瓶', 8.5, 85, 1, 10);

-- ----------------------------
-- Table structure for t_damage_list
-- ----------------------------
DROP TABLE IF EXISTS `t_damage_list`;
CREATE TABLE `t_damage_list`  (
  `damage_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品报损单id，主键',
  `damage_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品报损单号',
  `damage_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建日期',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`damage_list_id`) USING BTREE,
  INDEX `FKpn094ma69sch1icjc2gu7xus`(`user_id`) USING BTREE,
  CONSTRAINT `t_damage_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_damage_list
-- ----------------------------
INSERT INTO `t_damage_list` VALUES (1, 'BS1550561206988', '2019-02-19', '', 1);
INSERT INTO `t_damage_list` VALUES (2, 'BS1565489147613', '2019-08-11', 'aaaaa', 1);

-- ----------------------------
-- Table structure for t_damage_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_damage_list_goods`;
CREATE TABLE `t_damage_list_goods`  (
  `damage_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品报损单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goods_num` int(11) NULL DEFAULT NULL COMMENT '报损数量',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `damage_list_id` int(11) NULL DEFAULT NULL COMMENT '商品报损单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`damage_list_goods_id`) USING BTREE,
  INDEX `FKbf5m8mm3gctrnuubr9xkjamj8`(`damage_list_id`) USING BTREE,
  INDEX `FK8r7ietq6opa0ci7uxdqc264yf`(`goods_type_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `t_damage_list_goods_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_damage_list_goods_ibfk_2` FOREIGN KEY (`damage_list_id`) REFERENCES `t_damage_list` (`damage_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_damage_list_goods_ibfk_3` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_damage_list_goods
-- ----------------------------
INSERT INTO `t_damage_list_goods` VALUES (1, 14, '0006', '冰糖金桔干', '300g装', '盒', 4, 5, 20, 1, 11);
INSERT INTO `t_damage_list_goods` VALUES (2, 37, '0027', 'aaa', 'aaa', '户', 5, 20, 100, 2, 17);

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`  (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号id，主键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `inventory_quantity` int(11) NOT NULL COMMENT '库存数量',
  `min_num` int(11) NOT NULL COMMENT '库存下限',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_producer` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂商',
  `purchasing_price` float NOT NULL COMMENT '采购价格',
  `last_purchasing_price` float NOT NULL COMMENT '上一次采购价格',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `selling_price` float NOT NULL COMMENT '出售价格',
  `state` int(11) NOT NULL COMMENT '0表示初始值,1表示已入库，2表示有进货或销售单据',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`goods_id`) USING BTREE,
  INDEX `goods_type_id`(`goods_type_id`) USING BTREE,
  CONSTRAINT `t_goods_ibfk_1` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES (1, '0001', '陶华碧老干妈香辣脆油辣椒', 180, 1000, '红色装', '贵州省贵阳南明老干妈风味食品有限公司', 7.95, 8.5, '好卖', 8.5, 2, '瓶', 10);
INSERT INTO `t_goods` VALUES (2, '0002', '华为荣耀Note8', 155, 400, 'Note8', '华为计算机系统有限公司', 2152.51, 2220, '热销', 2200, 2, '台', 16);
INSERT INTO `t_goods` VALUES (11, '0003', '野生东北黑木耳', 2820, 400, '500g装', '辉南县博康土特产有限公司', 23, 23, '够黑2', 38, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (12, '0004', '新疆红枣', 350, 300, '2斤装', '沧州铭鑫食品有限公司', 13, 13, '好吃', 25, 2, '袋', 10);
INSERT INTO `t_goods` VALUES (13, '0005', '麦片燕麦巧克力', 60, 1000, '散装500克', '福建省麦德好食品工业有限公司', 8, 8, 'Goods', 15, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (14, '0006', '冰糖金桔干', 60, 1999, '300g装', '揭西县同心食品有限公司', 5.03, 5, '', 13, 2, '盒', 11);
INSERT INTO `t_goods` VALUES (15, '0007', '吉利人家牛肉味蛋糕', 100630, 400, '500g装', '合肥吉利人家食品有限公司', 4.5, 4.5, 'good', 10, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (16, '0008', '奕森奶油桃肉蜜饯果脯果干桃肉干休闲零食品', 200, 500, '128g装', '潮州市潮安区正大食品有限公司', 3, 3, '', 10, 2, '盒', 11);
INSERT INTO `t_goods` VALUES (17, '0009', '休闲零食坚果特产精品干果无漂白大个开心果', 400, 1000, '240g装', '石家庄博群食品有限公司', 20, 20, '', 33, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (18, '0010', '劲仔小鱼干', 20, 300, '250g装', '湖南省华文食品有限公司', 12, 12, '', 20, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (19, '0011', '山楂条', 11, 300, '198g装', '临朐县七贤升利食品厂', 3.2, 3.2, '', 10, 0, '袋', 11);
INSERT INTO `t_goods` VALUES (20, '0012', '大乌梅干', 22, 200, '500g装', '长春市鼎丰真食品有限责任公司', 20, 20, '', 25, 0, '袋', 11);
INSERT INTO `t_goods` VALUES (21, '0013', '手工制作芝麻香酥麻通', 400, 100, '250g装', '桂林兰雨食品有限公司', 3, 3, '', 8, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (22, '0014', '美国青豆原味 蒜香', 12, 200, '250g装', '菲律宾', 5, 5, '', 8, 2, '袋', 11);
INSERT INTO `t_goods` VALUES (24, '0015', ' iPhone X', 47, 100, 'X', 'xx2', 8000, 8000, 'xxx2', 9500, 2, '台', 16);
INSERT INTO `t_goods` VALUES (25, '0016', '21', 0, 12, 'X', '32', 102, 102, '21', 120, 0, '盒', 3);
INSERT INTO `t_goods` VALUES (26, '0017', 'Sony/索尼 ILCE-A6000L WIFI微单数码相机高清单电', -1, 100, 'ILCE-A6000L', 'xxx', 3000, 3000, 'xxx', 3650, 2, '台', 15);
INSERT INTO `t_goods` VALUES (27, '0018', 'Canon/佳能 IXUS 285 HS 数码相机 2020万像素高清拍摄', -1, 400, 'IXUS 285 HS', 'xx', 800, 800, 'xxx', 1299, 2, '台', 15);
INSERT INTO `t_goods` VALUES (28, '0019', 'Golden Field/金河田 Q8电脑音响台式多媒体家用音箱低音炮重低音', 10, 300, 'Q8', 'xxxx', 65, 70, '', 129, 2, '台', 17);
INSERT INTO `t_goods` VALUES (29, '0020', 'Haier/海尔冰箱BCD-190WDPT双门电冰箱大两门冷藏冷冻', 0, 50, '190WDPT', 'cc', 1000, 1000, '', 1699, 0, '台', 14);
INSERT INTO `t_goods` VALUES (30, '0021', 'Xiaomi/小米 小米电视4A 32英寸 智能液晶平板电视机', 0, 320, '4A ', 'cc', 700, 700, '', 1199, 0, '台', 12);
INSERT INTO `t_goods` VALUES (31, '0022', 'TCL XQB55-36SP 5.5公斤全自动波轮迷你小型洗衣机家用单脱抗菌', 0, 40, 'XQB55-36SP', 'cc', 400, 400, '', 729, 0, '台', 13);
INSERT INTO `t_goods` VALUES (32, '0023', '台湾进口膨化零食品张君雅小妹妹日式串烧丸子80g*2', 0, 1000, '80g*2', 'cc', 4, 4, '', 15, 0, '袋', 9);
INSERT INTO `t_goods` VALUES (33, '0024', '卓图女装立领针织格子印花拼接高腰A字裙2017秋冬新款碎花连衣裙', 0, 10, 'A字裙', 'cc', 168, 168, '', 298, 0, '件', 6);
INSERT INTO `t_goods` VALUES (34, '0025', '西服套装男三件套秋季新款商务修身职业正装男士西装新郎结婚礼服', 0, 10, '三件套秋', 'cc', 189, 189, '', 299, 0, '件', 7);
INSERT INTO `t_goods` VALUES (35, '0026', '加绒加厚正品AFS JEEP/战地吉普男大码长裤植绒保暖男士牛仔裤子', 0, 10, 'AFS JEEP', 'c', 60, 60, '', 89, 0, '条', 8);
INSERT INTO `t_goods` VALUES (37, '0027', 'aaa', 20, 11, 'aaa', 'aaa', 21.1, 21.1, 'aaa', 12.1, 2, '户', 17);

-- ----------------------------
-- Table structure for t_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_type`;
CREATE TABLE `t_goods_type`  (
  `goods_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品类别id，主键',
  `goods_type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品类别名称',
  `p_id` int(11) NULL DEFAULT NULL COMMENT '父商品类别id',
  `goods_type_state` int(11) NULL DEFAULT NULL COMMENT '类别状态，0为叶子节点',
  PRIMARY KEY (`goods_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods_type
-- ----------------------------
INSERT INTO `t_goods_type` VALUES (1, '所有类别', -1, 1);
INSERT INTO `t_goods_type` VALUES (2, '服饰', 1, 1);
INSERT INTO `t_goods_type` VALUES (3, '食品', 1, 1);
INSERT INTO `t_goods_type` VALUES (4, '家电', 1, 1);
INSERT INTO `t_goods_type` VALUES (5, '数码', 1, 1);
INSERT INTO `t_goods_type` VALUES (6, '连衣裙', 2, 0);
INSERT INTO `t_goods_type` VALUES (7, '男士西装', 2, 0);
INSERT INTO `t_goods_type` VALUES (8, '牛仔裤', 2, 0);
INSERT INTO `t_goods_type` VALUES (9, '进口食品', 3, 0);
INSERT INTO `t_goods_type` VALUES (10, '地方特产', 3, 0);
INSERT INTO `t_goods_type` VALUES (11, '休闲食品', 3, 0);
INSERT INTO `t_goods_type` VALUES (12, '电视机', 4, 0);
INSERT INTO `t_goods_type` VALUES (13, '洗衣机', 4, 0);
INSERT INTO `t_goods_type` VALUES (14, '冰箱', 4, 0);
INSERT INTO `t_goods_type` VALUES (15, '相机', 5, 0);
INSERT INTO `t_goods_type` VALUES (16, '手机', 5, 0);
INSERT INTO `t_goods_type` VALUES (17, '音箱', 5, 0);

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志id，主键',
  `log_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `content` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容',
  `log_date` datetime(0) NULL DEFAULT NULL COMMENT '日志时间',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `FKbvn5yabu3vqwvtjoh32i9r4ip`(`user_id`) USING BTREE,
  CONSTRAINT `t_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6056 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_log
-- ----------------------------
INSERT INTO `t_log` VALUES (4193, '登录操作', '登录系统', '2019-07-18 11:13:44', 1);
INSERT INTO `t_log` VALUES (4194, '登录操作', '登录系统', '2019-07-18 11:19:44', 1);
INSERT INTO `t_log` VALUES (4195, '登录操作', '登录系统', '2019-07-18 11:20:23', 1);
INSERT INTO `t_log` VALUES (4196, '登录操作', '登录系统', '2019-07-18 11:20:39', 1);
INSERT INTO `t_log` VALUES (4197, '登录操作', '登录系统', '2019-07-18 11:22:02', 1);
INSERT INTO `t_log` VALUES (4198, '登录操作', '登录系统', '2019-07-18 11:22:27', 1);
INSERT INTO `t_log` VALUES (4199, '登录操作', '登录系统', '2019-07-18 11:22:49', 3);
INSERT INTO `t_log` VALUES (4200, '登录操作', '登录系统', '2019-07-18 11:23:00', 3);
INSERT INTO `t_log` VALUES (4201, '登录操作', '登录系统', '2019-07-18 11:23:07', 3);
INSERT INTO `t_log` VALUES (4202, '登录操作', '登录系统', '2019-07-18 11:24:58', 3);
INSERT INTO `t_log` VALUES (4203, '登录操作', '登录系统', '2019-07-18 11:27:48', 1);
INSERT INTO `t_log` VALUES (4204, '登录操作', '登录系统', '2019-07-18 11:28:05', 3);
INSERT INTO `t_log` VALUES (4205, '登录操作', '登录系统', '2019-07-18 11:33:13', 1);
INSERT INTO `t_log` VALUES (4206, '登录操作', '登录系统', '2019-07-18 11:33:26', 3);
INSERT INTO `t_log` VALUES (4207, '登录操作', '登录系统', '2019-07-18 11:33:48', 3);
INSERT INTO `t_log` VALUES (4208, '登录操作', '登录系统', '2019-07-18 11:36:43', 3);
INSERT INTO `t_log` VALUES (4209, '登录操作', '登录系统', '2019-07-18 11:36:50', 3);
INSERT INTO `t_log` VALUES (4210, '登录操作', '登录系统', '2019-07-18 11:36:55', 3);
INSERT INTO `t_log` VALUES (4211, '登录操作', '登录系统', '2019-07-18 11:38:31', 3);
INSERT INTO `t_log` VALUES (4212, '登录操作', '登录系统', '2019-07-18 11:39:06', 3);
INSERT INTO `t_log` VALUES (4213, '登录操作', '登录系统', '2019-07-18 11:45:22', 3);
INSERT INTO `t_log` VALUES (4214, '登录操作', '登录系统', '2019-07-18 11:46:46', 3);
INSERT INTO `t_log` VALUES (4215, '登录操作', '登录系统', '2019-07-18 11:46:52', 3);
INSERT INTO `t_log` VALUES (4216, '登录操作', '登录系统', '2019-07-18 12:01:59', 3);
INSERT INTO `t_log` VALUES (4217, '登录操作', '登录系统', '2019-07-18 12:02:13', 1);
INSERT INTO `t_log` VALUES (4218, '登录操作', '登录系统', '2019-07-18 15:19:58', 1);
INSERT INTO `t_log` VALUES (4219, '登录操作', '登录系统', '2019-07-18 15:27:06', 1);
INSERT INTO `t_log` VALUES (4220, '登录操作', '登录系统', '2019-07-18 15:29:40', 3);
INSERT INTO `t_log` VALUES (4221, '登录操作', '登录系统', '2019-07-18 15:31:14', 3);
INSERT INTO `t_log` VALUES (4222, '登录操作', '登录系统', '2019-07-18 15:32:40', 3);
INSERT INTO `t_log` VALUES (4223, '登录操作', '登录系统', '2019-07-18 16:22:03', 1);
INSERT INTO `t_log` VALUES (4224, '登录操作', '登录系统', '2019-07-18 16:23:56', 3);
INSERT INTO `t_log` VALUES (4225, '登录操作', '登录系统', '2019-07-18 16:33:12', 1);
INSERT INTO `t_log` VALUES (4226, '登录操作', '登录系统', '2019-07-19 06:59:16', 1);
INSERT INTO `t_log` VALUES (4227, '登录操作', '登录系统', '2019-07-19 07:27:20', 1);
INSERT INTO `t_log` VALUES (4228, '登录操作', '登录系统', '2019-07-19 07:28:13', 1);
INSERT INTO `t_log` VALUES (4229, '登录操作', '登录系统', '2019-07-19 13:31:24', 1);
INSERT INTO `t_log` VALUES (4230, '登录操作', '登录系统', '2019-07-19 13:46:01', 1);
INSERT INTO `t_log` VALUES (4231, '登录操作', '登录系统', '2019-07-19 13:51:11', 1);
INSERT INTO `t_log` VALUES (4232, '登录操作', '登录系统', '2019-07-19 13:54:25', 1);
INSERT INTO `t_log` VALUES (4233, '登录操作', '登录系统', '2019-07-19 14:02:52', 1);
INSERT INTO `t_log` VALUES (4234, '登录操作', '登录系统', '2019-07-19 14:07:19', 1);
INSERT INTO `t_log` VALUES (4235, '查询操作', '分页查询角色信息', '2019-07-19 14:07:23', 1);
INSERT INTO `t_log` VALUES (4236, '查询操作', '分页查询角色信息', '2019-07-19 14:07:23', 1);
INSERT INTO `t_log` VALUES (4237, '查询操作', '分页查询角色信息', '2019-07-19 14:08:05', 1);
INSERT INTO `t_log` VALUES (4238, '查询操作', '分页查询角色信息', '2019-07-19 14:08:05', 1);
INSERT INTO `t_log` VALUES (4239, '登录操作', '登录系统', '2019-07-19 14:09:42', 1);
INSERT INTO `t_log` VALUES (4240, '查询操作', '分页查询角色信息', '2019-07-19 14:09:46', 1);
INSERT INTO `t_log` VALUES (4241, '查询操作', '分页查询角色信息', '2019-07-19 14:09:46', 1);
INSERT INTO `t_log` VALUES (4242, '登录操作', '登录系统', '2019-07-19 14:18:53', 1);
INSERT INTO `t_log` VALUES (4243, '查询操作', '分页查询角色信息', '2019-07-19 14:18:57', 1);
INSERT INTO `t_log` VALUES (4244, '查询操作', '分页查询角色信息', '2019-07-19 14:18:57', 1);
INSERT INTO `t_log` VALUES (4245, '查询操作', '分页查询角色信息', '2019-07-19 14:21:06', 1);
INSERT INTO `t_log` VALUES (4246, '查询操作', '分页查询角色信息', '2019-07-19 14:21:06', 1);
INSERT INTO `t_log` VALUES (4247, '查询操作', '分页查询角色信息', '2019-07-19 14:22:41', 1);
INSERT INTO `t_log` VALUES (4248, '查询操作', '分页查询角色信息', '2019-07-19 14:24:45', 1);
INSERT INTO `t_log` VALUES (4249, '查询操作', '分页查询角色信息', '2019-07-19 14:24:45', 1);
INSERT INTO `t_log` VALUES (4250, '查询操作', '分页查询角色信息', '2019-07-19 14:24:49', 1);
INSERT INTO `t_log` VALUES (4251, '登录操作', '登录系统', '2019-07-19 14:26:38', 1);
INSERT INTO `t_log` VALUES (4252, '查询操作', '分页查询角色信息', '2019-07-19 14:26:42', 1);
INSERT INTO `t_log` VALUES (4253, '查询操作', '分页查询角色信息', '2019-07-19 14:26:42', 1);
INSERT INTO `t_log` VALUES (4254, '查询操作', '分页查询角色信息', '2019-07-19 14:37:29', 1);
INSERT INTO `t_log` VALUES (4255, '查询操作', '分页查询角色信息', '2019-07-19 14:37:29', 1);
INSERT INTO `t_log` VALUES (4256, '查询操作', '分页查询角色信息', '2019-07-19 14:37:42', 1);
INSERT INTO `t_log` VALUES (4257, '登录操作', '登录系统', '2019-07-19 14:47:57', 1);
INSERT INTO `t_log` VALUES (4258, '查询操作', '分页查询角色信息', '2019-07-19 14:48:00', 1);
INSERT INTO `t_log` VALUES (4259, '查询操作', '分页查询角色信息', '2019-07-19 14:48:00', 1);
INSERT INTO `t_log` VALUES (4260, '查询操作', '分页查询角色信息', '2019-07-19 14:48:04', 1);
INSERT INTO `t_log` VALUES (4261, '查询操作', '分页查询角色信息', '2019-07-19 14:48:17', 1);
INSERT INTO `t_log` VALUES (4262, '查询操作', '分页查询角色信息', '2019-07-19 14:48:42', 1);
INSERT INTO `t_log` VALUES (4263, '查询操作', '分页查询角色信息', '2019-07-19 14:48:54', 1);
INSERT INTO `t_log` VALUES (4264, '登录操作', '登录系统', '2019-07-19 14:56:50', 1);
INSERT INTO `t_log` VALUES (4265, '查询操作', '分页查询角色信息', '2019-07-19 14:56:55', 1);
INSERT INTO `t_log` VALUES (4266, '查询操作', '分页查询角色信息', '2019-07-19 14:56:55', 1);
INSERT INTO `t_log` VALUES (4267, '查询操作', '分页查询角色信息', '2019-07-19 15:00:49', 1);
INSERT INTO `t_log` VALUES (4268, '查询操作', '分页查询角色信息', '2019-07-19 15:00:49', 1);
INSERT INTO `t_log` VALUES (4269, '查询操作', '分页查询角色信息', '2019-07-19 15:00:57', 1);
INSERT INTO `t_log` VALUES (4270, '查询操作', '分页查询角色信息', '2019-07-19 15:01:04', 1);
INSERT INTO `t_log` VALUES (4271, '查询操作', '分页查询角色信息', '2019-07-19 15:01:13', 1);
INSERT INTO `t_log` VALUES (4272, '查询操作', '分页查询角色信息', '2019-07-19 15:04:56', 1);
INSERT INTO `t_log` VALUES (4273, '查询操作', '分页查询角色信息', '2019-07-19 15:04:57', 1);
INSERT INTO `t_log` VALUES (4274, '查询操作', '分页查询角色信息', '2019-07-19 15:05:10', 1);
INSERT INTO `t_log` VALUES (4275, '查询操作', '分页查询角色信息', '2019-07-19 15:05:17', 1);
INSERT INTO `t_log` VALUES (4276, '查询操作', '分页查询角色信息', '2019-07-19 15:05:17', 1);
INSERT INTO `t_log` VALUES (4277, '查询操作', '分页查询角色信息', '2019-07-19 15:06:30', 1);
INSERT INTO `t_log` VALUES (4278, '查询操作', '分页查询角色信息', '2019-07-19 15:06:36', 1);
INSERT INTO `t_log` VALUES (4279, '查询操作', '分页查询角色信息', '2019-07-19 15:06:36', 1);
INSERT INTO `t_log` VALUES (4280, '查询操作', '分页查询角色信息', '2019-07-19 15:06:38', 1);
INSERT INTO `t_log` VALUES (4281, '登录操作', '登录系统', '2019-07-19 15:11:40', 1);
INSERT INTO `t_log` VALUES (4282, '查询操作', '分页查询角色信息', '2019-07-19 15:11:45', 1);
INSERT INTO `t_log` VALUES (4283, '查询操作', '分页查询角色信息', '2019-07-19 15:11:45', 1);
INSERT INTO `t_log` VALUES (4284, '查询操作', '分页查询角色信息', '2019-07-19 15:12:01', 1);
INSERT INTO `t_log` VALUES (4285, '查询操作', '分页查询角色信息', '2019-07-19 15:12:03', 1);
INSERT INTO `t_log` VALUES (4286, '查询操作', '分页查询角色信息', '2019-07-19 15:12:06', 1);
INSERT INTO `t_log` VALUES (4287, '查询操作', '分页查询角色信息', '2019-07-19 15:12:08', 1);
INSERT INTO `t_log` VALUES (4288, '查询操作', '分页查询角色信息', '2019-07-19 15:12:09', 1);
INSERT INTO `t_log` VALUES (4289, '查询操作', '分页查询角色信息', '2019-07-19 15:12:14', 1);
INSERT INTO `t_log` VALUES (4290, '查询操作', '分页查询角色信息', '2019-07-19 15:12:37', 1);
INSERT INTO `t_log` VALUES (4291, '查询操作', '分页查询角色信息', '2019-07-19 15:12:42', 1);
INSERT INTO `t_log` VALUES (4292, '登录操作', '登录系统', '2019-07-19 16:22:54', 1);
INSERT INTO `t_log` VALUES (4293, '查询操作', '分页查询角色信息', '2019-07-19 16:22:57', 1);
INSERT INTO `t_log` VALUES (4294, '查询操作', '分页查询角色信息', '2019-07-19 16:22:57', 1);
INSERT INTO `t_log` VALUES (4295, '登录操作', '登录系统', '2019-07-19 16:23:18', 3);
INSERT INTO `t_log` VALUES (4296, '登录操作', '登录系统', '2019-07-19 16:23:36', 3);
INSERT INTO `t_log` VALUES (4297, '登录操作', '登录系统', '2019-07-19 16:23:45', 3);
INSERT INTO `t_log` VALUES (4298, '登录操作', '登录系统', '2019-07-19 16:24:06', 1);
INSERT INTO `t_log` VALUES (4299, '登录操作', '登录系统', '2019-07-19 16:24:21', 3);
INSERT INTO `t_log` VALUES (4300, '登录操作', '登录系统', '2019-07-19 16:24:33', 1);
INSERT INTO `t_log` VALUES (4301, '查询操作', '分页查询角色信息', '2019-07-19 16:31:33', 1);
INSERT INTO `t_log` VALUES (4302, '查询操作', '分页查询角色信息', '2019-07-19 16:31:34', 1);
INSERT INTO `t_log` VALUES (4303, '查询操作', '分页查询角色信息', '2019-07-19 16:33:13', 1);
INSERT INTO `t_log` VALUES (4304, '查询操作', '分页查询角色信息', '2019-07-19 16:33:18', 1);
INSERT INTO `t_log` VALUES (4305, '查询操作', '分页查询角色信息', '2019-07-19 16:33:40', 1);
INSERT INTO `t_log` VALUES (4306, '查询操作', '分页查询角色信息', '2019-07-19 16:33:45', 1);
INSERT INTO `t_log` VALUES (4307, '查询操作', '分页查询角色信息', '2019-07-19 16:33:48', 1);
INSERT INTO `t_log` VALUES (4308, '查询操作', '分页查询角色信息', '2019-07-19 16:34:50', 1);
INSERT INTO `t_log` VALUES (4309, '查询操作', '分页查询角色信息', '2019-07-19 16:35:02', 1);
INSERT INTO `t_log` VALUES (4310, '查询操作', '分页查询角色信息', '2019-07-19 16:35:05', 1);
INSERT INTO `t_log` VALUES (4311, '查询操作', '分页查询角色信息', '2019-07-19 16:36:57', 1);
INSERT INTO `t_log` VALUES (4312, '查询操作', '分页查询角色信息', '2019-07-19 16:37:00', 1);
INSERT INTO `t_log` VALUES (4313, '查询操作', '分页查询角色信息', '2019-07-19 16:37:02', 1);
INSERT INTO `t_log` VALUES (4314, '查询操作', '分页查询角色信息', '2019-07-19 16:37:03', 1);
INSERT INTO `t_log` VALUES (4315, '查询操作', '分页查询角色信息', '2019-07-19 16:37:04', 1);
INSERT INTO `t_log` VALUES (4316, '查询操作', '分页查询角色信息', '2019-07-19 16:37:04', 1);
INSERT INTO `t_log` VALUES (4317, '查询操作', '分页查询角色信息', '2019-07-19 16:37:05', 1);
INSERT INTO `t_log` VALUES (4318, '查询操作', '分页查询角色信息', '2019-07-19 16:38:40', 1);
INSERT INTO `t_log` VALUES (4319, '查询操作', '分页查询角色信息', '2019-07-19 16:38:40', 1);
INSERT INTO `t_log` VALUES (4320, '查询操作', '分页查询角色信息', '2019-07-19 16:38:59', 1);
INSERT INTO `t_log` VALUES (4321, '查询操作', '分页查询角色信息', '2019-07-19 16:39:04', 1);
INSERT INTO `t_log` VALUES (4322, '查询操作', '分页查询角色信息', '2019-07-19 16:39:06', 1);
INSERT INTO `t_log` VALUES (4323, '查询操作', '分页查询角色信息', '2019-07-19 16:39:08', 1);
INSERT INTO `t_log` VALUES (4324, '查询操作', '分页查询角色信息', '2019-07-19 16:40:13', 1);
INSERT INTO `t_log` VALUES (4325, '查询操作', '分页查询角色信息', '2019-07-19 16:40:28', 1);
INSERT INTO `t_log` VALUES (4326, '查询操作', '分页查询角色信息', '2019-07-19 16:40:33', 1);
INSERT INTO `t_log` VALUES (4327, '查询操作', '分页查询角色信息', '2019-07-19 16:46:59', 1);
INSERT INTO `t_log` VALUES (4328, '查询操作', '分页查询角色信息', '2019-07-19 16:46:59', 1);
INSERT INTO `t_log` VALUES (4329, '登录操作', '登录系统', '2019-07-19 16:47:30', 1);
INSERT INTO `t_log` VALUES (4330, '查询操作', '分页查询角色信息', '2019-07-19 16:49:46', 1);
INSERT INTO `t_log` VALUES (4331, '查询操作', '分页查询角色信息', '2019-07-19 16:49:46', 1);
INSERT INTO `t_log` VALUES (4332, '查询操作', '分页查询角色信息', '2019-07-19 16:50:14', 1);
INSERT INTO `t_log` VALUES (4333, '查询操作', '分页查询角色信息', '2019-07-19 16:51:24', 1);
INSERT INTO `t_log` VALUES (4334, '查询操作', '分页查询角色信息', '2019-07-19 16:51:24', 1);
INSERT INTO `t_log` VALUES (4335, '查询操作', '分页查询角色信息', '2019-07-19 17:04:27', 1);
INSERT INTO `t_log` VALUES (4336, '查询操作', '分页查询角色信息', '2019-07-19 17:04:27', 1);
INSERT INTO `t_log` VALUES (4337, '登录操作', '登录系统', '2019-07-19 17:52:10', 1);
INSERT INTO `t_log` VALUES (4338, '查询操作', '分页查询角色信息', '2019-07-19 17:52:20', 1);
INSERT INTO `t_log` VALUES (4339, '查询操作', '分页查询角色信息', '2019-07-19 17:52:20', 1);
INSERT INTO `t_log` VALUES (4340, '查询操作', '分页查询角色信息', '2019-07-19 17:53:48', 1);
INSERT INTO `t_log` VALUES (4341, '查询操作', '分页查询角色信息', '2019-07-19 17:53:48', 1);
INSERT INTO `t_log` VALUES (4342, '查询操作', '分页查询角色信息', '2019-07-19 17:56:55', 1);
INSERT INTO `t_log` VALUES (4343, '查询操作', '分页查询角色信息', '2019-07-19 17:56:55', 1);
INSERT INTO `t_log` VALUES (4344, '查询操作', '分页查询角色信息', '2019-07-19 17:57:08', 1);
INSERT INTO `t_log` VALUES (4345, '查询操作', '分页查询角色信息', '2019-07-19 17:57:08', 1);
INSERT INTO `t_log` VALUES (4346, '新增操作', '新增角色:方法', '2019-07-19 17:57:58', 1);
INSERT INTO `t_log` VALUES (4347, '查询操作', '分页查询角色信息', '2019-07-19 17:57:58', 1);
INSERT INTO `t_log` VALUES (4348, '修改操作', '修改角色:方法啊啊', '2019-07-19 17:58:50', 1);
INSERT INTO `t_log` VALUES (4349, '查询操作', '分页查询角色信息', '2019-07-19 17:58:50', 1);
INSERT INTO `t_log` VALUES (4350, '修改操作', '修改角色:方法', '2019-07-19 17:59:31', 1);
INSERT INTO `t_log` VALUES (4351, '查询操作', '分页查询角色信息', '2019-07-19 17:59:31', 1);
INSERT INTO `t_log` VALUES (4352, '登录操作', '登录系统', '2019-07-21 17:53:37', 1);
INSERT INTO `t_log` VALUES (4353, '查询操作', '分页查询角色信息', '2019-07-21 17:54:16', 1);
INSERT INTO `t_log` VALUES (4354, '查询操作', '分页查询角色信息', '2019-07-21 17:54:16', 1);
INSERT INTO `t_log` VALUES (4355, '查询操作', '分页查询角色信息', '2019-07-21 18:13:57', 1);
INSERT INTO `t_log` VALUES (4356, '查询操作', '分页查询角色信息', '2019-07-21 18:14:06', 1);
INSERT INTO `t_log` VALUES (4357, '查询操作', '分页查询角色信息', '2019-07-21 18:14:10', 1);
INSERT INTO `t_log` VALUES (4358, '登录操作', '登录系统', '2019-07-25 09:07:32', 1);
INSERT INTO `t_log` VALUES (4359, '查询操作', '分页查询供应商', '2019-07-25 09:07:37', 1);
INSERT INTO `t_log` VALUES (4360, '查询操作', '分页查询供应商', '2019-07-25 09:07:37', 1);
INSERT INTO `t_log` VALUES (4361, '查询操作', '分页查询供应商', '2019-07-25 09:08:56', 1);
INSERT INTO `t_log` VALUES (4362, '查询操作', '分页查询供应商', '2019-07-25 09:10:22', 1);
INSERT INTO `t_log` VALUES (4363, '查询操作', '分页查询供应商', '2019-07-25 09:10:22', 1);
INSERT INTO `t_log` VALUES (4364, '查询操作', '分页查询供应商', '2019-07-25 09:13:26', 1);
INSERT INTO `t_log` VALUES (4365, '查询操作', '分页查询供应商', '2019-07-25 09:13:28', 1);
INSERT INTO `t_log` VALUES (4366, '查询操作', '分页查询供应商', '2019-07-25 09:14:18', 1);
INSERT INTO `t_log` VALUES (4367, '查询操作', '分页查询供应商', '2019-07-25 09:14:18', 1);
INSERT INTO `t_log` VALUES (4368, '登录操作', '登录系统', '2019-07-25 09:20:10', 1);
INSERT INTO `t_log` VALUES (4369, '查询操作', '分页查询供应商', '2019-07-25 09:20:15', 1);
INSERT INTO `t_log` VALUES (4370, '查询操作', '分页查询供应商', '2019-07-25 09:20:15', 1);
INSERT INTO `t_log` VALUES (4371, '查询操作', '分页查询供应商', '2019-07-25 09:48:13', 1);
INSERT INTO `t_log` VALUES (4372, '查询操作', '分页查询供应商', '2019-07-25 09:48:13', 1);
INSERT INTO `t_log` VALUES (4373, '登录操作', '登录系统', '2019-07-25 09:49:55', 1);
INSERT INTO `t_log` VALUES (4374, '查询操作', '分页查询供应商', '2019-07-25 09:50:02', 1);
INSERT INTO `t_log` VALUES (4375, '查询操作', '分页查询供应商', '2019-07-25 09:50:02', 1);
INSERT INTO `t_log` VALUES (4376, '查询操作', '分页查询供应商', '2019-07-25 09:50:32', 1);
INSERT INTO `t_log` VALUES (4377, '查询操作', '分页查询供应商', '2019-07-25 09:50:42', 1);
INSERT INTO `t_log` VALUES (4378, '查询操作', '分页查询供应商', '2019-07-25 09:50:49', 1);
INSERT INTO `t_log` VALUES (4379, '查询操作', '分页查询供应商', '2019-07-25 09:50:56', 1);
INSERT INTO `t_log` VALUES (4380, '查询操作', '分页查询供应商', '2019-07-25 09:51:03', 1);
INSERT INTO `t_log` VALUES (4381, '查询操作', '分页查询供应商', '2019-07-25 09:51:07', 1);
INSERT INTO `t_log` VALUES (4382, '查询操作', '分页查询供应商', '2019-07-25 09:51:10', 1);
INSERT INTO `t_log` VALUES (4383, '查询操作', '分页查询供应商', '2019-07-25 09:51:11', 1);
INSERT INTO `t_log` VALUES (4384, '查询操作', '分页查询供应商', '2019-07-25 09:51:16', 1);
INSERT INTO `t_log` VALUES (4385, '查询操作', '分页查询供应商', '2019-07-25 09:51:19', 1);
INSERT INTO `t_log` VALUES (4386, '登录操作', '登录系统', '2019-07-25 10:02:58', 1);
INSERT INTO `t_log` VALUES (4387, '查询操作', '分页查询供应商', '2019-07-25 10:03:02', 1);
INSERT INTO `t_log` VALUES (4388, '查询操作', '分页查询供应商', '2019-07-25 10:03:02', 1);
INSERT INTO `t_log` VALUES (4389, '登录操作', '登录系统', '2019-07-25 15:47:59', 1);
INSERT INTO `t_log` VALUES (4390, '查询操作', '分页查询供应商', '2019-07-25 15:48:07', 1);
INSERT INTO `t_log` VALUES (4391, '查询操作', '分页查询供应商', '2019-07-25 15:48:07', 1);
INSERT INTO `t_log` VALUES (4392, '查询操作', '分页查询供应商', '2019-07-25 15:55:43', 1);
INSERT INTO `t_log` VALUES (4393, '查询操作', '分页查询供应商', '2019-07-25 15:55:43', 1);
INSERT INTO `t_log` VALUES (4394, '新增操作', '添加供应商:null', '2019-07-25 15:56:51', 1);
INSERT INTO `t_log` VALUES (4395, '查询操作', '分页查询供应商', '2019-07-25 15:58:18', 1);
INSERT INTO `t_log` VALUES (4396, '查询操作', '分页查询供应商', '2019-07-25 15:58:18', 1);
INSERT INTO `t_log` VALUES (4397, '新增操作', '添加供应商:null', '2019-07-25 15:58:51', 1);
INSERT INTO `t_log` VALUES (4398, '查询操作', '分页查询供应商', '2019-07-25 16:00:08', 1);
INSERT INTO `t_log` VALUES (4399, '登录操作', '登录系统', '2019-07-25 16:01:45', 1);
INSERT INTO `t_log` VALUES (4400, '查询操作', '分页查询供应商', '2019-07-25 16:01:50', 1);
INSERT INTO `t_log` VALUES (4401, '查询操作', '分页查询供应商', '2019-07-25 16:01:50', 1);
INSERT INTO `t_log` VALUES (4402, '新增操作', '添加供应商:null', '2019-07-25 16:02:03', 1);
INSERT INTO `t_log` VALUES (4403, '查询操作', '分页查询供应商', '2019-07-25 16:02:03', 1);
INSERT INTO `t_log` VALUES (4404, '查询操作', '分页查询角色信息', '2019-07-25 16:02:33', 1);
INSERT INTO `t_log` VALUES (4405, '查询操作', '分页查询角色信息', '2019-07-25 16:02:33', 1);
INSERT INTO `t_log` VALUES (4406, '查询操作', '分页查询角色信息', '2019-07-25 16:02:50', 1);
INSERT INTO `t_log` VALUES (4407, '查询操作', '分页查询角色信息', '2019-07-25 16:02:50', 1);
INSERT INTO `t_log` VALUES (4408, '新增操作', '新增角色:aa', '2019-07-25 16:03:01', 1);
INSERT INTO `t_log` VALUES (4409, '查询操作', '分页查询角色信息', '2019-07-25 16:03:01', 1);
INSERT INTO `t_log` VALUES (4410, '查询操作', '查询菜单信息', '2019-07-25 16:03:08', 1);
INSERT INTO `t_log` VALUES (4411, '删除操作', '删除角色:aa', '2019-07-25 16:03:13', 1);
INSERT INTO `t_log` VALUES (4412, '查询操作', '分页查询角色信息', '2019-07-25 16:03:13', 1);
INSERT INTO `t_log` VALUES (4413, '查询操作', '分页查询供应商', '2019-07-25 16:05:00', 1);
INSERT INTO `t_log` VALUES (4414, '查询操作', '分页查询供应商', '2019-07-25 16:05:00', 1);
INSERT INTO `t_log` VALUES (4415, '新增操作', '添加供应商:SDA', '2019-07-25 16:05:19', 1);
INSERT INTO `t_log` VALUES (4416, '查询操作', '分页查询供应商', '2019-07-25 16:05:19', 1);
INSERT INTO `t_log` VALUES (4417, '查询操作', '分页查询供应商', '2019-07-25 16:05:56', 1);
INSERT INTO `t_log` VALUES (4418, '新增操作', '添加供应商:SDA', '2019-07-25 16:06:09', 1);
INSERT INTO `t_log` VALUES (4419, '查询操作', '分页查询供应商', '2019-07-25 16:06:09', 1);
INSERT INTO `t_log` VALUES (4420, '修改操作', '修改供应商:SDAa', '2019-07-25 16:09:59', 1);
INSERT INTO `t_log` VALUES (4421, '查询操作', '分页查询供应商', '2019-07-25 16:10:00', 1);
INSERT INTO `t_log` VALUES (4422, '查询操作', '分页查询供应商', '2019-07-25 16:10:26', 1);
INSERT INTO `t_log` VALUES (4423, '查询操作', '分页查询供应商', '2019-07-25 16:10:32', 1);
INSERT INTO `t_log` VALUES (4424, '查询操作', '分页查询供应商', '2019-07-25 16:10:34', 1);
INSERT INTO `t_log` VALUES (4425, '查询操作', '分页查询供应商', '2019-07-25 16:10:40', 1);
INSERT INTO `t_log` VALUES (4426, '查询操作', '分页查询供应商', '2019-07-25 16:10:45', 1);
INSERT INTO `t_log` VALUES (4427, '新增操作', '添加供应商:SDA', '2019-07-25 16:10:54', 1);
INSERT INTO `t_log` VALUES (4428, '查询操作', '分页查询供应商', '2019-07-25 16:10:55', 1);
INSERT INTO `t_log` VALUES (4429, '查询操作', '分页查询供应商', '2019-07-25 16:13:58', 1);
INSERT INTO `t_log` VALUES (4430, '新增操作', '添加供应商:SDAa', '2019-07-25 16:14:38', 1);
INSERT INTO `t_log` VALUES (4431, '查询操作', '分页查询供应商', '2019-07-25 16:14:38', 1);
INSERT INTO `t_log` VALUES (4432, '查询操作', '分页查询供应商', '2019-07-25 16:16:00', 1);
INSERT INTO `t_log` VALUES (4433, '查询操作', '分页查询供应商', '2019-07-25 16:16:00', 1);
INSERT INTO `t_log` VALUES (4434, '删除操作', '删除供应商:SDA', '2019-07-25 16:16:21', 1);
INSERT INTO `t_log` VALUES (4435, '删除操作', '删除供应商:SDAa', '2019-07-25 16:16:21', 1);
INSERT INTO `t_log` VALUES (4436, '查询操作', '分页查询供应商', '2019-07-25 16:16:21', 1);
INSERT INTO `t_log` VALUES (4437, '查询操作', '分页查询供应商', '2019-07-25 16:21:00', 1);
INSERT INTO `t_log` VALUES (4438, '查询操作', '分页查询供应商', '2019-07-25 16:21:00', 1);
INSERT INTO `t_log` VALUES (4439, '查询操作', '分页查询供应商', '2019-07-25 16:25:44', 1);
INSERT INTO `t_log` VALUES (4440, '查询操作', '分页查询供应商', '2019-07-25 16:25:44', 1);
INSERT INTO `t_log` VALUES (4441, '登录操作', '登录系统', '2019-07-26 08:47:13', 1);
INSERT INTO `t_log` VALUES (4442, '查询操作', '分页查询供应商', '2019-07-26 08:47:23', 1);
INSERT INTO `t_log` VALUES (4443, '查询操作', '分页查询供应商', '2019-07-26 08:47:24', 1);
INSERT INTO `t_log` VALUES (4444, '查询操作', '分页查询客户', '2019-07-26 08:47:32', 1);
INSERT INTO `t_log` VALUES (4445, '查询操作', '分页查询客户', '2019-07-26 08:47:32', 1);
INSERT INTO `t_log` VALUES (4446, '查询操作', '分页查询客户', '2019-07-26 08:47:39', 1);
INSERT INTO `t_log` VALUES (4447, '登录操作', '登录系统', '2019-07-26 08:54:10', 1);
INSERT INTO `t_log` VALUES (4448, '查询操作', '分页查询客户', '2019-07-26 08:54:18', 1);
INSERT INTO `t_log` VALUES (4449, '查询操作', '分页查询客户', '2019-07-26 08:54:18', 1);
INSERT INTO `t_log` VALUES (4450, '查询操作', '分页查询客户', '2019-07-26 08:54:37', 1);
INSERT INTO `t_log` VALUES (4451, '查询操作', '分页查询客户', '2019-07-26 08:54:45', 1);
INSERT INTO `t_log` VALUES (4452, '登录操作', '登录系统', '2019-07-26 08:55:59', 1);
INSERT INTO `t_log` VALUES (4453, '查询操作', '分页查询客户', '2019-07-26 08:56:06', 1);
INSERT INTO `t_log` VALUES (4454, '查询操作', '分页查询客户', '2019-07-26 08:56:06', 1);
INSERT INTO `t_log` VALUES (4455, '新增操作', '添加客户:万隆超市', '2019-07-26 08:57:37', 1);
INSERT INTO `t_log` VALUES (4456, '查询操作', '分页查询客户', '2019-07-26 08:57:37', 1);
INSERT INTO `t_log` VALUES (4457, '修改操作', '修改客户:万隆超市', '2019-07-26 08:57:53', 1);
INSERT INTO `t_log` VALUES (4458, '查询操作', '分页查询客户', '2019-07-26 08:57:53', 1);
INSERT INTO `t_log` VALUES (4459, '修改操作', '修改客户:万隆超市a', '2019-07-26 08:58:16', 1);
INSERT INTO `t_log` VALUES (4460, '查询操作', '分页查询客户', '2019-07-26 08:58:16', 1);
INSERT INTO `t_log` VALUES (4461, '修改操作', '修改客户:万隆超市', '2019-07-26 08:58:43', 1);
INSERT INTO `t_log` VALUES (4462, '查询操作', '分页查询客户', '2019-07-26 08:58:43', 1);
INSERT INTO `t_log` VALUES (4463, '登录操作', '登录系统', '2019-07-26 09:00:24', 1);
INSERT INTO `t_log` VALUES (4464, '查询操作', '分页查询客户', '2019-07-26 09:00:32', 1);
INSERT INTO `t_log` VALUES (4465, '查询操作', '分页查询客户', '2019-07-26 09:00:32', 1);
INSERT INTO `t_log` VALUES (4466, '登录操作', '登录系统', '2019-07-26 09:09:18', 1);
INSERT INTO `t_log` VALUES (4467, '查询操作', '分页查询客户', '2019-07-26 09:09:25', 1);
INSERT INTO `t_log` VALUES (4468, '查询操作', '分页查询客户', '2019-07-26 09:09:25', 1);
INSERT INTO `t_log` VALUES (4469, '修改操作', '修改客户:万隆超市a', '2019-07-26 09:09:32', 1);
INSERT INTO `t_log` VALUES (4470, '查询操作', '分页查询客户', '2019-07-26 09:09:32', 1);
INSERT INTO `t_log` VALUES (4471, '登录操作', '登录系统', '2019-07-26 09:22:04', 1);
INSERT INTO `t_log` VALUES (4472, '查询操作', '分页查询客户', '2019-07-26 09:22:48', 1);
INSERT INTO `t_log` VALUES (4473, '查询操作', '分页查询客户', '2019-07-26 09:22:48', 1);
INSERT INTO `t_log` VALUES (4474, '查询操作', '分页查询客户', '2019-07-26 09:22:52', 1);
INSERT INTO `t_log` VALUES (4475, '查询操作', '分页查询客户', '2019-07-26 09:22:55', 1);
INSERT INTO `t_log` VALUES (4476, '查询操作', '分页查询客户', '2019-07-26 09:23:07', 1);
INSERT INTO `t_log` VALUES (4477, '查询操作', '分页查询客户', '2019-07-26 09:23:09', 1);
INSERT INTO `t_log` VALUES (4478, '查询操作', '分页查询客户', '2019-07-26 09:23:17', 1);
INSERT INTO `t_log` VALUES (4479, '查询操作', '分页查询客户', '2019-07-26 09:23:18', 1);
INSERT INTO `t_log` VALUES (4480, '新增操作', '添加客户:万隆超市', '2019-07-26 09:23:34', 1);
INSERT INTO `t_log` VALUES (4481, '查询操作', '分页查询客户', '2019-07-26 09:23:35', 1);
INSERT INTO `t_log` VALUES (4482, '登录操作', '登录系统', '2019-07-26 09:26:54', 1);
INSERT INTO `t_log` VALUES (4483, '查询操作', '分页查询客户', '2019-07-26 09:27:03', 1);
INSERT INTO `t_log` VALUES (4484, '查询操作', '分页查询客户', '2019-07-26 09:27:03', 1);
INSERT INTO `t_log` VALUES (4485, '删除操作', '删除客户:万隆超市a', '2019-07-26 09:27:07', 1);
INSERT INTO `t_log` VALUES (4486, '删除操作', '删除客户:万隆超市', '2019-07-26 09:27:07', 1);
INSERT INTO `t_log` VALUES (4487, '查询操作', '分页查询客户', '2019-07-26 09:27:07', 1);
INSERT INTO `t_log` VALUES (4488, '查询操作', '分页查询客户', '2019-07-26 10:07:43', 1);
INSERT INTO `t_log` VALUES (4489, '查询操作', '分页查询客户', '2019-07-26 10:07:43', 1);
INSERT INTO `t_log` VALUES (4490, '登录操作', '登录系统', '2019-07-26 17:13:25', 1);
INSERT INTO `t_log` VALUES (4491, '查询操作', '分页查询客户', '2019-07-26 17:13:34', 1);
INSERT INTO `t_log` VALUES (4492, '查询操作', '分页查询客户', '2019-07-26 17:13:34', 1);
INSERT INTO `t_log` VALUES (4493, '查询操作', '查询商品类别信息', '2019-07-26 17:13:37', 1);
INSERT INTO `t_log` VALUES (4494, '登录操作', '登录系统', '2019-07-26 17:15:51', 1);
INSERT INTO `t_log` VALUES (4495, '查询操作', '查询商品类别信息', '2019-07-26 17:16:04', 1);
INSERT INTO `t_log` VALUES (4496, '查询操作', '查询商品类别信息', '2019-07-26 17:17:57', 1);
INSERT INTO `t_log` VALUES (4497, '登录操作', '登录系统', '2019-07-27 07:26:16', 1);
INSERT INTO `t_log` VALUES (4498, '查询操作', '查询商品类别信息', '2019-07-27 07:26:25', 1);
INSERT INTO `t_log` VALUES (4499, '登录操作', '登录系统', '2019-07-27 08:07:26', 1);
INSERT INTO `t_log` VALUES (4500, '查询操作', '分页查询用户信息', '2019-07-27 08:07:33', 1);
INSERT INTO `t_log` VALUES (4501, '查询操作', '查询所有角色信息', '2019-07-27 08:07:33', 1);
INSERT INTO `t_log` VALUES (4502, '查询操作', '分页查询用户信息', '2019-07-27 08:07:33', 1);
INSERT INTO `t_log` VALUES (4503, '查询操作', '分页查询用户信息', '2019-07-27 08:07:48', 1);
INSERT INTO `t_log` VALUES (4504, '查询操作', '分页查询用户信息', '2019-07-27 08:08:01', 1);
INSERT INTO `t_log` VALUES (4505, '查询操作', '分页查询用户信息', '2019-07-27 08:08:03', 1);
INSERT INTO `t_log` VALUES (4506, '查询操作', '分页查询用户信息', '2019-07-27 08:08:09', 1);
INSERT INTO `t_log` VALUES (4507, '查询操作', '查询商品类别信息', '2019-07-27 08:12:14', 1);
INSERT INTO `t_log` VALUES (4508, '查询操作', '查询商品类别信息', '2019-07-27 08:18:24', 1);
INSERT INTO `t_log` VALUES (4509, '登录操作', '登录系统', '2019-07-27 08:19:23', 1);
INSERT INTO `t_log` VALUES (4510, '查询操作', '查询商品类别信息', '2019-07-27 08:19:33', 1);
INSERT INTO `t_log` VALUES (4511, '新增操作', '添加商品单位:null', '2019-07-27 08:21:16', 1);
INSERT INTO `t_log` VALUES (4512, '登录操作', '登录系统', '2019-07-27 08:23:30', 1);
INSERT INTO `t_log` VALUES (4513, '查询操作', '查询商品类别信息', '2019-07-27 08:23:36', 1);
INSERT INTO `t_log` VALUES (4514, '查询操作', '查询商品类别信息', '2019-07-27 08:25:32', 1);
INSERT INTO `t_log` VALUES (4515, '删除操作', '删除商品单位:null', '2019-07-27 08:25:43', 1);
INSERT INTO `t_log` VALUES (4516, '登录操作', '登录系统', '2019-07-27 10:12:03', 1);
INSERT INTO `t_log` VALUES (4517, '查询操作', '查询商品类别信息', '2019-07-27 10:12:09', 1);
INSERT INTO `t_log` VALUES (4518, '新增操作', '添加商品单位:aa', '2019-07-27 10:12:58', 1);
INSERT INTO `t_log` VALUES (4519, '新增操作', '添加商品单位:aa', '2019-07-27 10:13:26', 1);
INSERT INTO `t_log` VALUES (4520, '查询操作', '查询商品类别信息', '2019-07-27 10:18:13', 1);
INSERT INTO `t_log` VALUES (4521, '登录操作', '登录系统', '2019-07-27 10:18:46', 1);
INSERT INTO `t_log` VALUES (4522, '查询操作', '查询商品类别信息', '2019-07-27 10:18:51', 1);
INSERT INTO `t_log` VALUES (4523, '删除操作', '删除商品单位:aa', '2019-07-27 10:21:58', 1);
INSERT INTO `t_log` VALUES (4524, '删除操作', '删除商品单位:aa', '2019-07-27 10:22:09', 1);
INSERT INTO `t_log` VALUES (4525, '登录操作', '登录系统', '2019-07-27 15:49:06', 1);
INSERT INTO `t_log` VALUES (4526, '查询操作', '查询商品类别信息', '2019-07-27 15:49:15', 1);
INSERT INTO `t_log` VALUES (4527, '查询操作', '查询商品类别信息', '2019-07-27 15:52:13', 1);
INSERT INTO `t_log` VALUES (4528, '查询操作', '查询商品类别信息', '2019-07-27 15:54:06', 1);
INSERT INTO `t_log` VALUES (4529, '新增操作', '新增商品类别:出行', '2019-07-27 15:57:48', 1);
INSERT INTO `t_log` VALUES (4530, '查询操作', '查询商品类别信息', '2019-07-27 15:57:48', 1);
INSERT INTO `t_log` VALUES (4531, '新增操作', '新增商品类别:摩托车', '2019-07-27 15:59:25', 1);
INSERT INTO `t_log` VALUES (4532, '查询操作', '查询商品类别信息', '2019-07-27 15:59:25', 1);
INSERT INTO `t_log` VALUES (4533, '新增操作', '新增商品类别:啊', '2019-07-27 15:59:42', 1);
INSERT INTO `t_log` VALUES (4534, '查询操作', '查询商品类别信息', '2019-07-27 15:59:42', 1);
INSERT INTO `t_log` VALUES (4535, '新增操作', '新增商品类别:啊', '2019-07-27 16:00:32', 1);
INSERT INTO `t_log` VALUES (4536, '查询操作', '查询商品类别信息', '2019-07-27 16:00:33', 1);
INSERT INTO `t_log` VALUES (4537, '登录操作', '登录系统', '2019-07-27 16:11:03', 1);
INSERT INTO `t_log` VALUES (4538, '查询操作', '查询商品类别信息', '2019-07-27 16:11:12', 1);
INSERT INTO `t_log` VALUES (4539, '登录操作', '登录系统', '2019-07-27 16:15:13', 1);
INSERT INTO `t_log` VALUES (4540, '查询操作', '查询商品类别信息', '2019-07-27 16:15:18', 1);
INSERT INTO `t_log` VALUES (4541, '查询操作', '查询商品类别信息', '2019-07-27 16:15:39', 1);
INSERT INTO `t_log` VALUES (4542, '查询操作', '查询商品类别信息', '2019-07-27 16:16:08', 1);
INSERT INTO `t_log` VALUES (4543, '删除操作', '删除商品类别：啊', '2019-07-27 16:16:16', 1);
INSERT INTO `t_log` VALUES (4544, '查询操作', '查询商品类别信息', '2019-07-27 16:16:16', 1);
INSERT INTO `t_log` VALUES (4545, '查询操作', '查询商品类别信息', '2019-07-27 16:16:48', 1);
INSERT INTO `t_log` VALUES (4546, '查询操作', '查询商品类别信息', '2019-07-27 16:17:12', 1);
INSERT INTO `t_log` VALUES (4547, '查询操作', '查询商品类别信息', '2019-07-27 16:20:59', 1);
INSERT INTO `t_log` VALUES (4548, '新增操作', '新增商品类别:af', '2019-07-27 16:21:22', 1);
INSERT INTO `t_log` VALUES (4549, '查询操作', '查询商品类别信息', '2019-07-27 16:21:22', 1);
INSERT INTO `t_log` VALUES (4550, '登录操作', '登录系统', '2019-07-27 16:30:00', 1);
INSERT INTO `t_log` VALUES (4551, '查询操作', '查询商品类别信息', '2019-07-27 16:30:06', 1);
INSERT INTO `t_log` VALUES (4552, '查询操作', '查询商品类别信息', '2019-07-27 16:30:25', 1);
INSERT INTO `t_log` VALUES (4553, '查询操作', '查询商品类别信息', '2019-07-27 16:34:16', 1);
INSERT INTO `t_log` VALUES (4554, '登录操作', '登录系统', '2019-07-27 16:36:05', 1);
INSERT INTO `t_log` VALUES (4555, '查询操作', '查询商品类别信息', '2019-07-27 16:36:11', 1);
INSERT INTO `t_log` VALUES (4556, '登录操作', '登录系统', '2019-07-27 16:40:57', 1);
INSERT INTO `t_log` VALUES (4557, '查询操作', '查询商品类别信息', '2019-07-27 16:41:03', 1);
INSERT INTO `t_log` VALUES (4558, '查询操作', '查询商品类别信息', '2019-07-27 16:41:44', 1);
INSERT INTO `t_log` VALUES (4559, '查询操作', '查询商品类别信息', '2019-07-27 16:42:59', 1);
INSERT INTO `t_log` VALUES (4560, '登录操作', '登录系统', '2019-07-27 16:47:34', 1);
INSERT INTO `t_log` VALUES (4561, '查询操作', '查询商品类别信息', '2019-07-27 16:47:43', 1);
INSERT INTO `t_log` VALUES (4562, '删除操作', '删除商品类别：啊', '2019-07-27 16:48:11', 1);
INSERT INTO `t_log` VALUES (4563, '查询操作', '查询商品类别信息', '2019-07-27 16:48:11', 1);
INSERT INTO `t_log` VALUES (4564, '删除操作', '删除商品类别：af', '2019-07-27 16:48:30', 1);
INSERT INTO `t_log` VALUES (4565, '查询操作', '查询商品类别信息', '2019-07-27 16:48:30', 1);
INSERT INTO `t_log` VALUES (4566, '删除操作', '删除商品类别：摩托车', '2019-07-27 16:48:43', 1);
INSERT INTO `t_log` VALUES (4567, '查询操作', '查询商品类别信息', '2019-07-27 16:48:43', 1);
INSERT INTO `t_log` VALUES (4568, '删除操作', '删除商品类别：出行', '2019-07-27 16:49:08', 1);
INSERT INTO `t_log` VALUES (4569, '查询操作', '查询商品类别信息', '2019-07-27 16:49:08', 1);
INSERT INTO `t_log` VALUES (4570, '新增操作', '新增商品类别:afd', '2019-07-27 16:54:30', 1);
INSERT INTO `t_log` VALUES (4571, '查询操作', '查询商品类别信息', '2019-07-27 16:54:30', 1);
INSERT INTO `t_log` VALUES (4572, '删除操作', '删除商品类别：afd', '2019-07-27 16:54:46', 1);
INSERT INTO `t_log` VALUES (4573, '查询操作', '查询商品类别信息', '2019-07-27 16:54:47', 1);
INSERT INTO `t_log` VALUES (4574, '查询操作', '查询商品类别信息', '2019-07-27 17:11:43', 1);
INSERT INTO `t_log` VALUES (4575, '查询操作', '查询商品类别信息', '2019-07-27 17:11:57', 1);
INSERT INTO `t_log` VALUES (4576, '登录操作', '登录系统', '2019-07-30 09:08:30', 1);
INSERT INTO `t_log` VALUES (4577, '查询操作', '分页查询商品信息', '2019-07-30 09:08:41', 1);
INSERT INTO `t_log` VALUES (4578, '查询操作', '查询商品类别信息', '2019-07-30 09:08:41', 1);
INSERT INTO `t_log` VALUES (4579, '查询操作', '分页查询商品信息', '2019-07-30 09:09:38', 1);
INSERT INTO `t_log` VALUES (4580, '查询操作', '分页查询商品信息', '2019-07-30 09:09:48', 1);
INSERT INTO `t_log` VALUES (4581, '查询操作', '分页查询商品信息', '2019-07-30 09:09:49', 1);
INSERT INTO `t_log` VALUES (4582, '查询操作', '分页查询商品信息', '2019-07-30 09:09:50', 1);
INSERT INTO `t_log` VALUES (4583, '查询操作', '分页查询商品信息', '2019-07-30 09:09:51', 1);
INSERT INTO `t_log` VALUES (4584, '查询操作', '分页查询商品信息', '2019-07-30 09:09:52', 1);
INSERT INTO `t_log` VALUES (4585, '查询操作', '分页查询商品信息', '2019-07-30 09:09:52', 1);
INSERT INTO `t_log` VALUES (4586, '登录操作', '登录系统', '2019-07-30 09:14:27', 1);
INSERT INTO `t_log` VALUES (4587, '查询操作', '分页查询商品信息', '2019-07-30 09:14:35', 1);
INSERT INTO `t_log` VALUES (4588, '查询操作', '查询商品类别信息', '2019-07-30 09:14:35', 1);
INSERT INTO `t_log` VALUES (4589, '登录操作', '登录系统', '2019-07-30 09:15:04', 1);
INSERT INTO `t_log` VALUES (4590, '查询操作', '分页查询商品信息', '2019-07-30 09:15:12', 1);
INSERT INTO `t_log` VALUES (4591, '查询操作', '查询商品类别信息', '2019-07-30 09:15:12', 1);
INSERT INTO `t_log` VALUES (4592, '登录操作', '登录系统', '2019-07-30 09:16:52', 1);
INSERT INTO `t_log` VALUES (4593, '查询操作', '分页查询商品信息', '2019-07-30 09:17:02', 1);
INSERT INTO `t_log` VALUES (4594, '查询操作', '查询商品类别信息', '2019-07-30 09:17:03', 1);
INSERT INTO `t_log` VALUES (4595, '查询操作', '分页查询商品信息', '2019-07-30 09:17:43', 1);
INSERT INTO `t_log` VALUES (4596, '查询操作', '分页查询商品信息', '2019-07-30 09:17:49', 1);
INSERT INTO `t_log` VALUES (4597, '查询操作', '分页查询商品信息', '2019-07-30 09:18:22', 1);
INSERT INTO `t_log` VALUES (4598, '查询操作', '分页查询商品信息', '2019-07-30 09:18:24', 1);
INSERT INTO `t_log` VALUES (4599, '查询操作', '分页查询商品信息', '2019-07-30 09:18:25', 1);
INSERT INTO `t_log` VALUES (4600, '查询操作', '分页查询商品信息', '2019-07-30 09:18:27', 1);
INSERT INTO `t_log` VALUES (4601, '查询操作', '分页查询商品信息', '2019-07-30 09:18:36', 1);
INSERT INTO `t_log` VALUES (4602, '查询操作', '分页查询商品信息', '2019-07-30 09:18:40', 1);
INSERT INTO `t_log` VALUES (4603, '登录操作', '登录系统', '2019-07-30 09:21:35', 1);
INSERT INTO `t_log` VALUES (4604, '查询操作', '分页查询商品信息', '2019-07-30 09:21:43', 1);
INSERT INTO `t_log` VALUES (4605, '查询操作', '查询商品类别信息', '2019-07-30 09:21:43', 1);
INSERT INTO `t_log` VALUES (4606, '查询操作', '分页查询商品信息', '2019-07-30 09:21:51', 1);
INSERT INTO `t_log` VALUES (4607, '查询操作', '分页查询商品信息', '2019-07-30 09:21:58', 1);
INSERT INTO `t_log` VALUES (4608, '查询操作', '查询商品类别信息', '2019-07-30 09:21:58', 1);
INSERT INTO `t_log` VALUES (4609, '查询操作', '分页查询商品信息', '2019-07-30 09:22:05', 1);
INSERT INTO `t_log` VALUES (4610, '查询操作', '分页查询商品信息', '2019-07-30 09:22:12', 1);
INSERT INTO `t_log` VALUES (4611, '查询操作', '分页查询商品信息', '2019-07-30 09:22:16', 1);
INSERT INTO `t_log` VALUES (4612, '查询操作', '分页查询商品信息', '2019-07-30 09:22:20', 1);
INSERT INTO `t_log` VALUES (4613, '查询操作', '分页查询商品信息', '2019-07-30 09:22:22', 1);
INSERT INTO `t_log` VALUES (4614, '查询操作', '分页查询商品信息', '2019-07-30 09:22:22', 1);
INSERT INTO `t_log` VALUES (4615, '查询操作', '分页查询商品信息', '2019-07-30 09:22:25', 1);
INSERT INTO `t_log` VALUES (4616, '查询操作', '分页查询商品信息', '2019-07-30 09:22:29', 1);
INSERT INTO `t_log` VALUES (4617, '查询操作', '分页查询商品信息', '2019-07-30 09:22:36', 1);
INSERT INTO `t_log` VALUES (4618, '查询操作', '分页查询商品信息', '2019-07-30 09:22:38', 1);
INSERT INTO `t_log` VALUES (4619, '查询操作', '分页查询商品信息', '2019-07-30 09:22:39', 1);
INSERT INTO `t_log` VALUES (4620, '查询操作', '分页查询商品信息', '2019-07-30 09:22:43', 1);
INSERT INTO `t_log` VALUES (4621, '查询操作', '分页查询商品信息', '2019-07-30 09:22:50', 1);
INSERT INTO `t_log` VALUES (4622, '查询操作', '分页查询商品信息', '2019-07-30 09:22:54', 1);
INSERT INTO `t_log` VALUES (4623, '查询操作', '分页查询商品信息', '2019-07-30 09:22:56', 1);
INSERT INTO `t_log` VALUES (4624, '查询操作', '分页查询商品信息', '2019-07-30 09:23:04', 1);
INSERT INTO `t_log` VALUES (4625, '查询操作', '分页查询商品信息', '2019-07-30 09:23:06', 1);
INSERT INTO `t_log` VALUES (4626, '查询操作', '分页查询商品信息', '2019-07-30 09:23:08', 1);
INSERT INTO `t_log` VALUES (4627, '查询操作', '分页查询商品信息', '2019-07-30 09:27:13', 1);
INSERT INTO `t_log` VALUES (4628, '查询操作', '分页查询商品信息', '2019-07-30 09:27:14', 1);
INSERT INTO `t_log` VALUES (4629, '查询操作', '分页查询商品信息', '2019-07-30 09:27:19', 1);
INSERT INTO `t_log` VALUES (4630, '查询操作', '分页查询商品信息', '2019-07-30 09:27:21', 1);
INSERT INTO `t_log` VALUES (4631, '查询操作', '分页查询商品信息', '2019-07-30 09:29:05', 1);
INSERT INTO `t_log` VALUES (4632, '查询操作', '分页查询客户', '2019-07-30 09:29:30', 1);
INSERT INTO `t_log` VALUES (4633, '查询操作', '分页查询客户', '2019-07-30 09:29:30', 1);
INSERT INTO `t_log` VALUES (4634, '登录操作', '登录系统', '2019-07-30 09:34:50', 1);
INSERT INTO `t_log` VALUES (4635, '查询操作', '分页查询商品信息', '2019-07-30 09:35:06', 1);
INSERT INTO `t_log` VALUES (4636, '查询操作', '查询商品类别信息', '2019-07-30 09:35:06', 1);
INSERT INTO `t_log` VALUES (4637, '查询操作', '分页查询商品信息', '2019-07-30 09:36:53', 1);
INSERT INTO `t_log` VALUES (4638, '查询操作', '查询商品类别信息', '2019-07-30 09:36:55', 1);
INSERT INTO `t_log` VALUES (4639, '查询操作', '分页查询商品信息', '2019-07-30 09:36:59', 1);
INSERT INTO `t_log` VALUES (4640, '查询操作', '查询商品类别信息', '2019-07-30 09:37:02', 1);
INSERT INTO `t_log` VALUES (4641, '查询操作', '分页查询商品信息', '2019-07-30 09:37:09', 1);
INSERT INTO `t_log` VALUES (4642, '查询操作', '查询商品类别信息', '2019-07-30 09:37:13', 1);
INSERT INTO `t_log` VALUES (4643, '查询操作', '查询商品类别信息', '2019-07-30 09:38:22', 1);
INSERT INTO `t_log` VALUES (4644, '查询操作', '查询商品类别信息', '2019-07-30 09:38:29', 1);
INSERT INTO `t_log` VALUES (4645, '查询操作', '分页查询商品信息', '2019-07-30 09:48:42', 1);
INSERT INTO `t_log` VALUES (4646, '查询操作', '分页查询商品信息', '2019-07-30 09:48:54', 1);
INSERT INTO `t_log` VALUES (4647, '查询操作', '查询商品类别信息', '2019-07-30 09:48:55', 1);
INSERT INTO `t_log` VALUES (4648, '登录操作', '登录系统', '2019-07-30 09:50:56', 1);
INSERT INTO `t_log` VALUES (4649, '查询操作', '分页查询商品信息', '2019-07-30 09:51:02', 1);
INSERT INTO `t_log` VALUES (4650, '查询操作', '查询商品类别信息', '2019-07-30 09:51:02', 1);
INSERT INTO `t_log` VALUES (4651, '查询操作', '分页查询商品信息', '2019-07-30 09:51:05', 1);
INSERT INTO `t_log` VALUES (4652, '查询操作', '分页查询商品信息', '2019-07-30 09:51:16', 1);
INSERT INTO `t_log` VALUES (4653, '查询操作', '分页查询商品信息', '2019-07-30 09:51:28', 1);
INSERT INTO `t_log` VALUES (4654, '查询操作', '分页查询商品信息', '2019-07-30 09:51:31', 1);
INSERT INTO `t_log` VALUES (4655, '查询操作', '分页查询商品信息', '2019-07-30 09:51:35', 1);
INSERT INTO `t_log` VALUES (4656, '查询操作', '分页查询商品信息', '2019-07-30 09:52:01', 1);
INSERT INTO `t_log` VALUES (4657, '查询操作', '查询商品类别信息', '2019-07-30 09:52:01', 1);
INSERT INTO `t_log` VALUES (4658, '查询操作', '分页查询商品信息', '2019-07-30 09:52:16', 1);
INSERT INTO `t_log` VALUES (4659, '查询操作', '查询商品类别信息', '2019-07-30 09:52:16', 1);
INSERT INTO `t_log` VALUES (4660, '登录操作', '登录系统', '2019-07-30 09:52:58', 1);
INSERT INTO `t_log` VALUES (4661, '查询操作', '分页查询商品信息', '2019-07-30 09:53:04', 1);
INSERT INTO `t_log` VALUES (4662, '查询操作', '查询商品类别信息', '2019-07-30 09:53:05', 1);
INSERT INTO `t_log` VALUES (4663, '查询操作', '分页查询商品信息', '2019-07-30 09:53:10', 1);
INSERT INTO `t_log` VALUES (4664, '查询操作', '分页查询商品信息', '2019-07-30 09:53:13', 1);
INSERT INTO `t_log` VALUES (4665, '登录操作', '登录系统', '2019-07-30 09:56:04', 1);
INSERT INTO `t_log` VALUES (4666, '查询操作', '分页查询商品信息', '2019-07-30 09:56:09', 1);
INSERT INTO `t_log` VALUES (4667, '查询操作', '查询商品类别信息', '2019-07-30 09:56:09', 1);
INSERT INTO `t_log` VALUES (4668, '查询操作', '分页查询商品信息', '2019-07-30 09:56:11', 1);
INSERT INTO `t_log` VALUES (4669, '查询操作', '分页查询商品信息', '2019-07-30 09:56:13', 1);
INSERT INTO `t_log` VALUES (4670, '查询操作', '分页查询商品信息', '2019-07-30 09:56:20', 1);
INSERT INTO `t_log` VALUES (4671, '查询操作', '分页查询商品信息', '2019-07-30 09:56:22', 1);
INSERT INTO `t_log` VALUES (4672, '查询操作', '分页查询商品信息', '2019-07-30 09:56:43', 1);
INSERT INTO `t_log` VALUES (4673, '查询操作', '分页查询商品信息', '2019-07-30 09:56:45', 1);
INSERT INTO `t_log` VALUES (4674, '查询操作', '分页查询商品信息', '2019-07-30 09:56:48', 1);
INSERT INTO `t_log` VALUES (4675, '查询操作', '分页查询商品信息', '2019-07-30 09:56:55', 1);
INSERT INTO `t_log` VALUES (4676, '查询操作', '查询商品类别信息', '2019-07-30 09:57:03', 1);
INSERT INTO `t_log` VALUES (4677, '登录操作', '登录系统', '2019-07-30 10:21:07', 1);
INSERT INTO `t_log` VALUES (4678, '查询操作', '分页查询商品信息', '2019-07-30 10:21:15', 1);
INSERT INTO `t_log` VALUES (4679, '查询操作', '查询商品类别信息', '2019-07-30 10:21:15', 1);
INSERT INTO `t_log` VALUES (4680, '查询操作', '分页查询商品信息', '2019-07-30 10:21:33', 1);
INSERT INTO `t_log` VALUES (4681, '查询操作', '分页查询商品信息', '2019-07-30 10:21:40', 1);
INSERT INTO `t_log` VALUES (4682, '查询操作', '分页查询商品信息', '2019-07-30 10:21:47', 1);
INSERT INTO `t_log` VALUES (4683, '新增操作', '添加商品:aaa', '2019-07-30 10:23:48', 1);
INSERT INTO `t_log` VALUES (4684, '登录操作', '登录系统', '2019-07-30 10:27:06', 1);
INSERT INTO `t_log` VALUES (4685, '查询操作', '分页查询商品信息', '2019-07-30 10:27:11', 1);
INSERT INTO `t_log` VALUES (4686, '查询操作', '查询商品类别信息', '2019-07-30 10:27:12', 1);
INSERT INTO `t_log` VALUES (4687, '查询操作', '分页查询商品信息', '2019-07-30 10:27:13', 1);
INSERT INTO `t_log` VALUES (4688, '新增操作', '添加商品:aaa', '2019-07-30 10:27:31', 1);
INSERT INTO `t_log` VALUES (4689, '登录操作', '登录系统', '2019-07-30 10:29:32', 1);
INSERT INTO `t_log` VALUES (4690, '查询操作', '分页查询商品信息', '2019-07-30 10:29:38', 1);
INSERT INTO `t_log` VALUES (4691, '查询操作', '查询商品类别信息', '2019-07-30 10:29:38', 1);
INSERT INTO `t_log` VALUES (4692, '查询操作', '分页查询商品信息', '2019-07-30 10:29:39', 1);
INSERT INTO `t_log` VALUES (4693, '新增操作', '添加商品:aaa', '2019-07-30 10:29:54', 1);
INSERT INTO `t_log` VALUES (4694, '查询操作', '分页查询商品信息', '2019-07-30 10:29:55', 1);
INSERT INTO `t_log` VALUES (4695, '查询操作', '分页查询商品信息', '2019-07-30 10:29:59', 1);
INSERT INTO `t_log` VALUES (4696, '查询操作', '分页查询商品信息', '2019-07-30 10:31:11', 1);
INSERT INTO `t_log` VALUES (4697, '登录操作', '登录系统', '2019-07-30 16:08:53', 1);
INSERT INTO `t_log` VALUES (4698, '查询操作', '分页查询商品信息', '2019-07-30 16:09:04', 1);
INSERT INTO `t_log` VALUES (4699, '查询操作', '查询商品类别信息', '2019-07-30 16:09:05', 1);
INSERT INTO `t_log` VALUES (4700, '查询操作', '分页查询商品信息', '2019-07-30 16:09:28', 1);
INSERT INTO `t_log` VALUES (4701, '查询操作', '查询商品类别信息', '2019-07-30 16:09:29', 1);
INSERT INTO `t_log` VALUES (4702, '查询操作', '分页查询商品信息', '2019-07-30 16:09:31', 1);
INSERT INTO `t_log` VALUES (4703, '查询操作', '分页查询商品信息', '2019-07-30 16:09:32', 1);
INSERT INTO `t_log` VALUES (4704, '查询操作', '分页查询商品信息', '2019-07-30 16:09:33', 1);
INSERT INTO `t_log` VALUES (4705, '查询操作', '分页查询商品信息', '2019-07-30 16:09:35', 1);
INSERT INTO `t_log` VALUES (4706, '查询操作', '分页查询商品信息', '2019-07-30 16:09:40', 1);
INSERT INTO `t_log` VALUES (4707, '查询操作', '查询商品类别信息', '2019-07-30 16:10:34', 1);
INSERT INTO `t_log` VALUES (4708, '查询操作', '查询商品类别信息', '2019-07-30 16:10:38', 1);
INSERT INTO `t_log` VALUES (4709, '修改操作', '修改商品:bbb', '2019-07-30 16:11:02', 1);
INSERT INTO `t_log` VALUES (4710, '查询操作', '分页查询商品信息', '2019-07-30 16:11:03', 1);
INSERT INTO `t_log` VALUES (4711, '查询操作', '分页查询商品信息', '2019-07-30 16:12:21', 1);
INSERT INTO `t_log` VALUES (4712, '查询操作', '查询商品类别信息', '2019-07-30 16:12:27', 1);
INSERT INTO `t_log` VALUES (4713, '修改操作', '修改商品:bbb', '2019-07-30 16:12:32', 1);
INSERT INTO `t_log` VALUES (4714, '查询操作', '分页查询商品信息', '2019-07-30 16:12:32', 1);
INSERT INTO `t_log` VALUES (4715, '查询操作', '分页查询商品信息', '2019-07-30 16:12:35', 1);
INSERT INTO `t_log` VALUES (4716, '查询操作', '分页查询商品信息', '2019-07-30 16:14:20', 1);
INSERT INTO `t_log` VALUES (4717, '查询操作', '分页查询商品信息', '2019-07-30 16:14:24', 1);
INSERT INTO `t_log` VALUES (4718, '删除操作', '删除商品:bbb', '2019-07-30 16:15:31', 1);
INSERT INTO `t_log` VALUES (4719, '查询操作', '分页查询商品信息', '2019-07-30 16:15:32', 1);
INSERT INTO `t_log` VALUES (4720, '查询操作', '分页查询商品信息', '2019-07-30 16:15:34', 1);
INSERT INTO `t_log` VALUES (4721, '查询操作', '分页查询商品信息', '2019-07-30 16:16:00', 1);
INSERT INTO `t_log` VALUES (4722, '查询操作', '查询商品类别信息', '2019-07-30 16:16:00', 1);
INSERT INTO `t_log` VALUES (4723, '查询操作', '分页查询商品信息', '2019-07-30 16:16:04', 1);
INSERT INTO `t_log` VALUES (4724, '查询操作', '分页查询商品信息', '2019-07-30 16:16:05', 1);
INSERT INTO `t_log` VALUES (4725, '登录操作', '登录系统', '2019-08-01 08:08:47', 1);
INSERT INTO `t_log` VALUES (4726, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:08:57', 1);
INSERT INTO `t_log` VALUES (4727, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:08:57', 1);
INSERT INTO `t_log` VALUES (4728, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:10:19', 1);
INSERT INTO `t_log` VALUES (4729, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:10:29', 1);
INSERT INTO `t_log` VALUES (4730, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:10:39', 1);
INSERT INTO `t_log` VALUES (4731, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:10:48', 1);
INSERT INTO `t_log` VALUES (4732, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:10:49', 1);
INSERT INTO `t_log` VALUES (4733, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:10:49', 1);
INSERT INTO `t_log` VALUES (4734, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:10:55', 1);
INSERT INTO `t_log` VALUES (4735, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:22', 1);
INSERT INTO `t_log` VALUES (4736, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:22', 1);
INSERT INTO `t_log` VALUES (4737, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:24', 1);
INSERT INTO `t_log` VALUES (4738, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:25', 1);
INSERT INTO `t_log` VALUES (4739, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:26', 1);
INSERT INTO `t_log` VALUES (4740, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:26', 1);
INSERT INTO `t_log` VALUES (4741, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:26', 1);
INSERT INTO `t_log` VALUES (4742, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:27', 1);
INSERT INTO `t_log` VALUES (4743, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:11:40', 1);
INSERT INTO `t_log` VALUES (4744, '登录操作', '登录系统', '2019-08-01 08:15:04', 1);
INSERT INTO `t_log` VALUES (4745, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:11', 1);
INSERT INTO `t_log` VALUES (4746, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:15:11', 1);
INSERT INTO `t_log` VALUES (4747, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:13', 1);
INSERT INTO `t_log` VALUES (4748, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:20', 1);
INSERT INTO `t_log` VALUES (4749, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:35', 1);
INSERT INTO `t_log` VALUES (4750, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:35', 1);
INSERT INTO `t_log` VALUES (4751, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:37', 1);
INSERT INTO `t_log` VALUES (4752, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:39', 1);
INSERT INTO `t_log` VALUES (4753, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:40', 1);
INSERT INTO `t_log` VALUES (4754, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:41', 1);
INSERT INTO `t_log` VALUES (4755, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:46', 1);
INSERT INTO `t_log` VALUES (4756, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:15:58', 1);
INSERT INTO `t_log` VALUES (4757, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:01', 1);
INSERT INTO `t_log` VALUES (4758, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:02', 1);
INSERT INTO `t_log` VALUES (4759, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:03', 1);
INSERT INTO `t_log` VALUES (4760, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:04', 1);
INSERT INTO `t_log` VALUES (4761, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:07', 1);
INSERT INTO `t_log` VALUES (4762, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:16', 1);
INSERT INTO `t_log` VALUES (4763, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:18', 1);
INSERT INTO `t_log` VALUES (4764, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:18', 1);
INSERT INTO `t_log` VALUES (4765, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:19', 1);
INSERT INTO `t_log` VALUES (4766, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:19', 1);
INSERT INTO `t_log` VALUES (4767, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:20', 1);
INSERT INTO `t_log` VALUES (4768, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:20', 1);
INSERT INTO `t_log` VALUES (4769, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:21', 1);
INSERT INTO `t_log` VALUES (4770, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:21', 1);
INSERT INTO `t_log` VALUES (4771, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:21', 1);
INSERT INTO `t_log` VALUES (4772, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:22', 1);
INSERT INTO `t_log` VALUES (4773, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:23', 1);
INSERT INTO `t_log` VALUES (4774, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:24', 1);
INSERT INTO `t_log` VALUES (4775, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:16:54', 1);
INSERT INTO `t_log` VALUES (4776, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:16:54', 1);
INSERT INTO `t_log` VALUES (4777, '查询操作', '分页查询商品信息', '2019-08-01 08:17:05', 1);
INSERT INTO `t_log` VALUES (4778, '查询操作', '查询商品类别信息', '2019-08-01 08:17:05', 1);
INSERT INTO `t_log` VALUES (4779, '查询操作', '分页查询商品信息', '2019-08-01 08:17:18', 1);
INSERT INTO `t_log` VALUES (4780, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:17:24', 1);
INSERT INTO `t_log` VALUES (4781, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:17:24', 1);
INSERT INTO `t_log` VALUES (4782, '查询操作', '分页查询商品信息', '2019-08-01 08:17:43', 1);
INSERT INTO `t_log` VALUES (4783, '查询操作', '分页查询商品信息', '2019-08-01 08:17:46', 1);
INSERT INTO `t_log` VALUES (4784, '新增操作', '添加商品:aaa', '2019-08-01 08:18:27', 1);
INSERT INTO `t_log` VALUES (4785, '查询操作', '分页查询商品信息', '2019-08-01 08:18:27', 1);
INSERT INTO `t_log` VALUES (4786, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:18:43', 1);
INSERT INTO `t_log` VALUES (4787, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:18:43', 1);
INSERT INTO `t_log` VALUES (4788, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:19:20', 1);
INSERT INTO `t_log` VALUES (4789, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:19:20', 1);
INSERT INTO `t_log` VALUES (4790, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:19:25', 1);
INSERT INTO `t_log` VALUES (4791, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:19:26', 1);
INSERT INTO `t_log` VALUES (4792, '登录操作', '登录系统', '2019-08-01 08:35:54', 1);
INSERT INTO `t_log` VALUES (4793, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:07', 1);
INSERT INTO `t_log` VALUES (4794, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:36:07', 1);
INSERT INTO `t_log` VALUES (4795, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:18', 1);
INSERT INTO `t_log` VALUES (4796, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:19', 1);
INSERT INTO `t_log` VALUES (4797, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:20', 1);
INSERT INTO `t_log` VALUES (4798, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:22', 1);
INSERT INTO `t_log` VALUES (4799, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:23', 1);
INSERT INTO `t_log` VALUES (4800, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:36:24', 1);
INSERT INTO `t_log` VALUES (4801, '修改操作', 'aaa商品期初入库', '2019-08-01 08:38:00', 1);
INSERT INTO `t_log` VALUES (4802, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:38:01', 1);
INSERT INTO `t_log` VALUES (4803, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:38:01', 1);
INSERT INTO `t_log` VALUES (4804, '修改操作', 'aaa商品期初入库', '2019-08-01 08:41:35', 1);
INSERT INTO `t_log` VALUES (4805, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:41:35', 1);
INSERT INTO `t_log` VALUES (4806, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:41:35', 1);
INSERT INTO `t_log` VALUES (4807, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:14', 1);
INSERT INTO `t_log` VALUES (4808, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:15', 1);
INSERT INTO `t_log` VALUES (4809, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:16', 1);
INSERT INTO `t_log` VALUES (4810, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:16', 1);
INSERT INTO `t_log` VALUES (4811, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:17', 1);
INSERT INTO `t_log` VALUES (4812, '修改操作', 'aaa商品期初入库', '2019-08-01 08:42:28', 1);
INSERT INTO `t_log` VALUES (4813, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:28', 1);
INSERT INTO `t_log` VALUES (4814, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:42:28', 1);
INSERT INTO `t_log` VALUES (4815, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:42:33', 1);
INSERT INTO `t_log` VALUES (4816, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:43:49', 1);
INSERT INTO `t_log` VALUES (4817, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:43:50', 1);
INSERT INTO `t_log` VALUES (4818, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:45:20', 1);
INSERT INTO `t_log` VALUES (4819, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:45:21', 1);
INSERT INTO `t_log` VALUES (4820, '登录操作', '登录系统', '2019-08-01 08:45:47', 1);
INSERT INTO `t_log` VALUES (4821, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:45:53', 1);
INSERT INTO `t_log` VALUES (4822, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:45:53', 1);
INSERT INTO `t_log` VALUES (4823, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:01', 1);
INSERT INTO `t_log` VALUES (4824, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:03', 1);
INSERT INTO `t_log` VALUES (4825, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:09', 1);
INSERT INTO `t_log` VALUES (4826, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:14', 1);
INSERT INTO `t_log` VALUES (4827, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:19', 1);
INSERT INTO `t_log` VALUES (4828, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:20', 1);
INSERT INTO `t_log` VALUES (4829, '修改操作', 'aaa商品清除库存', '2019-08-01 08:46:43', 1);
INSERT INTO `t_log` VALUES (4830, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:46:43', 1);
INSERT INTO `t_log` VALUES (4831, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:46:43', 1);
INSERT INTO `t_log` VALUES (4832, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:49:22', 1);
INSERT INTO `t_log` VALUES (4833, '修改操作', 'aaa商品清除库存', '2019-08-01 08:50:17', 1);
INSERT INTO `t_log` VALUES (4834, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:50:17', 1);
INSERT INTO `t_log` VALUES (4835, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:50:17', 1);
INSERT INTO `t_log` VALUES (4836, '修改操作', 'aaa商品清除库存', '2019-08-01 08:53:50', 1);
INSERT INTO `t_log` VALUES (4837, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 08:53:50', 1);
INSERT INTO `t_log` VALUES (4838, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 08:53:50', 1);
INSERT INTO `t_log` VALUES (4839, '登录操作', '登录系统', '2019-08-01 15:48:31', 1);
INSERT INTO `t_log` VALUES (4840, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 15:48:46', 1);
INSERT INTO `t_log` VALUES (4841, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 15:48:46', 1);
INSERT INTO `t_log` VALUES (4842, '修改操作', 'aaa商品清除库存', '2019-08-01 15:48:59', 1);
INSERT INTO `t_log` VALUES (4843, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 15:48:59', 1);
INSERT INTO `t_log` VALUES (4844, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 15:48:59', 1);
INSERT INTO `t_log` VALUES (4845, '登录操作', '登录系统', '2019-08-01 15:58:17', 1);
INSERT INTO `t_log` VALUES (4846, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 15:58:23', 1);
INSERT INTO `t_log` VALUES (4847, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 15:58:23', 1);
INSERT INTO `t_log` VALUES (4848, '修改操作', 'aaa商品清除库存', '2019-08-01 15:58:34', 1);
INSERT INTO `t_log` VALUES (4849, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 15:58:34', 1);
INSERT INTO `t_log` VALUES (4850, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 15:58:34', 1);
INSERT INTO `t_log` VALUES (4851, '修改操作', 'aaa商品清除库存', '2019-08-01 15:59:51', 1);
INSERT INTO `t_log` VALUES (4852, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 15:59:51', 1);
INSERT INTO `t_log` VALUES (4853, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 15:59:51', 1);
INSERT INTO `t_log` VALUES (4854, '修改操作', 'aaa商品清除库存', '2019-08-01 16:01:06', 1);
INSERT INTO `t_log` VALUES (4855, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:01:06', 1);
INSERT INTO `t_log` VALUES (4856, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:01:06', 1);
INSERT INTO `t_log` VALUES (4857, '修改操作', 'aaa商品期初入库', '2019-08-01 16:17:17', 1);
INSERT INTO `t_log` VALUES (4858, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:17:17', 1);
INSERT INTO `t_log` VALUES (4859, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:17:17', 1);
INSERT INTO `t_log` VALUES (4860, '登录操作', '登录系统', '2019-08-01 16:29:06', 1);
INSERT INTO `t_log` VALUES (4861, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:29:12', 1);
INSERT INTO `t_log` VALUES (4862, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:29:12', 1);
INSERT INTO `t_log` VALUES (4863, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:29:23', 1);
INSERT INTO `t_log` VALUES (4864, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:29:23', 1);
INSERT INTO `t_log` VALUES (4865, '修改操作', 'aaa商品期初入库', '2019-08-01 16:29:38', 1);
INSERT INTO `t_log` VALUES (4866, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:29:38', 1);
INSERT INTO `t_log` VALUES (4867, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:29:38', 1);
INSERT INTO `t_log` VALUES (4868, '修改操作', 'aaa商品清除库存', '2019-08-01 16:29:45', 1);
INSERT INTO `t_log` VALUES (4869, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 16:29:45', 1);
INSERT INTO `t_log` VALUES (4870, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 16:29:45', 1);
INSERT INTO `t_log` VALUES (4871, '查询操作', '分页查询商品信息', '2019-08-01 16:40:43', 1);
INSERT INTO `t_log` VALUES (4872, '查询操作', '分页查询商品信息', '2019-08-01 16:40:44', 1);
INSERT INTO `t_log` VALUES (4873, '查询操作', '分页查询商品信息', '2019-08-01 16:40:52', 1);
INSERT INTO `t_log` VALUES (4874, '查询操作', '分页查询商品信息', '2019-08-01 16:40:52', 1);
INSERT INTO `t_log` VALUES (4875, '查询操作', '查询商品类别信息', '2019-08-01 16:40:59', 1);
INSERT INTO `t_log` VALUES (4876, '查询操作', '查询商品类别信息', '2019-08-01 16:42:37', 1);
INSERT INTO `t_log` VALUES (4877, '查询操作', '分页查询商品信息', '2019-08-01 16:42:43', 1);
INSERT INTO `t_log` VALUES (4878, '查询操作', '分页查询商品信息', '2019-08-01 16:42:44', 1);
INSERT INTO `t_log` VALUES (4879, '查询操作', '查询商品类别信息', '2019-08-01 16:42:57', 1);
INSERT INTO `t_log` VALUES (4880, '查询操作', '查询商品类别信息', '2019-08-01 16:43:07', 1);
INSERT INTO `t_log` VALUES (4881, '查询操作', '分页查询商品信息', '2019-08-01 16:43:10', 1);
INSERT INTO `t_log` VALUES (4882, '查询操作', '分页查询商品信息', '2019-08-01 16:43:34', 1);
INSERT INTO `t_log` VALUES (4883, '查询操作', '查询商品类别信息', '2019-08-01 16:44:30', 1);
INSERT INTO `t_log` VALUES (4884, '查询操作', '分页查询商品信息', '2019-08-01 16:44:44', 1);
INSERT INTO `t_log` VALUES (4885, '查询操作', '分页查询商品信息', '2019-08-01 16:44:44', 1);
INSERT INTO `t_log` VALUES (4886, '查询操作', '分页查询商品信息', '2019-08-01 16:46:23', 1);
INSERT INTO `t_log` VALUES (4887, '查询操作', '分页查询商品信息', '2019-08-01 16:46:23', 1);
INSERT INTO `t_log` VALUES (4888, '查询操作', '分页查询商品信息', '2019-08-01 16:48:12', 1);
INSERT INTO `t_log` VALUES (4889, '查询操作', '分页查询商品信息', '2019-08-01 16:48:12', 1);
INSERT INTO `t_log` VALUES (4890, '查询操作', '分页查询商品信息', '2019-08-01 16:48:35', 1);
INSERT INTO `t_log` VALUES (4891, '查询操作', '分页查询商品信息', '2019-08-01 16:48:36', 1);
INSERT INTO `t_log` VALUES (4892, '查询操作', '查询商品类别信息', '2019-08-01 16:48:38', 1);
INSERT INTO `t_log` VALUES (4893, '查询操作', '分页查询商品信息', '2019-08-01 16:48:43', 1);
INSERT INTO `t_log` VALUES (4894, '查询操作', '分页查询商品信息', '2019-08-01 16:48:56', 1);
INSERT INTO `t_log` VALUES (4895, '查询操作', '分页查询商品信息', '2019-08-01 16:49:01', 1);
INSERT INTO `t_log` VALUES (4896, '查询操作', '分页查询商品信息', '2019-08-01 16:49:06', 1);
INSERT INTO `t_log` VALUES (4897, '查询操作', '分页查询商品信息', '2019-08-01 16:52:46', 1);
INSERT INTO `t_log` VALUES (4898, '查询操作', '分页查询商品信息', '2019-08-01 16:52:46', 1);
INSERT INTO `t_log` VALUES (4899, '登录操作', '登录系统', '2019-08-01 20:00:46', 1);
INSERT INTO `t_log` VALUES (4900, '查询操作', '分页查询商品信息（无库存）', '2019-08-01 20:00:53', 1);
INSERT INTO `t_log` VALUES (4901, '查询操作', '分页查询商品信息（有库存）', '2019-08-01 20:00:53', 1);
INSERT INTO `t_log` VALUES (4902, '查询操作', '分页查询商品信息', '2019-08-01 20:01:02', 1);
INSERT INTO `t_log` VALUES (4903, '查询操作', '分页查询商品信息', '2019-08-01 20:01:02', 1);
INSERT INTO `t_log` VALUES (4904, '登录操作', '登录系统', '2019-08-01 20:02:59', 1);
INSERT INTO `t_log` VALUES (4905, '查询操作', '分页查询商品信息', '2019-08-01 20:04:36', 1);
INSERT INTO `t_log` VALUES (4906, '查询操作', '分页查询商品信息', '2019-08-01 20:04:37', 1);
INSERT INTO `t_log` VALUES (4907, '查询操作', '分页查询商品信息', '2019-08-01 20:05:34', 1);
INSERT INTO `t_log` VALUES (4908, '查询操作', '分页查询商品信息', '2019-08-01 20:05:35', 1);
INSERT INTO `t_log` VALUES (4909, '查询操作', '查询商品类别信息', '2019-08-01 20:06:14', 1);
INSERT INTO `t_log` VALUES (4910, '查询操作', '查询商品类别信息', '2019-08-01 20:06:33', 1);
INSERT INTO `t_log` VALUES (4911, '查询操作', '分页查询商品信息', '2019-08-01 20:07:13', 1);
INSERT INTO `t_log` VALUES (4912, '查询操作', '分页查询商品信息', '2019-08-01 20:07:14', 1);
INSERT INTO `t_log` VALUES (4913, '查询操作', '分页查询商品信息', '2019-08-01 20:07:28', 1);
INSERT INTO `t_log` VALUES (4914, '查询操作', '分页查询商品信息', '2019-08-01 20:07:28', 1);
INSERT INTO `t_log` VALUES (4915, '查询操作', '查询商品类别信息', '2019-08-01 20:07:44', 1);
INSERT INTO `t_log` VALUES (4916, '查询操作', '分页查询商品信息', '2019-08-01 20:07:49', 1);
INSERT INTO `t_log` VALUES (4917, '查询操作', '分页查询商品信息', '2019-08-01 20:08:03', 1);
INSERT INTO `t_log` VALUES (4918, '查询操作', '分页查询商品信息', '2019-08-01 20:08:04', 1);
INSERT INTO `t_log` VALUES (4919, '查询操作', '查询商品类别信息', '2019-08-01 20:09:19', 1);
INSERT INTO `t_log` VALUES (4920, '查询操作', '查询商品类别信息', '2019-08-01 20:09:31', 1);
INSERT INTO `t_log` VALUES (4921, '登录操作', '登录系统', '2019-08-02 08:09:48', 1);
INSERT INTO `t_log` VALUES (4922, '查询操作', '分页查询商品信息', '2019-08-02 08:09:55', 1);
INSERT INTO `t_log` VALUES (4923, '查询操作', '分页查询商品信息', '2019-08-02 08:09:56', 1);
INSERT INTO `t_log` VALUES (4924, '登录操作', '登录系统', '2019-08-02 08:44:21', 1);
INSERT INTO `t_log` VALUES (4925, '查询操作', '分页查询商品信息', '2019-08-02 08:44:30', 1);
INSERT INTO `t_log` VALUES (4926, '查询操作', '分页查询商品信息', '2019-08-02 08:44:31', 1);
INSERT INTO `t_log` VALUES (4927, '登录操作', '登录系统', '2019-08-02 19:19:05', 1);
INSERT INTO `t_log` VALUES (4928, '查询操作', '分页查询商品信息', '2019-08-02 19:19:44', 1);
INSERT INTO `t_log` VALUES (4929, '查询操作', '分页查询商品信息', '2019-08-02 19:19:44', 1);
INSERT INTO `t_log` VALUES (4930, '查询操作', '分页查询商品信息', '2019-08-02 19:20:07', 1);
INSERT INTO `t_log` VALUES (4931, '查询操作', '分页查询商品信息', '2019-08-02 19:20:08', 1);
INSERT INTO `t_log` VALUES (4932, '查询操作', '分页查询商品信息', '2019-08-02 19:20:18', 1);
INSERT INTO `t_log` VALUES (4933, '查询操作', '分页查询商品信息', '2019-08-02 19:20:19', 1);
INSERT INTO `t_log` VALUES (4934, '查询操作', '分页查询商品信息', '2019-08-02 19:20:22', 1);
INSERT INTO `t_log` VALUES (4935, '查询操作', '分页查询商品信息', '2019-08-02 19:20:22', 1);
INSERT INTO `t_log` VALUES (4936, '查询操作', '分页查询商品信息', '2019-08-02 19:20:30', 1);
INSERT INTO `t_log` VALUES (4937, '查询操作', '分页查询商品信息', '2019-08-02 19:20:30', 1);
INSERT INTO `t_log` VALUES (4938, '查询操作', '分页查询商品信息', '2019-08-02 19:25:28', 1);
INSERT INTO `t_log` VALUES (4939, '查询操作', '分页查询商品信息', '2019-08-02 19:25:28', 1);
INSERT INTO `t_log` VALUES (4940, '查询操作', '分页查询商品信息', '2019-08-02 19:25:37', 1);
INSERT INTO `t_log` VALUES (4941, '查询操作', '分页查询商品信息', '2019-08-02 19:25:38', 1);
INSERT INTO `t_log` VALUES (4942, '登录操作', '登录系统', '2019-08-02 19:26:55', 1);
INSERT INTO `t_log` VALUES (4943, '查询操作', '分页查询商品信息', '2019-08-02 19:27:08', 1);
INSERT INTO `t_log` VALUES (4944, '查询操作', '分页查询商品信息', '2019-08-02 19:27:09', 1);
INSERT INTO `t_log` VALUES (4945, '查询操作', '查询商品类别信息', '2019-08-02 19:36:44', 1);
INSERT INTO `t_log` VALUES (4946, '查询操作', '查询商品类别信息', '2019-08-02 19:38:48', 1);
INSERT INTO `t_log` VALUES (4947, '查询操作', '查询商品类别信息', '2019-08-02 19:39:57', 1);
INSERT INTO `t_log` VALUES (4948, '查询操作', '分页查询商品信息', '2019-08-02 19:40:05', 1);
INSERT INTO `t_log` VALUES (4949, '查询操作', '查询商品类别信息', '2019-08-02 19:40:35', 1);
INSERT INTO `t_log` VALUES (4950, '查询操作', '查询商品类别信息', '2019-08-02 19:49:27', 1);
INSERT INTO `t_log` VALUES (4951, '登录操作', '登录系统', '2019-08-03 15:59:09', 1);
INSERT INTO `t_log` VALUES (4952, '查询操作', '分页查询商品信息', '2019-08-03 15:59:17', 1);
INSERT INTO `t_log` VALUES (4953, '查询操作', '分页查询商品信息', '2019-08-03 15:59:18', 1);
INSERT INTO `t_log` VALUES (4954, '查询操作', '查询商品类别信息', '2019-08-03 16:02:08', 1);
INSERT INTO `t_log` VALUES (4955, '查询操作', '查询商品类别信息', '2019-08-03 16:03:15', 1);
INSERT INTO `t_log` VALUES (4956, '查询操作', '分页查询商品信息', '2019-08-03 16:04:18', 1);
INSERT INTO `t_log` VALUES (4957, '新增操作', '新增商品类别:null', '2019-08-03 16:04:28', 1);
INSERT INTO `t_log` VALUES (4958, '查询操作', '查询商品类别信息', '2019-08-03 16:04:44', 1);
INSERT INTO `t_log` VALUES (4959, '查询操作', '分页查询商品信息', '2019-08-03 16:04:49', 1);
INSERT INTO `t_log` VALUES (4960, '查询操作', '分页查询商品信息', '2019-08-03 16:15:24', 1);
INSERT INTO `t_log` VALUES (4961, '查询操作', '分页查询商品信息', '2019-08-03 16:15:48', 1);
INSERT INTO `t_log` VALUES (4962, '查询操作', '分页查询商品信息', '2019-08-03 16:15:59', 1);
INSERT INTO `t_log` VALUES (4963, '查询操作', '分页查询商品信息', '2019-08-03 16:16:04', 1);
INSERT INTO `t_log` VALUES (4964, '查询操作', '分页查询商品信息', '2019-08-03 16:16:07', 1);
INSERT INTO `t_log` VALUES (4965, '查询操作', '分页查询商品信息', '2019-08-03 16:16:22', 1);
INSERT INTO `t_log` VALUES (4966, '查询操作', '分页查询商品信息', '2019-08-03 16:16:38', 1);
INSERT INTO `t_log` VALUES (4967, '查询操作', '查询商品类别信息', '2019-08-03 16:17:25', 1);
INSERT INTO `t_log` VALUES (4968, '查询操作', '查询商品类别信息', '2019-08-03 16:17:59', 1);
INSERT INTO `t_log` VALUES (4969, '登录操作', '登录系统', '2019-08-03 16:30:46', 1);
INSERT INTO `t_log` VALUES (4970, '查询操作', '分页查询商品信息', '2019-08-03 16:30:51', 1);
INSERT INTO `t_log` VALUES (4971, '查询操作', '分页查询商品信息', '2019-08-03 16:30:51', 1);
INSERT INTO `t_log` VALUES (4972, '查询操作', '查询商品类别信息', '2019-08-03 16:30:58', 1);
INSERT INTO `t_log` VALUES (4973, '查询操作', '分页查询商品信息', '2019-08-03 16:31:04', 1);
INSERT INTO `t_log` VALUES (4974, '查询操作', '查询商品类别信息', '2019-08-03 16:31:09', 1);
INSERT INTO `t_log` VALUES (4975, '查询操作', '分页查询商品信息', '2019-08-03 16:31:13', 1);
INSERT INTO `t_log` VALUES (4976, '查询操作', '分页查询商品信息', '2019-08-03 16:31:15', 1);
INSERT INTO `t_log` VALUES (4977, '查询操作', '分页查询商品信息', '2019-08-03 16:31:42', 1);
INSERT INTO `t_log` VALUES (4978, '查询操作', '分页查询商品信息', '2019-08-03 16:31:44', 1);
INSERT INTO `t_log` VALUES (4979, '查询操作', '分页查询商品信息', '2019-08-03 16:31:45', 1);
INSERT INTO `t_log` VALUES (4980, '查询操作', '分页查询商品信息', '2019-08-03 16:31:46', 1);
INSERT INTO `t_log` VALUES (4981, '查询操作', '分页查询商品信息', '2019-08-03 16:31:50', 1);
INSERT INTO `t_log` VALUES (4982, '查询操作', '分页查询商品信息', '2019-08-03 16:31:50', 1);
INSERT INTO `t_log` VALUES (4983, '查询操作', '分页查询商品信息', '2019-08-03 16:31:51', 1);
INSERT INTO `t_log` VALUES (4984, '查询操作', '分页查询商品信息', '2019-08-03 16:31:53', 1);
INSERT INTO `t_log` VALUES (4985, '查询操作', '分页查询商品信息', '2019-08-03 16:32:11', 1);
INSERT INTO `t_log` VALUES (4986, '查询操作', '分页查询商品信息', '2019-08-03 16:32:20', 1);
INSERT INTO `t_log` VALUES (4987, '查询操作', '分页查询商品信息', '2019-08-03 16:32:27', 1);
INSERT INTO `t_log` VALUES (4988, '查询操作', '分页查询商品信息', '2019-08-03 16:32:35', 1);
INSERT INTO `t_log` VALUES (4989, '查询操作', '分页查询商品信息', '2019-08-03 16:32:39', 1);
INSERT INTO `t_log` VALUES (4990, '查询操作', '分页查询商品信息', '2019-08-03 16:32:43', 1);
INSERT INTO `t_log` VALUES (4991, '查询操作', '分页查询商品信息', '2019-08-03 16:33:35', 1);
INSERT INTO `t_log` VALUES (4992, '新增操作', '新增商品类别:儿童', '2019-08-03 16:33:45', 1);
INSERT INTO `t_log` VALUES (4993, '查询操作', '查询商品类别信息', '2019-08-03 16:33:45', 1);
INSERT INTO `t_log` VALUES (4994, '查询操作', '分页查询商品信息', '2019-08-03 16:33:49', 1);
INSERT INTO `t_log` VALUES (4995, '查询操作', '分页查询商品信息', '2019-08-03 16:33:54', 1);
INSERT INTO `t_log` VALUES (4996, '查询操作', '分页查询商品信息', '2019-08-03 16:33:57', 1);
INSERT INTO `t_log` VALUES (4997, '查询操作', '分页查询商品信息', '2019-08-03 16:34:00', 1);
INSERT INTO `t_log` VALUES (4998, '查询操作', '分页查询商品信息', '2019-08-03 16:34:01', 1);
INSERT INTO `t_log` VALUES (4999, '查询操作', '分页查询商品信息', '2019-08-03 16:34:02', 1);
INSERT INTO `t_log` VALUES (5000, '新增操作', '新增商品类别:test', '2019-08-03 16:34:10', 1);
INSERT INTO `t_log` VALUES (5001, '查询操作', '查询商品类别信息', '2019-08-03 16:34:10', 1);
INSERT INTO `t_log` VALUES (5002, '查询操作', '分页查询商品信息', '2019-08-03 16:34:20', 1);
INSERT INTO `t_log` VALUES (5003, '查询操作', '分页查询商品信息', '2019-08-03 16:34:21', 1);
INSERT INTO `t_log` VALUES (5004, '查询操作', '分页查询商品信息', '2019-08-03 16:34:25', 1);
INSERT INTO `t_log` VALUES (5005, '查询操作', '分页查询商品信息', '2019-08-03 16:34:26', 1);
INSERT INTO `t_log` VALUES (5006, '删除操作', '删除商品类别：儿童', '2019-08-03 16:34:34', 1);
INSERT INTO `t_log` VALUES (5007, '查询操作', '查询商品类别信息', '2019-08-03 16:34:34', 1);
INSERT INTO `t_log` VALUES (5008, '查询操作', '分页查询商品信息', '2019-08-03 16:35:10', 1);
INSERT INTO `t_log` VALUES (5009, '删除操作', '删除商品类别：服饰', '2019-08-03 16:35:17', 1);
INSERT INTO `t_log` VALUES (5010, '查询操作', '查询商品类别信息', '2019-08-03 16:35:17', 1);
INSERT INTO `t_log` VALUES (5011, '查询操作', '分页查询商品信息', '2019-08-03 16:35:46', 1);
INSERT INTO `t_log` VALUES (5012, '查询操作', '分页查询商品信息', '2019-08-03 16:35:52', 1);
INSERT INTO `t_log` VALUES (5013, '查询操作', '分页查询商品信息', '2019-08-03 16:36:01', 1);
INSERT INTO `t_log` VALUES (5014, '查询操作', '分页查询商品信息', '2019-08-03 16:36:03', 1);
INSERT INTO `t_log` VALUES (5015, '删除操作', '删除商品类别：数码', '2019-08-03 16:36:06', 1);
INSERT INTO `t_log` VALUES (5016, '查询操作', '查询商品类别信息', '2019-08-03 16:36:06', 1);
INSERT INTO `t_log` VALUES (5017, '查询操作', '分页查询商品信息', '2019-08-03 16:36:08', 1);
INSERT INTO `t_log` VALUES (5018, '删除操作', '删除商品类别：家电', '2019-08-03 16:36:59', 1);
INSERT INTO `t_log` VALUES (5019, '查询操作', '查询商品类别信息', '2019-08-03 16:36:59', 1);
INSERT INTO `t_log` VALUES (5020, '查询操作', '查询商品类别信息', '2019-08-03 16:43:03', 1);
INSERT INTO `t_log` VALUES (5021, '查询操作', '查询商品类别信息', '2019-08-03 16:45:37', 1);
INSERT INTO `t_log` VALUES (5022, '查询操作', '分页查询商品信息', '2019-08-03 16:45:44', 1);
INSERT INTO `t_log` VALUES (5023, '查询操作', '分页查询商品信息', '2019-08-03 16:46:20', 1);
INSERT INTO `t_log` VALUES (5024, '查询操作', '分页查询商品信息', '2019-08-03 16:46:20', 1);
INSERT INTO `t_log` VALUES (5025, '查询操作', '查询商品类别信息', '2019-08-03 16:46:22', 1);
INSERT INTO `t_log` VALUES (5026, '查询操作', '分页查询商品信息', '2019-08-03 16:46:27', 1);
INSERT INTO `t_log` VALUES (5027, '新增操作', '新增商品类别:儿童', '2019-08-03 16:46:31', 1);
INSERT INTO `t_log` VALUES (5028, '查询操作', '查询商品类别信息', '2019-08-03 16:46:31', 1);
INSERT INTO `t_log` VALUES (5029, '查询操作', '分页查询商品信息', '2019-08-03 16:47:51', 1);
INSERT INTO `t_log` VALUES (5030, '新增操作', '新增商品类别:test', '2019-08-03 16:47:57', 1);
INSERT INTO `t_log` VALUES (5031, '查询操作', '查询商品类别信息', '2019-08-03 16:47:57', 1);
INSERT INTO `t_log` VALUES (5032, '查询操作', '分页查询商品信息', '2019-08-03 16:48:00', 1);
INSERT INTO `t_log` VALUES (5033, '删除操作', '删除商品类别：test', '2019-08-03 16:48:03', 1);
INSERT INTO `t_log` VALUES (5034, '查询操作', '查询商品类别信息', '2019-08-03 16:48:03', 1);
INSERT INTO `t_log` VALUES (5035, '查询操作', '分页查询商品信息', '2019-08-03 16:48:05', 1);
INSERT INTO `t_log` VALUES (5036, '删除操作', '删除商品类别：儿童', '2019-08-03 16:48:09', 1);
INSERT INTO `t_log` VALUES (5037, '查询操作', '查询商品类别信息', '2019-08-03 16:48:09', 1);
INSERT INTO `t_log` VALUES (5038, '查询操作', '分页查询商品信息', '2019-08-03 16:48:25', 1);
INSERT INTO `t_log` VALUES (5039, '查询操作', '分页查询商品信息', '2019-08-03 16:48:46', 1);
INSERT INTO `t_log` VALUES (5040, '查询操作', '分页查询商品信息', '2019-08-03 16:49:07', 1);
INSERT INTO `t_log` VALUES (5041, '删除操作', '删除商品类别：服饰', '2019-08-03 16:49:10', 1);
INSERT INTO `t_log` VALUES (5042, '查询操作', '查询商品类别信息', '2019-08-03 16:49:10', 1);
INSERT INTO `t_log` VALUES (5043, '查询操作', '查询商品类别信息', '2019-08-03 16:52:35', 1);
INSERT INTO `t_log` VALUES (5044, '查询操作', '分页查询商品信息', '2019-08-03 16:52:38', 1);
INSERT INTO `t_log` VALUES (5045, '查询操作', '查询商品类别信息', '2019-08-03 16:58:25', 1);
INSERT INTO `t_log` VALUES (5046, '查询操作', '查询商品类别信息', '2019-08-03 16:58:32', 1);
INSERT INTO `t_log` VALUES (5047, '查询操作', '查询商品类别信息', '2019-08-03 16:58:39', 1);
INSERT INTO `t_log` VALUES (5048, '查询操作', '分页查询商品信息', '2019-08-03 16:58:45', 1);
INSERT INTO `t_log` VALUES (5049, '查询操作', '分页查询商品信息', '2019-08-03 17:00:24', 1);
INSERT INTO `t_log` VALUES (5050, '查询操作', '分页查询商品信息', '2019-08-03 17:00:24', 1);
INSERT INTO `t_log` VALUES (5051, '查询操作', '查询商品类别信息', '2019-08-03 17:00:26', 1);
INSERT INTO `t_log` VALUES (5052, '查询操作', '分页查询商品信息', '2019-08-03 17:00:27', 1);
INSERT INTO `t_log` VALUES (5053, '登录操作', '登录系统', '2019-08-03 17:01:21', 1);
INSERT INTO `t_log` VALUES (5054, '查询操作', '分页查询商品信息', '2019-08-03 17:01:26', 1);
INSERT INTO `t_log` VALUES (5055, '查询操作', '分页查询商品信息', '2019-08-03 17:01:26', 1);
INSERT INTO `t_log` VALUES (5056, '查询操作', '查询商品类别信息', '2019-08-03 17:01:27', 1);
INSERT INTO `t_log` VALUES (5057, '查询操作', '分页查询商品信息', '2019-08-03 17:02:32', 1);
INSERT INTO `t_log` VALUES (5058, '查询操作', '分页查询商品信息', '2019-08-03 17:02:34', 1);
INSERT INTO `t_log` VALUES (5059, '查询操作', '分页查询商品信息', '2019-08-03 17:02:35', 1);
INSERT INTO `t_log` VALUES (5060, '查询操作', '分页查询商品信息', '2019-08-03 17:02:36', 1);
INSERT INTO `t_log` VALUES (5061, '查询操作', '分页查询商品信息', '2019-08-03 17:02:36', 1);
INSERT INTO `t_log` VALUES (5062, '查询操作', '分页查询商品信息', '2019-08-03 17:02:38', 1);
INSERT INTO `t_log` VALUES (5063, '查询操作', '分页查询商品信息', '2019-08-03 17:02:48', 1);
INSERT INTO `t_log` VALUES (5064, '查询操作', '分页查询商品信息', '2019-08-03 17:02:50', 1);
INSERT INTO `t_log` VALUES (5065, '查询操作', '查询商品类别信息', '2019-08-03 17:06:39', 1);
INSERT INTO `t_log` VALUES (5066, '登录操作', '登录系统', '2019-08-03 17:11:49', 1);
INSERT INTO `t_log` VALUES (5067, '查询操作', '分页查询商品信息', '2019-08-03 17:12:00', 1);
INSERT INTO `t_log` VALUES (5068, '查询操作', '分页查询商品信息', '2019-08-03 17:12:01', 1);
INSERT INTO `t_log` VALUES (5069, '查询操作', '查询商品类别信息', '2019-08-03 17:12:02', 1);
INSERT INTO `t_log` VALUES (5070, '查询操作', '分页查询商品信息', '2019-08-03 17:12:06', 1);
INSERT INTO `t_log` VALUES (5071, '查询操作', '分页查询商品信息', '2019-08-03 17:13:04', 1);
INSERT INTO `t_log` VALUES (5072, '查询操作', '分页查询商品信息', '2019-08-03 17:13:06', 1);
INSERT INTO `t_log` VALUES (5073, '查询操作', '分页查询商品信息', '2019-08-03 17:13:40', 1);
INSERT INTO `t_log` VALUES (5074, '查询操作', '查询商品类别信息', '2019-08-03 17:13:40', 1);
INSERT INTO `t_log` VALUES (5075, '登录操作', '登录系统', '2019-08-04 08:02:27', 1);
INSERT INTO `t_log` VALUES (5076, '查询操作', '分页查询商品信息', '2019-08-04 08:02:46', 1);
INSERT INTO `t_log` VALUES (5077, '查询操作', '分页查询商品信息', '2019-08-04 08:02:46', 1);
INSERT INTO `t_log` VALUES (5078, '查询操作', '查询商品类别信息', '2019-08-04 08:02:59', 1);
INSERT INTO `t_log` VALUES (5079, '查询操作', '分页查询商品信息', '2019-08-04 08:03:05', 1);
INSERT INTO `t_log` VALUES (5080, '查询操作', '分页查询商品信息', '2019-08-04 08:03:14', 1);
INSERT INTO `t_log` VALUES (5081, '查询操作', '分页查询商品信息', '2019-08-04 08:03:20', 1);
INSERT INTO `t_log` VALUES (5082, '查询操作', '分页查询商品信息', '2019-08-04 08:03:30', 1);
INSERT INTO `t_log` VALUES (5083, '查询操作', '分页查询商品信息', '2019-08-04 08:04:24', 1);
INSERT INTO `t_log` VALUES (5084, '登录操作', '登录系统', '2019-08-04 08:26:19', 1);
INSERT INTO `t_log` VALUES (5085, '查询操作', '分页查询商品信息', '2019-08-04 08:26:33', 1);
INSERT INTO `t_log` VALUES (5086, '查询操作', '分页查询商品信息', '2019-08-04 08:26:34', 1);
INSERT INTO `t_log` VALUES (5087, '查询操作', '查询商品类别信息', '2019-08-04 08:26:39', 1);
INSERT INTO `t_log` VALUES (5088, '查询操作', '分页查询商品信息', '2019-08-04 08:26:48', 1);
INSERT INTO `t_log` VALUES (5089, '查询操作', '分页查询商品信息', '2019-08-04 08:26:48', 1);
INSERT INTO `t_log` VALUES (5090, '查询操作', '查询商品类别信息', '2019-08-04 08:26:52', 1);
INSERT INTO `t_log` VALUES (5091, '查询操作', '分页查询商品信息', '2019-08-04 08:27:23', 1);
INSERT INTO `t_log` VALUES (5092, '查询操作', '查询商品类别信息', '2019-08-04 08:27:41', 1);
INSERT INTO `t_log` VALUES (5093, '查询操作', '查询商品类别信息', '2019-08-04 08:28:50', 1);
INSERT INTO `t_log` VALUES (5094, '查询操作', '查询商品类别信息', '2019-08-04 08:29:40', 1);
INSERT INTO `t_log` VALUES (5095, '查询操作', '查询商品类别信息', '2019-08-04 08:38:24', 1);
INSERT INTO `t_log` VALUES (5096, '查询操作', '查询商品类别信息', '2019-08-04 08:39:28', 1);
INSERT INTO `t_log` VALUES (5097, '登录操作', '登录系统', '2019-08-04 08:40:08', 1);
INSERT INTO `t_log` VALUES (5098, '查询操作', '分页查询商品信息', '2019-08-04 08:40:14', 1);
INSERT INTO `t_log` VALUES (5099, '查询操作', '分页查询商品信息', '2019-08-04 08:40:14', 1);
INSERT INTO `t_log` VALUES (5100, '查询操作', '查询商品类别信息', '2019-08-04 08:40:16', 1);
INSERT INTO `t_log` VALUES (5101, '查询操作', '分页查询商品信息', '2019-08-04 08:40:19', 1);
INSERT INTO `t_log` VALUES (5102, '查询操作', '查询商品类别信息', '2019-08-04 08:40:25', 1);
INSERT INTO `t_log` VALUES (5103, '登录操作', '登录系统', '2019-08-04 08:49:53', 1);
INSERT INTO `t_log` VALUES (5104, '查询操作', '分页查询商品信息', '2019-08-04 08:50:02', 1);
INSERT INTO `t_log` VALUES (5105, '查询操作', '分页查询商品信息', '2019-08-04 08:50:03', 1);
INSERT INTO `t_log` VALUES (5106, '查询操作', '查询商品类别信息', '2019-08-04 08:50:05', 1);
INSERT INTO `t_log` VALUES (5107, '查询操作', '分页查询商品信息', '2019-08-04 08:50:10', 1);
INSERT INTO `t_log` VALUES (5108, '查询操作', '查询商品类别信息', '2019-08-04 08:50:17', 1);
INSERT INTO `t_log` VALUES (5109, '登录操作', '登录系统', '2019-08-04 08:57:51', 1);
INSERT INTO `t_log` VALUES (5110, '查询操作', '分页查询商品信息', '2019-08-04 08:58:21', 1);
INSERT INTO `t_log` VALUES (5111, '查询操作', '分页查询商品信息', '2019-08-04 08:58:21', 1);
INSERT INTO `t_log` VALUES (5112, '查询操作', '查询商品类别信息', '2019-08-04 08:58:23', 1);
INSERT INTO `t_log` VALUES (5113, '查询操作', '分页查询商品信息', '2019-08-04 08:58:27', 1);
INSERT INTO `t_log` VALUES (5114, '查询操作', '查询商品类别信息', '2019-08-04 08:58:31', 1);
INSERT INTO `t_log` VALUES (5115, '查询操作', '分页查询商品信息', '2019-08-04 09:28:23', 1);
INSERT INTO `t_log` VALUES (5116, '查询操作', '分页查询商品信息', '2019-08-04 09:28:23', 1);
INSERT INTO `t_log` VALUES (5117, '查询操作', '查询商品类别信息', '2019-08-04 09:28:25', 1);
INSERT INTO `t_log` VALUES (5118, '查询操作', '分页查询商品信息', '2019-08-04 09:28:30', 1);
INSERT INTO `t_log` VALUES (5119, '查询操作', '查询商品类别信息', '2019-08-04 09:28:34', 1);
INSERT INTO `t_log` VALUES (5120, '登录操作', '登录系统', '2019-08-04 09:29:46', 1);
INSERT INTO `t_log` VALUES (5121, '查询操作', '分页查询商品信息', '2019-08-04 09:30:14', 1);
INSERT INTO `t_log` VALUES (5122, '查询操作', '分页查询商品信息', '2019-08-04 09:30:14', 1);
INSERT INTO `t_log` VALUES (5123, '查询操作', '查询商品类别信息', '2019-08-04 09:30:17', 1);
INSERT INTO `t_log` VALUES (5124, '查询操作', '分页查询商品信息', '2019-08-04 09:30:20', 1);
INSERT INTO `t_log` VALUES (5125, '查询操作', '查询商品类别信息', '2019-08-04 09:30:24', 1);
INSERT INTO `t_log` VALUES (5126, '新增操作', '新增进货单：JH1564882213808', '2019-08-04 09:30:48', 1);
INSERT INTO `t_log` VALUES (5127, '查询操作', '分页查询商品信息', '2019-08-04 09:30:52', 1);
INSERT INTO `t_log` VALUES (5128, '查询操作', '分页查询商品信息', '2019-08-04 09:30:52', 1);
INSERT INTO `t_log` VALUES (5129, '查询操作', '查询商品类别信息', '2019-08-04 09:34:45', 1);
INSERT INTO `t_log` VALUES (5130, '查询操作', '分页查询商品信息', '2019-08-04 09:34:48', 1);
INSERT INTO `t_log` VALUES (5131, '新增操作', '新增进货单：JH1564882251720', '2019-08-04 09:35:05', 1);
INSERT INTO `t_log` VALUES (5132, '查询操作', '分页查询商品信息', '2019-08-04 09:35:07', 1);
INSERT INTO `t_log` VALUES (5133, '查询操作', '分页查询商品信息', '2019-08-04 09:35:08', 1);
INSERT INTO `t_log` VALUES (5134, '查询操作', '分页查询商品信息', '2019-08-04 09:38:31', 1);
INSERT INTO `t_log` VALUES (5135, '查询操作', '分页查询商品信息', '2019-08-04 09:38:31', 1);
INSERT INTO `t_log` VALUES (5136, '查询操作', '分页查询商品信息', '2019-08-04 09:38:52', 1);
INSERT INTO `t_log` VALUES (5137, '查询操作', '分页查询商品信息', '2019-08-04 09:38:52', 1);
INSERT INTO `t_log` VALUES (5138, '查询操作', '查询商品类别信息', '2019-08-04 09:39:36', 1);
INSERT INTO `t_log` VALUES (5139, '查询操作', '分页查询商品信息', '2019-08-04 09:39:37', 1);
INSERT INTO `t_log` VALUES (5140, '登录操作', '登录系统', '2019-08-04 10:14:30', 1);
INSERT INTO `t_log` VALUES (5141, '登录操作', '登录系统', '2019-08-05 08:58:20', 1);
INSERT INTO `t_log` VALUES (5142, '查询操作', '分页查询商品信息', '2019-08-05 08:58:27', 1);
INSERT INTO `t_log` VALUES (5143, '查询操作', '分页查询商品信息', '2019-08-05 08:58:27', 1);
INSERT INTO `t_log` VALUES (5144, '查询操作', '查询商品类别信息', '2019-08-05 08:58:31', 1);
INSERT INTO `t_log` VALUES (5145, '查询操作', '分页查询商品信息', '2019-08-05 08:58:43', 1);
INSERT INTO `t_log` VALUES (5146, '查询操作', '分页查询商品信息', '2019-08-05 08:58:43', 1);
INSERT INTO `t_log` VALUES (5147, '查询操作', '进货单据查询', '2019-08-05 08:58:59', 1);
INSERT INTO `t_log` VALUES (5148, '查询操作', '进货单据查询', '2019-08-05 08:58:59', 1);
INSERT INTO `t_log` VALUES (5149, '登录操作', '登录系统', '2019-08-05 09:14:54', 1);
INSERT INTO `t_log` VALUES (5150, '查询操作', '分页查询商品信息', '2019-08-05 09:14:58', 1);
INSERT INTO `t_log` VALUES (5151, '查询操作', '分页查询商品信息', '2019-08-05 09:14:58', 1);
INSERT INTO `t_log` VALUES (5152, '查询操作', '查询商品类别信息', '2019-08-05 09:15:00', 1);
INSERT INTO `t_log` VALUES (5153, '查询操作', '分页查询商品信息', '2019-08-05 09:15:03', 1);
INSERT INTO `t_log` VALUES (5154, '登录操作', '登录系统', '2019-08-05 15:47:42', 1);
INSERT INTO `t_log` VALUES (5155, '查询操作', '分页查询商品信息', '2019-08-05 15:47:55', 1);
INSERT INTO `t_log` VALUES (5156, '查询操作', '分页查询商品信息', '2019-08-05 15:47:56', 1);
INSERT INTO `t_log` VALUES (5157, '查询操作', '查询商品类别信息', '2019-08-05 15:47:59', 1);
INSERT INTO `t_log` VALUES (5158, '查询操作', '分页查询商品信息', '2019-08-05 15:48:02', 1);
INSERT INTO `t_log` VALUES (5159, '查询操作', '分页查询商品信息', '2019-08-05 15:48:24', 1);
INSERT INTO `t_log` VALUES (5160, '查询操作', '分页查询商品信息', '2019-08-05 15:48:24', 1);
INSERT INTO `t_log` VALUES (5161, '登录操作', '登录系统', '2019-08-06 08:07:26', 1);
INSERT INTO `t_log` VALUES (5162, '查询操作', '分页查询商品信息', '2019-08-06 08:07:37', 1);
INSERT INTO `t_log` VALUES (5163, '查询操作', '分页查询商品信息', '2019-08-06 08:07:38', 1);
INSERT INTO `t_log` VALUES (5164, '查询操作', '查询商品类别信息', '2019-08-06 08:07:48', 1);
INSERT INTO `t_log` VALUES (5165, '查询操作', '分页查询商品信息', '2019-08-06 08:08:03', 1);
INSERT INTO `t_log` VALUES (5166, '查询操作', '分页查询商品信息', '2019-08-06 08:08:05', 1);
INSERT INTO `t_log` VALUES (5167, '查询操作', '分页查询商品信息', '2019-08-06 08:08:07', 1);
INSERT INTO `t_log` VALUES (5168, '查询操作', '分页查询商品信息', '2019-08-06 08:08:08', 1);
INSERT INTO `t_log` VALUES (5169, '查询操作', '分页查询商品信息', '2019-08-06 08:08:09', 1);
INSERT INTO `t_log` VALUES (5170, '查询操作', '分页查询商品信息', '2019-08-06 08:08:14', 1);
INSERT INTO `t_log` VALUES (5171, '查询操作', '分页查询商品信息', '2019-08-06 08:08:18', 1);
INSERT INTO `t_log` VALUES (5172, '查询操作', '分页查询商品信息', '2019-08-06 08:08:20', 1);
INSERT INTO `t_log` VALUES (5173, '查询操作', '分页查询商品信息', '2019-08-06 08:08:43', 1);
INSERT INTO `t_log` VALUES (5174, '查询操作', '分页查询商品信息', '2019-08-06 08:08:48', 1);
INSERT INTO `t_log` VALUES (5175, '查询操作', '分页查询商品信息', '2019-08-06 08:08:55', 1);
INSERT INTO `t_log` VALUES (5176, '查询操作', '分页查询商品信息', '2019-08-06 08:08:57', 1);
INSERT INTO `t_log` VALUES (5177, '查询操作', '查询商品类别信息', '2019-08-06 08:09:35', 1);
INSERT INTO `t_log` VALUES (5178, '查询操作', '分页查询商品信息', '2019-08-06 08:09:41', 1);
INSERT INTO `t_log` VALUES (5179, '查询操作', '分页查询商品信息', '2019-08-06 08:09:55', 1);
INSERT INTO `t_log` VALUES (5180, '查询操作', '分页查询商品信息', '2019-08-06 08:09:55', 1);
INSERT INTO `t_log` VALUES (5181, '查询操作', '查询商品类别信息', '2019-08-06 08:09:56', 1);
INSERT INTO `t_log` VALUES (5182, '查询操作', '分页查询商品信息', '2019-08-06 08:10:00', 1);
INSERT INTO `t_log` VALUES (5183, '查询操作', '分页查询商品信息', '2019-08-06 08:10:12', 1);
INSERT INTO `t_log` VALUES (5184, '查询操作', '分页查询商品信息', '2019-08-06 08:10:12', 1);
INSERT INTO `t_log` VALUES (5185, '查询操作', '查询商品类别信息', '2019-08-06 08:10:16', 1);
INSERT INTO `t_log` VALUES (5186, '登录操作', '登录系统', '2019-08-06 08:11:36', 1);
INSERT INTO `t_log` VALUES (5187, '查询操作', '分页查询商品信息', '2019-08-06 08:11:42', 1);
INSERT INTO `t_log` VALUES (5188, '查询操作', '分页查询商品信息', '2019-08-06 08:11:42', 1);
INSERT INTO `t_log` VALUES (5189, '查询操作', '查询商品类别信息', '2019-08-06 08:12:02', 1);
INSERT INTO `t_log` VALUES (5190, '查询操作', '分页查询商品信息', '2019-08-06 08:12:05', 1);
INSERT INTO `t_log` VALUES (5191, '查询操作', '分页查询商品信息', '2019-08-06 08:12:07', 1);
INSERT INTO `t_log` VALUES (5192, '查询操作', '分页查询商品信息', '2019-08-06 08:12:08', 1);
INSERT INTO `t_log` VALUES (5193, '查询操作', '分页查询商品信息', '2019-08-06 08:12:13', 1);
INSERT INTO `t_log` VALUES (5194, '查询操作', '分页查询商品信息', '2019-08-06 08:12:17', 1);
INSERT INTO `t_log` VALUES (5195, '查询操作', '分页查询商品信息', '2019-08-06 08:12:22', 1);
INSERT INTO `t_log` VALUES (5196, '查询操作', '分页查询商品信息', '2019-08-06 08:12:24', 1);
INSERT INTO `t_log` VALUES (5197, '查询操作', '分页查询商品信息', '2019-08-06 08:12:25', 1);
INSERT INTO `t_log` VALUES (5198, '查询操作', '分页查询商品信息', '2019-08-06 08:12:26', 1);
INSERT INTO `t_log` VALUES (5199, '查询操作', '分页查询商品信息', '2019-08-06 08:12:27', 1);
INSERT INTO `t_log` VALUES (5200, '查询操作', '分页查询商品信息', '2019-08-06 08:12:28', 1);
INSERT INTO `t_log` VALUES (5201, '查询操作', '分页查询商品信息', '2019-08-06 08:12:32', 1);
INSERT INTO `t_log` VALUES (5202, '查询操作', '分页查询商品信息', '2019-08-06 08:12:33', 1);
INSERT INTO `t_log` VALUES (5203, '查询操作', '分页查询商品信息', '2019-08-06 08:12:34', 1);
INSERT INTO `t_log` VALUES (5204, '查询操作', '分页查询商品信息', '2019-08-06 08:12:36', 1);
INSERT INTO `t_log` VALUES (5205, '查询操作', '分页查询商品信息', '2019-08-06 08:12:38', 1);
INSERT INTO `t_log` VALUES (5206, '查询操作', '分页查询商品信息', '2019-08-06 08:12:50', 1);
INSERT INTO `t_log` VALUES (5207, '查询操作', '分页查询商品信息', '2019-08-06 08:12:52', 1);
INSERT INTO `t_log` VALUES (5208, '查询操作', '分页查询商品信息', '2019-08-06 08:12:53', 1);
INSERT INTO `t_log` VALUES (5209, '查询操作', '分页查询商品信息', '2019-08-06 08:12:55', 1);
INSERT INTO `t_log` VALUES (5210, '查询操作', '分页查询商品信息', '2019-08-06 08:12:55', 1);
INSERT INTO `t_log` VALUES (5211, '查询操作', '查询商品类别信息', '2019-08-06 08:13:12', 1);
INSERT INTO `t_log` VALUES (5212, '查询操作', '分页查询商品信息', '2019-08-06 08:13:20', 1);
INSERT INTO `t_log` VALUES (5213, '查询操作', '分页查询商品信息', '2019-08-06 08:13:21', 1);
INSERT INTO `t_log` VALUES (5214, '查询操作', '查询商品类别信息', '2019-08-06 08:13:22', 1);
INSERT INTO `t_log` VALUES (5215, '查询操作', '分页查询商品信息', '2019-08-06 08:13:28', 1);
INSERT INTO `t_log` VALUES (5216, '查询操作', '查询商品类别信息', '2019-08-06 08:14:34', 1);
INSERT INTO `t_log` VALUES (5217, '登录操作', '登录系统', '2019-08-06 08:20:54', 1);
INSERT INTO `t_log` VALUES (5218, '查询操作', '分页查询商品信息', '2019-08-06 08:21:00', 1);
INSERT INTO `t_log` VALUES (5219, '查询操作', '分页查询商品信息', '2019-08-06 08:21:00', 1);
INSERT INTO `t_log` VALUES (5220, '查询操作', '查询商品类别信息', '2019-08-06 08:21:02', 1);
INSERT INTO `t_log` VALUES (5221, '查询操作', '分页查询商品信息', '2019-08-06 08:21:10', 1);
INSERT INTO `t_log` VALUES (5222, '新增操作', '新增商品类别:啊啊啊', '2019-08-06 08:21:18', 1);
INSERT INTO `t_log` VALUES (5223, '查询操作', '查询商品类别信息', '2019-08-06 08:21:18', 1);
INSERT INTO `t_log` VALUES (5224, '查询操作', '分页查询商品信息', '2019-08-06 08:21:22', 1);
INSERT INTO `t_log` VALUES (5225, '新增操作', '新增商品类别:把v', '2019-08-06 08:21:33', 1);
INSERT INTO `t_log` VALUES (5226, '查询操作', '查询商品类别信息', '2019-08-06 08:21:33', 1);
INSERT INTO `t_log` VALUES (5227, '查询操作', '分页查询商品信息', '2019-08-06 08:21:36', 1);
INSERT INTO `t_log` VALUES (5228, '查询操作', '分页查询商品信息', '2019-08-06 08:21:40', 1);
INSERT INTO `t_log` VALUES (5229, '删除操作', '删除商品类别：把v', '2019-08-06 08:21:42', 1);
INSERT INTO `t_log` VALUES (5230, '查询操作', '查询商品类别信息', '2019-08-06 08:21:42', 1);
INSERT INTO `t_log` VALUES (5231, '查询操作', '分页查询商品信息', '2019-08-06 08:21:44', 1);
INSERT INTO `t_log` VALUES (5232, '删除操作', '删除商品类别：啊啊啊', '2019-08-06 08:21:47', 1);
INSERT INTO `t_log` VALUES (5233, '查询操作', '查询商品类别信息', '2019-08-06 08:21:47', 1);
INSERT INTO `t_log` VALUES (5234, '查询操作', '分页查询商品信息', '2019-08-06 08:22:12', 1);
INSERT INTO `t_log` VALUES (5235, '登录操作', '登录系统', '2019-08-06 08:26:38', 1);
INSERT INTO `t_log` VALUES (5236, '查询操作', '分页查询商品信息', '2019-08-06 08:26:43', 1);
INSERT INTO `t_log` VALUES (5237, '查询操作', '分页查询商品信息', '2019-08-06 08:26:44', 1);
INSERT INTO `t_log` VALUES (5238, '查询操作', '查询商品类别信息', '2019-08-06 08:26:45', 1);
INSERT INTO `t_log` VALUES (5239, '查询操作', '分页查询商品信息', '2019-08-06 08:26:48', 1);
INSERT INTO `t_log` VALUES (5240, '登录操作', '登录系统', '2019-08-06 15:36:27', 1);
INSERT INTO `t_log` VALUES (5241, '查询操作', '分页查询商品信息', '2019-08-06 15:36:39', 1);
INSERT INTO `t_log` VALUES (5242, '查询操作', '分页查询商品信息', '2019-08-06 15:36:39', 1);
INSERT INTO `t_log` VALUES (5243, '查询操作', '查询商品类别信息', '2019-08-06 15:36:45', 1);
INSERT INTO `t_log` VALUES (5244, '查询操作', '分页查询商品信息', '2019-08-06 15:36:53', 1);
INSERT INTO `t_log` VALUES (5245, '查询操作', '分页查询商品信息', '2019-08-06 15:38:47', 1);
INSERT INTO `t_log` VALUES (5246, '查询操作', '分页查询商品信息', '2019-08-06 15:38:47', 1);
INSERT INTO `t_log` VALUES (5247, '查询操作', '查询商品类别信息', '2019-08-06 15:38:48', 1);
INSERT INTO `t_log` VALUES (5248, '查询操作', '分页查询商品信息', '2019-08-06 15:38:51', 1);
INSERT INTO `t_log` VALUES (5249, '查询操作', '查询商品类别信息', '2019-08-06 15:39:03', 1);
INSERT INTO `t_log` VALUES (5250, '新增操作', '新增退货单：TH1565077126915', '2019-08-06 15:41:14', 1);
INSERT INTO `t_log` VALUES (5251, '查询操作', '分页查询商品信息', '2019-08-06 15:41:18', 1);
INSERT INTO `t_log` VALUES (5252, '查询操作', '分页查询商品信息', '2019-08-06 15:41:19', 1);
INSERT INTO `t_log` VALUES (5253, '查询操作', '进货单据查询', '2019-08-06 15:51:06', 1);
INSERT INTO `t_log` VALUES (5254, '查询操作', '进货单据查询', '2019-08-06 15:51:06', 1);
INSERT INTO `t_log` VALUES (5255, '登录操作', '登录系统', '2019-08-06 16:08:01', 1);
INSERT INTO `t_log` VALUES (5256, '查询操作', '进货单据查询', '2019-08-06 16:08:06', 1);
INSERT INTO `t_log` VALUES (5257, '查询操作', '进货单据查询', '2019-08-06 16:08:06', 1);
INSERT INTO `t_log` VALUES (5258, '查询操作', '进货单据查询', '2019-08-06 16:08:46', 1);
INSERT INTO `t_log` VALUES (5259, '查询操作', '进货单据查询', '2019-08-06 16:09:17', 1);
INSERT INTO `t_log` VALUES (5260, '查询操作', '进货单据查询', '2019-08-06 16:09:31', 1);
INSERT INTO `t_log` VALUES (5261, '查询操作', '进货单据查询', '2019-08-06 16:09:40', 1);
INSERT INTO `t_log` VALUES (5262, '登录操作', '登录系统', '2019-08-06 16:10:20', 1);
INSERT INTO `t_log` VALUES (5263, '查询操作', '进货单据查询', '2019-08-06 16:10:26', 1);
INSERT INTO `t_log` VALUES (5264, '查询操作', '进货单据查询', '2019-08-06 16:10:26', 1);
INSERT INTO `t_log` VALUES (5265, '查询操作', '进货单据查询', '2019-08-06 16:11:15', 1);
INSERT INTO `t_log` VALUES (5266, '查询操作', '进货单据查询', '2019-08-06 16:11:26', 1);
INSERT INTO `t_log` VALUES (5267, '查询操作', '进货单据查询', '2019-08-06 16:11:29', 1);
INSERT INTO `t_log` VALUES (5268, '查询操作', '进货单据查询', '2019-08-06 16:11:32', 1);
INSERT INTO `t_log` VALUES (5269, '查询操作', '进货单据查询', '2019-08-06 16:11:50', 1);
INSERT INTO `t_log` VALUES (5270, '查询操作', '进货单据查询', '2019-08-06 16:11:57', 1);
INSERT INTO `t_log` VALUES (5271, '查询操作', '进货单据查询', '2019-08-06 16:12:02', 1);
INSERT INTO `t_log` VALUES (5272, '查询操作', '进货单据查询', '2019-08-06 16:12:08', 1);
INSERT INTO `t_log` VALUES (5273, '查询操作', '进货单据查询', '2019-08-06 16:12:24', 1);
INSERT INTO `t_log` VALUES (5274, '查询操作', '进货单据查询', '2019-08-06 16:12:37', 1);
INSERT INTO `t_log` VALUES (5275, '查询操作', '进货单据查询', '2019-08-06 16:12:44', 1);
INSERT INTO `t_log` VALUES (5276, '查询操作', '进货单据查询', '2019-08-06 16:12:48', 1);
INSERT INTO `t_log` VALUES (5277, '查询操作', '进货单据查询', '2019-08-06 16:12:51', 1);
INSERT INTO `t_log` VALUES (5278, '查询操作', '进货单据查询', '2019-08-06 16:13:30', 1);
INSERT INTO `t_log` VALUES (5279, '查询操作', '进货单据查询', '2019-08-06 16:13:33', 1);
INSERT INTO `t_log` VALUES (5280, '查询操作', '进货单据查询', '2019-08-06 16:13:53', 1);
INSERT INTO `t_log` VALUES (5281, '查询操作', '进货单据查询', '2019-08-06 16:13:57', 1);
INSERT INTO `t_log` VALUES (5282, '查询操作', '进货单据查询', '2019-08-06 16:14:00', 1);
INSERT INTO `t_log` VALUES (5283, '查询操作', '进货单据查询', '2019-08-06 16:14:06', 1);
INSERT INTO `t_log` VALUES (5284, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:08', 1);
INSERT INTO `t_log` VALUES (5285, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:31', 1);
INSERT INTO `t_log` VALUES (5286, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:34', 1);
INSERT INTO `t_log` VALUES (5287, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:35', 1);
INSERT INTO `t_log` VALUES (5288, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:37', 1);
INSERT INTO `t_log` VALUES (5289, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:37', 1);
INSERT INTO `t_log` VALUES (5290, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:38', 1);
INSERT INTO `t_log` VALUES (5291, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:44', 1);
INSERT INTO `t_log` VALUES (5292, '查询操作', '进货单商品信息查询', '2019-08-06 16:14:44', 1);
INSERT INTO `t_log` VALUES (5293, '查询操作', '进货单商品信息查询', '2019-08-06 16:18:01', 1);
INSERT INTO `t_log` VALUES (5294, '查询操作', '进货单商品信息查询', '2019-08-06 16:18:01', 1);
INSERT INTO `t_log` VALUES (5295, '查询操作', '进货单商品信息查询', '2019-08-06 16:18:02', 1);
INSERT INTO `t_log` VALUES (5296, '查询操作', '进货单商品信息查询', '2019-08-06 16:18:03', 1);
INSERT INTO `t_log` VALUES (5297, '登录操作', '登录系统', '2019-08-06 16:22:51', 1);
INSERT INTO `t_log` VALUES (5298, '查询操作', '进货单据查询', '2019-08-06 16:23:34', 1);
INSERT INTO `t_log` VALUES (5299, '查询操作', '进货单据查询', '2019-08-06 16:23:34', 1);
INSERT INTO `t_log` VALUES (5300, '查询操作', '进货单据查询', '2019-08-06 16:24:04', 1);
INSERT INTO `t_log` VALUES (5301, '查询操作', '进货单据查询', '2019-08-06 16:24:08', 1);
INSERT INTO `t_log` VALUES (5302, '查询操作', '进货单商品信息查询', '2019-08-06 16:24:13', 1);
INSERT INTO `t_log` VALUES (5303, '查询操作', '进货单商品信息查询', '2019-08-06 16:24:20', 1);
INSERT INTO `t_log` VALUES (5304, '查询操作', '进货单商品信息查询', '2019-08-06 16:24:41', 1);
INSERT INTO `t_log` VALUES (5305, '查询操作', '进货单商品信息查询', '2019-08-06 16:25:09', 1);
INSERT INTO `t_log` VALUES (5306, '查询操作', '进货单据查询', '2019-08-06 16:26:21', 1);
INSERT INTO `t_log` VALUES (5307, '查询操作', '进货单据查询', '2019-08-06 16:26:21', 1);
INSERT INTO `t_log` VALUES (5308, '查询操作', '进货单商品信息查询', '2019-08-06 16:27:01', 1);
INSERT INTO `t_log` VALUES (5309, '查询操作', '进货单据查询', '2019-08-06 16:27:11', 1);
INSERT INTO `t_log` VALUES (5310, '查询操作', '进货单据查询', '2019-08-06 16:27:11', 1);
INSERT INTO `t_log` VALUES (5311, '查询操作', '进货单商品信息查询', '2019-08-06 16:27:15', 1);
INSERT INTO `t_log` VALUES (5312, '删除操作', '删除进货单：JH1564882251720', '2019-08-06 16:27:25', 1);
INSERT INTO `t_log` VALUES (5313, '登录操作', '登录系统', '2019-08-06 16:37:27', 1);
INSERT INTO `t_log` VALUES (5314, '查询操作', '进货单据查询', '2019-08-06 16:37:36', 1);
INSERT INTO `t_log` VALUES (5315, '查询操作', '进货单据查询', '2019-08-06 16:37:36', 1);
INSERT INTO `t_log` VALUES (5316, '查询操作', '进货单商品信息查询', '2019-08-06 16:37:41', 1);
INSERT INTO `t_log` VALUES (5317, '删除操作', '删除进货单：JH1564882251720', '2019-08-06 16:37:57', 1);
INSERT INTO `t_log` VALUES (5318, '查询操作', '进货单据查询', '2019-08-06 16:37:57', 1);
INSERT INTO `t_log` VALUES (5319, '查询操作', '进货单商品信息查询', '2019-08-06 16:37:57', 1);
INSERT INTO `t_log` VALUES (5320, '登录操作', '登录系统', '2019-08-07 08:24:52', 1);
INSERT INTO `t_log` VALUES (5321, '查询操作', '进货单据查询', '2019-08-07 08:25:02', 1);
INSERT INTO `t_log` VALUES (5322, '查询操作', '进货单据查询', '2019-08-07 08:25:02', 1);
INSERT INTO `t_log` VALUES (5323, '查询操作', '进货单商品信息查询', '2019-08-07 08:25:04', 1);
INSERT INTO `t_log` VALUES (5324, '查询操作', '退货单据查询', '2019-08-07 08:25:10', 1);
INSERT INTO `t_log` VALUES (5325, '查询操作', '退货单据查询', '2019-08-07 08:25:10', 1);
INSERT INTO `t_log` VALUES (5326, '登录操作', '登录系统', '2019-08-07 08:26:09', 1);
INSERT INTO `t_log` VALUES (5327, '查询操作', '退货单据查询', '2019-08-07 08:26:42', 1);
INSERT INTO `t_log` VALUES (5328, '查询操作', '退货单据查询', '2019-08-07 08:26:42', 1);
INSERT INTO `t_log` VALUES (5329, '查询操作', '退货单据查询', '2019-08-07 08:27:10', 1);
INSERT INTO `t_log` VALUES (5330, '查询操作', '退货单据查询', '2019-08-07 08:27:16', 1);
INSERT INTO `t_log` VALUES (5331, '查询操作', '退货单据查询', '2019-08-07 08:27:25', 1);
INSERT INTO `t_log` VALUES (5332, '查询操作', '退货单据查询', '2019-08-07 08:27:29', 1);
INSERT INTO `t_log` VALUES (5333, '查询操作', '退货单据查询', '2019-08-07 08:28:26', 1);
INSERT INTO `t_log` VALUES (5334, '查询操作', '退货单据查询', '2019-08-07 08:28:27', 1);
INSERT INTO `t_log` VALUES (5335, '查询操作', '退货单据查询', '2019-08-07 08:28:43', 1);
INSERT INTO `t_log` VALUES (5336, '查询操作', '退货单据查询', '2019-08-07 08:28:43', 1);
INSERT INTO `t_log` VALUES (5337, '查询操作', '退货单据查询', '2019-08-07 08:29:06', 1);
INSERT INTO `t_log` VALUES (5338, '查询操作', '退货单据查询', '2019-08-07 08:29:13', 1);
INSERT INTO `t_log` VALUES (5339, '查询操作', '退货单据查询', '2019-08-07 08:29:18', 1);
INSERT INTO `t_log` VALUES (5340, '查询操作', '退货单据查询', '2019-08-07 08:29:32', 1);
INSERT INTO `t_log` VALUES (5341, '登录操作', '登录系统', '2019-08-07 08:33:43', 1);
INSERT INTO `t_log` VALUES (5342, '查询操作', '退货单据查询', '2019-08-07 08:33:48', 1);
INSERT INTO `t_log` VALUES (5343, '查询操作', '退货单据查询', '2019-08-07 08:33:48', 1);
INSERT INTO `t_log` VALUES (5344, '查询操作', '退货单据查询', '2019-08-07 08:33:53', 1);
INSERT INTO `t_log` VALUES (5345, '查询操作', '退货单据查询', '2019-08-07 08:33:57', 1);
INSERT INTO `t_log` VALUES (5346, '查询操作', '退货单据查询', '2019-08-07 08:34:05', 1);
INSERT INTO `t_log` VALUES (5347, '查询操作', '退货单据查询', '2019-08-07 08:34:10', 1);
INSERT INTO `t_log` VALUES (5348, '查询操作', '退货单据查询', '2019-08-07 08:34:13', 1);
INSERT INTO `t_log` VALUES (5349, '查询操作', '退货单据查询', '2019-08-07 08:34:18', 1);
INSERT INTO `t_log` VALUES (5350, '查询操作', '退货单据查询', '2019-08-07 08:34:21', 1);
INSERT INTO `t_log` VALUES (5351, '查询操作', '退货单据查询', '2019-08-07 08:34:23', 1);
INSERT INTO `t_log` VALUES (5352, '查询操作', '退货单据查询', '2019-08-07 08:34:38', 1);
INSERT INTO `t_log` VALUES (5353, '查询操作', '退货单据查询', '2019-08-07 08:34:49', 1);
INSERT INTO `t_log` VALUES (5354, '查询操作', '退货单据查询', '2019-08-07 08:34:57', 1);
INSERT INTO `t_log` VALUES (5355, '查询操作', '退货单据查询', '2019-08-07 08:35:07', 1);
INSERT INTO `t_log` VALUES (5356, '查询操作', '退货单商品信息查询', '2019-08-07 08:35:12', 1);
INSERT INTO `t_log` VALUES (5357, '查询操作', '退货单商品信息查询', '2019-08-07 08:35:24', 1);
INSERT INTO `t_log` VALUES (5358, '查询操作', '退货单商品信息查询', '2019-08-07 08:35:24', 1);
INSERT INTO `t_log` VALUES (5359, '查询操作', '退货单商品信息查询', '2019-08-07 08:35:50', 1);
INSERT INTO `t_log` VALUES (5360, '查询操作', '退货单据查询', '2019-08-07 08:36:28', 1);
INSERT INTO `t_log` VALUES (5361, '查询操作', '退货单据查询', '2019-08-07 08:39:08', 1);
INSERT INTO `t_log` VALUES (5362, '查询操作', '退货单据查询', '2019-08-07 08:39:12', 1);
INSERT INTO `t_log` VALUES (5363, '查询操作', '退货单据查询', '2019-08-07 08:39:15', 1);
INSERT INTO `t_log` VALUES (5364, '查询操作', '退货单商品信息查询', '2019-08-07 08:39:17', 1);
INSERT INTO `t_log` VALUES (5365, '查询操作', '退货单据查询', '2019-08-07 08:39:28', 1);
INSERT INTO `t_log` VALUES (5366, '查询操作', '退货单据查询', '2019-08-07 08:39:28', 1);
INSERT INTO `t_log` VALUES (5367, '查询操作', '退货单据查询', '2019-08-07 08:39:33', 1);
INSERT INTO `t_log` VALUES (5368, '查询操作', '退货单商品信息查询', '2019-08-07 08:39:41', 1);
INSERT INTO `t_log` VALUES (5369, '删除操作', '删除退货单：TH1565077126915', '2019-08-07 08:39:47', 1);
INSERT INTO `t_log` VALUES (5370, '查询操作', '退货单据查询', '2019-08-07 08:39:47', 1);
INSERT INTO `t_log` VALUES (5371, '查询操作', '退货单商品信息查询', '2019-08-07 08:39:47', 1);
INSERT INTO `t_log` VALUES (5372, '查询操作', '查询商品类别信息', '2019-08-07 08:43:31', 1);
INSERT INTO `t_log` VALUES (5373, '登录操作', '登录系统', '2019-08-07 10:16:59', 1);
INSERT INTO `t_log` VALUES (5374, '登录操作', '登录系统', '2019-08-07 10:20:15', 1);
INSERT INTO `t_log` VALUES (5375, '查询操作', '分页查询商品库存信息', '2019-08-07 10:20:16', 1);
INSERT INTO `t_log` VALUES (5376, '查询操作', '分页查询商品库存信息', '2019-08-07 10:20:26', 1);
INSERT INTO `t_log` VALUES (5377, '查询操作', '分页查询商品库存信息', '2019-08-07 10:24:18', 1);
INSERT INTO `t_log` VALUES (5378, '登录操作', '登录系统', '2019-08-07 10:24:45', 1);
INSERT INTO `t_log` VALUES (5379, '查询操作', '分页查询商品库存信息', '2019-08-07 10:24:47', 1);
INSERT INTO `t_log` VALUES (5380, '查询操作', '分页查询商品库存信息', '2019-08-07 10:25:27', 1);
INSERT INTO `t_log` VALUES (5381, '查询操作', '分页查询商品库存信息', '2019-08-07 10:26:02', 1);
INSERT INTO `t_log` VALUES (5382, '查询操作', '查询商品类别信息', '2019-08-07 10:26:08', 1);
INSERT INTO `t_log` VALUES (5383, '查询操作', '查询商品类别信息', '2019-08-07 10:26:15', 1);
INSERT INTO `t_log` VALUES (5384, '查询操作', '分页查询商品库存信息', '2019-08-07 10:26:23', 1);
INSERT INTO `t_log` VALUES (5385, '查询操作', '查询商品类别信息', '2019-08-07 10:26:43', 1);
INSERT INTO `t_log` VALUES (5386, '查询操作', '分页查询商品库存信息', '2019-08-07 10:26:46', 1);
INSERT INTO `t_log` VALUES (5387, '查询操作', '查询商品类别信息', '2019-08-07 10:26:51', 1);
INSERT INTO `t_log` VALUES (5388, '查询操作', '分页查询商品库存信息', '2019-08-07 10:26:54', 1);
INSERT INTO `t_log` VALUES (5389, '查询操作', '查询商品类别信息', '2019-08-07 10:26:58', 1);
INSERT INTO `t_log` VALUES (5390, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:00', 1);
INSERT INTO `t_log` VALUES (5391, '查询操作', '查询商品类别信息', '2019-08-07 10:27:05', 1);
INSERT INTO `t_log` VALUES (5392, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:09', 1);
INSERT INTO `t_log` VALUES (5393, '查询操作', '查询商品类别信息', '2019-08-07 10:27:10', 1);
INSERT INTO `t_log` VALUES (5394, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:13', 1);
INSERT INTO `t_log` VALUES (5395, '查询操作', '查询商品类别信息', '2019-08-07 10:27:14', 1);
INSERT INTO `t_log` VALUES (5396, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:16', 1);
INSERT INTO `t_log` VALUES (5397, '查询操作', '查询商品类别信息', '2019-08-07 10:27:20', 1);
INSERT INTO `t_log` VALUES (5398, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:22', 1);
INSERT INTO `t_log` VALUES (5399, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:30', 1);
INSERT INTO `t_log` VALUES (5400, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:32', 1);
INSERT INTO `t_log` VALUES (5401, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:39', 1);
INSERT INTO `t_log` VALUES (5402, '查询操作', '查询商品类别信息', '2019-08-07 10:27:42', 1);
INSERT INTO `t_log` VALUES (5403, '查询操作', '分页查询商品库存信息', '2019-08-07 10:27:43', 1);
INSERT INTO `t_log` VALUES (5404, '查询操作', '分页查询商品库存信息', '2019-08-07 10:28:00', 1);
INSERT INTO `t_log` VALUES (5405, '查询操作', '查询商品类别信息', '2019-08-07 10:28:03', 1);
INSERT INTO `t_log` VALUES (5406, '查询操作', '分页查询商品库存信息', '2019-08-07 10:28:05', 1);
INSERT INTO `t_log` VALUES (5407, '查询操作', '分页查询商品库存信息', '2019-08-07 10:28:09', 1);
INSERT INTO `t_log` VALUES (5408, '查询操作', '分页查询商品库存信息', '2019-08-07 10:28:16', 1);
INSERT INTO `t_log` VALUES (5409, '查询操作', '查询商品类别信息', '2019-08-07 10:28:18', 1);
INSERT INTO `t_log` VALUES (5410, '查询操作', '分页查询商品库存信息', '2019-08-07 10:28:19', 1);
INSERT INTO `t_log` VALUES (5411, '查询操作', '分页查询商品库存信息', '2019-08-07 10:29:03', 1);
INSERT INTO `t_log` VALUES (5412, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:25', 1);
INSERT INTO `t_log` VALUES (5413, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:36', 1);
INSERT INTO `t_log` VALUES (5414, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:46', 1);
INSERT INTO `t_log` VALUES (5415, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:50', 1);
INSERT INTO `t_log` VALUES (5416, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:55', 1);
INSERT INTO `t_log` VALUES (5417, '查询操作', '分页查询商品库存信息', '2019-08-07 10:31:56', 1);
INSERT INTO `t_log` VALUES (5418, '查询操作', '分页查询商品库存信息', '2019-08-07 10:35:03', 1);
INSERT INTO `t_log` VALUES (5419, '查询操作', '分页查询商品信息', '2019-08-07 10:48:30', 1);
INSERT INTO `t_log` VALUES (5420, '查询操作', '分页查询商品信息', '2019-08-07 10:48:30', 1);
INSERT INTO `t_log` VALUES (5421, '查询操作', '分页查询商品信息', '2019-08-07 10:48:45', 1);
INSERT INTO `t_log` VALUES (5422, '查询操作', '分页查询商品信息', '2019-08-07 10:48:45', 1);
INSERT INTO `t_log` VALUES (5423, '查询操作', '分页查询商品库存信息', '2019-08-07 10:49:12', 1);
INSERT INTO `t_log` VALUES (5424, '查询操作', '分页查询商品信息', '2019-08-07 10:49:33', 1);
INSERT INTO `t_log` VALUES (5425, '查询操作', '分页查询商品信息', '2019-08-07 10:49:34', 1);
INSERT INTO `t_log` VALUES (5426, '登录操作', '登录系统', '2019-08-07 15:25:59', 1);
INSERT INTO `t_log` VALUES (5427, '查询操作', '分页查询商品库存信息', '2019-08-07 15:26:01', 1);
INSERT INTO `t_log` VALUES (5428, '查询操作', '分页查询商品信息', '2019-08-07 15:26:08', 1);
INSERT INTO `t_log` VALUES (5429, '查询操作', '分页查询商品信息', '2019-08-07 15:26:09', 1);
INSERT INTO `t_log` VALUES (5430, '查询操作', '查询商品类别信息', '2019-08-07 15:35:50', 1);
INSERT INTO `t_log` VALUES (5431, '查询操作', '退货单据查询', '2019-08-07 15:39:30', 1);
INSERT INTO `t_log` VALUES (5432, '查询操作', '退货单据查询', '2019-08-07 15:39:30', 1);
INSERT INTO `t_log` VALUES (5433, '查询操作', '退货单据查询', '2019-08-07 15:39:42', 1);
INSERT INTO `t_log` VALUES (5434, '查询操作', '退货单据查询', '2019-08-07 15:40:21', 1);
INSERT INTO `t_log` VALUES (5435, '登录操作', '登录系统', '2019-08-07 17:08:07', 1);
INSERT INTO `t_log` VALUES (5436, '查询操作', '分页查询商品库存信息', '2019-08-07 17:08:09', 1);
INSERT INTO `t_log` VALUES (5437, '登录操作', '登录系统', '2019-08-09 16:12:43', 1);
INSERT INTO `t_log` VALUES (5438, '查询操作', '分页查询商品库存信息', '2019-08-09 16:12:46', 1);
INSERT INTO `t_log` VALUES (5439, '查询操作', '分页查询商品库存信息', '2019-08-09 16:12:50', 1);
INSERT INTO `t_log` VALUES (5440, '查询操作', '退货单据查询', '2019-08-09 16:12:53', 1);
INSERT INTO `t_log` VALUES (5441, '查询操作', '退货单据查询', '2019-08-09 16:12:54', 1);
INSERT INTO `t_log` VALUES (5442, '查询操作', '退货单据查询', '2019-08-09 16:12:56', 1);
INSERT INTO `t_log` VALUES (5443, '查询操作', '退货单据查询', '2019-08-09 16:12:59', 1);
INSERT INTO `t_log` VALUES (5444, '查询操作', '分页查询商品信息', '2019-08-09 16:13:08', 1);
INSERT INTO `t_log` VALUES (5445, '查询操作', '分页查询商品信息', '2019-08-09 16:13:08', 1);
INSERT INTO `t_log` VALUES (5446, '查询操作', '查询商品类别信息', '2019-08-09 16:14:08', 1);
INSERT INTO `t_log` VALUES (5447, '查询操作', '分页查询商品信息', '2019-08-09 16:15:05', 1);
INSERT INTO `t_log` VALUES (5448, '查询操作', '分页查询商品信息', '2019-08-09 16:15:07', 1);
INSERT INTO `t_log` VALUES (5449, '查询操作', '分页查询商品信息', '2019-08-09 16:15:28', 1);
INSERT INTO `t_log` VALUES (5450, '查询操作', '分页查询商品信息', '2019-08-09 16:15:31', 1);
INSERT INTO `t_log` VALUES (5451, '查询操作', '分页查询商品信息', '2019-08-09 16:15:33', 1);
INSERT INTO `t_log` VALUES (5452, '查询操作', '分页查询商品信息', '2019-08-09 16:15:34', 1);
INSERT INTO `t_log` VALUES (5453, '查询操作', '分页查询商品信息', '2019-08-09 16:15:35', 1);
INSERT INTO `t_log` VALUES (5454, '查询操作', '分页查询商品信息', '2019-08-09 16:15:36', 1);
INSERT INTO `t_log` VALUES (5455, '查询操作', '分页查询商品信息', '2019-08-09 16:15:37', 1);
INSERT INTO `t_log` VALUES (5456, '查询操作', '分页查询商品信息', '2019-08-09 16:16:02', 1);
INSERT INTO `t_log` VALUES (5457, '查询操作', '分页查询商品信息', '2019-08-09 16:16:32', 1);
INSERT INTO `t_log` VALUES (5458, '查询操作', '分页查询商品信息', '2019-08-09 16:16:32', 1);
INSERT INTO `t_log` VALUES (5459, '查询操作', '分页查询商品信息', '2019-08-09 16:16:41', 1);
INSERT INTO `t_log` VALUES (5460, '查询操作', '分页查询商品信息', '2019-08-09 16:16:42', 1);
INSERT INTO `t_log` VALUES (5461, '查询操作', '查询商品类别信息', '2019-08-09 16:17:04', 1);
INSERT INTO `t_log` VALUES (5462, '查询操作', '分页查询商品信息', '2019-08-09 16:17:24', 1);
INSERT INTO `t_log` VALUES (5463, '新增操作', '新增商品类别:啊啊啊', '2019-08-09 16:17:30', 1);
INSERT INTO `t_log` VALUES (5464, '查询操作', '查询商品类别信息', '2019-08-09 16:17:30', 1);
INSERT INTO `t_log` VALUES (5465, '查询操作', '分页查询商品信息', '2019-08-09 16:17:32', 1);
INSERT INTO `t_log` VALUES (5466, '新增操作', '新增商品类别:啊啊', '2019-08-09 16:17:39', 1);
INSERT INTO `t_log` VALUES (5467, '查询操作', '查询商品类别信息', '2019-08-09 16:17:39', 1);
INSERT INTO `t_log` VALUES (5468, '查询操作', '分页查询商品信息', '2019-08-09 16:17:41', 1);
INSERT INTO `t_log` VALUES (5469, '删除操作', '删除商品类别：啊啊', '2019-08-09 16:17:45', 1);
INSERT INTO `t_log` VALUES (5470, '查询操作', '查询商品类别信息', '2019-08-09 16:17:45', 1);
INSERT INTO `t_log` VALUES (5471, '查询操作', '分页查询商品信息', '2019-08-09 16:17:52', 1);
INSERT INTO `t_log` VALUES (5472, '删除操作', '删除商品类别：啊啊啊', '2019-08-09 16:17:56', 1);
INSERT INTO `t_log` VALUES (5473, '查询操作', '查询商品类别信息', '2019-08-09 16:17:56', 1);
INSERT INTO `t_log` VALUES (5474, '查询操作', '分页查询商品信息', '2019-08-09 16:18:07', 1);
INSERT INTO `t_log` VALUES (5475, '查询操作', '分页查询商品信息', '2019-08-09 16:18:07', 1);
INSERT INTO `t_log` VALUES (5476, '查询操作', '查询商品类别信息', '2019-08-09 16:18:15', 1);
INSERT INTO `t_log` VALUES (5477, '查询操作', '查询商品类别信息', '2019-08-09 16:18:48', 1);
INSERT INTO `t_log` VALUES (5478, '查询操作', '分页查询商品信息', '2019-08-09 16:18:52', 1);
INSERT INTO `t_log` VALUES (5479, '查询操作', '查询商品类别信息', '2019-08-09 16:19:56', 1);
INSERT INTO `t_log` VALUES (5480, '查询操作', '查询商品类别信息', '2019-08-09 16:20:30', 1);
INSERT INTO `t_log` VALUES (5481, '查询操作', '查询商品类别信息', '2019-08-09 16:20:51', 1);
INSERT INTO `t_log` VALUES (5482, '查询操作', '查询商品类别信息', '2019-08-09 16:21:02', 1);
INSERT INTO `t_log` VALUES (5483, '登录操作', '登录系统', '2019-08-09 16:23:43', 1);
INSERT INTO `t_log` VALUES (5484, '查询操作', '分页查询商品库存信息', '2019-08-09 16:23:45', 1);
INSERT INTO `t_log` VALUES (5485, '查询操作', '分页查询商品信息', '2019-08-09 16:23:50', 1);
INSERT INTO `t_log` VALUES (5486, '查询操作', '分页查询商品信息', '2019-08-09 16:23:50', 1);
INSERT INTO `t_log` VALUES (5487, '查询操作', '查询商品类别信息', '2019-08-09 16:23:53', 1);
INSERT INTO `t_log` VALUES (5488, '查询操作', '分页查询商品信息', '2019-08-09 16:23:58', 1);
INSERT INTO `t_log` VALUES (5489, '查询操作', '查询商品类别信息', '2019-08-09 16:25:39', 1);
INSERT INTO `t_log` VALUES (5490, '查询操作', '查询商品类别信息', '2019-08-09 16:26:04', 1);
INSERT INTO `t_log` VALUES (5491, '登录操作', '登录系统', '2019-08-09 16:31:20', 1);
INSERT INTO `t_log` VALUES (5492, '查询操作', '分页查询商品库存信息', '2019-08-09 16:31:22', 1);
INSERT INTO `t_log` VALUES (5493, '查询操作', '分页查询商品信息', '2019-08-09 16:31:25', 1);
INSERT INTO `t_log` VALUES (5494, '查询操作', '分页查询商品信息', '2019-08-09 16:31:25', 1);
INSERT INTO `t_log` VALUES (5495, '查询操作', '查询商品类别信息', '2019-08-09 16:31:27', 1);
INSERT INTO `t_log` VALUES (5496, '查询操作', '分页查询商品信息', '2019-08-09 16:31:29', 1);
INSERT INTO `t_log` VALUES (5497, '新增操作', '新增销售单：XS1565339485220', '2019-08-09 16:32:10', 1);
INSERT INTO `t_log` VALUES (5498, '查询操作', '分页查询商品信息', '2019-08-09 16:32:13', 1);
INSERT INTO `t_log` VALUES (5499, '查询操作', '分页查询商品信息', '2019-08-09 16:32:14', 1);
INSERT INTO `t_log` VALUES (5500, '查询操作', '分页查询商品信息', '2019-08-09 16:34:34', 1);
INSERT INTO `t_log` VALUES (5501, '查询操作', '分页查询商品信息', '2019-08-09 16:34:35', 1);
INSERT INTO `t_log` VALUES (5502, '登录操作', '登录系统', '2019-08-10 07:42:39', 1);
INSERT INTO `t_log` VALUES (5503, '查询操作', '分页查询商品库存信息', '2019-08-10 07:42:42', 1);
INSERT INTO `t_log` VALUES (5504, '查询操作', '分页查询商品信息', '2019-08-10 07:42:52', 1);
INSERT INTO `t_log` VALUES (5505, '查询操作', '分页查询商品信息', '2019-08-10 07:42:52', 1);
INSERT INTO `t_log` VALUES (5506, '查询操作', '分页查询商品信息', '2019-08-10 07:43:05', 1);
INSERT INTO `t_log` VALUES (5507, '查询操作', '分页查询商品信息', '2019-08-10 07:43:06', 1);
INSERT INTO `t_log` VALUES (5508, '查询操作', '查询商品类别信息', '2019-08-10 07:43:56', 1);
INSERT INTO `t_log` VALUES (5509, '查询操作', '分页查询商品信息', '2019-08-10 07:44:03', 1);
INSERT INTO `t_log` VALUES (5510, '查询操作', '分页查询商品信息', '2019-08-10 07:44:15', 1);
INSERT INTO `t_log` VALUES (5511, '查询操作', '分页查询商品信息', '2019-08-10 07:44:17', 1);
INSERT INTO `t_log` VALUES (5512, '查询操作', '分页查询商品信息', '2019-08-10 07:44:19', 1);
INSERT INTO `t_log` VALUES (5513, '查询操作', '分页查询商品信息', '2019-08-10 07:44:20', 1);
INSERT INTO `t_log` VALUES (5514, '查询操作', '分页查询商品信息', '2019-08-10 07:44:21', 1);
INSERT INTO `t_log` VALUES (5515, '查询操作', '分页查询商品信息', '2019-08-10 07:44:29', 1);
INSERT INTO `t_log` VALUES (5516, '查询操作', '分页查询商品信息', '2019-08-10 07:44:31', 1);
INSERT INTO `t_log` VALUES (5517, '查询操作', '分页查询商品信息', '2019-08-10 07:44:32', 1);
INSERT INTO `t_log` VALUES (5518, '查询操作', '分页查询商品信息', '2019-08-10 07:44:33', 1);
INSERT INTO `t_log` VALUES (5519, '查询操作', '分页查询商品信息', '2019-08-10 07:44:38', 1);
INSERT INTO `t_log` VALUES (5520, '查询操作', '分页查询商品信息', '2019-08-10 07:44:54', 1);
INSERT INTO `t_log` VALUES (5521, '查询操作', '查询商品类别信息', '2019-08-10 07:45:29', 1);
INSERT INTO `t_log` VALUES (5522, '查询操作', '查询商品类别信息', '2019-08-10 07:45:50', 1);
INSERT INTO `t_log` VALUES (5523, '查询操作', '查询商品类别信息', '2019-08-10 07:46:20', 1);
INSERT INTO `t_log` VALUES (5524, '新增操作', '新增客户退货单：null', '2019-08-10 07:47:13', 1);
INSERT INTO `t_log` VALUES (5525, '查询操作', '分页查询商品信息', '2019-08-10 07:47:15', 1);
INSERT INTO `t_log` VALUES (5526, '查询操作', '分页查询商品信息', '2019-08-10 07:47:15', 1);
INSERT INTO `t_log` VALUES (5527, '登录操作', '登录系统', '2019-08-10 07:51:10', 1);
INSERT INTO `t_log` VALUES (5528, '查询操作', '分页查询商品库存信息', '2019-08-10 07:51:12', 1);
INSERT INTO `t_log` VALUES (5529, '查询操作', '分页查询商品信息', '2019-08-10 07:51:16', 1);
INSERT INTO `t_log` VALUES (5530, '查询操作', '分页查询商品信息', '2019-08-10 07:51:17', 1);
INSERT INTO `t_log` VALUES (5531, '查询操作', '查询商品类别信息', '2019-08-10 07:51:18', 1);
INSERT INTO `t_log` VALUES (5532, '查询操作', '分页查询商品信息', '2019-08-10 07:51:21', 1);
INSERT INTO `t_log` VALUES (5533, '新增操作', '新增客户退货单：XT1565394676222', '2019-08-10 07:51:42', 1);
INSERT INTO `t_log` VALUES (5534, '查询操作', '分页查询商品信息', '2019-08-10 07:51:44', 1);
INSERT INTO `t_log` VALUES (5535, '查询操作', '分页查询商品信息', '2019-08-10 07:51:44', 1);
INSERT INTO `t_log` VALUES (5536, '登录操作', '登录系统', '2019-08-10 15:09:39', 1);
INSERT INTO `t_log` VALUES (5537, '查询操作', '分页查询商品库存信息', '2019-08-10 15:09:41', 1);
INSERT INTO `t_log` VALUES (5538, '查询操作', '销售单据查询', '2019-08-10 15:09:51', 1);
INSERT INTO `t_log` VALUES (5539, '查询操作', '销售单据查询', '2019-08-10 15:09:51', 1);
INSERT INTO `t_log` VALUES (5540, '查询操作', '销售单据查询', '2019-08-10 15:10:22', 1);
INSERT INTO `t_log` VALUES (5541, '查询操作', '销售单据查询', '2019-08-10 15:10:33', 1);
INSERT INTO `t_log` VALUES (5542, '查询操作', '销售单据查询', '2019-08-10 15:10:47', 1);
INSERT INTO `t_log` VALUES (5543, '查询操作', '销售单据查询', '2019-08-10 15:10:57', 1);
INSERT INTO `t_log` VALUES (5544, '查询操作', '销售单据查询', '2019-08-10 15:11:02', 1);
INSERT INTO `t_log` VALUES (5545, '查询操作', '销售单据查询', '2019-08-10 15:11:15', 1);
INSERT INTO `t_log` VALUES (5546, '查询操作', '销售单据查询', '2019-08-10 15:11:18', 1);
INSERT INTO `t_log` VALUES (5547, '查询操作', '销售单据查询', '2019-08-10 15:11:49', 1);
INSERT INTO `t_log` VALUES (5548, '查询操作', '销售单据查询', '2019-08-10 15:12:11', 1);
INSERT INTO `t_log` VALUES (5549, '查询操作', '销售单据查询', '2019-08-10 15:12:14', 1);
INSERT INTO `t_log` VALUES (5550, '查询操作', '销售单据查询', '2019-08-10 15:12:20', 1);
INSERT INTO `t_log` VALUES (5551, '查询操作', '销售单据查询', '2019-08-10 15:12:31', 1);
INSERT INTO `t_log` VALUES (5552, '查询操作', '销售单据查询', '2019-08-10 15:12:34', 1);
INSERT INTO `t_log` VALUES (5553, '查询操作', '销售单商品信息查询', '2019-08-10 15:12:39', 1);
INSERT INTO `t_log` VALUES (5554, '查询操作', '销售单据查询', '2019-08-10 15:12:48', 1);
INSERT INTO `t_log` VALUES (5555, '查询操作', '销售单商品信息查询', '2019-08-10 15:12:50', 1);
INSERT INTO `t_log` VALUES (5556, '查询操作', '销售单商品信息查询', '2019-08-10 15:12:52', 1);
INSERT INTO `t_log` VALUES (5557, '查询操作', '销售单商品信息查询', '2019-08-10 15:12:53', 1);
INSERT INTO `t_log` VALUES (5558, '查询操作', '销售单商品信息查询', '2019-08-10 15:12:55', 1);
INSERT INTO `t_log` VALUES (5559, '查询操作', '销售单商品信息查询', '2019-08-10 15:14:03', 1);
INSERT INTO `t_log` VALUES (5560, '查询操作', '销售单商品信息查询', '2019-08-10 15:14:04', 1);
INSERT INTO `t_log` VALUES (5561, '删除操作', '删除销售单：XS1565339485220', '2019-08-10 15:14:13', 1);
INSERT INTO `t_log` VALUES (5562, '登录操作', '登录系统', '2019-08-10 15:16:40', 1);
INSERT INTO `t_log` VALUES (5563, '查询操作', '分页查询商品库存信息', '2019-08-10 15:16:42', 1);
INSERT INTO `t_log` VALUES (5564, '查询操作', '分页查询商品库存信息', '2019-08-10 15:16:50', 1);
INSERT INTO `t_log` VALUES (5565, '查询操作', '销售单据查询', '2019-08-10 15:16:59', 1);
INSERT INTO `t_log` VALUES (5566, '查询操作', '销售单据查询', '2019-08-10 15:16:59', 1);
INSERT INTO `t_log` VALUES (5567, '查询操作', '销售单据查询', '2019-08-10 15:17:07', 1);
INSERT INTO `t_log` VALUES (5568, '查询操作', '销售单商品信息查询', '2019-08-10 15:17:09', 1);
INSERT INTO `t_log` VALUES (5569, '删除操作', '删除销售单：XS1565339485220', '2019-08-10 15:17:31', 1);
INSERT INTO `t_log` VALUES (5570, '查询操作', '销售单据查询', '2019-08-10 15:17:31', 1);
INSERT INTO `t_log` VALUES (5571, '查询操作', '销售单商品信息查询', '2019-08-10 15:17:31', 1);
INSERT INTO `t_log` VALUES (5572, '查询操作', '客户退货单据查询', '2019-08-10 15:17:47', 1);
INSERT INTO `t_log` VALUES (5573, '查询操作', '客户退货单据查询', '2019-08-10 15:17:47', 1);
INSERT INTO `t_log` VALUES (5574, '查询操作', '客户退货单据查询', '2019-08-10 15:18:00', 1);
INSERT INTO `t_log` VALUES (5575, '查询操作', '客户退货单据查询', '2019-08-10 15:18:00', 1);
INSERT INTO `t_log` VALUES (5576, '查询操作', '销售单据查询', '2019-08-10 15:18:57', 1);
INSERT INTO `t_log` VALUES (5577, '查询操作', '销售单据查询', '2019-08-10 15:18:57', 1);
INSERT INTO `t_log` VALUES (5578, '登录操作', '登录系统', '2019-08-10 15:28:52', 1);
INSERT INTO `t_log` VALUES (5579, '查询操作', '分页查询商品库存信息', '2019-08-10 15:28:54', 1);
INSERT INTO `t_log` VALUES (5580, '查询操作', '客户退货单据查询', '2019-08-10 15:29:01', 1);
INSERT INTO `t_log` VALUES (5581, '查询操作', '客户退货单据查询', '2019-08-10 15:29:01', 1);
INSERT INTO `t_log` VALUES (5582, '查询操作', '客户退货单据查询', '2019-08-10 15:29:56', 1);
INSERT INTO `t_log` VALUES (5583, '查询操作', '客户退货单据查询', '2019-08-10 15:30:04', 1);
INSERT INTO `t_log` VALUES (5584, '查询操作', '客户退货单据查询', '2019-08-10 15:30:07', 1);
INSERT INTO `t_log` VALUES (5585, '查询操作', '客户退货单据查询', '2019-08-10 15:30:10', 1);
INSERT INTO `t_log` VALUES (5586, '查询操作', '客户退货单据查询', '2019-08-10 15:30:19', 1);
INSERT INTO `t_log` VALUES (5587, '查询操作', '客户退货单据查询', '2019-08-10 15:30:21', 1);
INSERT INTO `t_log` VALUES (5588, '查询操作', '客户退货单据查询', '2019-08-10 15:30:31', 1);
INSERT INTO `t_log` VALUES (5589, '查询操作', '客户退货单据查询', '2019-08-10 15:30:33', 1);
INSERT INTO `t_log` VALUES (5590, '查询操作', '客户退货单据查询', '2019-08-10 15:30:38', 1);
INSERT INTO `t_log` VALUES (5591, '查询操作', '客户退货单据查询', '2019-08-10 15:30:41', 1);
INSERT INTO `t_log` VALUES (5592, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:30:48', 1);
INSERT INTO `t_log` VALUES (5593, '查询操作', '客户退货单据查询', '2019-08-10 15:30:59', 1);
INSERT INTO `t_log` VALUES (5594, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:31:00', 1);
INSERT INTO `t_log` VALUES (5595, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:31:04', 1);
INSERT INTO `t_log` VALUES (5596, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:31:12', 1);
INSERT INTO `t_log` VALUES (5597, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:31:18', 1);
INSERT INTO `t_log` VALUES (5598, '删除操作', '删除客户退货单：XT1565394676222', '2019-08-10 15:31:45', 1);
INSERT INTO `t_log` VALUES (5599, '查询操作', '客户退货单据查询', '2019-08-10 15:31:45', 1);
INSERT INTO `t_log` VALUES (5600, '查询操作', '客户退货单商品信息查询', '2019-08-10 15:31:45', 1);
INSERT INTO `t_log` VALUES (5601, '查询操作', '分页查询商品库存信息', '2019-08-10 15:31:56', 1);
INSERT INTO `t_log` VALUES (5602, '登录操作', '登录系统', '2019-08-10 15:48:18', 1);
INSERT INTO `t_log` VALUES (5603, '查询操作', '分页查询商品库存信息', '2019-08-10 15:48:19', 1);
INSERT INTO `t_log` VALUES (5604, '查询操作', '分页查询商品库存信息', '2019-08-10 15:53:54', 1);
INSERT INTO `t_log` VALUES (5605, '查询操作', '分页查询商品信息', '2019-08-10 15:53:56', 1);
INSERT INTO `t_log` VALUES (5606, '查询操作', '分页查询商品信息', '2019-08-10 15:53:56', 1);
INSERT INTO `t_log` VALUES (5607, '查询操作', '查询商品类别信息', '2019-08-10 15:54:06', 1);
INSERT INTO `t_log` VALUES (5608, '查询操作', '分页查询商品信息', '2019-08-10 15:54:18', 1);
INSERT INTO `t_log` VALUES (5609, '查询操作', '分页查询商品信息', '2019-08-10 15:54:18', 1);
INSERT INTO `t_log` VALUES (5610, '查询操作', '分页查询商品信息', '2019-08-10 15:55:29', 1);
INSERT INTO `t_log` VALUES (5611, '查询操作', '分页查询商品信息', '2019-08-10 15:55:29', 1);
INSERT INTO `t_log` VALUES (5612, '查询操作', '查询商品类别信息', '2019-08-10 16:01:38', 1);
INSERT INTO `t_log` VALUES (5613, '登录操作', '登录系统', '2019-08-11 09:42:50', 1);
INSERT INTO `t_log` VALUES (5614, '查询操作', '分页查询商品库存信息', '2019-08-11 09:42:54', 1);
INSERT INTO `t_log` VALUES (5615, '查询操作', '分页查询商品库存信息', '2019-08-11 09:43:02', 1);
INSERT INTO `t_log` VALUES (5616, '查询操作', '客户退货单据查询', '2019-08-11 09:43:04', 1);
INSERT INTO `t_log` VALUES (5617, '查询操作', '客户退货单据查询', '2019-08-11 09:43:05', 1);
INSERT INTO `t_log` VALUES (5618, '查询操作', '分页查询商品信息', '2019-08-11 09:43:14', 1);
INSERT INTO `t_log` VALUES (5619, '查询操作', '分页查询商品信息', '2019-08-11 09:43:15', 1);
INSERT INTO `t_log` VALUES (5620, '查询操作', '分页查询商品信息', '2019-08-11 09:43:31', 1);
INSERT INTO `t_log` VALUES (5621, '查询操作', '分页查询商品信息', '2019-08-11 09:43:31', 1);
INSERT INTO `t_log` VALUES (5622, '查询操作', '查询商品类别信息', '2019-08-11 09:44:19', 1);
INSERT INTO `t_log` VALUES (5623, '登录操作', '登录系统', '2019-08-11 10:03:24', 1);
INSERT INTO `t_log` VALUES (5624, '查询操作', '分页查询商品库存信息', '2019-08-11 10:03:27', 1);
INSERT INTO `t_log` VALUES (5625, '查询操作', '分页查询商品信息', '2019-08-11 10:03:31', 1);
INSERT INTO `t_log` VALUES (5626, '查询操作', '分页查询商品信息', '2019-08-11 10:03:31', 1);
INSERT INTO `t_log` VALUES (5627, '查询操作', '查询商品类别信息', '2019-08-11 10:04:19', 1);
INSERT INTO `t_log` VALUES (5628, '查询操作', '分页查询商品信息', '2019-08-11 10:04:25', 1);
INSERT INTO `t_log` VALUES (5629, '查询操作', '分页查询商品信息', '2019-08-11 10:04:31', 1);
INSERT INTO `t_log` VALUES (5630, '查询操作', '分页查询商品信息', '2019-08-11 10:04:32', 1);
INSERT INTO `t_log` VALUES (5631, '查询操作', '分页查询商品信息', '2019-08-11 10:04:33', 1);
INSERT INTO `t_log` VALUES (5632, '查询操作', '分页查询商品信息', '2019-08-11 10:04:35', 1);
INSERT INTO `t_log` VALUES (5633, '查询操作', '分页查询商品信息', '2019-08-11 10:04:36', 1);
INSERT INTO `t_log` VALUES (5634, '查询操作', '分页查询商品信息', '2019-08-11 10:04:45', 1);
INSERT INTO `t_log` VALUES (5635, '查询操作', '分页查询商品信息', '2019-08-11 10:04:53', 1);
INSERT INTO `t_log` VALUES (5636, '查询操作', '分页查询商品信息', '2019-08-11 10:04:56', 1);
INSERT INTO `t_log` VALUES (5637, '查询操作', '分页查询商品信息', '2019-08-11 10:05:48', 1);
INSERT INTO `t_log` VALUES (5638, '查询操作', '分页查询商品信息', '2019-08-11 10:05:48', 1);
INSERT INTO `t_log` VALUES (5639, '查询操作', '查询商品类别信息', '2019-08-11 10:05:50', 1);
INSERT INTO `t_log` VALUES (5640, '查询操作', '分页查询商品信息', '2019-08-11 10:06:06', 1);
INSERT INTO `t_log` VALUES (5641, '新增操作', '新增商品类别:啊啊', '2019-08-11 10:06:10', 1);
INSERT INTO `t_log` VALUES (5642, '查询操作', '查询商品类别信息', '2019-08-11 10:06:10', 1);
INSERT INTO `t_log` VALUES (5643, '查询操作', '分页查询商品信息', '2019-08-11 10:06:12', 1);
INSERT INTO `t_log` VALUES (5644, '新增操作', '新增商品类别:啊', '2019-08-11 10:06:18', 1);
INSERT INTO `t_log` VALUES (5645, '查询操作', '查询商品类别信息', '2019-08-11 10:06:18', 1);
INSERT INTO `t_log` VALUES (5646, '查询操作', '分页查询商品信息', '2019-08-11 10:06:27', 1);
INSERT INTO `t_log` VALUES (5647, '删除操作', '删除商品类别：啊', '2019-08-11 10:06:28', 1);
INSERT INTO `t_log` VALUES (5648, '查询操作', '查询商品类别信息', '2019-08-11 10:06:28', 1);
INSERT INTO `t_log` VALUES (5649, '查询操作', '分页查询商品信息', '2019-08-11 10:06:31', 1);
INSERT INTO `t_log` VALUES (5650, '删除操作', '删除商品类别：啊啊', '2019-08-11 10:06:32', 1);
INSERT INTO `t_log` VALUES (5651, '查询操作', '查询商品类别信息', '2019-08-11 10:06:33', 1);
INSERT INTO `t_log` VALUES (5652, '查询操作', '分页查询商品信息', '2019-08-11 10:06:45', 1);
INSERT INTO `t_log` VALUES (5653, '查询操作', '查询商品类别信息', '2019-08-11 10:07:15', 1);
INSERT INTO `t_log` VALUES (5654, '查询操作', '查询商品类别信息', '2019-08-11 10:07:33', 1);
INSERT INTO `t_log` VALUES (5655, '查询操作', '查询商品类别信息', '2019-08-11 10:07:41', 1);
INSERT INTO `t_log` VALUES (5656, '查询操作', '查询商品类别信息', '2019-08-11 10:08:00', 1);
INSERT INTO `t_log` VALUES (5657, '新增操作', '新增商品报损单：BS1565489147613', '2019-08-11 10:09:31', 1);
INSERT INTO `t_log` VALUES (5658, '查询操作', '分页查询商品信息', '2019-08-11 10:09:34', 1);
INSERT INTO `t_log` VALUES (5659, '查询操作', '分页查询商品信息', '2019-08-11 10:09:34', 1);
INSERT INTO `t_log` VALUES (5660, '查询操作', '分页查询商品信息', '2019-08-11 10:17:03', 1);
INSERT INTO `t_log` VALUES (5661, '查询操作', '分页查询商品信息', '2019-08-11 10:17:03', 1);
INSERT INTO `t_log` VALUES (5662, '查询操作', '查询商品类别信息', '2019-08-11 10:17:04', 1);
INSERT INTO `t_log` VALUES (5663, '登录操作', '登录系统', '2019-08-11 10:38:39', 1);
INSERT INTO `t_log` VALUES (5664, '查询操作', '分页查询商品库存信息', '2019-08-11 10:38:40', 1);
INSERT INTO `t_log` VALUES (5665, '查询操作', '分页查询商品信息', '2019-08-11 10:38:50', 1);
INSERT INTO `t_log` VALUES (5666, '查询操作', '分页查询商品信息', '2019-08-11 10:38:50', 1);
INSERT INTO `t_log` VALUES (5667, '查询操作', '查询商品类别信息', '2019-08-11 10:39:45', 1);
INSERT INTO `t_log` VALUES (5668, '查询操作', '分页查询商品信息', '2019-08-11 10:39:52', 1);
INSERT INTO `t_log` VALUES (5669, '查询操作', '分页查询商品信息', '2019-08-11 10:39:56', 1);
INSERT INTO `t_log` VALUES (5670, '查询操作', '分页查询商品信息', '2019-08-11 10:39:57', 1);
INSERT INTO `t_log` VALUES (5671, '查询操作', '分页查询商品信息', '2019-08-11 10:39:58', 1);
INSERT INTO `t_log` VALUES (5672, '查询操作', '分页查询商品信息', '2019-08-11 10:39:59', 1);
INSERT INTO `t_log` VALUES (5673, '查询操作', '分页查询商品信息', '2019-08-11 10:40:00', 1);
INSERT INTO `t_log` VALUES (5674, '查询操作', '分页查询商品信息', '2019-08-11 10:40:03', 1);
INSERT INTO `t_log` VALUES (5675, '查询操作', '分页查询商品信息', '2019-08-11 10:40:07', 1);
INSERT INTO `t_log` VALUES (5676, '查询操作', '分页查询商品信息', '2019-08-11 10:40:07', 1);
INSERT INTO `t_log` VALUES (5677, '查询操作', '查询商品类别信息', '2019-08-11 10:40:29', 1);
INSERT INTO `t_log` VALUES (5678, '查询操作', '分页查询商品信息', '2019-08-11 10:40:41', 1);
INSERT INTO `t_log` VALUES (5679, '新增操作', '新增商品类别:啊啊', '2019-08-11 10:40:45', 1);
INSERT INTO `t_log` VALUES (5680, '查询操作', '查询商品类别信息', '2019-08-11 10:40:45', 1);
INSERT INTO `t_log` VALUES (5681, '查询操作', '分页查询商品信息', '2019-08-11 10:40:47', 1);
INSERT INTO `t_log` VALUES (5682, '新增操作', '新增商品类别:啊', '2019-08-11 10:40:53', 1);
INSERT INTO `t_log` VALUES (5683, '查询操作', '查询商品类别信息', '2019-08-11 10:40:53', 1);
INSERT INTO `t_log` VALUES (5684, '查询操作', '分页查询商品信息', '2019-08-11 10:40:55', 1);
INSERT INTO `t_log` VALUES (5685, '删除操作', '删除商品类别：啊', '2019-08-11 10:40:58', 1);
INSERT INTO `t_log` VALUES (5686, '查询操作', '查询商品类别信息', '2019-08-11 10:40:59', 1);
INSERT INTO `t_log` VALUES (5687, '查询操作', '分页查询商品信息', '2019-08-11 10:41:03', 1);
INSERT INTO `t_log` VALUES (5688, '删除操作', '删除商品类别：啊啊', '2019-08-11 10:41:05', 1);
INSERT INTO `t_log` VALUES (5689, '查询操作', '查询商品类别信息', '2019-08-11 10:41:05', 1);
INSERT INTO `t_log` VALUES (5690, '查询操作', '分页查询商品信息', '2019-08-11 10:41:09', 1);
INSERT INTO `t_log` VALUES (5691, '查询操作', '查询商品类别信息', '2019-08-11 10:41:28', 1);
INSERT INTO `t_log` VALUES (5692, '查询操作', '查询商品类别信息', '2019-08-11 10:41:47', 1);
INSERT INTO `t_log` VALUES (5693, '新增操作', '新增商品报溢单：BY1565491207302', '2019-08-11 11:09:34', 1);
INSERT INTO `t_log` VALUES (5694, '查询操作', '分页查询商品信息', '2019-08-11 11:09:36', 1);
INSERT INTO `t_log` VALUES (5695, '查询操作', '分页查询商品信息', '2019-08-11 11:09:36', 1);
INSERT INTO `t_log` VALUES (5696, '查询操作', '分页查询商品信息', '2019-08-11 11:10:47', 1);
INSERT INTO `t_log` VALUES (5697, '查询操作', '分页查询商品信息', '2019-08-11 11:10:47', 1);
INSERT INTO `t_log` VALUES (5698, '查询操作', '分页查询商品库存信息', '2019-08-11 11:16:24', 1);
INSERT INTO `t_log` VALUES (5699, '登录操作', '登录系统', '2019-08-12 08:28:33', 1);
INSERT INTO `t_log` VALUES (5700, '查询操作', '分页查询商品库存信息', '2019-08-12 08:28:36', 1);
INSERT INTO `t_log` VALUES (5701, '查询操作', '分页查询商品信息', '2019-08-12 08:29:04', 1);
INSERT INTO `t_log` VALUES (5702, '查询操作', '分页查询商品信息', '2019-08-12 08:29:05', 1);
INSERT INTO `t_log` VALUES (5703, '查询操作', '分页查询商品信息', '2019-08-12 08:29:10', 1);
INSERT INTO `t_log` VALUES (5704, '查询操作', '分页查询商品信息', '2019-08-12 08:29:10', 1);
INSERT INTO `t_log` VALUES (5705, '查询操作', '查询商品类别信息', '2019-08-12 08:29:12', 1);
INSERT INTO `t_log` VALUES (5706, '查询操作', '查询库存报警商品信息', '2019-08-12 08:29:20', 1);
INSERT INTO `t_log` VALUES (5707, '查询操作', '分页查询商品库存信息', '2019-08-12 08:30:59', 1);
INSERT INTO `t_log` VALUES (5708, '登录操作', '登录系统', '2019-08-12 08:33:40', 1);
INSERT INTO `t_log` VALUES (5709, '查询操作', '分页查询商品库存信息', '2019-08-12 08:33:41', 1);
INSERT INTO `t_log` VALUES (5710, '查询操作', '商品报损单据查询', '2019-08-12 08:33:46', 1);
INSERT INTO `t_log` VALUES (5711, '登录操作', '登录系统', '2019-08-12 08:41:41', 1);
INSERT INTO `t_log` VALUES (5712, '查询操作', '分页查询商品库存信息', '2019-08-12 08:41:43', 1);
INSERT INTO `t_log` VALUES (5713, '查询操作', '商品报损单据查询', '2019-08-12 08:41:48', 1);
INSERT INTO `t_log` VALUES (5714, '查询操作', '商品报损单据查询', '2019-08-12 08:42:07', 1);
INSERT INTO `t_log` VALUES (5715, '查询操作', '商品报损单据查询', '2019-08-12 08:42:21', 1);
INSERT INTO `t_log` VALUES (5716, '查询操作', '商品报溢单据查询', '2019-08-12 08:42:39', 1);
INSERT INTO `t_log` VALUES (5717, '查询操作', '商品报损单据查询', '2019-08-12 08:42:51', 1);
INSERT INTO `t_log` VALUES (5718, '查询操作', '商品报损单商品信息查询', '2019-08-12 08:43:50', 1);
INSERT INTO `t_log` VALUES (5719, '查询操作', '商品报损单商品信息查询', '2019-08-12 08:44:10', 1);
INSERT INTO `t_log` VALUES (5720, '查询操作', '商品报溢单据查询', '2019-08-12 08:44:19', 1);
INSERT INTO `t_log` VALUES (5721, '查询操作', '商品报溢单商品信息查询', '2019-08-12 08:44:20', 1);
INSERT INTO `t_log` VALUES (5722, '查询操作', '商品报溢单商品信息查询', '2019-08-12 08:44:24', 1);
INSERT INTO `t_log` VALUES (5723, '查询操作', '分页查询商品库存信息', '2019-08-12 08:45:50', 1);
INSERT INTO `t_log` VALUES (5724, '查询操作', '商品报损单据查询', '2019-08-12 08:46:00', 1);
INSERT INTO `t_log` VALUES (5725, '查询操作', '商品报损单商品信息查询', '2019-08-12 08:46:02', 1);
INSERT INTO `t_log` VALUES (5726, '查询操作', '进货单据查询', '2019-08-12 08:54:46', 1);
INSERT INTO `t_log` VALUES (5727, '查询操作', '退货单据查询', '2019-08-12 08:54:46', 1);
INSERT INTO `t_log` VALUES (5728, '查询操作', '客户退货单据查询', '2019-08-12 08:55:04', 1);
INSERT INTO `t_log` VALUES (5729, '查询操作', '销售单据查询', '2019-08-12 08:55:04', 1);
INSERT INTO `t_log` VALUES (5730, '查询操作', '客户退货单据查询', '2019-08-12 08:55:11', 1);
INSERT INTO `t_log` VALUES (5731, '查询操作', '销售单据查询', '2019-08-12 08:55:11', 1);
INSERT INTO `t_log` VALUES (5732, '查询操作', '进货单据查询', '2019-08-12 08:55:35', 1);
INSERT INTO `t_log` VALUES (5733, '查询操作', '退货单据查询', '2019-08-12 08:55:35', 1);
INSERT INTO `t_log` VALUES (5734, '查询操作', '销售单据查询', '2019-08-12 09:08:56', 1);
INSERT INTO `t_log` VALUES (5735, '查询操作', '客户退货单据查询', '2019-08-12 09:08:56', 1);
INSERT INTO `t_log` VALUES (5736, '登录操作', '登录系统', '2019-08-12 10:00:03', 1);
INSERT INTO `t_log` VALUES (5737, '查询操作', '分页查询商品库存信息', '2019-08-12 10:00:05', 1);
INSERT INTO `t_log` VALUES (5738, '查询操作', '退货单据查询', '2019-08-12 10:00:12', 1);
INSERT INTO `t_log` VALUES (5739, '查询操作', '进货单据查询', '2019-08-12 10:00:12', 1);
INSERT INTO `t_log` VALUES (5740, '登录操作', '登录系统', '2019-08-12 10:01:28', 1);
INSERT INTO `t_log` VALUES (5741, '查询操作', '分页查询商品库存信息', '2019-08-12 10:01:30', 1);
INSERT INTO `t_log` VALUES (5742, '查询操作', '进货单据查询', '2019-08-12 10:01:37', 1);
INSERT INTO `t_log` VALUES (5743, '查询操作', '退货单据查询', '2019-08-12 10:01:37', 1);
INSERT INTO `t_log` VALUES (5744, '查询操作', '进货单据查询', '2019-08-12 10:02:09', 1);
INSERT INTO `t_log` VALUES (5745, '查询操作', '退货单据查询', '2019-08-12 10:02:09', 1);
INSERT INTO `t_log` VALUES (5746, '查询操作', '退货单据查询', '2019-08-12 10:03:02', 1);
INSERT INTO `t_log` VALUES (5747, '查询操作', '进货单据查询', '2019-08-12 10:03:02', 1);
INSERT INTO `t_log` VALUES (5748, '查询操作', '进货单据查询', '2019-08-12 10:03:07', 1);
INSERT INTO `t_log` VALUES (5749, '查询操作', '退货单据查询', '2019-08-12 10:03:07', 1);
INSERT INTO `t_log` VALUES (5750, '查询操作', '进货单据查询', '2019-08-12 10:03:16', 1);
INSERT INTO `t_log` VALUES (5751, '查询操作', '退货单据查询', '2019-08-12 10:03:16', 1);
INSERT INTO `t_log` VALUES (5752, '查询操作', '进货单据查询', '2019-08-12 10:03:20', 1);
INSERT INTO `t_log` VALUES (5753, '查询操作', '退货单据查询', '2019-08-12 10:03:20', 1);
INSERT INTO `t_log` VALUES (5754, '查询操作', '退货单据查询', '2019-08-12 10:04:42', 1);
INSERT INTO `t_log` VALUES (5755, '查询操作', '进货单据查询', '2019-08-12 10:04:42', 1);
INSERT INTO `t_log` VALUES (5756, '查询操作', '退货单据查询', '2019-08-12 10:05:12', 1);
INSERT INTO `t_log` VALUES (5757, '查询操作', '进货单据查询', '2019-08-12 10:05:12', 1);
INSERT INTO `t_log` VALUES (5758, '查询操作', '进货单据查询', '2019-08-12 10:05:22', 1);
INSERT INTO `t_log` VALUES (5759, '查询操作', '退货单据查询', '2019-08-12 10:05:22', 1);
INSERT INTO `t_log` VALUES (5760, '查询操作', '退货单据查询', '2019-08-12 10:05:27', 1);
INSERT INTO `t_log` VALUES (5761, '查询操作', '进货单据查询', '2019-08-12 10:05:27', 1);
INSERT INTO `t_log` VALUES (5762, '查询操作', '进货单商品信息查询', '2019-08-12 10:05:40', 1);
INSERT INTO `t_log` VALUES (5763, '查询操作', '进货单商品信息查询', '2019-08-12 10:06:06', 1);
INSERT INTO `t_log` VALUES (5764, '查询操作', '退货单商品信息查询', '2019-08-12 10:06:10', 1);
INSERT INTO `t_log` VALUES (5765, '查询操作', '进货单商品信息查询', '2019-08-12 10:06:37', 1);
INSERT INTO `t_log` VALUES (5766, '查询操作', '进货单商品信息查询', '2019-08-12 10:07:07', 1);
INSERT INTO `t_log` VALUES (5767, '查询操作', '退货单商品信息查询', '2019-08-12 10:07:10', 1);
INSERT INTO `t_log` VALUES (5768, '删除操作', '支付结算退货单：TH1549940820089', '2019-08-12 10:07:19', 1);
INSERT INTO `t_log` VALUES (5769, '查询操作', '退货单据查询', '2019-08-12 10:07:19', 1);
INSERT INTO `t_log` VALUES (5770, '查询操作', '进货单据查询', '2019-08-12 10:07:19', 1);
INSERT INTO `t_log` VALUES (5771, '查询操作', '进货单据查询', '2019-08-12 10:07:37', 1);
INSERT INTO `t_log` VALUES (5772, '查询操作', '退货单据查询', '2019-08-12 10:07:37', 1);
INSERT INTO `t_log` VALUES (5773, '查询操作', '退货单据查询', '2019-08-12 10:07:51', 1);
INSERT INTO `t_log` VALUES (5774, '查询操作', '进货单据查询', '2019-08-12 10:07:51', 1);
INSERT INTO `t_log` VALUES (5775, '查询操作', '进货单据查询', '2019-08-12 10:08:19', 1);
INSERT INTO `t_log` VALUES (5776, '查询操作', '退货单据查询', '2019-08-12 10:08:19', 1);
INSERT INTO `t_log` VALUES (5777, '查询操作', '进货单商品信息查询', '2019-08-12 10:08:22', 1);
INSERT INTO `t_log` VALUES (5778, '查询操作', '进货单商品信息查询', '2019-08-12 10:08:33', 1);
INSERT INTO `t_log` VALUES (5779, '删除操作', '支付结算进货单：JH1564882213808', '2019-08-12 10:08:38', 1);
INSERT INTO `t_log` VALUES (5780, '查询操作', '进货单据查询', '2019-08-12 10:08:38', 1);
INSERT INTO `t_log` VALUES (5781, '查询操作', '退货单据查询', '2019-08-12 10:08:38', 1);
INSERT INTO `t_log` VALUES (5782, '登录操作', '登录系统', '2019-08-12 10:39:32', 1);
INSERT INTO `t_log` VALUES (5783, '查询操作', '分页查询商品库存信息', '2019-08-12 10:39:34', 1);
INSERT INTO `t_log` VALUES (5784, '查询操作', '销售单据查询', '2019-08-12 10:39:41', 1);
INSERT INTO `t_log` VALUES (5785, '查询操作', '客户退货单据查询', '2019-08-12 10:39:41', 1);
INSERT INTO `t_log` VALUES (5786, '查询操作', '销售单据查询', '2019-08-12 10:40:59', 1);
INSERT INTO `t_log` VALUES (5787, '查询操作', '客户退货单据查询', '2019-08-12 10:40:59', 1);
INSERT INTO `t_log` VALUES (5788, '查询操作', '销售单据查询', '2019-08-12 10:41:45', 1);
INSERT INTO `t_log` VALUES (5789, '查询操作', '客户退货单据查询', '2019-08-12 10:41:45', 1);
INSERT INTO `t_log` VALUES (5790, '查询操作', '客户退货单据查询', '2019-08-12 10:41:49', 1);
INSERT INTO `t_log` VALUES (5791, '查询操作', '销售单据查询', '2019-08-12 10:41:49', 1);
INSERT INTO `t_log` VALUES (5792, '查询操作', '销售单据查询', '2019-08-12 10:41:52', 1);
INSERT INTO `t_log` VALUES (5793, '查询操作', '客户退货单据查询', '2019-08-12 10:41:52', 1);
INSERT INTO `t_log` VALUES (5794, '查询操作', '销售单据查询', '2019-08-12 10:42:07', 1);
INSERT INTO `t_log` VALUES (5795, '查询操作', '客户退货单据查询', '2019-08-12 10:42:07', 1);
INSERT INTO `t_log` VALUES (5796, '查询操作', '客户退货单据查询', '2019-08-12 10:42:30', 1);
INSERT INTO `t_log` VALUES (5797, '查询操作', '销售单据查询', '2019-08-12 10:42:30', 1);
INSERT INTO `t_log` VALUES (5798, '查询操作', '销售单据查询', '2019-08-12 10:42:33', 1);
INSERT INTO `t_log` VALUES (5799, '查询操作', '客户退货单据查询', '2019-08-12 10:42:33', 1);
INSERT INTO `t_log` VALUES (5800, '查询操作', '客户退货单据查询', '2019-08-12 10:42:42', 1);
INSERT INTO `t_log` VALUES (5801, '查询操作', '销售单据查询', '2019-08-12 10:42:42', 1);
INSERT INTO `t_log` VALUES (5802, '查询操作', '客户退货单据查询', '2019-08-12 10:42:44', 1);
INSERT INTO `t_log` VALUES (5803, '查询操作', '销售单据查询', '2019-08-12 10:42:44', 1);
INSERT INTO `t_log` VALUES (5804, '查询操作', '销售单据查询', '2019-08-12 10:42:46', 1);
INSERT INTO `t_log` VALUES (5805, '查询操作', '客户退货单据查询', '2019-08-12 10:42:46', 1);
INSERT INTO `t_log` VALUES (5806, '查询操作', '销售单商品信息查询', '2019-08-12 10:43:14', 1);
INSERT INTO `t_log` VALUES (5807, '查询操作', '销售单商品信息查询', '2019-08-12 10:43:18', 1);
INSERT INTO `t_log` VALUES (5808, '查询操作', '销售单商品信息查询', '2019-08-12 10:43:22', 1);
INSERT INTO `t_log` VALUES (5809, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:43:22', 1);
INSERT INTO `t_log` VALUES (5810, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:45:19', 1);
INSERT INTO `t_log` VALUES (5811, '查询操作', '销售单商品信息查询', '2019-08-12 10:45:25', 1);
INSERT INTO `t_log` VALUES (5812, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:45:39', 1);
INSERT INTO `t_log` VALUES (5813, '登录操作', '登录系统', '2019-08-12 10:46:20', 1);
INSERT INTO `t_log` VALUES (5814, '查询操作', '分页查询商品库存信息', '2019-08-12 10:46:21', 1);
INSERT INTO `t_log` VALUES (5815, '查询操作', '销售单据查询', '2019-08-12 10:46:28', 1);
INSERT INTO `t_log` VALUES (5816, '查询操作', '客户退货单据查询', '2019-08-12 10:46:28', 1);
INSERT INTO `t_log` VALUES (5817, '查询操作', '客户退货单据查询', '2019-08-12 10:46:33', 1);
INSERT INTO `t_log` VALUES (5818, '查询操作', '销售单据查询', '2019-08-12 10:46:33', 1);
INSERT INTO `t_log` VALUES (5819, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:46:34', 1);
INSERT INTO `t_log` VALUES (5820, '查询操作', '销售单商品信息查询', '2019-08-12 10:46:36', 1);
INSERT INTO `t_log` VALUES (5821, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:46:44', 1);
INSERT INTO `t_log` VALUES (5822, '登录操作', '登录系统', '2019-08-12 10:49:55', 1);
INSERT INTO `t_log` VALUES (5823, '查询操作', '分页查询商品库存信息', '2019-08-12 10:49:56', 1);
INSERT INTO `t_log` VALUES (5824, '查询操作', '销售单据查询', '2019-08-12 10:50:02', 1);
INSERT INTO `t_log` VALUES (5825, '查询操作', '客户退货单据查询', '2019-08-12 10:50:02', 1);
INSERT INTO `t_log` VALUES (5826, '查询操作', '客户退货单据查询', '2019-08-12 10:50:06', 1);
INSERT INTO `t_log` VALUES (5827, '查询操作', '销售单据查询', '2019-08-12 10:50:06', 1);
INSERT INTO `t_log` VALUES (5828, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:50:07', 1);
INSERT INTO `t_log` VALUES (5829, '查询操作', '销售单商品信息查询', '2019-08-12 10:50:09', 1);
INSERT INTO `t_log` VALUES (5830, '查询操作', '销售单商品信息查询', '2019-08-12 10:50:10', 1);
INSERT INTO `t_log` VALUES (5831, '查询操作', '销售单商品信息查询', '2019-08-12 10:50:10', 1);
INSERT INTO `t_log` VALUES (5832, '查询操作', '销售单据查询', '2019-08-12 10:50:41', 1);
INSERT INTO `t_log` VALUES (5833, '查询操作', '客户退货单据查询', '2019-08-12 10:50:41', 1);
INSERT INTO `t_log` VALUES (5834, '查询操作', '销售单商品信息查询', '2019-08-12 10:50:45', 1);
INSERT INTO `t_log` VALUES (5835, '查询操作', '销售单商品信息查询', '2019-08-12 10:50:49', 1);
INSERT INTO `t_log` VALUES (5836, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:50:52', 1);
INSERT INTO `t_log` VALUES (5837, '删除操作', '支付结算客户退货单：XT1550220103291', '2019-08-12 10:50:56', 1);
INSERT INTO `t_log` VALUES (5838, '查询操作', '销售单据查询', '2019-08-12 10:50:56', 1);
INSERT INTO `t_log` VALUES (5839, '查询操作', '客户退货单据查询', '2019-08-12 10:50:56', 1);
INSERT INTO `t_log` VALUES (5840, '查询操作', '销售单商品信息查询', '2019-08-12 10:51:08', 1);
INSERT INTO `t_log` VALUES (5841, '删除操作', '支付结算销售单：XS1551232158294', '2019-08-12 10:51:11', 1);
INSERT INTO `t_log` VALUES (5842, '查询操作', '客户退货单据查询', '2019-08-12 10:51:11', 1);
INSERT INTO `t_log` VALUES (5843, '查询操作', '销售单据查询', '2019-08-12 10:51:11', 1);
INSERT INTO `t_log` VALUES (5844, '查询操作', '客户退货单商品信息查询', '2019-08-12 10:51:31', 1);
INSERT INTO `t_log` VALUES (5845, '查询操作', '销售单商品信息查询', '2019-08-12 10:51:34', 1);
INSERT INTO `t_log` VALUES (5846, '登录操作', '登录系统', '2019-08-13 16:52:23', 1);
INSERT INTO `t_log` VALUES (5847, '查询操作', '分页查询商品库存信息', '2019-08-13 16:52:26', 1);
INSERT INTO `t_log` VALUES (5848, '查询操作', '退货商品统计查询', '2019-08-13 16:52:33', 1);
INSERT INTO `t_log` VALUES (5849, '查询操作', '进货商品统计查询', '2019-08-13 16:52:33', 1);
INSERT INTO `t_log` VALUES (5850, '查询操作', '客户退货单据查询', '2019-08-13 16:52:35', 1);
INSERT INTO `t_log` VALUES (5851, '查询操作', '销售单据查询', '2019-08-13 16:52:35', 1);
INSERT INTO `t_log` VALUES (5852, '查询操作', '退货商品统计查询', '2019-08-13 16:52:56', 1);
INSERT INTO `t_log` VALUES (5853, '查询操作', '进货商品统计查询', '2019-08-13 16:52:56', 1);
INSERT INTO `t_log` VALUES (5854, '查询操作', '退货商品统计查询', '2019-08-13 16:54:58', 1);
INSERT INTO `t_log` VALUES (5855, '查询操作', '进货商品统计查询', '2019-08-13 16:54:58', 1);
INSERT INTO `t_log` VALUES (5856, '查询操作', '退货商品统计查询', '2019-08-13 16:55:05', 1);
INSERT INTO `t_log` VALUES (5857, '查询操作', '进货商品统计查询', '2019-08-13 16:55:05', 1);
INSERT INTO `t_log` VALUES (5858, '查询操作', '退货商品统计查询', '2019-08-13 16:55:15', 1);
INSERT INTO `t_log` VALUES (5859, '查询操作', '进货商品统计查询', '2019-08-13 16:55:15', 1);
INSERT INTO `t_log` VALUES (5860, '查询操作', '查询商品类别信息', '2019-08-13 16:55:24', 1);
INSERT INTO `t_log` VALUES (5861, '查询操作', '查询商品类别信息', '2019-08-13 16:55:32', 1);
INSERT INTO `t_log` VALUES (5862, '查询操作', '查询商品类别信息', '2019-08-13 16:55:38', 1);
INSERT INTO `t_log` VALUES (5863, '查询操作', '查询商品类别信息', '2019-08-13 16:55:41', 1);
INSERT INTO `t_log` VALUES (5864, '查询操作', '查询商品类别信息', '2019-08-13 16:55:46', 1);
INSERT INTO `t_log` VALUES (5865, '查询操作', '查询商品类别信息', '2019-08-13 16:55:49', 1);
INSERT INTO `t_log` VALUES (5866, '查询操作', '进货商品统计查询', '2019-08-13 16:55:54', 1);
INSERT INTO `t_log` VALUES (5867, '查询操作', '退货商品统计查询', '2019-08-13 16:55:54', 1);
INSERT INTO `t_log` VALUES (5868, '查询操作', '查询商品类别信息', '2019-08-13 16:56:04', 1);
INSERT INTO `t_log` VALUES (5869, '查询操作', '退货商品统计查询', '2019-08-13 16:56:09', 1);
INSERT INTO `t_log` VALUES (5870, '查询操作', '进货商品统计查询', '2019-08-13 16:56:09', 1);
INSERT INTO `t_log` VALUES (5871, '查询操作', '查询商品类别信息', '2019-08-13 16:56:16', 1);
INSERT INTO `t_log` VALUES (5872, '查询操作', '退货商品统计查询', '2019-08-13 16:56:22', 1);
INSERT INTO `t_log` VALUES (5873, '查询操作', '进货商品统计查询', '2019-08-13 16:56:22', 1);
INSERT INTO `t_log` VALUES (5874, '查询操作', '查询商品类别信息', '2019-08-13 16:56:22', 1);
INSERT INTO `t_log` VALUES (5875, '查询操作', '退货商品统计查询', '2019-08-13 16:56:25', 1);
INSERT INTO `t_log` VALUES (5876, '查询操作', '进货商品统计查询', '2019-08-13 16:56:25', 1);
INSERT INTO `t_log` VALUES (5877, '查询操作', '查询商品类别信息', '2019-08-13 16:56:37', 1);
INSERT INTO `t_log` VALUES (5878, '查询操作', '查询商品类别信息', '2019-08-13 16:56:40', 1);
INSERT INTO `t_log` VALUES (5879, '查询操作', '查询商品类别信息', '2019-08-13 16:56:46', 1);
INSERT INTO `t_log` VALUES (5880, '查询操作', '查询商品类别信息', '2019-08-13 16:56:51', 1);
INSERT INTO `t_log` VALUES (5881, '查询操作', '进货商品统计查询', '2019-08-13 16:57:00', 1);
INSERT INTO `t_log` VALUES (5882, '查询操作', '退货商品统计查询', '2019-08-13 16:57:00', 1);
INSERT INTO `t_log` VALUES (5883, '查询操作', '退货商品统计查询', '2019-08-13 16:57:13', 1);
INSERT INTO `t_log` VALUES (5884, '查询操作', '进货商品统计查询', '2019-08-13 16:57:13', 1);
INSERT INTO `t_log` VALUES (5885, '查询操作', '进货商品统计查询', '2019-08-13 16:58:05', 1);
INSERT INTO `t_log` VALUES (5886, '查询操作', '退货商品统计查询', '2019-08-13 16:58:05', 1);
INSERT INTO `t_log` VALUES (5887, '查询操作', '退货商品统计查询', '2019-08-13 16:58:18', 1);
INSERT INTO `t_log` VALUES (5888, '查询操作', '进货商品统计查询', '2019-08-13 16:58:18', 1);
INSERT INTO `t_log` VALUES (5889, '查询操作', '退货商品统计查询', '2019-08-13 16:58:22', 1);
INSERT INTO `t_log` VALUES (5890, '查询操作', '进货商品统计查询', '2019-08-13 16:58:22', 1);
INSERT INTO `t_log` VALUES (5891, '查询操作', '退货商品统计查询', '2019-08-13 16:58:32', 1);
INSERT INTO `t_log` VALUES (5892, '查询操作', '进货商品统计查询', '2019-08-13 16:58:32', 1);
INSERT INTO `t_log` VALUES (5893, '查询操作', '查询商品类别信息', '2019-08-13 16:58:34', 1);
INSERT INTO `t_log` VALUES (5894, '查询操作', '退货商品统计查询', '2019-08-13 16:58:37', 1);
INSERT INTO `t_log` VALUES (5895, '查询操作', '进货商品统计查询', '2019-08-13 16:58:37', 1);
INSERT INTO `t_log` VALUES (5896, '查询操作', '查询商品类别信息', '2019-08-13 16:58:38', 1);
INSERT INTO `t_log` VALUES (5897, '查询操作', '进货商品统计查询', '2019-08-13 16:58:41', 1);
INSERT INTO `t_log` VALUES (5898, '查询操作', '退货商品统计查询', '2019-08-13 16:58:41', 1);
INSERT INTO `t_log` VALUES (5899, '查询操作', '查询商品类别信息', '2019-08-13 16:58:42', 1);
INSERT INTO `t_log` VALUES (5900, '查询操作', '退货商品统计查询', '2019-08-13 16:58:46', 1);
INSERT INTO `t_log` VALUES (5901, '查询操作', '进货商品统计查询', '2019-08-13 16:58:46', 1);
INSERT INTO `t_log` VALUES (5902, '查询操作', '查询商品类别信息', '2019-08-13 16:58:47', 1);
INSERT INTO `t_log` VALUES (5903, '查询操作', '进货商品统计查询', '2019-08-13 16:58:49', 1);
INSERT INTO `t_log` VALUES (5904, '查询操作', '退货商品统计查询', '2019-08-13 16:58:49', 1);
INSERT INTO `t_log` VALUES (5905, '查询操作', '客户退货商品统计查询', '2019-08-13 17:00:28', 1);
INSERT INTO `t_log` VALUES (5906, '查询操作', '销售商品统计查询', '2019-08-13 17:00:28', 1);
INSERT INTO `t_log` VALUES (5907, '登录操作', '登录系统', '2019-08-13 17:07:48', 1);
INSERT INTO `t_log` VALUES (5908, '查询操作', '分页查询商品库存信息', '2019-08-13 17:07:49', 1);
INSERT INTO `t_log` VALUES (5909, '查询操作', '销售商品统计查询', '2019-08-13 17:08:02', 1);
INSERT INTO `t_log` VALUES (5910, '查询操作', '客户退货商品统计查询', '2019-08-13 17:08:02', 1);
INSERT INTO `t_log` VALUES (5911, '查询操作', '退货商品统计查询', '2019-08-13 17:08:24', 1);
INSERT INTO `t_log` VALUES (5912, '查询操作', '进货商品统计查询', '2019-08-13 17:08:24', 1);
INSERT INTO `t_log` VALUES (5913, '登录操作', '登录系统', '2019-08-13 17:19:11', 1);
INSERT INTO `t_log` VALUES (5914, '查询操作', '分页查询商品库存信息', '2019-08-13 17:19:13', 1);
INSERT INTO `t_log` VALUES (5915, '查询操作', '客户退货商品统计查询', '2019-08-13 17:20:52', 1);
INSERT INTO `t_log` VALUES (5916, '查询操作', '销售商品统计查询', '2019-08-13 17:20:52', 1);
INSERT INTO `t_log` VALUES (5917, '查询操作', '客户退货商品统计查询', '2019-08-13 17:21:00', 1);
INSERT INTO `t_log` VALUES (5918, '登录操作', '登录系统', '2019-08-13 17:30:20', 1);
INSERT INTO `t_log` VALUES (5919, '查询操作', '分页查询商品库存信息', '2019-08-13 17:30:22', 1);
INSERT INTO `t_log` VALUES (5920, '查询操作', '客户退货商品统计查询', '2019-08-13 17:30:29', 1);
INSERT INTO `t_log` VALUES (5921, '查询操作', '销售商品统计查询', '2019-08-13 17:30:29', 1);
INSERT INTO `t_log` VALUES (5922, '查询操作', '客户退货商品统计查询', '2019-08-13 17:30:43', 1);
INSERT INTO `t_log` VALUES (5923, '查询操作', '销售商品统计查询', '2019-08-13 17:30:43', 1);
INSERT INTO `t_log` VALUES (5924, '查询操作', '销售商品统计查询', '2019-08-13 17:31:20', 1);
INSERT INTO `t_log` VALUES (5925, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:20', 1);
INSERT INTO `t_log` VALUES (5926, '查询操作', '查询商品类别信息', '2019-08-13 17:31:25', 1);
INSERT INTO `t_log` VALUES (5927, '查询操作', '查询商品类别信息', '2019-08-13 17:31:29', 1);
INSERT INTO `t_log` VALUES (5928, '查询操作', '查询商品类别信息', '2019-08-13 17:31:32', 1);
INSERT INTO `t_log` VALUES (5929, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:37', 1);
INSERT INTO `t_log` VALUES (5930, '查询操作', '销售商品统计查询', '2019-08-13 17:31:37', 1);
INSERT INTO `t_log` VALUES (5931, '查询操作', '查询商品类别信息', '2019-08-13 17:31:38', 1);
INSERT INTO `t_log` VALUES (5932, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:42', 1);
INSERT INTO `t_log` VALUES (5933, '查询操作', '销售商品统计查询', '2019-08-13 17:31:42', 1);
INSERT INTO `t_log` VALUES (5934, '查询操作', '查询商品类别信息', '2019-08-13 17:31:44', 1);
INSERT INTO `t_log` VALUES (5935, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:47', 1);
INSERT INTO `t_log` VALUES (5936, '查询操作', '销售商品统计查询', '2019-08-13 17:31:47', 1);
INSERT INTO `t_log` VALUES (5937, '查询操作', '查询商品类别信息', '2019-08-13 17:31:48', 1);
INSERT INTO `t_log` VALUES (5938, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:50', 1);
INSERT INTO `t_log` VALUES (5939, '查询操作', '销售商品统计查询', '2019-08-13 17:31:50', 1);
INSERT INTO `t_log` VALUES (5940, '查询操作', '查询商品类别信息', '2019-08-13 17:31:52', 1);
INSERT INTO `t_log` VALUES (5941, '查询操作', '客户退货商品统计查询', '2019-08-13 17:31:57', 1);
INSERT INTO `t_log` VALUES (5942, '查询操作', '销售商品统计查询', '2019-08-13 17:31:57', 1);
INSERT INTO `t_log` VALUES (5943, '查询操作', '查询商品类别信息', '2019-08-13 17:31:59', 1);
INSERT INTO `t_log` VALUES (5944, '查询操作', '客户退货商品统计查询', '2019-08-13 17:32:05', 1);
INSERT INTO `t_log` VALUES (5945, '查询操作', '销售商品统计查询', '2019-08-13 17:32:05', 1);
INSERT INTO `t_log` VALUES (5946, '查询操作', '客户退货商品统计查询', '2019-08-13 17:32:30', 1);
INSERT INTO `t_log` VALUES (5947, '查询操作', '销售商品统计查询', '2019-08-13 17:32:30', 1);
INSERT INTO `t_log` VALUES (5948, '查询操作', '查询商品类别信息', '2019-08-13 17:32:34', 1);
INSERT INTO `t_log` VALUES (5949, '查询操作', '客户退货商品统计查询', '2019-08-13 17:32:41', 1);
INSERT INTO `t_log` VALUES (5950, '查询操作', '销售商品统计查询', '2019-08-13 17:32:41', 1);
INSERT INTO `t_log` VALUES (5951, '查询操作', '查询商品类别信息', '2019-08-13 17:32:42', 1);
INSERT INTO `t_log` VALUES (5952, '查询操作', '客户退货商品统计查询', '2019-08-13 17:32:44', 1);
INSERT INTO `t_log` VALUES (5953, '查询操作', '销售商品统计查询', '2019-08-13 17:32:44', 1);
INSERT INTO `t_log` VALUES (5954, '登录操作', '登录系统', '2019-08-15 08:29:17', 1);
INSERT INTO `t_log` VALUES (5955, '查询操作', '分页查询商品库存信息', '2019-08-15 08:29:18', 1);
INSERT INTO `t_log` VALUES (5956, '查询操作', '销售商品统计查询', '2019-08-15 08:29:30', 1);
INSERT INTO `t_log` VALUES (5957, '查询操作', '客户退货商品统计查询', '2019-08-15 08:29:30', 1);
INSERT INTO `t_log` VALUES (5958, '查询操作', '查询商品类别信息', '2019-08-15 08:29:32', 1);
INSERT INTO `t_log` VALUES (5959, '查询操作', '查询商品类别信息', '2019-08-15 08:29:34', 1);
INSERT INTO `t_log` VALUES (5960, '查询操作', '客户退货商品统计查询', '2019-08-15 08:29:40', 1);
INSERT INTO `t_log` VALUES (5961, '查询操作', '销售商品统计查询', '2019-08-15 08:29:40', 1);
INSERT INTO `t_log` VALUES (5962, '查询操作', '客户退货商品统计查询', '2019-08-15 08:29:43', 1);
INSERT INTO `t_log` VALUES (5963, '查询操作', '销售商品统计查询', '2019-08-15 08:29:43', 1);
INSERT INTO `t_log` VALUES (5964, '查询操作', '查询按日统计分析数据', '2019-08-15 08:29:48', 1);
INSERT INTO `t_log` VALUES (5965, '查询操作', '查询按日统计分析数据', '2019-08-15 08:30:45', 1);
INSERT INTO `t_log` VALUES (5966, '查询操作', '查询按日统计分析数据', '2019-08-15 08:31:53', 1);
INSERT INTO `t_log` VALUES (5967, '查询操作', '查询按日统计分析数据', '2019-08-15 08:32:28', 1);
INSERT INTO `t_log` VALUES (5968, '查询操作', '查询按日统计分析数据', '2019-08-15 08:32:44', 1);
INSERT INTO `t_log` VALUES (5969, '查询操作', '查询按日统计分析数据', '2019-08-15 08:33:15', 1);
INSERT INTO `t_log` VALUES (5970, '查询操作', '查询按日统计分析数据', '2019-08-15 08:37:12', 1);
INSERT INTO `t_log` VALUES (5971, '查询操作', '查询按日统计分析数据', '2019-08-15 08:37:24', 1);
INSERT INTO `t_log` VALUES (5972, '查询操作', '查询按日统计分析数据', '2019-08-15 08:37:42', 1);
INSERT INTO `t_log` VALUES (5973, '查询操作', '查询按月统计分析数据', '2019-08-15 08:38:15', 1);
INSERT INTO `t_log` VALUES (5974, '查询操作', '查询按月统计分析数据', '2019-08-15 08:40:22', 1);
INSERT INTO `t_log` VALUES (5975, '查询操作', '查询按日统计分析数据', '2019-08-15 08:41:15', 1);
INSERT INTO `t_log` VALUES (5976, '查询操作', '查询按日统计分析数据', '2019-08-15 08:41:26', 1);
INSERT INTO `t_log` VALUES (5977, '登录操作', '登录系统', '2019-08-15 08:46:51', 1);
INSERT INTO `t_log` VALUES (5978, '查询操作', '分页查询商品库存信息', '2019-08-15 08:46:54', 1);
INSERT INTO `t_log` VALUES (5979, '查询操作', '查询按日统计分析数据', '2019-08-15 08:47:00', 1);
INSERT INTO `t_log` VALUES (5980, '查询操作', '查询按日统计分析数据', '2019-08-15 08:47:21', 1);
INSERT INTO `t_log` VALUES (5981, '查询操作', '分页查询商品库存信息', '2019-08-15 08:50:06', 1);
INSERT INTO `t_log` VALUES (5982, '登录操作', '登录系统', '2019-08-15 08:50:22', 1);
INSERT INTO `t_log` VALUES (5983, '查询操作', '分页查询商品库存信息', '2019-08-15 08:50:23', 1);
INSERT INTO `t_log` VALUES (5984, '查询操作', '查询按日统计分析数据', '2019-08-15 08:50:32', 1);
INSERT INTO `t_log` VALUES (5985, '查询操作', '查询按日统计分析数据', '2019-08-15 08:51:56', 1);
INSERT INTO `t_log` VALUES (5986, '登录操作', '登录系统', '2019-08-15 08:53:58', 1);
INSERT INTO `t_log` VALUES (5987, '查询操作', '分页查询商品库存信息', '2019-08-15 08:53:59', 1);
INSERT INTO `t_log` VALUES (5988, '查询操作', '查询按日统计分析数据', '2019-08-15 08:54:02', 1);
INSERT INTO `t_log` VALUES (5989, '查询操作', '分页查询商品库存信息', '2019-08-15 09:00:24', 1);
INSERT INTO `t_log` VALUES (5990, '查询操作', '查询按日统计分析数据', '2019-08-15 09:00:28', 1);
INSERT INTO `t_log` VALUES (5991, '查询操作', '查询按日统计分析数据', '2019-08-15 09:00:54', 1);
INSERT INTO `t_log` VALUES (5992, '登录操作', '登录系统', '2019-08-15 09:01:15', 1);
INSERT INTO `t_log` VALUES (5993, '查询操作', '分页查询商品库存信息', '2019-08-15 09:01:17', 1);
INSERT INTO `t_log` VALUES (5994, '查询操作', '查询按日统计分析数据', '2019-08-15 09:01:19', 1);
INSERT INTO `t_log` VALUES (5995, '查询操作', '分页查询商品库存信息', '2019-08-15 09:14:44', 1);
INSERT INTO `t_log` VALUES (5996, '查询操作', '查询按日统计分析数据', '2019-08-15 09:14:51', 1);
INSERT INTO `t_log` VALUES (5997, '查询操作', '查询按日统计分析数据', '2019-08-15 09:15:23', 1);
INSERT INTO `t_log` VALUES (5998, '查询操作', '查询按日统计分析数据', '2019-08-15 09:26:03', 1);
INSERT INTO `t_log` VALUES (5999, '查询操作', '查询按日统计分析数据', '2019-08-15 09:26:16', 1);
INSERT INTO `t_log` VALUES (6000, '查询操作', '查询按日统计分析数据', '2019-08-15 09:28:57', 1);
INSERT INTO `t_log` VALUES (6001, '查询操作', '查询按日统计分析数据', '2019-08-15 09:29:09', 1);
INSERT INTO `t_log` VALUES (6002, '查询操作', '查询按日统计分析数据', '2019-08-15 09:30:18', 1);
INSERT INTO `t_log` VALUES (6003, '查询操作', '查询按日统计分析数据', '2019-08-15 09:30:33', 1);
INSERT INTO `t_log` VALUES (6004, '查询操作', '查询按日统计分析数据', '2019-08-15 09:30:39', 1);
INSERT INTO `t_log` VALUES (6005, '查询操作', '查询按日统计分析数据', '2019-08-15 09:30:53', 1);
INSERT INTO `t_log` VALUES (6006, '查询操作', '查询按日统计分析数据', '2019-08-15 09:31:29', 1);
INSERT INTO `t_log` VALUES (6007, '查询操作', '查询按日统计分析数据', '2019-08-15 09:33:27', 1);
INSERT INTO `t_log` VALUES (6008, '查询操作', '查询按日统计分析数据', '2019-08-15 09:33:34', 1);
INSERT INTO `t_log` VALUES (6009, '查询操作', '查询按日统计分析数据', '2019-08-15 09:34:31', 1);
INSERT INTO `t_log` VALUES (6010, '查询操作', '查询按日统计分析数据', '2019-08-15 09:34:42', 1);
INSERT INTO `t_log` VALUES (6011, '查询操作', '查询按日统计分析数据', '2019-08-15 09:34:51', 1);
INSERT INTO `t_log` VALUES (6012, '查询操作', '查询按日统计分析数据', '2019-08-15 09:35:38', 1);
INSERT INTO `t_log` VALUES (6013, '查询操作', '查询按日统计分析数据', '2019-08-15 09:36:12', 1);
INSERT INTO `t_log` VALUES (6014, '查询操作', '查询按日统计分析数据', '2019-08-15 09:40:35', 1);
INSERT INTO `t_log` VALUES (6015, '查询操作', '查询按日统计分析数据', '2019-08-15 09:40:53', 1);
INSERT INTO `t_log` VALUES (6016, '查询操作', '查询按日统计分析数据', '2019-08-15 09:40:59', 1);
INSERT INTO `t_log` VALUES (6017, '查询操作', '查询按日统计分析数据', '2019-08-15 09:41:12', 1);
INSERT INTO `t_log` VALUES (6018, '查询操作', '查询按日统计分析数据', '2019-08-15 09:42:22', 1);
INSERT INTO `t_log` VALUES (6019, '查询操作', '查询按日统计分析数据', '2019-08-15 09:42:36', 1);
INSERT INTO `t_log` VALUES (6020, '查询操作', '查询按日统计分析数据', '2019-08-15 09:43:21', 1);
INSERT INTO `t_log` VALUES (6021, '查询操作', '分页查询商品库存信息', '2019-08-15 09:50:08', 1);
INSERT INTO `t_log` VALUES (6022, '查询操作', '查询按日统计分析数据', '2019-08-15 09:50:13', 1);
INSERT INTO `t_log` VALUES (6023, '查询操作', '查询按日统计分析数据', '2019-08-15 09:51:16', 1);
INSERT INTO `t_log` VALUES (6024, '查询操作', '查询按日统计分析数据', '2019-08-15 09:53:20', 1);
INSERT INTO `t_log` VALUES (6025, '查询操作', '查询按日统计分析数据', '2019-08-15 09:56:19', 1);
INSERT INTO `t_log` VALUES (6026, '查询操作', '查询按日统计分析数据', '2019-08-15 09:56:33', 1);
INSERT INTO `t_log` VALUES (6027, '查询操作', '查询按日统计分析数据', '2019-08-15 09:56:39', 1);
INSERT INTO `t_log` VALUES (6028, '查询操作', '查询按日统计分析数据', '2019-08-15 09:58:48', 1);
INSERT INTO `t_log` VALUES (6029, '查询操作', '查询按日统计分析数据', '2019-08-15 09:58:55', 1);
INSERT INTO `t_log` VALUES (6030, '查询操作', '查询按日统计分析数据', '2019-08-15 09:59:02', 1);
INSERT INTO `t_log` VALUES (6031, '查询操作', '查询按日统计分析数据', '2019-08-15 09:59:11', 1);
INSERT INTO `t_log` VALUES (6032, '查询操作', '查询按日统计分析数据', '2019-08-15 10:00:20', 1);
INSERT INTO `t_log` VALUES (6033, '查询操作', '查询按日统计分析数据', '2019-08-15 10:01:17', 1);
INSERT INTO `t_log` VALUES (6034, '查询操作', '查询按日统计分析数据', '2019-08-15 10:01:34', 1);
INSERT INTO `t_log` VALUES (6035, '查询操作', '分页查询商品库存信息', '2019-08-15 10:02:06', 1);
INSERT INTO `t_log` VALUES (6036, '查询操作', '分页查询商品库存信息', '2019-08-15 10:02:15', 1);
INSERT INTO `t_log` VALUES (6037, '查询操作', '查询按日统计分析数据', '2019-08-15 10:02:21', 1);
INSERT INTO `t_log` VALUES (6038, '查询操作', '查询按日统计分析数据', '2019-08-15 10:05:57', 1);
INSERT INTO `t_log` VALUES (6039, '查询操作', '查询按日统计分析数据', '2019-08-15 10:06:25', 1);
INSERT INTO `t_log` VALUES (6040, '登录操作', '登录系统', '2019-08-15 15:13:53', 1);
INSERT INTO `t_log` VALUES (6041, '查询操作', '分页查询商品库存信息', '2019-08-15 15:13:56', 1);
INSERT INTO `t_log` VALUES (6042, '查询操作', '查询按日统计分析数据', '2019-08-15 15:14:10', 1);
INSERT INTO `t_log` VALUES (6043, '查询操作', '查询按日统计分析数据', '2019-08-15 15:14:25', 1);
INSERT INTO `t_log` VALUES (6044, '查询操作', '查询按日统计分析数据', '2019-08-15 15:14:47', 1);
INSERT INTO `t_log` VALUES (6045, '查询操作', '查询按日统计分析数据', '2019-08-15 15:15:12', 1);
INSERT INTO `t_log` VALUES (6046, '查询操作', '查询按月统计分析数据', '2019-08-15 15:15:28', 1);
INSERT INTO `t_log` VALUES (6047, '查询操作', '查询按月统计分析数据', '2019-08-15 15:16:24', 1);
INSERT INTO `t_log` VALUES (6048, '查询操作', '查询按月统计分析数据', '2019-08-15 15:16:45', 1);
INSERT INTO `t_log` VALUES (6049, '查询操作', '查询按月统计分析数据', '2019-08-15 15:17:08', 1);
INSERT INTO `t_log` VALUES (6050, '登录操作', '登录系统', '2019-08-15 15:17:37', 1);
INSERT INTO `t_log` VALUES (6051, '查询操作', '分页查询商品库存信息', '2019-08-15 15:17:39', 1);
INSERT INTO `t_log` VALUES (6052, '查询操作', '查询按日统计分析数据', '2019-08-15 15:17:42', 1);
INSERT INTO `t_log` VALUES (6053, '查询操作', '查询按日统计分析数据', '2019-08-15 15:17:49', 1);
INSERT INTO `t_log` VALUES (6054, '查询操作', '查询按日统计分析数据', '2019-08-15 15:17:59', 1);
INSERT INTO `t_log` VALUES (6055, '查询操作', '查询按月统计分析数据', '2019-08-15 15:18:05', 1);

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu`  (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图片',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `p_id` int(11) NULL DEFAULT NULL COMMENT '父菜单id',
  `menu_state` int(11) NULL DEFAULT NULL COMMENT '菜单状态，1表示目录，0表示结点',
  `menu_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单的链接地址',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6051 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES (1, 'menu-plugin', '系统菜单', -1, 1, NULL);
INSERT INTO `t_menu` VALUES (10, 'menu-1', '进货管理', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (20, 'menu-2', '销售管理', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (30, 'menu-3', '库存管理', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (40, 'menu-4', '统计报表', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (50, 'menu-5', '基础资料', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (60, 'menu-6', '系统管理', 1, 1, NULL);
INSERT INTO `t_menu` VALUES (1010, 'menu-11', '进货入库', 10, 0, '/purchase/purchase.html');
INSERT INTO `t_menu` VALUES (1020, 'menu-12', '退货出库', 10, 0, '/purchase/return.html');
INSERT INTO `t_menu` VALUES (1030, 'menu-13', '进货单据查询', 10, 0, '/purchase/purchaseSearch.html');
INSERT INTO `t_menu` VALUES (1040, 'menu-14', '退货单据查询', 10, 0, '/purchase/returnSearch.html');
INSERT INTO `t_menu` VALUES (1050, 'menu-15', '当前库存查询', 10, 0, '/common/stockSearch.html');
INSERT INTO `t_menu` VALUES (2010, 'menu-21', '销售出库', 20, 0, '/sale/saleout.html');
INSERT INTO `t_menu` VALUES (2020, 'menu-22', '客户退货', 20, 0, '/sale/salereturn.html');
INSERT INTO `t_menu` VALUES (2030, 'menu-23', '销售单据查询', 20, 0, '/sale/saleSearch.html');
INSERT INTO `t_menu` VALUES (2040, 'menu-24', '客户退货查询', 20, 0, '/sale/returnSearch.html');
INSERT INTO `t_menu` VALUES (2050, 'menu-25', '当前库存查询', 20, 0, '/common/stockSearch.html');
INSERT INTO `t_menu` VALUES (3010, 'menu-31', '商品报损', 30, 0, '/stock/damage.html');
INSERT INTO `t_menu` VALUES (3020, 'menu-32', '商品报溢', 30, 0, '/stock/overflow.html');
INSERT INTO `t_menu` VALUES (3030, 'menu-33', '库存报警', 30, 0, '/stock/alarm.html');
INSERT INTO `t_menu` VALUES (3040, 'menu-34', '报损报溢查询', 30, 0, '/stock/damageOverflowSearch.html');
INSERT INTO `t_menu` VALUES (3050, 'menu-35', '当前库存查询', 30, 0, '/common/stockSearch.html');
INSERT INTO `t_menu` VALUES (4010, 'menu-41', '供应商统计', 40, 0, '/count/supplier.html');
INSERT INTO `t_menu` VALUES (4020, 'menu-42', '客户统计', 40, 0, '/count/customer.html');
INSERT INTO `t_menu` VALUES (4030, 'menu-43', '商品采购统计', 40, 0, '/count/purchase.html');
INSERT INTO `t_menu` VALUES (4040, 'menu-44', '商品销售统计', 40, 0, '/count/sale.html');
INSERT INTO `t_menu` VALUES (4050, 'menu-45', '按日统计分析', 40, 0, '/count/saleDay.html');
INSERT INTO `t_menu` VALUES (4060, 'menu-46', '按月统计分析', 40, 0, '/count/saleMonth.html');
INSERT INTO `t_menu` VALUES (5010, 'menu-51', '供应商管理', 50, 0, '/basicData/supplier.html');
INSERT INTO `t_menu` VALUES (5020, 'menu-52', '客户管理', 50, 0, '/basicData/customer.html');
INSERT INTO `t_menu` VALUES (5030, 'menu-53', '商品管理', 50, 0, '/basicData/goods.html');
INSERT INTO `t_menu` VALUES (5040, 'menu-54', '期初库存', 50, 0, '/basicData/stock.html');
INSERT INTO `t_menu` VALUES (6010, 'menu-61', '角色管理', 60, 0, '/power/role.html');
INSERT INTO `t_menu` VALUES (6020, 'menu-62', '用户管理', 60, 0, '/power/user.html');
INSERT INTO `t_menu` VALUES (6030, 'menu-65', '系统日志', 60, 0, '/power/log.html');
INSERT INTO `t_menu` VALUES (6040, 'menu-63', '修改密码', 60, 0, NULL);
INSERT INTO `t_menu` VALUES (6050, 'menu-64', '安全退出', 60, 0, NULL);

-- ----------------------------
-- Table structure for t_overflow_list
-- ----------------------------
DROP TABLE IF EXISTS `t_overflow_list`;
CREATE TABLE `t_overflow_list`  (
  `overflow_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品报溢单id，主键',
  `overflow_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品报溢单号',
  `overflow_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报溢日期',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`overflow_list_id`) USING BTREE,
  INDEX `FK3bu8hj2xniqwbrtg6ls6b8ej2`(`user_id`) USING BTREE,
  CONSTRAINT `t_overflow_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_overflow_list
-- ----------------------------
INSERT INTO `t_overflow_list` VALUES (1, 'BY1550565907039', '2019-02-19', '', 1);
INSERT INTO `t_overflow_list` VALUES (2, 'BY1565491207302', '2019-08-11', 'aaaaa', 1);

-- ----------------------------
-- Table structure for t_overflow_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_overflow_list_goods`;
CREATE TABLE `t_overflow_list_goods`  (
  `overflow_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品报溢单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goods_num` int(11) NULL DEFAULT NULL COMMENT '报溢数量',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `overflow_list_id` int(11) NULL DEFAULT NULL COMMENT '商品报溢单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`overflow_list_goods_id`) USING BTREE,
  INDEX `FKd3s9761mgl456tn2xb0d164h7`(`overflow_list_id`) USING BTREE,
  INDEX `FK20rudkne4kc8uftcenkrng1mn`(`goods_type_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `t_overflow_list_goods_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_overflow_list_goods_ibfk_2` FOREIGN KEY (`overflow_list_id`) REFERENCES `t_overflow_list` (`overflow_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_overflow_list_goods_ibfk_3` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_overflow_list_goods
-- ----------------------------
INSERT INTO `t_overflow_list_goods` VALUES (1, 1, '0001', '陶华碧老干妈香辣脆油辣椒', '红色装', '瓶', 5, 8.5, 42.5, 1, 10);
INSERT INTO `t_overflow_list_goods` VALUES (2, 37, '0027', 'aaa', 'aaa', '户', 10, 20, 200, 2, 17);

-- ----------------------------
-- Table structure for t_purchase_list
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase_list`;
CREATE TABLE `t_purchase_list`  (
  `purchase_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '进货单id，主键',
  `purchase_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '进货单号',
  `amount_paid` float NOT NULL COMMENT '实付金额',
  `amount_payable` float NOT NULL COMMENT '应付金额',
  `purchase_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货日期',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态',
  `supplier_id` int(11) NULL DEFAULT NULL COMMENT '供应商id，外键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`purchase_list_id`) USING BTREE,
  INDEX `supplier_id`(`supplier_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_purchase_list_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `t_supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_purchase_list_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_purchase_list
-- ----------------------------
INSERT INTO `t_purchase_list` VALUES (124, 'JH1550048597876', 86, 86, '2019-02-13', '', 1, 1, 1);
INSERT INTO `t_purchase_list` VALUES (130, 'JH1564882213808', 910, 911, '2019-08-04', 'aaaaa', 1, 1, 1);

-- ----------------------------
-- Table structure for t_purchase_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase_list_goods`;
CREATE TABLE `t_purchase_list_goods`  (
  `purchase_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '进货单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goods_num` int(11) NOT NULL COMMENT '进货数量',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `purchase_list_id` int(11) NULL DEFAULT NULL COMMENT '进货单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`purchase_list_goods_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  INDEX `purchase_list_id`(`purchase_list_id`) USING BTREE,
  INDEX `goods_type_id`(`goods_type_id`) USING BTREE,
  CONSTRAINT `t_purchase_list_goods_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_purchase_list_goods_ibfk_2` FOREIGN KEY (`purchase_list_id`) REFERENCES `t_purchase_list` (`purchase_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_purchase_list_goods_ibfk_3` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_purchase_list_goods
-- ----------------------------
INSERT INTO `t_purchase_list_goods` VALUES (126, 17, '0009', '休闲零食坚果特产精品干果无漂白大个开心果', '240g装', '袋', 4, 20, 80, 124, 11);
INSERT INTO `t_purchase_list_goods` VALUES (127, 16, '0008', '奕森奶油桃肉蜜饯果脯果干桃肉干休闲零食品', '128g装', '盒', 2, 3, 6, 124, 11);
INSERT INTO `t_purchase_list_goods` VALUES (130, 37, '0027', 'aaa', 'aaa', '户', 10, 21.1, 211, 130, 17);
INSERT INTO `t_purchase_list_goods` VALUES (131, 28, '0019', 'Golden Field/金河田 Q8电脑音响台式多媒体家用音箱低音炮重低音', 'Q8', '台', 10, 70, 700, 130, 17);

-- ----------------------------
-- Table structure for t_return_list
-- ----------------------------
DROP TABLE IF EXISTS `t_return_list`;
CREATE TABLE `t_return_list`  (
  `return_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退货单id，主键',
  `return_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货单号',
  `return_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货日期',
  `amount_paid` float NOT NULL COMMENT '实退金额',
  `amount_payable` float NOT NULL COMMENT '应退金额',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态,1表示已退，2表示未退',
  `supplier_id` int(11) NULL DEFAULT NULL COMMENT '供应商id，外键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`return_list_id`) USING BTREE,
  INDEX `FK4qxjj8bvj2etne243xluni0vn`(`supplier_id`) USING BTREE,
  INDEX `FK904juw2v1hm2av0ig26gae9jb`(`user_id`) USING BTREE,
  CONSTRAINT `t_return_list_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `t_supplier` (`supplier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_return_list_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_return_list
-- ----------------------------
INSERT INTO `t_return_list` VALUES (1, 'TH1549940820089', '2019-02-12', 42.5, 42.5, '', 2, 1, 1);

-- ----------------------------
-- Table structure for t_return_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_return_list_goods`;
CREATE TABLE `t_return_list_goods`  (
  `return_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退货单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `goods_num` int(11) NULL DEFAULT NULL COMMENT '商品数量',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `return_list_id` int(11) NULL DEFAULT NULL COMMENT '退货单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`return_list_goods_id`) USING BTREE,
  INDEX `FKemclu281vyvyk063c3foafq1w`(`return_list_id`) USING BTREE,
  INDEX `FKpxnqi9jfkw6wdm1uox2kkr0wk`(`goods_type_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `t_return_list_goods_ibfk_1` FOREIGN KEY (`return_list_id`) REFERENCES `t_return_list` (`return_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_return_list_goods_ibfk_3` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_return_list_goods_ibfk_4` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_return_list_goods
-- ----------------------------
INSERT INTO `t_return_list_goods` VALUES (1, 1, '0001', '陶华碧老干妈香辣脆油辣椒', '红色装', '瓶', 5, 8.5, 42.5, 1, 10);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id，主键',
  `role_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, '系统管理员', '管理员');
INSERT INTO `t_role` VALUES (2, '主管', '主管');
INSERT INTO `t_role` VALUES (4, '采购员', '采购员');
INSERT INTO `t_role` VALUES (5, '销售经理', '销售经理');
INSERT INTO `t_role` VALUES (7, '仓库管理员', '仓库管理员');
INSERT INTO `t_role` VALUES (8, '测试员', '测试员');
INSERT INTO `t_role` VALUES (9, '方法', '啊啊');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu`  (
  `role_menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色-菜单id',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '菜单id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`role_menu_id`) USING BTREE,
  INDEX `FKhayg4ib6v7h1wyeyxhq6xlddq`(`menu_id`) USING BTREE,
  INDEX `FKsonb0rbt2u99hbrqqvv3r0wse`(`role_id`) USING BTREE,
  CONSTRAINT `t_role_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `t_menu` (`menu_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_role_menu_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES (2, 1, 1);
INSERT INTO `t_role_menu` VALUES (3, 10, 1);
INSERT INTO `t_role_menu` VALUES (4, 20, 1);
INSERT INTO `t_role_menu` VALUES (5, 30, 1);
INSERT INTO `t_role_menu` VALUES (6, 40, 1);
INSERT INTO `t_role_menu` VALUES (7, 50, 1);
INSERT INTO `t_role_menu` VALUES (8, 60, 1);
INSERT INTO `t_role_menu` VALUES (9, 1010, 1);
INSERT INTO `t_role_menu` VALUES (10, 1020, 1);
INSERT INTO `t_role_menu` VALUES (11, 1030, 1);
INSERT INTO `t_role_menu` VALUES (12, 1040, 1);
INSERT INTO `t_role_menu` VALUES (13, 1050, 1);
INSERT INTO `t_role_menu` VALUES (14, 2010, 1);
INSERT INTO `t_role_menu` VALUES (15, 2020, 1);
INSERT INTO `t_role_menu` VALUES (16, 2030, 1);
INSERT INTO `t_role_menu` VALUES (17, 2040, 1);
INSERT INTO `t_role_menu` VALUES (18, 2050, 1);
INSERT INTO `t_role_menu` VALUES (19, 3010, 1);
INSERT INTO `t_role_menu` VALUES (20, 3020, 1);
INSERT INTO `t_role_menu` VALUES (21, 3030, 1);
INSERT INTO `t_role_menu` VALUES (22, 3040, 1);
INSERT INTO `t_role_menu` VALUES (23, 3050, 1);
INSERT INTO `t_role_menu` VALUES (24, 4010, 1);
INSERT INTO `t_role_menu` VALUES (25, 4020, 1);
INSERT INTO `t_role_menu` VALUES (26, 4030, 1);
INSERT INTO `t_role_menu` VALUES (27, 4040, 1);
INSERT INTO `t_role_menu` VALUES (28, 4050, 1);
INSERT INTO `t_role_menu` VALUES (29, 4060, 1);
INSERT INTO `t_role_menu` VALUES (30, 5010, 1);
INSERT INTO `t_role_menu` VALUES (31, 5020, 1);
INSERT INTO `t_role_menu` VALUES (32, 5030, 1);
INSERT INTO `t_role_menu` VALUES (33, 5040, 1);
INSERT INTO `t_role_menu` VALUES (34, 6010, 1);
INSERT INTO `t_role_menu` VALUES (35, 6020, 1);
INSERT INTO `t_role_menu` VALUES (43, 6030, 1);
INSERT INTO `t_role_menu` VALUES (44, 6040, 1);
INSERT INTO `t_role_menu` VALUES (45, 1, 4);
INSERT INTO `t_role_menu` VALUES (46, 20, 4);
INSERT INTO `t_role_menu` VALUES (47, 2010, 4);
INSERT INTO `t_role_menu` VALUES (48, 1, 5);
INSERT INTO `t_role_menu` VALUES (49, 30, 5);
INSERT INTO `t_role_menu` VALUES (50, 3010, 5);
INSERT INTO `t_role_menu` VALUES (51, 1, NULL);
INSERT INTO `t_role_menu` VALUES (52, 10, NULL);
INSERT INTO `t_role_menu` VALUES (53, 1010, NULL);
INSERT INTO `t_role_menu` VALUES (54, 1020, NULL);
INSERT INTO `t_role_menu` VALUES (55, 1030, NULL);
INSERT INTO `t_role_menu` VALUES (56, 1040, NULL);
INSERT INTO `t_role_menu` VALUES (57, 1050, NULL);
INSERT INTO `t_role_menu` VALUES (58, 20, NULL);
INSERT INTO `t_role_menu` VALUES (59, 2010, NULL);
INSERT INTO `t_role_menu` VALUES (60, 2020, NULL);
INSERT INTO `t_role_menu` VALUES (61, 2030, NULL);
INSERT INTO `t_role_menu` VALUES (62, 2040, NULL);
INSERT INTO `t_role_menu` VALUES (63, 2050, NULL);
INSERT INTO `t_role_menu` VALUES (64, 6050, 1);
INSERT INTO `t_role_menu` VALUES (65, 1, 7);
INSERT INTO `t_role_menu` VALUES (66, 10, 7);
INSERT INTO `t_role_menu` VALUES (67, 1010, 7);
INSERT INTO `t_role_menu` VALUES (68, 1020, 7);
INSERT INTO `t_role_menu` VALUES (69, 1030, 7);
INSERT INTO `t_role_menu` VALUES (70, 1040, 7);
INSERT INTO `t_role_menu` VALUES (71, 1050, 7);
INSERT INTO `t_role_menu` VALUES (72, 20, 7);
INSERT INTO `t_role_menu` VALUES (73, 2010, 7);
INSERT INTO `t_role_menu` VALUES (74, 2020, 7);
INSERT INTO `t_role_menu` VALUES (75, 2030, 7);
INSERT INTO `t_role_menu` VALUES (76, 40, 7);
INSERT INTO `t_role_menu` VALUES (77, 4010, 7);
INSERT INTO `t_role_menu` VALUES (78, 4020, 7);
INSERT INTO `t_role_menu` VALUES (79, 1, NULL);
INSERT INTO `t_role_menu` VALUES (80, 10, NULL);
INSERT INTO `t_role_menu` VALUES (81, 1010, NULL);
INSERT INTO `t_role_menu` VALUES (82, 1020, NULL);
INSERT INTO `t_role_menu` VALUES (83, 1030, NULL);
INSERT INTO `t_role_menu` VALUES (84, 1040, NULL);
INSERT INTO `t_role_menu` VALUES (85, 1050, NULL);
INSERT INTO `t_role_menu` VALUES (99, 1, 8);
INSERT INTO `t_role_menu` VALUES (100, 50, 8);
INSERT INTO `t_role_menu` VALUES (101, 5010, 8);
INSERT INTO `t_role_menu` VALUES (102, 5020, 8);
INSERT INTO `t_role_menu` VALUES (103, 5030, 8);
INSERT INTO `t_role_menu` VALUES (104, 5040, 8);
INSERT INTO `t_role_menu` VALUES (117, 1, 2);
INSERT INTO `t_role_menu` VALUES (118, 10, 2);
INSERT INTO `t_role_menu` VALUES (119, 1010, 2);
INSERT INTO `t_role_menu` VALUES (120, 1020, 2);
INSERT INTO `t_role_menu` VALUES (121, 1030, 2);
INSERT INTO `t_role_menu` VALUES (122, 1040, 2);
INSERT INTO `t_role_menu` VALUES (123, 1050, 2);
INSERT INTO `t_role_menu` VALUES (124, 60, 2);
INSERT INTO `t_role_menu` VALUES (125, 6030, 2);
INSERT INTO `t_role_menu` VALUES (126, 6040, 2);
INSERT INTO `t_role_menu` VALUES (127, 6050, 2);

-- ----------------------------
-- Table structure for t_sale_list
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_list`;
CREATE TABLE `t_sale_list`  (
  `sale_list_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售单id，主键',
  `sale_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '销售单号',
  `amount_paid` float NOT NULL COMMENT '实付金额',
  `amount_payable` float NOT NULL COMMENT '应付金额',
  `sale_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '销售单创建日期',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT '客户id，外键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id，外键',
  PRIMARY KEY (`sale_list_id`) USING BTREE,
  INDEX `FKox4qfs87eu3fvwdmrvelqhi8e`(`customer_id`) USING BTREE,
  INDEX `FK34bnujemrdqimbhg133enp8k8`(`user_id`) USING BTREE,
  CONSTRAINT `t_sale_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_sale_list_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `t_customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sale_list
-- ----------------------------
INSERT INTO `t_sale_list` VALUES (1, 'XS1550133166343', 127.5, 127.5, '2019-02-14', 1, '', 1, 1);
INSERT INTO `t_sale_list` VALUES (3, 'XS1551175088245', 3040, 3040, '2019-02-26', 1, '', 1, 1);
INSERT INTO `t_sale_list` VALUES (4, 'XS1551232158294', 450, 450, '2019-02-27', 1, '', 3, 1);

-- ----------------------------
-- Table structure for t_sale_list_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_list_goods`;
CREATE TABLE `t_sale_list_goods`  (
  `sale_list_goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售单商品列表id，主键',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品编号id，外键',
  `goods_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品型号',
  `goods_num` int(11) NULL DEFAULT NULL COMMENT '销售数量',
  `goods_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位',
  `price` float NOT NULL COMMENT '商品单价',
  `total` float NOT NULL COMMENT '总金额',
  `sale_list_id` int(11) NULL DEFAULT NULL COMMENT '销售单id，外键',
  `goods_type_id` int(11) NULL DEFAULT NULL COMMENT '商品类别id，外键',
  PRIMARY KEY (`sale_list_goods_id`) USING BTREE,
  INDEX `FK20ehd6ta9geyql4hxtdsnhbox`(`sale_list_id`) USING BTREE,
  INDEX `FK39ej927qf0ldkykafj2nhyu3u`(`goods_type_id`) USING BTREE,
  INDEX `goods_id`(`goods_id`) USING BTREE,
  CONSTRAINT `t_sale_list_goods_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_sale_list_goods_ibfk_2` FOREIGN KEY (`sale_list_id`) REFERENCES `t_sale_list` (`sale_list_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_sale_list_goods_ibfk_3` FOREIGN KEY (`goods_type_id`) REFERENCES `t_goods_type` (`goods_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sale_list_goods
-- ----------------------------
INSERT INTO `t_sale_list_goods` VALUES (1, 1, '0001', '陶华碧老干妈香辣脆油辣椒', '红色装', 15, '瓶', 8.5, 127.5, 1, 10);
INSERT INTO `t_sale_list_goods` VALUES (3, 11, '0003', '野生东北黑木耳', '500g装', 80, '袋', 38, 3040, 3, 11);
INSERT INTO `t_sale_list_goods` VALUES (4, 15, '0007', '吉利人家牛肉味蛋糕', '500g装', 20, '袋', 10, 200, 4, 11);
INSERT INTO `t_sale_list_goods` VALUES (5, 12, '0004', '新疆红枣', '2斤装', 10, '袋', 25, 250, 4, 10);

-- ----------------------------
-- Table structure for t_supplier
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier`  (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商id，主键',
  `supplier_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `contacts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商地址',
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`supplier_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_supplier
-- ----------------------------
INSERT INTO `t_supplier` VALUES (1, '四川耀荣汇商贸有限公司', '张三', '13558873068', '中国四川成都金牛区金泉街道淳风路133号3层附340号', '四川耀荣汇商贸有限公司 经销批发的大枣、山楂、枣夹核、枸杞、农副产品畅销消费者市场');
INSERT INTO `t_supplier` VALUES (4, '四川省郫县豆瓣股份有限公司', '李四', '13888888888', '中国四川成都郫都区中国川菜产业园区永安路333号', '四川省郫县豆瓣股份有限公司，主营“鹃城牌”郫县豆瓣');
INSERT INTO `t_supplier` VALUES (5, '四川食萃食品有限公司', '王五', '13555555555', '中国四川德阳中江县南华镇积水村8社', '四川食萃食品有限公司是一家集餐饮川菜调料研发、生产、销售为一体的现代派企业');
INSERT INTO `t_supplier` VALUES (6, '四川岳老大食品有限责任公司 ', '岳小平', '13981670066', '中国四川巴中巴州区宕梁办事处插旗山村九社', '四川岳老大食品有限责任公司是一家专业从事宾馆、酒店和休闲食品研发、生产销售为一体的现代化民营企业');
INSERT INTO `t_supplier` VALUES (7, '四川天味食品集团股份有限公司', '侯定述', '028-82808141', '中国四川成都双流区西航港街道腾飞一路333号', '中国调味品协会理事单位、农业产业化国家重点龙头企业');
INSERT INTO `t_supplier` VALUES (8, '四川老廖家风味食品有限公司', '廖天发', '18808276999', '中国四川巴中经开区巴州工业园产业大道18号', '公司是集科研、生产、销售为一体的肉类食品加工民营企业');
INSERT INTO `t_supplier` VALUES (9, '山东九日进出口有限公司', '张相志', '0631-5782006', '中国山东威海环翠区张村镇钱江街-16-7号', '公司所有产品均是通过正规通关渠道进口，海关、商检相关手续齐全');
INSERT INTO `t_supplier` VALUES (10, '深圳市朱雀君电子商务有限公司', '陈松鑫', '0755-28500676', '中国广东深圳罗湖区南湖街道东门南路2006号宝丰大厦', '深圳市朱雀君有限公司是一家专业进出口企业，专注于进口食品流通供应链业务，经营全球进口食品');
INSERT INTO `t_supplier` VALUES (11, '绍兴市博创商贸有限公司', '徐晓坚', '0575-88136229', '中国浙江绍兴城南工贸园区3幢一层', '绍兴市博创商贸有限公司是明治,丽芝士,皇冠,宏亚,AJI,张君雅,EGO,等国内外大品牌区域总代,同时还销售各类进口食品,所售食品为原装进口');
INSERT INTO `t_supplier` VALUES (12, '临安高朋食品有限公司', '王仲芳', '0571-61132098', '中国浙江杭州临安市玲珑街道上蟠龙桥2号', '依托上海市场，聚焦在坚果炒货、炭烤海鲜、果脯蜜饯、果干脆片、特色糖果等五大核心领域');

-- ----------------------------
-- Table structure for t_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_unit`;
CREATE TABLE `t_unit`  (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品单位id，主键',
  `unit_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品单位名称',
  PRIMARY KEY (`unit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_unit
-- ----------------------------
INSERT INTO `t_unit` VALUES (1, '元');
INSERT INTO `t_unit` VALUES (6, '户');
INSERT INTO `t_unit` VALUES (7, '斤');
INSERT INTO `t_unit` VALUES (8, '台');
INSERT INTO `t_unit` VALUES (9, '瓶');
INSERT INTO `t_unit` VALUES (10, '袋');
INSERT INTO `t_unit` VALUES (11, '盒');
INSERT INTO `t_unit` VALUES (12, '条');
INSERT INTO `t_unit` VALUES (13, '吨');
INSERT INTO `t_unit` VALUES (14, '个');
INSERT INTO `t_unit` VALUES (15, '件');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id，主键',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `true_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `roles` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `remarks` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', 'admin123', '兰杰', NULL, '管理员');
INSERT INTO `t_user` VALUES (3, 'marry', '123456', '玛丽', '仓库管理员,销售经理,采购员,主管', '销售经理');
INSERT INTO `t_user` VALUES (10, 'gucaini', '123456', '古采尼', '采购员,主管,销售经理', '古大师');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_role_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1, 1, 1);
INSERT INTO `t_user_role` VALUES (29, 2, 3);
INSERT INTO `t_user_role` VALUES (30, 4, 3);
INSERT INTO `t_user_role` VALUES (31, 5, 3);
INSERT INTO `t_user_role` VALUES (32, 7, 3);
INSERT INTO `t_user_role` VALUES (35, 2, 10);
INSERT INTO `t_user_role` VALUES (36, 4, 10);
INSERT INTO `t_user_role` VALUES (37, 5, 10);

SET FOREIGN_KEY_CHECKS = 1;
