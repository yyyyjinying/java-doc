CREATE TABLE `t_user`  (
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
<!-- PRIMARY KEY (id), -->
PRIMARY KEY (`id`,`role_id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;