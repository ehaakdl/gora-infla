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

-- 테이블 gora.email_verify 구조 내보내기
CREATE TABLE IF NOT EXISTS `email_verify` (
  `email` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `verified_expire_at` timestamp NULL DEFAULT NULL COMMENT '인증 유효시간',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이메일 인증에 대한 데이터가 담긴다.\r\n1. 이메일 인증 후 유효한 시간\r\n2. 이메일 인증 요청';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.privilege 구조 내보내기
CREATE TABLE IF NOT EXISTS `privilege` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상세권한 명시한다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.role 구조 내보내기
CREATE TABLE IF NOT EXISTS `role` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='권한을 명시한다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.role_privilege 구조 내보내기
CREATE TABLE IF NOT EXISTS `role_privilege` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `role_seq` bigint NOT NULL,
  `privilege_seq` bigint NOT NULL,
  `created_by` bigint NOT NULL DEFAULT '-1',
  `updated_by` bigint NOT NULL DEFAULT '-1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `role_privilege_UN` (`role_seq`,`privilege_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상세권한과 권한의 관계를 명시한다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.social_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `social_user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `social_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '소셜 유형을 의미한다.\r\n\r\n구글(google)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='소셜 가입자에 대한 정보를 담는다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.token 구조 내보내기
CREATE TABLE IF NOT EXISTS `token` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'accessToken을 의미한다.(로그인)',
  `access_expire_at` timestamp NOT NULL,
  `refresh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'refreshToken을 의미한다.(로그인)',
  `user_seq` bigint DEFAULT NULL,
  `email_verify_seq` bigint DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'type 유형\r\n- email_verify\r\n- login',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `access` (`access`),
  UNIQUE KEY `refresh` (`refresh`),
  KEY `token_FK` (`email_verify_seq`),
  CONSTRAINT `token_FK` FOREIGN KEY (`email_verify_seq`) REFERENCES `email_verify` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='type으로 로그인, 이메일 인증을 구분한다.\r\ntype\r\n- login\r\n- email_verify\r\n1. 로그인 가입자 토큰을 담는다.\r\n2. 이메일 인증 토큰을 담는다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'basic(일반), 소셜가입자(social)',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저에대한 정보가 담긴다.\r\n유저 유형\r\n- 소셜가입자\r\n- 일반가입자';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 gora.user_role 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_role` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `role_seq` bigint NOT NULL,
  `user_seq` bigint NOT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `user_role_UN` (`role_seq`,`user_seq`),
  KEY `user_role_FK_1` (`user_seq`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`role_seq`) REFERENCES `role` (`seq`),
  CONSTRAINT `user_role_FK_1` FOREIGN KEY (`user_seq`) REFERENCES `user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='유저가 가지는 권한을 가지는 관계를 명시한다.';

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
