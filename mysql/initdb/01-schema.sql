-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.32 - MySQL Community Server - GPL
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- gora 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `gora` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gora`;

-- gora.email_verify definition

CREATE TABLE `email_verify` (
  `email` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '인증대상 이메일',
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `verified_expire_at` timestamp NULL DEFAULT NULL COMMENT '인증만료기간을 의미한다.',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이메일 인증 요청과 인증 후 만료일에 대한 데이터 담긴다.';


-- gora.`map` definition

CREATE TABLE `map` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `max_x` float NOT NULL COMMENT '맵에 최대 x축크기',
  `max_y` float NOT NULL COMMENT '맵에 최대 y축크기',
  `code` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '클라이언트에서 맵을 식별할 코드다.',
  `created_at` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='맵 정보 담김';


-- gora.privilege definition

CREATE TABLE `privilege` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '상세 권한 화면출력 이름',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '식별용도',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `privilege_pk` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상세권한에 대한 데이터 담긴다.';


-- gora.`role` definition

CREATE TABLE `role` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '화면에 출력되는 이름',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '식별용도',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `role_pk` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='권한에 대한 데이터 담긴다.';


-- gora.server_info definition

CREATE TABLE `server_info` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `min_x` float NOT NULL COMMENT '서버가 할당된 최소 x좌표범위',
  `min_y` float NOT NULL COMMENT '서버가 할당된 최소 y좌표범위',
  `max_x` float NOT NULL COMMENT '서버가 할당된 최대 x좌표범위',
  `max_y` float NOT NULL COMMENT '서버가 할당된 최대 y좌표범위',
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '서버 유형\n- master(마스터서버)\n- slave(슬레이브서버)',
  `tcp_ports` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'tcp 포트 배열를 담는다. \n구분자: ,',
  `udp_ports` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Udp 포트 배열를 담는다. \n구분자: ,',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_connect` tinyint NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL DEFAULT '-1',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `seq_UNIQUE` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='서버 정보';


-- gora.social_user definition

CREATE TABLE `social_user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `social_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유형: 구글(google)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='social 로그인 유저에 대한 데이터 담긴다.';


-- gora.map_obstacle definition

CREATE TABLE `map_obstacle` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `map_seq` int NOT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '장애물 유형',
  `max_x` float NOT NULL COMMENT '장애물 최대 x크기',
  `max_y` float NOT NULL COMMENT '장애물 최대 y크기',
  `map_x_pos` float NOT NULL COMMENT '맵에서 장애물에 x위치',
  `map_y_pos` float NOT NULL COMMENT '맵에서 장애물에 y위치',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL DEFAULT '-1',
  PRIMARY KEY (`seq`),
  KEY `map_obstacle_FK` (`map_seq`),
  CONSTRAINT `map_obstacle_FK` FOREIGN KEY (`map_seq`) REFERENCES `map` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='맵에 대한 장애물 정보 테이블';


-- gora.role_privilege definition

CREATE TABLE `role_privilege` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `role_seq` bigint NOT NULL,
  `privilege_seq` bigint NOT NULL,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL DEFAULT '-1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `role_privilege_UN` (`role_seq`,`privilege_seq`),
  KEY `role_privilege_FK_1` (`privilege_seq`),
  CONSTRAINT `role_privilege_FK` FOREIGN KEY (`role_seq`) REFERENCES `role` (`seq`),
  CONSTRAINT `role_privilege_FK_1` FOREIGN KEY (`privilege_seq`) REFERENCES `privilege` (`seq`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='권한과 상세권한에 연관관계에 대한 데이터 담긴다.';


-- gora.`user` definition

CREATE TABLE `user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유형: basic(일반), 소셜가입자(social)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `social_seq` bigint DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `user_social_user_seq_fk` (`social_seq`),
  CONSTRAINT `user_social_user_seq_fk` FOREIGN KEY (`social_seq`) REFERENCES `social_user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저에 대한 데이터 담긴다.';


-- gora.user_role definition

CREATE TABLE `user_role` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `role_seq` bigint NOT NULL,
  `user_seq` bigint NOT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `user_role_UN` (`role_seq`,`user_seq`),
  KEY `user_role_FK_1` (`user_seq`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`role_seq`) REFERENCES `role` (`seq`),
  CONSTRAINT `user_role_FK_1` FOREIGN KEY (`user_seq`) REFERENCES `user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저와 권한에 연관관계에 대한 데이터 담긴다.';


-- gora.charator definition

CREATE TABLE `charator` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `user_seq` bigint NOT NULL,
  `hp` float NOT NULL COMMENT '현재 체력 상태',
  `max_hp` float NOT NULL COMMENT '최대 hp',
  `map_x` float NOT NULL COMMENT 'map 에서의 케릭터 x 위치',
  `map_y` float NOT NULL COMMENT 'map 에서의 케릭터 y 위치',
  `map_seq` int NOT NULL COMMENT '케릭터가 어떤 맵인지 담는곳',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL DEFAULT '-1',
  PRIMARY KEY (`seq`),
  KEY `charator_FK` (`user_seq`),
  KEY `charator_FK_1` (`map_seq`),
  CONSTRAINT `charator_FK` FOREIGN KEY (`user_seq`) REFERENCES `user` (`seq`),
  CONSTRAINT `charator_FK_1` FOREIGN KEY (`map_seq`) REFERENCES `map` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저에 케릭터 담는 테이블';


-- gora.token definition

CREATE TABLE `token` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'accessToken 을 의미한다.',
  `access_expire_at` timestamp NOT NULL,
  `refresh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'refreshToken 을 의미한다.',
  `user_seq` bigint DEFAULT NULL,
  `email_verify_seq` bigint DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유형: email_verify(이메일 인증), login(로그인), oauth_token(소셜 인증 후 받은 토큰 유형)',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `access` (`access`),
  UNIQUE KEY `refresh` (`refresh`),
  KEY `token_FK` (`email_verify_seq`),
  KEY `token_FK_1` (`user_seq`),
  CONSTRAINT `token_FK` FOREIGN KEY (`email_verify_seq`) REFERENCES `email_verify` (`seq`),
  CONSTRAINT `token_FK_1` FOREIGN KEY (`user_seq`) REFERENCES `user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='토큰에 대한 데이터 담긴다. ex) 이메일 인증, 로그인';

-- gora.user_group definition

CREATE TABLE `user_group` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '그룹이 가지는 유형(나중에 not null 수정할 예정)',
  `created_by` bigint NOT NULL DEFAULT '-1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint NOT NULL DEFAULT '-1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저가 가지는 그룹이 담긴다.';


-- gora.chat_history definition

CREATE TABLE `chat_history` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `sender_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '송신자 이메일',
  `sender_user_seq` bigint NOT NULL COMMENT '송신자 유저번호',
  `receive_group_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수신 그룹이 가지는 유형',
  `receive_user_seq` bigint DEFAULT NULL COMMENT '수신자 유저 번호',
  `receive_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수신자 이메일',
  `receive_gorup_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수신자 그룹 유형',
  `chat_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '채팅 유형\n- DirectMsg(개인)\n- PublicMsg(전체채팅)\n- GroupMsg(그룹채팅)',
  `message` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보낸 메시지',
  `created_by` bigint NOT NULL DEFAULT '-1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` bigint NOT NULL DEFAULT '-1',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seq`),
  KEY `chat_history_FK` (`receive_user_seq`),
  KEY `chat_history_FK_1` (`sender_user_seq`),
  CONSTRAINT `chat_history_FK` FOREIGN KEY (`receive_user_seq`) REFERENCES `user` (`seq`),
  CONSTRAINT `chat_history_FK_1` FOREIGN KEY (`sender_user_seq`) REFERENCES `user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='채팅 내역이 담기는 곳';