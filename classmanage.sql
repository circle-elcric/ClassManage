/*
 Navicat Premium Data Transfer

 Source Server         : book
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : classmanage

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 26/05/2022 12:15:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cou_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程号',
  `cname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课程名',
  `credit` int NULL DEFAULT NULL COMMENT '学分',
  `dep_id` int NULL DEFAULT NULL COMMENT '院系号',
  PRIMARY KEY (`cou_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('C01', '数据库原理', 5, 1);
INSERT INTO `course` VALUES ('C02', '操作系统', 4, 1);
INSERT INTO `course` VALUES ('C03', '计算机网络', 4, 1);
INSERT INTO `course` VALUES ('C04', '计算机组成原理', 4, 1);
INSERT INTO `course` VALUES ('C05', '数据结构', 4, 1);
INSERT INTO `course` VALUES ('C06', '通信原理', 5, 3);
INSERT INTO `course` VALUES ('C07', '社会学', 2, 5);
INSERT INTO `course` VALUES ('C08', '软件工程', 4, 1);
INSERT INTO `course` VALUES ('C09', '高等数学', 5, 2);
INSERT INTO `course` VALUES ('C77', '容量上限测试', 1, 1);

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `dep_id` int NOT NULL COMMENT '院系号',
  `dname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '院系名称',
  `adr` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `tel` int NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`dep_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '计算机学院', '东区计算机大楼', 25125124);
INSERT INTO `department` VALUES (2, '理学院', '宝山校区理学院楼', 42524124);
INSERT INTO `department` VALUES (3, '通信学院', '东区通信大楼', NULL);
INSERT INTO `department` VALUES (4, '机电学院', '东区机电大楼', NULL);
INSERT INTO `department` VALUES (5, '文学院', '东区文学院楼', NULL);
INSERT INTO `department` VALUES (6, '经管学院', '东区经管大楼', NULL);

-- ----------------------------
-- Table structure for electclass
-- ----------------------------
DROP TABLE IF EXISTS `electclass`;
CREATE TABLE `electclass`  (
  `stu_id` int NOT NULL COMMENT '学号',
  `cou_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程号',
  `tea_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师号',
  `cj` int NULL DEFAULT NULL COMMENT '成绩',
  `point` float NULL DEFAULT NULL COMMENT '绩点',
  PRIMARY KEY (`cou_id`, `tea_id`, `stu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '选课表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of electclass
-- ----------------------------
INSERT INTO `electclass` VALUES (22001, 'C01', 'T02', 60, 1);
INSERT INTO `electclass` VALUES (22011, 'C01', 'T02', 60, 1);
INSERT INTO `electclass` VALUES (22013, 'C01', 'T02', 60, 1);
INSERT INTO `electclass` VALUES (22001, 'C02', 'T03', 80, 3);
INSERT INTO `electclass` VALUES (22011, 'C02', 'T03', 60, 1);
INSERT INTO `electclass` VALUES (22013, 'C02', 'T03', 90, 4);
INSERT INTO `electclass` VALUES (22001, 'C03', 'T03', NULL, NULL);
INSERT INTO `electclass` VALUES (22011, 'C03', 'T03', NULL, NULL);
INSERT INTO `electclass` VALUES (22001, 'C04', 'T04', NULL, NULL);
INSERT INTO `electclass` VALUES (22011, 'C04', 'T04', NULL, NULL);
INSERT INTO `electclass` VALUES (22001, 'C05', 'T02', 80, 3);
INSERT INTO `electclass` VALUES (22011, 'C05', 'T02', NULL, NULL);
INSERT INTO `electclass` VALUES (22001, 'C07', 'T06', NULL, NULL);

-- ----------------------------
-- Table structure for openclass
-- ----------------------------
DROP TABLE IF EXISTS `openclass`;
CREATE TABLE `openclass`  (
  `cou_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程号',
  `tea_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '开课教师号',
  `xq` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开课学期(秋、冬、春)',
  `time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '开课时间（星期几-节数）',
  `stunum` int NULL DEFAULT NULL COMMENT '选课人数',
  `uplim` int NULL DEFAULT NULL COMMENT '选课人数上限',
  PRIMARY KEY (`cou_id`, `tea_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of openclass
-- ----------------------------
INSERT INTO `openclass` VALUES ('C01', 'T02', '秋季学期', '一1-2', 0, 50);
INSERT INTO `openclass` VALUES ('C02', 'T03', '秋季学期', '二1-2', 0, 50);
INSERT INTO `openclass` VALUES ('C03', 'T03', '冬季学期\n', '四3-4', 0, 40);
INSERT INTO `openclass` VALUES ('C04', 'T04', '春季学期', '一7-8', 0, 40);
INSERT INTO `openclass` VALUES ('C05', 'T02', '秋季学期', '一5-6', 0, 60);
INSERT INTO `openclass` VALUES ('C06', 'T05', '春季学期', '一1-2', 0, 50);
INSERT INTO `openclass` VALUES ('C07', 'T06', '秋季学期', '四7-8', 0, 40);
INSERT INTO `openclass` VALUES ('C08', 'T04', '春季学期', '一1-2', 0, 30);
INSERT INTO `openclass` VALUES ('C09', 'T07', '秋季学期', '一1-2', 0, 40);
INSERT INTO `openclass` VALUES ('C77', 'T04', '秋季学期', '一7-8', 0, 1);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `stu_id` int NOT NULL AUTO_INCREMENT COMMENT '学号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `dep_id` int NULL DEFAULT NULL COMMENT '院系号',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账号',
  `passwd` int NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`stu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 998293508 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (22001, '小红', '女', 1, 'xiaohong', 22001);
INSERT INTO `student` VALUES (22002, '小明', '男', 2, 'xiaoming', 22002);
INSERT INTO `student` VALUES (22003, '小杨', '男', 3, 'xiaoyang', 22003);
INSERT INTO `student` VALUES (22004, '小张', '女', 1, 'xiaozhang', 22004);
INSERT INTO `student` VALUES (22005, '张三', '男', 1, 'zhangsan', 22005);
INSERT INTO `student` VALUES (22006, '李四', '男', 2, 'lisi', 22006);
INSERT INTO `student` VALUES (22007, '王五', '男', 4, 'wamgwu', 22007);
INSERT INTO `student` VALUES (22008, '赵六', '男', 5, 'zhaoliu', 22008);
INSERT INTO `student` VALUES (22009, '小雷', '女', 5, 'lei', 22009);
INSERT INTO `student` VALUES (22010, '小连', '男', 4, 'lian', 22010);
INSERT INTO `student` VALUES (22011, '小李', '女', 2, 'li', 22011);
INSERT INTO `student` VALUES (22012, '小卓', '男', 3, 'zhuo', 22012);
INSERT INTO `student` VALUES (22013, '小丁', '女', 3, 'ding', 22013);
INSERT INTO `student` VALUES (22014, '小文', '女', 4, 'wen', 22014);
INSERT INTO `student` VALUES (22015, '小万', '女', 5, 'wan', 22015);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `tea_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师号',
  `tname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '教师名',
  `dep_id` int NULL DEFAULT NULL COMMENT '学院号',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账户名',
  `passwd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色（教师/管理员）',
  PRIMARY KEY (`tea_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('T01', '管理员', 1, 'admin', '123', '管理员');
INSERT INTO `teacher` VALUES ('T02', '谢希仁', 1, 'xie', '123', '教师');
INSERT INTO `teacher` VALUES ('T03', '汤小丹', 1, 'tangxiaodan', '123', '教师');
INSERT INTO `teacher` VALUES ('T04', '白中英', 1, 'baizhongying', '123', '教师');
INSERT INTO `teacher` VALUES ('T05', '朴灵', 3, 'puling', '123', '教师');
INSERT INTO `teacher` VALUES ('T06', '毛法宪', 5, 'maofaxian', '123', '教师');
INSERT INTO `teacher` VALUES ('T07', '宋浩', 2, 'songhao', '123', '教师');

-- ----------------------------
-- Procedure structure for update_point
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_point`;
delimiter ;;
CREATE PROCEDURE `update_point`()
BEGIN
	DECLARE nodata INT DEFAULT 0 ;
	
	DECLARE sid int;
	DECLARE cid VARCHAR(10);
	DECLARE tid VARCHAR(10);
	DECLARE point float;
	DECLARE grade int;
	DECLARE t CURSOR FOR
		SELECT stu_id,cou_id,tea_id,cj from electclass;
	DECLARE EXIT HANDLER FOR NOT FOUND 
		SET nodata = 1 ; -- 当读到数据的最后一条时,设置变量为1 
	OPEN t;
	WHILE nodata=0 DO
	FETCH t INTO sid,cid,tid,grade;
	IF grade>=90 THEN
		UPDATE electclass set point=4.0 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=85 THEN
		UPDATE electclass set point=3.7 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=83 THEN
		UPDATE electclass set point=3.3 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=78 THEN
		UPDATE electclass set point=3.0 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=76 THEN
		UPDATE electclass set point=2.7 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=73 THEN
		UPDATE electclass set point=2.3 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=69 THEN
		UPDATE electclass set point=2.0 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=67 THEN
		UPDATE electclass set point=1.7 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=65 THEN
		UPDATE electclass set point=1.5 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade>=60 THEN
		UPDATE electclass set point=1 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	ELSEIF grade!=NULL THEN
		UPDATE electclass set point=0 WHERE stu_id=sid AND cou_id=cid AND tea_id=tid;
	END IF;
END WHILE;
	CLOSE t;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for update_point
-- ----------------------------
DROP EVENT IF EXISTS `update_point`;
delimiter ;;
CREATE EVENT `update_point`
ON SCHEDULE
EVERY '2' SECOND STARTS '2022-05-26 10:52:39'
DO CALL update_point()
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table electclass
-- ----------------------------
DROP TRIGGER IF EXISTS `limitstunum`;
delimiter ;;
CREATE TRIGGER `limitstunum` BEFORE INSERT ON `electclass` FOR EACH ROW BEGIN
	DECLARE C INTEGER;
	DECLARE S INTEGER;
	SELECT stunum INTO C FROM openclass WHERE cou_id = NEW.cou_id AND tea_id = NEW.tea_id;
	SELECT uplim INTO S FROM openclass WHERE cou_id = NEW.cou_id AND tea_id = NEW.tea_id;
	IF C >= S
		THEN 
		SIGNAL SQLSTATE '45000' SET message_text= "超出人数限制，选课失败";
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table electclass
-- ----------------------------
DROP TRIGGER IF EXISTS `updatestunum`;
delimiter ;;
CREATE TRIGGER `updatestunum` AFTER INSERT ON `electclass` FOR EACH ROW BEGIN	
	UPDATE openclass
			SET stunum = stunum + 1 WHERE NEW.cou_id = cou_id AND NEW.tea_id = tea_id;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table electclass
-- ----------------------------
DROP TRIGGER IF EXISTS `updatestunum2`;
delimiter ;;
CREATE TRIGGER `updatestunum2` AFTER DELETE ON `electclass` FOR EACH ROW BEGIN
	UPDATE openclass
			SET stunum = stunum - 1 WHERE OLD.cou_id = cou_id AND OLD.tea_id = tea_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teacher
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_teacher`;
delimiter ;;
CREATE TRIGGER `delete_teacher` AFTER DELETE ON `teacher` FOR EACH ROW BEGIN 
DELETE 
FROM openclass
WHERE tea_id = old.tea_id;
DELETE 
FROM electclass
WHERE cj!=NULL AND tea_id = old.tea_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
