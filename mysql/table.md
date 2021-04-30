CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY (`id`),
  `username` varchar(255) NULL,
  `pwd` varchar(255) NULL,
  `regTime` date NULL,
  `lastLoginTime` timestamp(0) NULL
)ENGINE=MyISAM DEFAULT CHARSET=utf8;