SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

drop table if exists `customisation_authors`;

CREATE TABLE `customisation_authors` (
  `author_id` mediumint(8) unsigned NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `phpbb_user_id` mediumint(8) unsigned NOT NULL default '0',
  `author_username` varchar(255) collate utf8_bin NOT NULL,
  `author_username_clean` varchar(255) collate utf8_bin NOT NULL,
  `author_realname` varchar(255) collate utf8_bin NOT NULL,
  `author_website` varchar(200) collate utf8_bin NOT NULL,
  `author_email` varchar(100) collate utf8_bin NOT NULL,
  `author_email_hash` bigint(20) NOT NULL default '0',
  `author_rating` decimal(11,9) unsigned NOT NULL default '0.000000000',
  `author_rating_count` mediumint(8) unsigned NOT NULL default '0',
  `author_contribs` mediumint(8) unsigned NOT NULL default '0',
  `author_snippets` mediumint(8) unsigned NOT NULL default '0',
  `author_mods` mediumint(8) unsigned NOT NULL default '0',
  `author_styles` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`author_id`),
  KEY `user_id` (`user_id`),
  KEY `author_email_hash` (`author_email_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_authors` values('2','2','165089','Highway of Life','highway of life','David Lewis','http://startrekguide.com','highwayoflife@gmail.com','175420516723','0.000000000','0','1','0','1','0');

drop table if exists `customisation_contrib_tags`;

CREATE TABLE `customisation_contrib_tags` (
  `contrib_id` mediumint(8) unsigned NOT NULL default '0',
  `tag_id` mediumint(8) unsigned NOT NULL default '0',
  `tag_value` varchar(255) collate utf8_bin NOT NULL,
  PRIMARY KEY  (`contrib_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  KEY `contrib_id` (`contrib_id`),
  CONSTRAINT `fk_tags_contrib_id` FOREIGN KEY (`contrib_id`) REFERENCES `customisation_contribs` (`contrib_id`),
  CONSTRAINT `fk_tags_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `customisation_tag_fields` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_contrib_tags` values('1','2','');

drop table if exists `customisation_contribs`;

CREATE TABLE `customisation_contribs` (
  `contrib_id` mediumint(8) unsigned NOT NULL auto_increment,
  `contrib_type` tinyint(1) unsigned NOT NULL default '1',
  `contrib_name` varchar(255) collate utf8_bin NOT NULL,
  `contrib_description` mediumtext collate utf8_bin NOT NULL,
  `contrib_desc_bitfield` varchar(255) collate utf8_bin NOT NULL,
  `contrib_desc_options` int(11) unsigned NOT NULL default '7',
  `contrib_desc_uid` varchar(8) collate utf8_bin NOT NULL,
  `contrib_status` tinyint(2) unsigned NOT NULL default '0',
  `contrib_version` varchar(15) collate utf8_bin NOT NULL,
  `contrib_revision` mediumint(8) unsigned NOT NULL default '0',
  `contrib_validated_revision` mediumint(8) unsigned NOT NULL default '0',
  `contrib_author_id` mediumint(8) unsigned NOT NULL default '0',
  `contrib_maintainer` mediumint(8) unsigned NOT NULL default '0',
  `contrib_downloads` mediumint(8) unsigned NOT NULL default '0',
  `contrib_views` mediumint(8) unsigned NOT NULL default '0',
  `contrib_phpbb_version` tinyint(2) unsigned NOT NULL default '0',
  `contrib_release_date` int(11) unsigned NOT NULL default '0',
  `contrib_update_date` int(11) unsigned NOT NULL default '0',
  `contrib_visibility` tinyint(1) unsigned NOT NULL default '0',
  `contrib_rating` decimal(11,9) unsigned NOT NULL default '0.000000000',
  `contrib_rating_count` mediumint(8) unsigned NOT NULL default '0',
  `contrib_demo` varchar(255) collate utf8_bin NOT NULL,
  PRIMARY KEY  (`contrib_id`),
  KEY `contrib_author_id` (`contrib_author_id`),
  KEY `contrib_status` (`contrib_status`),
  KEY `contrib_visibility` (`contrib_visibility`),
  KEY `contrib_phpbb_version` (`contrib_phpbb_version`),
  KEY `contrib_rating` (`contrib_rating`),
  KEY `contrib_downloads` (`contrib_downloads`),
  KEY `contrib_id` (`contrib_id`),
  CONSTRAINT `fk_author_id` FOREIGN KEY (`contrib_author_id`) REFERENCES `customisation_authors` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_contribs` values('1','1','ACP Add User MOD',0x416464732061206e6577204d6f64756c65207468617420656e61626c657320616e2041646d696e6973747261746f7220746f206372656174652061206e65772075736572206163636f756e74207468726f756768207468652041646d696e697374726174696f6e20436f6e74726f6c2050616e656c2028414350292e0a4164647320616e206578747261207065726d697373696f6e20746f20616c6c6f772061646d696e6973747261746f7220746f206372656174652061206e65772075736572206163636f756e742e0a4769766573207468652061646d696e6973747261746f7220746865206162696c69747920746f20696e7374616e746c7920617070726f76652061206e6577206d656d626572206166746572206372656174696f6e2e,'','7','','1','1.0.1','1','1','2','0','5','20','3','1220301000','0','1','0.000000000','0','');

drop table if exists `customisation_downloads`;

CREATE TABLE `customisation_downloads` (
  `download_id` mediumint(8) unsigned NOT NULL auto_increment,
  `revision_id` mediumint(8) unsigned NOT NULL default '0',
  `download_type` tinyint(1) unsigned NOT NULL default '0',
  `download_status` tinyint(1) unsigned NOT NULL default '0',
  `filesize` int(11) unsigned NOT NULL default '0',
  `filetime` int(11) unsigned NOT NULL default '0',
  `physical_filename` varchar(255) collate utf8_bin NOT NULL,
  `real_filename` varchar(255) collate utf8_bin NOT NULL,
  `download_count` mediumint(8) unsigned NOT NULL default '0',
  `extension` varchar(100) collate utf8_bin NOT NULL,
  `mimetype` varchar(100) collate utf8_bin NOT NULL,
  `download_hash` varchar(32) collate utf8_bin NOT NULL,
  `download_url` varchar(255) collate utf8_bin NOT NULL,
  `thumbnail` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`download_id`),
  KEY `revision_id` (`revision_id`),
  KEY `download_type` (`download_type`),
  CONSTRAINT `fk_download_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `customisation_revisions` (`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


drop table if exists `customisation_queue`;

CREATE TABLE `customisation_queue` (
  `queue_id` mediumint(8) unsigned NOT NULL auto_increment,
  `revision_id` mediumint(8) unsigned NOT NULL default '0',
  `queue_type` tinyint(1) unsigned NOT NULL default '0',
  `queue_status` tinyint(1) unsigned NOT NULL default '0',
  `topic_id` mediumint(8) unsigned NOT NULL default '0',
  `contrib_id` mediumint(8) unsigned NOT NULL default '0',
  `submitter_user_id` mediumint(8) unsigned NOT NULL default '0',
  `queue_notes` mediumtext collate utf8_bin NOT NULL,
  `queue_notes_bitfield` varchar(255) collate utf8_bin NOT NULL,
  `queue_notes_options` int(11) unsigned NOT NULL default '0',
  `queue_notes_uid` varchar(8) collate utf8_bin NOT NULL,
  `queue_progress` tinyint(3) unsigned NOT NULL default '0',
  `queue_submit_time` int(11) unsigned NOT NULL default '0',
  `queue_close_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`queue_id`),
  KEY `topic_id` (`topic_id`),
  KEY `contrib_id` (`contrib_id`),
  KEY `queue_type` (`queue_type`),
  KEY `queue_status` (`queue_status`),
  KEY `revision_id` (`revision_id`),
  KEY `submitter_user_id` (`submitter_user_id`),
  KEY `queue_id` (`queue_id`),
  CONSTRAINT `fk_queue_contrib_id` FOREIGN KEY (`contrib_id`) REFERENCES `customisation_contribs` (`contrib_id`),
  CONSTRAINT `fk_queue_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `customisation_revisions` (`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


drop table if exists `customisation_queue_history`;

CREATE TABLE `customisation_queue_history` (
  `history_id` mediumint(8) unsigned NOT NULL auto_increment,
  `queue_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`history_id`),
  KEY `queue_id` (`queue_id`),
  CONSTRAINT `fk_history_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `customisation_queue` (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


drop table if exists `customisation_reviews`;

CREATE TABLE `customisation_reviews` (
  `review_id` mediumint(8) unsigned NOT NULL auto_increment,
  `contrib_id` mediumint(8) unsigned NOT NULL default '0',
  `review_text` mediumtext collate utf8_bin NOT NULL,
  `review_text_bitfield` varchar(255) collate utf8_bin NOT NULL,
  `review_text_uid` varchar(8) collate utf8_bin NOT NULL,
  `review_text_options` int(11) unsigned NOT NULL default '7',
  `review_rating` tinyint(1) unsigned NOT NULL default '3',
  `review_user_id` mediumint(8) unsigned NOT NULL default '0',
  `review_status` tinyint(1) unsigned NOT NULL default '1',
  `review_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`review_id`),
  KEY `review_user_id` (`review_user_id`),
  KEY `review_status` (`review_status`),
  KEY `contrib_id` (`contrib_id`),
  CONSTRAINT `fk_review_contrib_id` FOREIGN KEY (`contrib_id`) REFERENCES `customisation_contribs` (`contrib_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


drop table if exists `customisation_revisions`;

CREATE TABLE `customisation_revisions` (
  `revision_id` mediumint(8) unsigned NOT NULL auto_increment,
  `contrib_id` mediumint(8) unsigned NOT NULL default '0',
  `contrib_type` tinyint(1) unsigned NOT NULL default '0',
  `revision_name` varchar(100) collate utf8_bin NOT NULL,
  `revision_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`revision_id`),
  KEY `contrib_id` (`contrib_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_revisions` values('1','1','1','1.0.0','1220301000');

drop table if exists `customisation_tag_fields`;

CREATE TABLE `customisation_tag_fields` (
  `tag_id` mediumint(8) unsigned NOT NULL auto_increment,
  `tag_type_id` mediumint(8) unsigned NOT NULL default '0',
  `tag_field_name` varchar(100) collate utf8_bin NOT NULL,
  `tag_field_desc` varchar(255) collate utf8_bin NOT NULL,
  `tag_clean_name` varchar(100) collate utf8_bin NOT NULL,
  PRIMARY KEY  (`tag_id`),
  KEY `tag_type_id` (`tag_type_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `fk_tag_type_id` FOREIGN KEY (`tag_type_id`) REFERENCES `customisation_tag_types` (`tag_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_tag_fields` values('1','1','Add-ons','Add-on MOds','add-ons'),
 ('2','1','ACP Modules','Administration Control Panel Module','acp modules'),
 ('3','1','MCP Modules','Moderator Control Panel Module','mcp modules'),
 ('4','1','UCP Modules','User Control Panel Module','ucp modules'),
 ('5','1','Search','Search plugins and Modifications','search'),
 ('6','1','Anti-Spam','Anti-Spam tools, Add-ons and MODs','anti-spam'),
 ('7','1','Entertainment','Entertainment and Games MODs','entertainment'),
 ('8','1','Syndication','RSS Feed and Syndication MODs','syndication');

drop table if exists `customisation_tag_types`;

CREATE TABLE `customisation_tag_types` (
  `tag_type_id` mediumint(8) unsigned NOT NULL auto_increment,
  `tag_type_name` varchar(255) collate utf8_bin NOT NULL,
  PRIMARY KEY  (`tag_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

insert into `customisation_tag_types` values('1','CATEGORY'),
 ('2','COMPONENT'),
 ('3','COMPLEXITY');

drop table if exists `customisation_watch`;

CREATE TABLE `customisation_watch` (
  `contrib_id` mediumint(8) unsigned NOT NULL default '0',
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `mark_time` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`contrib_id`,`user_id`),
  KEY `contrib_id` (`contrib_id`),
  CONSTRAINT `fk_watch_contrib_id` FOREIGN KEY (`contrib_id`) REFERENCES `customisation_contribs` (`contrib_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


SET FOREIGN_KEY_CHECKS = 1;