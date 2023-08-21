-- 일반 유저 권한
INSERT INTO gora.privilege
(seq, display_name, code, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by)
VALUES(1, '일반 유저 상세 권한', 'PRIVILEGE_PUBLIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, -(1), -(1), 0);

INSERT INTO gora.`role`
(seq, display_name, code, created_at, updated_at, deleted_at, created_by, updated_by, deleted_by)
VALUES(1, '일반 유저 권한', 'ROLE_PUBLIC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, -(1), -(1), 0);

INSERT INTO gora.role_privilege
(privilege_seq, role_seq, created_at, updated_at, created_by, updated_by)
VALUES(1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -(1), -(1));