create database IF NOT EXISTS gora;

use gora;

create table privilege
(
    seq          bigint auto_increment
        primary key,
    display_name varchar(255)                        not null,
    code         varchar(255)                        not null comment '식별용도',
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    updated_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    created_by   bigint    default (-(1))            not null,
    updated_by   bigint    default (-(1))            not null,
    deleted_by   bigint                              null,
    constraint privilege_pk
        unique (code)
);

create table role
(
    seq          bigint auto_increment
        primary key,
    display_name varchar(255)                        null,
    code         varchar(255)                        not null comment '식별용도',
    created_at   timestamp default CURRENT_TIMESTAMP not null,
    updated_at   timestamp default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp                           null,
    created_by   bigint    default (-(1))            not null,
    updated_by   bigint    default (-(1))            not null,
    deleted_by   bigint                              null,
    constraint role_pk
        unique (code)
);

create table role_privilege
(
    privilege_seq bigint                              not null,
    role_seq      bigint                              not null,
    created_at    timestamp default CURRENT_TIMESTAMP not null,
    updated_at    timestamp default CURRENT_TIMESTAMP not null,
    created_by    bigint    default (-(1))            not null,
    updated_by    bigint    default (-(1))            not null,
    primary key (privilege_seq, role_seq),
    constraint role_privilege_privilege_seq_fk
        foreign key (privilege_seq) references privilege (seq),
    constraint role_privilege_role_seq_fk
        foreign key (role_seq) references role (seq)
);

create table social_user
(
    seq         bigint auto_increment
        primary key,
    social_type varchar(20)                         not null comment '구글(google)',
    created_at  timestamp default CURRENT_TIMESTAMP null,
    updated_at  timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    deleted_at  timestamp                           null,
    created_by  bigint    default (-(1))            not null,
    updated_by  bigint    default (-(1))            not null,
    deleted_by  bigint                              null
);

create table token
(
    seq              bigint auto_increment
        primary key,
    access           varchar(255) not null,
    access_expire_at timestamp    not null,
    refresh          varchar(255) not null,
    user_seq         bigint       not null
);

create table user
(
    seq        bigint auto_increment
        primary key,
    email      varchar(255)                         not null,
    password   varchar(255)                         null,
    type       varchar(20)                          not null comment 'basic(일반), 소셜가입자(social)',
    created_at timestamp  default CURRENT_TIMESTAMP not null,
    updated_at timestamp  default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                            null,
    social_seq bigint                               null,
    disable    tinyint(1) default 0                 null,
    created_by bigint     default (-(1))            not null,
    updated_by bigint     default (-(1))            not null,
    deleted_by bigint                               null,
    constraint user_social_user_seq_fk
        foreign key (social_seq) references social_user (seq)
);

-- todo 기본키 컬럼 추가하기
CREATE TABLE `user_role` (
  `seq` bigint NOT NULL AUTO_INCREMENT,
  `role_seq` bigint NOT NULL,
  `user_seq` bigint NOT NULL,
  PRIMARY KEY (`seq`),
  UNIQUE KEY `user_role_UN` (`role_seq`,`user_seq`),
  KEY `user_role_FK_1` (`user_seq`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`role_seq`) REFERENCES `role` (`seq`),
  CONSTRAINT `user_role_FK_1` FOREIGN KEY (`user_seq`) REFERENCES `user` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


