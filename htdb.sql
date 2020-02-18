/*
Navicat MySQL Data Transfer

Source Server         : wgs
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : htdb

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2020-02-17 14:29:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `class`
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `Classid` varchar(3) NOT NULL,
  `Classname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Classid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('001', '手机');

-- ----------------------------
-- Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `Coid` varchar(9) NOT NULL,
  `Cotime` char(12) NOT NULL,
  `Cototal` decimal(12,2) NOT NULL,
  `Cstatus` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cid` varchar(6) DEFAULT NULL,
  `Sid` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`Coid`),
  KEY `fk_cc` (`Cid`),
  KEY `fk_cs` (`Sid`),
  CONSTRAINT `fk_cc` FOREIGN KEY (`Cid`) REFERENCES `customer` (`cid`),
  CONSTRAINT `fk_cs` FOREIGN KEY (`Sid`) REFERENCES `staff` (`Sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES ('000000001', '201811291441', '29998.00', '未审核', '000001', '000001');
INSERT INTO `contract` VALUES ('000000002', '201811291444', '44440.00', '已审核', '000001', null);
INSERT INTO `contract` VALUES ('000000003', '201811291742', '62776.00', '已审核', '000002', null);

-- ----------------------------
-- Table structure for `cp`
-- ----------------------------
DROP TABLE IF EXISTS `cp`;
CREATE TABLE `cp` (
  `Coid` varchar(9) NOT NULL,
  `Pid` varchar(9) NOT NULL,
  `Num` int(11) NOT NULL,
  PRIMARY KEY (`Coid`,`Pid`),
  KEY `fk_cpp` (`Pid`),
  CONSTRAINT `fk_cpc` FOREIGN KEY (`Coid`) REFERENCES `contract` (`coid`),
  CONSTRAINT `fk_cpp` FOREIGN KEY (`Pid`) REFERENCES `product` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cp
-- ----------------------------
INSERT INTO `cp` VALUES ('000000001', '000000002', '2');
INSERT INTO `cp` VALUES ('000000002', '000000003', '5');
INSERT INTO `cp` VALUES ('000000003', '000000003', '2');

-- ----------------------------
-- Table structure for `cpl`
-- ----------------------------
DROP TABLE IF EXISTS `cpl`;
CREATE TABLE `cpl` (
  `Coid` varchar(9) NOT NULL,
  `Pid` varchar(9) NOT NULL,
  `Delivernum` int(11) NOT NULL,
  `Lid` varchar(9) NOT NULL,
  PRIMARY KEY (`Coid`,`Pid`,`Lid`),
  KEY `fk_cplp` (`Pid`),
  KEY `fk_cpll` (`Lid`),
  CONSTRAINT `fk_cplc` FOREIGN KEY (`Coid`) REFERENCES `contract` (`coid`),
  CONSTRAINT `fk_cpll` FOREIGN KEY (`Lid`) REFERENCES `logistics` (`lid`),
  CONSTRAINT `fk_cplp` FOREIGN KEY (`Pid`) REFERENCES `product` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cpl
-- ----------------------------
INSERT INTO `cpl` VALUES ('000000001', '000000002', '2', '000000005');
INSERT INTO `cpl` VALUES ('000000002', '000000003', '5', '000000003');
INSERT INTO `cpl` VALUES ('000000003', '000000003', '2', '000000004');

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `Cid` varchar(6) NOT NULL,
  `Carea` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Clocation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Clevel` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cpeople` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Cphone` varchar(15) NOT NULL,
  `Cemail` varchar(30) NOT NULL,
  `Cpostcode` varchar(10) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cid`),
  KEY `fk_cu` (`Username`),
  CONSTRAINT `fk_cu` FOREIGN KEY (`Username`) REFERENCES `login` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('000001', '东莞', '寮步', '苏宁易购', '3', '张三', '12456899777', '123463532@qq.com', '516300', null);
INSERT INTO `customer` VALUES ('000002', '东莞', '寮步', '京东', '1', '张三', '12432234343', '1232342221@qq.com', '516300', null);
INSERT INTO `customer` VALUES ('000003', '浙江', '杭州', '淘宝', '4', '张三', '12432435341', '1232432531@qq.com', '516300', null);

-- ----------------------------
-- Table structure for `login`
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `Username` varchar(50) NOT NULL,
  `Passcode` char(64) NOT NULL,
  `Isadmin` bit(1) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of login
-- ----------------------------
INSERT INTO `login` VALUES ('123', '123', '');
INSERT INTO `login` VALUES ('1234', '1234', '');
INSERT INTO `login` VALUES ('201535020333', '201535020333', '');
INSERT INTO `login` VALUES ('admin', '123', '');
INSERT INTO `login` VALUES ('root', 'root', '');

-- ----------------------------
-- Table structure for `logistics`
-- ----------------------------
DROP TABLE IF EXISTS `logistics`;
CREATE TABLE `logistics` (
  `Lid` varchar(9) NOT NULL,
  `Ltime` char(12) NOT NULL,
  `Lcompany` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Lcode` varchar(20) NOT NULL,
  PRIMARY KEY (`Lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logistics
-- ----------------------------
INSERT INTO `logistics` VALUES ('000000001', '201811012211', '申通', '123456789876543');
INSERT INTO `logistics` VALUES ('000000002', '201811012211', '申通', '1213433211232');
INSERT INTO `logistics` VALUES ('000000003', '201812202020', '顺风', '1037412365192');
INSERT INTO `logistics` VALUES ('000000004', '201811012211', '顺风', '1213433211232');
INSERT INTO `logistics` VALUES ('000000005', '201811012211', '申通', '1037412365192');

-- ----------------------------
-- Table structure for `product`
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `Pid` varchar(9) NOT NULL,
  `Pname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Pmodel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Punit` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Pprice` decimal(10,2) NOT NULL,
  `Pnumber` int(11) NOT NULL,
  `Supplierid` varchar(3) DEFAULT NULL,
  `Classid` varchar(3) DEFAULT NULL,
  `Wid` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`Pid`),
  KEY `fk_pc` (`Classid`),
  KEY `fk_ps` (`Supplierid`),
  KEY `fk_pw` (`Wid`),
  CONSTRAINT `fk_pc` FOREIGN KEY (`Classid`) REFERENCES `class` (`classid`),
  CONSTRAINT `fk_ps` FOREIGN KEY (`Supplierid`) REFERENCES `supplier` (`supplierid`),
  CONSTRAINT `fk_pw` FOREIGN KEY (`Wid`) REFERENCES `warehouse` (`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('000000002', '华为', 'mate20pro', '个', '5999.00', '998', null, '001', '002');
INSERT INTO `product` VALUES ('000000003', 'r17', 'r17', '个', '8888.00', '29993', '003', null, null);
INSERT INTO `product` VALUES ('000000004', 'iPhone', 'xs', '个', '9000.00', '999', '001', '001', '001');

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `Sid` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Sname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Ssex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Sphone` varchar(15) NOT NULL,
  `Sduty` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Slocation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Sstatus` bit(1) NOT NULL,
  `Stime` char(8) NOT NULL,
  `Sdept` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Sid`),
  KEY `fk_su` (`Username`),
  CONSTRAINT `fk_su` FOREIGN KEY (`Username`) REFERENCES `login` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('000001', '翁某某', '男', '1234567832', '员工', '东莞', '', '20180908', '批发部', null);

-- ----------------------------
-- Table structure for `supplier`
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `Supplierid` varchar(3) NOT NULL,
  `Suppliername` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('001', 'apple');
INSERT INTO `supplier` VALUES ('003', 'oppo');

-- ----------------------------
-- Table structure for `warehouse`
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `Wid` varchar(3) NOT NULL,
  `Wname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Wlocation` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Wpeople` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Wphone` varchar(15) NOT NULL,
  PRIMARY KEY (`Wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES ('001', '仓库1', '东莞', '翁某某', '12345678999');
INSERT INTO `warehouse` VALUES ('002', '仓库2', '北京', '黄某某', '1231432432');
