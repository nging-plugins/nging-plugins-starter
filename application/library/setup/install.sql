-- MySQL dump 10.13  Distrib 9.0.1, for macos12.7 (x86_64)
--
-- Host: 127.0.0.1    Database: nging
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `forum_assets`
--

DROP TABLE IF EXISTS `forum_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_assets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `target_type` enum('topic','comment') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'topic' COMMENT '目标类型(topic-帖子;comment-评论)',
  `target_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '帖子或评论ID',
  `alloc_type` enum('reward','bounty') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'reward' COMMENT '资产分配方式(reward-收到的打赏;bounty-悬赏)',
  `asset_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'money' COMMENT '资产类型(money-钱;point-点数;credit-信用分;integral-积分;gold-金币;silver-银币;copper-铜币;experience-经验)',
  `amount` decimal(12,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '总金额',
  `pepoles` int unsigned NOT NULL DEFAULT '0' COMMENT '人数',
  PRIMARY KEY (`id`),
  KEY `forum_assets_target` (`target_id`,`target_type`),
  KEY `forum_assets_alloc` (`alloc_type`),
  KEY `forum_assets_type` (`asset_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='帖子资产';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_comment`
--

DROP TABLE IF EXISTS `forum_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_comment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `topic_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '帖子ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `contype` enum('text','markdown','html') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'text' COMMENT '内容类型',
  `reply_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '回复评论ID',
  `root_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '根评论ID',
  `replies` int unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `weight` tinyint(1) NOT NULL DEFAULT '0' COMMENT '权重(0为正常;>0为置顶;<0为降权)',
  `up_votes` int unsigned NOT NULL DEFAULT '0' COMMENT '赞成票',
  `down_votes` int unsigned NOT NULL DEFAULT '0' COMMENT '反对票',
  `final_votes` int NOT NULL DEFAULT '0' COMMENT '最终得票',
  `is_best` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT '是否(Y/N)最佳答案',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `updated` int unsigned NOT NULL COMMENT '评论更新时间',
  PRIMARY KEY (`id`),
  KEY `forum_comment_topic_id` (`topic_id`,`reply_id`),
  KEY `forum_comment_customer` (`customer_id`),
  KEY `forum_comment_weight` (`weight` DESC,`id`),
  KEY `forum_comment_root` (`root_id`),
  KEY `forum_comment_final_votes` (`final_votes` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_rewards`
--

DROP TABLE IF EXISTS `forum_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_rewards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `target_type` enum('topic','comment') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'topic' COMMENT '目标类型(topic-帖子;comment-评论)',
  `target_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '帖子ID',
  `customer_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `amount` decimal(12,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '打赏金额',
  `postscript` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '附言',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '打赏时间',
  PRIMARY KEY (`id`),
  KEY `forum_rewards_customer` (`customer_id`),
  KEY `forum_rewards_target` (`target_id`,`target_type`,`amount` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='打赏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic`
--

DROP TABLE IF EXISTS `forum_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `category_ids` json NOT NULL DEFAULT 'null' COMMENT '分类ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `tags` json NOT NULL DEFAULT 'null' COMMENT '标签',
  `positions` json NOT NULL DEFAULT 'null' COMMENT '位置',
  `weight` tinyint(1) NOT NULL DEFAULT '0' COMMENT '权重(0为正常;>0为置顶;<0为降权)',
  `views` bigint unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `viewer_level` int unsigned NOT NULL DEFAULT '0' COMMENT '浏览者所需最低等级',
  `last_replied` int unsigned NOT NULL DEFAULT '0' COMMENT '最后回复时间',
  `last_replier_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '最后回复人ID',
  `up_votes` int unsigned NOT NULL DEFAULT '0' COMMENT '赞成票',
  `down_votes` int unsigned NOT NULL DEFAULT '0' COMMENT '反对票',
  `final_votes` int NOT NULL DEFAULT '0' COMMENT '最终得票',
  `repliers` int unsigned NOT NULL DEFAULT '0' COMMENT '回复人数',
  `replies` int unsigned NOT NULL DEFAULT '0' COMMENT '回复数量',
  `favorites` int unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `status` enum('open','close','draft','pending') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'open' COMMENT '帖子状态(open-打开;close-关闭;draft-草稿;pending-待审核)',
  `resovled` int unsigned NOT NULL DEFAULT '0' COMMENT '解决时间',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `forum_topic_updated` (`updated` DESC),
  KEY `forum_topic_weight` (`weight` DESC,`last_replied` DESC,`id` DESC),
  KEY `forum_topic_customer_id` (`customer_id`,`status`),
  KEY `forum_topic_final_votes` (`final_votes` DESC),
  KEY `forum_topic_category_ids` ((cast(`category_ids` as unsigned array))),
  KEY `forum_topic_tags` ((cast(`tags` as char(30) array))),
  KEY `forum_topic_positions` ((cast(`positions` as char(30) array))),
  FULLTEXT KEY `forum_topic_title` (`title`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='论坛帖子';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_topic_content`
--

DROP TABLE IF EXISTS `forum_topic_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_topic_content` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `topic_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '帖子ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '帖子内容',
  `contype` enum('text','markdown','html') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'text' COMMENT '内容类型',
  `append` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N' COMMENT '是否(Y/N)属于追加附言',
  `created` int unsigned NOT NULL DEFAULT '0' COMMENT '内容创建时间',
  `updated` int unsigned NOT NULL COMMENT '内容更新时间',
  PRIMARY KEY (`id`),
  KEY `forum_topic_content_topic_id` (`topic_id`,`append`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-10 14:29:57
