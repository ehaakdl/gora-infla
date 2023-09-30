create database IF NOT EXISTS gora;

use gora;


-- gora.email_verify definition

CREATE TABLE `email_verify` (
  `email` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `verified_expire_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seq`)
);

CREATE TABLE `token` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_expire_at` timestamp NOT NULL,
  `refresh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_seq` bigint DEFAULT NULL,
  `email_verify_seq` bigint DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`seq`)
);

ALTER TABLE `token`
ADD KEY `token_FK` (`email_verify_seq`),
ADD CONSTRAINT `token_FK` FOREIGN KEY (`email_verify_seq`) REFERENCES `email_verify` (`seq`);

-- gora.privilege definition

CREATE TABLE `privilege` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '식별용도',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `privilege_pk` (`code`)
);


-- gora.`role` definition

CREATE TABLE `role` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '식별용도',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `role_pk` (`code`)
);

-- gora.social_user definition

CREATE TABLE `social_user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `social_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '구글(google)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint NOT NULL DEFAULT (-(1)),
  `updated_by` bigint NOT NULL DEFAULT (-(1)),
  `deleted_by` bigint DEFAULT NULL,
  PRIMARY KEY (`seq`)
);




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
  UNIQUE KEY `role_privilege_UN` (`role_seq`,`privilege_seq`)
); 

-- gora.`user` definition

CREATE TABLE `user` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'basic(일반), 소셜가입자(social)',
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
);


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
);

