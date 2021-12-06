CREATE TABLE `a_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY (`id`),
  `username` varchar(255) NULL,
  `pwd` varchar(255) NULL,
  `regTime` date NULL,
  `lastLoginTime` timestamp(0) NULL

)ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `oauth_client_token`;
CREATE TABLE `oauth_client_token` (
  `token_id` varchar(256) DEFAULT NULL,
  `token` blob,
  `authentication_id` varchar(48) NOT NULL,
  `user_name` varchar(256) DEFAULT NULL,
  `client_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`authentication_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

create table s_user(
id INT(10) not null AUTO_INCREMENT comment "主键ID",
`name` VARCHAR(20) not null comment "用户名",
role_id INT(10) comment "角色ID",
PRIMARY KEY (`id`,`role_id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE `t_role` (
`id` varchar(32) not null comment "主键ID",
`role_name` varchar(60) DEFAULT NULL,
`description` varchar(255) DEFAULT NULL,
`create_time` datetime DEFAULT NULL,
`update_time` datetime DEFAULT NULL,
`status` char(1) NOT NULL,
PRIMARY KEY (`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
insert into `t_role`(`id`,`role_name`,`description`,`create_time`,`update_time`,`status`) values
('1','管理员',NULL,NULL,NULL,'');

