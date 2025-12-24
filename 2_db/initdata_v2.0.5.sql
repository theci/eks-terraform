SET FOREIGN_KEY_CHECKS = 0;

-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: genai_init
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `TB_AGENT_BOOKMARK`
--

DROP TABLE IF EXISTS `TB_AGENT_BOOKMARK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_BOOKMARK` (
                                     `AGENT_ID` varchar(50) NOT NULL COMMENT 'Agent ID',
                                     `USER_ID` varchar(50) NOT NULL COMMENT '사용자 ID',
                                     `REG_DT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                     `REG_USER_ID` varchar(50) NOT NULL COMMENT '등록자 ID',
                                     `UPD_DT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                     `UPD_USER_ID` varchar(50) NOT NULL COMMENT '수정자 ID',
                                     PRIMARY KEY (`AGENT_ID`,`USER_ID`),
                                     KEY `IDX_AGENT_BOOKMARK_USER_ID` (`USER_ID`),
                                     KEY `IDX_AGENT_BOOKMARK_REG_DT` (`REG_DT`),
                                     CONSTRAINT `TB_AGENT_BOOKMARK_ibfk_1` FOREIGN KEY (`AGENT_ID`) REFERENCES `TB_AGENT_MASTER` (`AGENT_ID`) ON DELETE CASCADE,
                                     CONSTRAINT `TB_AGENT_BOOKMARK_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `TB_SYS_USER` (`USER_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Agent 북마크';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_BOOKMARK`
--

LOCK TABLES `TB_AGENT_BOOKMARK` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_BOOKMARK` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_BOOKMARK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_CONVERSATION`
--

DROP TABLE IF EXISTS `TB_AGENT_CONVERSATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_CONVERSATION` (
                                         `CONVERSATION_ID` varchar(100) NOT NULL,
                                         `USER_ID` varchar(100) NOT NULL,
                                         `AGENT_ID` varchar(50) NOT NULL,
                                         `START_DTTM` datetime NOT NULL,
                                         `LAST_ACTIVITY_DTTM` datetime NOT NULL,
                                         `END_DTTM` datetime DEFAULT NULL,
                                         `REG_DTTM` datetime NOT NULL,
                                         PRIMARY KEY (`CONVERSATION_ID`),
                                         KEY `idx_user_agent` (`USER_ID`,`AGENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_CONVERSATION`
--

LOCK TABLES `TB_AGENT_CONVERSATION` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_CONVERSATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_CONVERSATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_HIST`
--

DROP TABLE IF EXISTS `TB_AGENT_HIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_HIST` (
                                 `AGENT_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                                 `AGENT_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '에이전트 ID',
                                 `GROUP_RUN_ID` int NOT NULL DEFAULT '0' COMMENT '실행 그룹 ID',
                                 `RUN_SEQ` int NOT NULL DEFAULT '0' COMMENT '노드 실행 순서',
                                 `NODE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '노드 이름',
                                 `QUESTION` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '질문',
                                 `ANSWER` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '답변',
                                 `DEL_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제 여부',
                                 `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
                                 `REG_USER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '생성 아이디',
                                 `REG_USER_IP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '생성 IP',
                                 `SESSION_ID` varchar(40) DEFAULT NULL COMMENT 'Session ID',
                                 `REPOSITORY_INDEX` varchar(100) DEFAULT NULL COMMENT '저장소',
                                 `MODEL_ID` varchar(100) DEFAULT 'gemini-2.0-flash' COMMENT '사용된 LLM 모델 ID',
                                 `FILE_LIST` longtext,
                                 PRIMARY KEY (`AGENT_SNO`),
                                 UNIQUE KEY `TB_AGENT_HIST_UNIQUE` (`AGENT_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='에이전트 히스토리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_HIST`
--

LOCK TABLES `TB_AGENT_HIST` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_HIST` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_HIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_MASTER`
--

DROP TABLE IF EXISTS `TB_AGENT_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_MASTER` (
                                   `AGENT_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT (uuid()) COMMENT '에이전트 아이디',
                                   `AGENT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '에이전트 명',
                                   `VERSION` varchar(10) NOT NULL COMMENT '버전',
                                   `PROPERTIES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'YAML 프로퍼티',
                                   `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                   `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                   `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                   `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                   `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                   `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                   `DESCRIPTION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '설명',
                                   `DEFAULT_YN` varchar(1) DEFAULT 'N' COMMENT '기본 제공 여부',
                                   `PUBLIC_SCOPE` varchar(3) DEFAULT 'PRI' COMMENT '공개 범위 (PRI:개인/PRJ:프로젝트/PUB:전체)',
                                   `AGENT_TYPE` smallint DEFAULT '0' COMMENT 'Agent Type (0: SimpleAgent / 1: MultiAgent)',
                                   `LLM_MODEL_CONFIG` varchar(100) DEFAULT NULL,
                                   `MCP_SRVR_CNTN_ID` varchar(100) DEFAULT NULL,
                                   `DEL_YN` varchar(1) DEFAULT 'N' COMMENT '삭제 여부',
                                   `SUGGESTED_QUESTION` longtext COMMENT '추천 질문 : list<string> 형태',
                                   `SUBTITLE` varchar(50) DEFAULT NULL COMMENT '부제목',
                                   `PROVIDER` varchar(15) DEFAULT NULL COMMENT 'Agent 제공자',
                                   `TRACING` char(1) DEFAULT NULL,
                                   PRIMARY KEY (`AGENT_ID`),
                                   UNIQUE KEY `TB_AGENT_MANAGEMENT_UNIQUE` (`AGENT_NAME`,`VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AGENT 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_MASTER`
--

LOCK TABLES `TB_AGENT_MASTER` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_MASTER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_MASTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_MCP_SERVER_MAP`
--

DROP TABLE IF EXISTS `TB_AGENT_MCP_SERVER_MAP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_MCP_SERVER_MAP` (
                                           `AGENT_ID` varchar(64) NOT NULL,
                                           `MCP_SRVR_CNTN_ID` varchar(64) NOT NULL,
                                           `USE_YN` char(1) DEFAULT 'Y',
                                           `REG_DT` datetime DEFAULT CURRENT_TIMESTAMP,
                                           `REG_ID` varchar(64) DEFAULT NULL,
                                           `UPD_DT` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                           `UPD_ID` varchar(64) DEFAULT NULL,
                                           PRIMARY KEY (`AGENT_ID`,`MCP_SRVR_CNTN_ID`),
                                           KEY `MCP_SRVR_CNTN_ID` (`MCP_SRVR_CNTN_ID`),
                                           CONSTRAINT `TB_AGENT_MCP_SERVER_MAP_ibfk_1` FOREIGN KEY (`AGENT_ID`) REFERENCES `TB_AGENT_MASTER` (`AGENT_ID`),
                                           CONSTRAINT `TB_AGENT_MCP_SERVER_MAP_ibfk_2` FOREIGN KEY (`MCP_SRVR_CNTN_ID`) REFERENCES `TB_MCP_SRVR_CNTN_INFO` (`MCP_SRVR_CNTN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_MCP_SERVER_MAP`
--

LOCK TABLES `TB_AGENT_MCP_SERVER_MAP` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_MCP_SERVER_MAP` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_MCP_SERVER_MAP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_MESSAGE`
--

DROP TABLE IF EXISTS `TB_AGENT_MESSAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_MESSAGE` (
                                    `MESSAGE_ID` bigint NOT NULL AUTO_INCREMENT,
                                    `CONVERSATION_ID` varchar(100) NOT NULL,
                                    `USER_ID` varchar(100) NOT NULL,
                                    `AGENT_ID` varchar(50) NOT NULL,
                                    `QUESTION` text NOT NULL,
                                    `ANSWER` text NOT NULL,
                                    `REG_DTTM` datetime NOT NULL,
                                    `FEED_BACK` varchar(100) DEFAULT NULL,
                                    PRIMARY KEY (`MESSAGE_ID`),
                                    KEY `idx_conversation` (`CONVERSATION_ID`),
                                    CONSTRAINT `TB_AGENT_MESSAGE_ibfk_1` FOREIGN KEY (`CONVERSATION_ID`) REFERENCES `TB_AGENT_CONVERSATION` (`CONVERSATION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=353 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_MESSAGE`
--

LOCK TABLES `TB_AGENT_MESSAGE` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_MESSAGE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_MESSAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_METADATA`
--

DROP TABLE IF EXISTS `TB_AGENT_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_METADATA` (
                                     `AGENT_METADATA_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                                     `AGENT_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '에이전트 아이디',
                                     `METADATA_SNO` bigint unsigned NOT NULL COMMENT 'seq',
                                     `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
                                     PRIMARY KEY (`AGENT_METADATA_SNO`),
                                     UNIQUE KEY `TB_AGENT_METADATA_UNIQUE` (`AGENT_METADATA_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_METADATA`
--

LOCK TABLES `TB_AGENT_METADATA` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_METADATA` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_METADATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_ROLE`
--

DROP TABLE IF EXISTS `TB_AGENT_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_ROLE` (
                                 `AGENT_ROLE_SNO` int NOT NULL AUTO_INCREMENT COMMENT '에이전트권한번호',
                                 `AGENT_ROLE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '에이전트 권한ID',
                                 `AGENT_ROLE_NM` varchar(50) NOT NULL COMMENT '에이전트권한명',
                                 `AGENT_ROLE_DESC` varchar(1000) DEFAULT NULL COMMENT '에이전트권한설명',
                                 `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                 `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                                 `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                 `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                 `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                 `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                 `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                 `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                 PRIMARY KEY (`AGENT_ROLE_SNO`),
                                 UNIQUE KEY `TB_AGENT_ROLE_UNIQUE` (`AGENT_ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='에이전트 권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_ROLE`
--

LOCK TABLES `TB_AGENT_ROLE` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_ROLE_AGENT_MASTER_RLT`
--

DROP TABLE IF EXISTS `TB_AGENT_ROLE_AGENT_MASTER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_ROLE_AGENT_MASTER_RLT` (
                                                  `AGENT_ROLE_SNO` int NOT NULL COMMENT '에이전트권한번호',
                                                  `AGENT_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '에이전트 아이디',
                                                  `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                                  `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                                  `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                                  `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                                  `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                                  `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                                  `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                                  PRIMARY KEY (`AGENT_ROLE_SNO`,`AGENT_ID`),
                                                  KEY `FK_AGENT_ROLE_AGENT_MASTER_RLT_AGENT_ID` (`AGENT_ID`),
                                                  CONSTRAINT `FK_AGENT_ROLE_AGENT_MASTER_RLT_AGENT_ID` FOREIGN KEY (`AGENT_ID`) REFERENCES `TB_AGENT_MASTER` (`AGENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='에이전트 권한 에이전트 마스터 관계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_ROLE_AGENT_MASTER_RLT`
--

LOCK TABLES `TB_AGENT_ROLE_AGENT_MASTER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_ROLE_AGENT_MASTER_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_ROLE_AGENT_MASTER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AGENT_ROLE_USER_RLT`
--

DROP TABLE IF EXISTS `TB_AGENT_ROLE_USER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AGENT_ROLE_USER_RLT` (
                                          `AGENT_ROLE_SNO` int NOT NULL COMMENT '에이전트권한번호',
                                          `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
                                          `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                          `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                          `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                          `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                          `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                          `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                          `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                          PRIMARY KEY (`AGENT_ROLE_SNO`,`USER_ID`),
                                          CONSTRAINT `TB_AGENT_ROLE_USER_RLT_ibfk_1` FOREIGN KEY (`AGENT_ROLE_SNO`) REFERENCES `TB_AGENT_ROLE` (`AGENT_ROLE_SNO`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='에이전트 권한 사용자 맵핑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AGENT_ROLE_USER_RLT`
--

LOCK TABLES `TB_AGENT_ROLE_USER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_AGENT_ROLE_USER_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AGENT_ROLE_USER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT`
--

DROP TABLE IF EXISTS `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT` (
                                                              `FK_RAG_PIPELINE_SETTING_ID` bigint NOT NULL COMMENT 'RAG PIPLINE SETTING ID',
                                                              `FK_ATTACH_FILE_SNO` bigint unsigned NOT NULL COMMENT 'ATTACH ID',
                                                              `FK_ATTACH_FILE_NO` int NOT NULL DEFAULT '1' COMMENT '첨부파일순번',
                                                              KEY `FK_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT_ATTACH_FILE_ID` (`FK_ATTACH_FILE_SNO`,`FK_ATTACH_FILE_NO`),
                                                              KEY `FK_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT_RLT_RAG_ID` (`FK_RAG_PIPELINE_SETTING_ID`),
                                                              CONSTRAINT `FK_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT_ATTACH_FILE_ID` FOREIGN KEY (`FK_ATTACH_FILE_SNO`, `FK_ATTACH_FILE_NO`) REFERENCES `TB_ATTACH_PDF` (`ATTACH_FILE_SNO`, `ATTACH_FILE_NO`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                              CONSTRAINT `FK_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT_RLT_RAG_ID` FOREIGN KEY (`FK_RAG_PIPELINE_SETTING_ID`) REFERENCES `TB_RAG_PIPELINE_SETTING` (`PK_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ATTACH FILE RAG PIPELINE SETTING 관계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT`
--

LOCK TABLES `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT` WRITE;
/*!40000 ALTER TABLE `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_ATTACH_FILE_TB_RAG_PIPELINE_SETTING_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_ATTACH_FILE_TB_SESSION_RLT`
--

DROP TABLE IF EXISTS `TB_ATTACH_FILE_TB_SESSION_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_ATTACH_FILE_TB_SESSION_RLT` (
                                                 `FK_SESSION_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'SESSION ID',
                                                 `FK_ATTACH_FILE_SNO` bigint unsigned NOT NULL COMMENT 'ATTACH ID',
                                                 `FK_ATTACH_FILE_NO` int NOT NULL DEFAULT '1' COMMENT '첨부파일순번',
                                                 KEY `FK_ATTACH_FILE_TB_SESSION_RLT_ATTACH_FILE_ID` (`FK_ATTACH_FILE_SNO`,`FK_ATTACH_FILE_NO`),
                                                 KEY `FK_ATTACH_FILE_TB_SESSION_RLT_SESSION_ID` (`FK_SESSION_ID`),
                                                 CONSTRAINT `FK_ATTACH_FILE_TB_SESSION_RLT_ATTACH_FILE_ID` FOREIGN KEY (`FK_ATTACH_FILE_SNO`, `FK_ATTACH_FILE_NO`) REFERENCES `TB_ATTACH_PDF` (`ATTACH_FILE_SNO`, `ATTACH_FILE_NO`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                 CONSTRAINT `FK_ATTACH_FILE_TB_SESSION_RLT_SESSION_ID` FOREIGN KEY (`FK_SESSION_ID`) REFERENCES `TB_SESSION` (`SESSION_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ATTACH FILE SESSION 관계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_ATTACH_FILE_TB_SESSION_RLT`
--

LOCK TABLES `TB_ATTACH_FILE_TB_SESSION_RLT` WRITE;
/*!40000 ALTER TABLE `TB_ATTACH_FILE_TB_SESSION_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_ATTACH_FILE_TB_SESSION_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_ATTACH_PDF`
--

DROP TABLE IF EXISTS `TB_ATTACH_PDF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_ATTACH_PDF` (
                                 `ATTACH_FILE_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '첨부파일ID',
                                 `ATTACH_FILE_NO` int NOT NULL DEFAULT '1' COMMENT '첨부파일순번',
                                 `ATTACH_TYPE` varchar(100) DEFAULT NULL COMMENT '첨부타입',
                                 `CLASSIFIER` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '분류',
                                 `INDEX_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '인덱스명',
                                 `BUCKET_NM` varchar(100) DEFAULT NULL COMMENT 'S3 BUCKET',
                                 `PREFIX_NM` varchar(100) DEFAULT NULL COMMENT 'S3 PREFIX',
                                 `OBJECT_NM` varchar(1024) DEFAULT NULL,
                                 `ORIGIN_NM` varchar(1024) DEFAULT NULL,
                                 `ATTACH_FILE_URL` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '첨부파일경로명',
                                 `ATTACH_FILE_SIZE` decimal(10,0) DEFAULT NULL COMMENT '첨부파일크기',
                                 `STATUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'READY' COMMENT '상태(READY, PROGRESS, SUCCESS, FAIL)',
                                 `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Y' COMMENT '사용여부',
                                 `DEL_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제여부',
                                 `FINISH_DTTM` timestamp NULL DEFAULT NULL COMMENT '완료시간',
                                 `DURATION_TIME` int DEFAULT NULL COMMENT '소요시간',
                                 `PAGE_COUNT` int DEFAULT NULL COMMENT '페이지수',
                                 `CHUNK_COUNT` int DEFAULT NULL COMMENT '청크수',
                                 `TOKEN_COUNT` int DEFAULT NULL COMMENT '소요토큰 수',
                                 `PAGE_CONTENTS` varchar(500) DEFAULT NULL COMMENT '페이지카운트',
                                 `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                 `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                 `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                 `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                 `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                 PRIMARY KEY (`ATTACH_FILE_SNO`,`ATTACH_FILE_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=10696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='S3 PDF 첨부파일(LLM 전용)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_ATTACH_PDF`
--

LOCK TABLES `TB_ATTACH_PDF` WRITE;
/*!40000 ALTER TABLE `TB_ATTACH_PDF` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_ATTACH_PDF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AUTH_INFO_TEMPLATE`
--

DROP TABLE IF EXISTS `TB_AUTH_INFO_TEMPLATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AUTH_INFO_TEMPLATE` (
                                         `TEMPLATE_ID` varchar(40) NOT NULL DEFAULT (uuid()) COMMENT '인증 정보 템플릿 고유 ID (UUID4)',
                                         `TEMPLATE_NAME` varchar(200) NOT NULL COMMENT '인증 정보 템플릿 이름 (예: AWS 인증 정보, GitHub 인증 정보)',
                                         `DESCRIPTION` text COMMENT '인증 정보 템플릿 설명',
                                         `AUTH_SCOPE` varchar(20) NOT NULL DEFAULT 'PUBLIC' COMMENT '인증 범위 (PUBLIC: 공개, PERSONAL: 개인)',
                                         `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                         `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                         `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                         `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '등록사용자ID',
                                         `REG_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                         `UPDT_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                         `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                         `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                         `VENDOR` varchar(50) DEFAULT 'UNKNOWN' COMMENT '인증 및 접근 공급사 (AWS, Google, Slack, Github...)',
                                         PRIMARY KEY (`TEMPLATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인증 정보 템플릿 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AUTH_INFO_TEMPLATE`
--

LOCK TABLES `TB_AUTH_INFO_TEMPLATE` WRITE;
/*!40000 ALTER TABLE `TB_AUTH_INFO_TEMPLATE` DISABLE KEYS */;
INSERT INTO `TB_AUTH_INFO_TEMPLATE` VALUES ('09f5aa32-587d-4f84-8ac1-9522685b7f62','Perplexity API Authentication','Perplexity AI의 API Key 기반 인증 방식','PERSONAL','Y','N','2025-07-28 04:58:35','kangmj@mz.co.kr','127.0.0.1','2025-07-28 04:58:35','kangmj@mz.co.kr',NULL,'Perplexity AI'),('23c06ff1-f48f-40f5-9962-7cdf74383291','AWS 기본 인증 정보','AWS 서비스 접근용 기본 인증 정보','PUBLIC','Y','N','2025-09-23 06:17:23','dcjeon@mz.co.kr','127.0.0.1','2025-09-23 06:21:38','dcjeon@mz.co.kr',NULL,'AWS'),('2e732bee-7a73-4bae-91a6-e9049b966abe','LangSmith API Key','Agent 로그용으로 사용 합니다.','PERSONAL','Y','N','2025-10-21 00:42:59','leeehh@mz.co.kr','127.0.0.1','2025-10-21 00:49:57','leeehh@mz.co.kr',NULL,'LangChain'),('83250fd9-1805-4b96-8f18-108c0d3406e5','Confluence API Token Authentication','Confluence API Token 기반 인증 방식입니다.','PERSONAL','Y','N','2025-07-28 04:55:51','kangmj@mz.co.kr','127.0.0.1','2025-07-28 04:57:31','kangmj@mz.co.kr',NULL,'Atlassian'),('b6d51485-e816-40f2-a2ac-07fe57f16e93','AWS S3 Bucket 정보','AWS S3 Bucket 정보 설정','PUBLIC','Y','N','2025-09-23 06:18:09','dcjeon@mz.co.kr','127.0.0.1','2025-09-23 06:18:09','dcjeon@mz.co.kr',NULL,'AWS'),('d473f4ca-0e19-471d-a490-35b809e362ba','Google Authentication (JSON)','Google Service Account (JSON) 방식의 인증 체계입니다.','PERSONAL','Y','N','2025-08-19 06:00:48','kangmj@mz.co.kr','127.0.0.1','2025-08-19 06:00:48','kangmj@mz.co.kr',NULL,'Google');
/*!40000 ALTER TABLE `TB_AUTH_INFO_TEMPLATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AUTH_INFO_TEMPLATE_FIELD`
--

DROP TABLE IF EXISTS `TB_AUTH_INFO_TEMPLATE_FIELD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AUTH_INFO_TEMPLATE_FIELD` (
                                               `FIELD_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '템플릿 필드 순번',
                                               `TEMPLATE_ID` varchar(40) NOT NULL COMMENT '인증 정보 템플릿 ID',
                                               `FIELD_KEY` varchar(100) NOT NULL COMMENT '실제 인증 키 이름 (예: ACCESS_KEY_ID, SECRET_ACCESS_KEY)',
                                               `FIELD_NAME` varchar(200) NOT NULL COMMENT 'UI에서 표시되는 사용자 친화적 이름',
                                               `DESCRIPTION` text COMMENT '필드 설명',
                                               `IS_REQUIRED` tinyint(1) DEFAULT '1' COMMENT '필수 입력 여부',
                                               `FIELD_ORDER` int DEFAULT '1' COMMENT '필드 표시 순서',
                                               `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                               `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                               `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                               `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '등록사용자ID',
                                               `REG_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                               `UPDT_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                               `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                               `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                               PRIMARY KEY (`FIELD_SNO`),
                                               UNIQUE KEY `uk_template_field` (`TEMPLATE_ID`,`FIELD_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인증 정보 템플릿 필드 정의';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AUTH_INFO_TEMPLATE_FIELD`
--

LOCK TABLES `TB_AUTH_INFO_TEMPLATE_FIELD` WRITE;
/*!40000 ALTER TABLE `TB_AUTH_INFO_TEMPLATE_FIELD` DISABLE KEYS */;
INSERT INTO `TB_AUTH_INFO_TEMPLATE_FIELD` VALUES (4,'83250fd9-1805-4b96-8f18-108c0d3406e5','CONFLUENCE_INSTANCE_URL','CONFLUENCE_INSTANCE_URL',NULL,1,1,'Y','N','2025-07-28 04:57:31','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:57:31','dcjeon@mz.co.kr',NULL),(5,'83250fd9-1805-4b96-8f18-108c0d3406e5','CONFLUENCE_USERNAME','CONFLUENCE_USERNAME',NULL,1,2,'Y','N','2025-07-28 04:57:31','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:57:31','dcjeon@mz.co.kr',NULL),(6,'83250fd9-1805-4b96-8f18-108c0d3406e5','CONFLUENCE_API_TOKEN','CONFLUENCE_API_TOKEN',NULL,1,3,'Y','N','2025-07-28 04:57:31','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:57:31','dcjeon@mz.co.kr',NULL),(7,'09f5aa32-587d-4f84-8ac1-9522685b7f62','PERPLEXITY_API_KEY','PERPLEXITY_API_KEY',NULL,1,1,'Y','N','2025-07-28 04:58:35','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:58:35','dcjeon@mz.co.kr',NULL),(8,'09f5aa32-587d-4f84-8ac1-9522685b7f62','PERPLEXITY_BASE_URL','PERPLEXITY_BASE_URL',NULL,1,2,'Y','N','2025-07-28 04:58:35','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:58:35','dcjeon@mz.co.kr',NULL),(9,'09f5aa32-587d-4f84-8ac1-9522685b7f62','PERPLEXITY_DEFAULT_MODEL','PERPLEXITY_DEFAULT_MODEL',NULL,1,3,'Y','N','2025-07-28 04:58:35','dcjeon@mz.co.kr','127.0.0.1','2025-07-28 04:58:35','dcjeon@mz.co.kr',NULL),(10,'d473f4ca-0e19-471d-a490-35b809e362ba','GOOGLE_SERVICE_ACCOUNT_JSON','GOOGLE_SERVICE_ACCOUNT_JSON',NULL,1,1,'Y','N','2025-08-19 06:00:48','dcjeon@mz.co.kr','127.0.0.1','2025-08-19 06:00:48','dcjeon@mz.co.kr',NULL),(17,'23c06ff1-f48f-40f5-9962-7cdf74383291','AWS_REGION','AWS_REGION',NULL,1,1,'Y','N','2025-09-23 06:21:38','dcjeon@mz.co.kr','127.0.0.1','2025-09-23 06:21:38','dcjeon@mz.co.kr',NULL),(18,'23c06ff1-f48f-40f5-9962-7cdf74383291','AWS_ACCESS_KEY_ID','AWS_ACCESS_KEY_ID',NULL,1,2,'Y','N','2025-09-23 06:21:38','dcjeon@mz.co.kr','127.0.0.1','2025-09-23 06:21:38','dcjeon@mz.co.kr',NULL),(19,'23c06ff1-f48f-40f5-9962-7cdf74383291','AWS_SECRET_ACCESS_KEY','AWS_SECRET_ACCESS_KEY',NULL,1,3,'Y','N','2025-09-23 06:21:38','dcjeon@mz.co.kr','127.0.0.1','2025-09-23 06:21:38','dcjeon@mz.co.kr',NULL),(21,'2e732bee-7a73-4bae-91a6-e9049b966abe','LANGCHAIN_API_KEY','LANGCHAIN_API_KEY',NULL,1,1,'Y','N','2025-10-21 00:49:57','leeehh@mz.co.kr','127.0.0.1','2025-10-21 00:49:57','leeehh@mz.co.kr',NULL);
/*!40000 ALTER TABLE `TB_AUTH_INFO_TEMPLATE_FIELD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_AUTH_INFO_VALUE`
--

DROP TABLE IF EXISTS `TB_AUTH_INFO_VALUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_AUTH_INFO_VALUE` (
                                      `VALUE_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '인증 정보 값 순번',
                                      `TEMPLATE_ID` varchar(40) NOT NULL COMMENT '인증 정보 템플릿 ID',
                                      `USER_ID` varchar(50) DEFAULT NULL COMMENT '사용자 ID (개인 인증 정보인 경우), 공개 인증 정보는 NULL',
                                      `FIELD_KEY` varchar(100) NOT NULL COMMENT '필드 키 이름',
                                      `FIELD_VALUE` text NOT NULL COMMENT '필드 값 (향후 암호화 예정)',
                                      `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                      `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                      `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                      `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '등록사용자ID',
                                      `REG_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                      `UPDT_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                      `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                      `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                      PRIMARY KEY (`VALUE_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인증 정보 실제 값 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_AUTH_INFO_VALUE`
--

LOCK TABLES `TB_AUTH_INFO_VALUE` WRITE;
/*!40000 ALTER TABLE `TB_AUTH_INFO_VALUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_AUTH_INFO_VALUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_CANVAS_HIST`
--

DROP TABLE IF EXISTS `TB_CANVAS_HIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_CANVAS_HIST` (
                                  `CANVAS_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                                  `QUESTION` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '지시사항(질문)',
                                  `ANSWER` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '응답',
                                  `DEL_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제 여부',
                                  `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
                                  `CONTENTS` longtext COMMENT '연관 문서',
                                  `SESSION_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Session ID',
                                  `REG_USER_IP` varchar(20) DEFAULT '127.0.0.1' COMMENT '사용자 IP',
                                  `REPOSITORY_INDEX` varchar(100) DEFAULT NULL COMMENT '저장소',
                                  `MODEL_ID` varchar(100) DEFAULT 'gemini-2.0-flash' COMMENT '사용된 LLM 모델 ID',
                                  PRIMARY KEY (`CANVAS_SNO`),
                                  UNIQUE KEY `TEMP_TB_CHAT_HIST_UNIQUE` (`CANVAS_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='CANVAS CHAT 이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_CANVAS_HIST`
--

LOCK TABLES `TB_CANVAS_HIST` WRITE;
/*!40000 ALTER TABLE `TB_CANVAS_HIST` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_CANVAS_HIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_CHAT_CONFIG`
--

DROP TABLE IF EXISTS `TB_CHAT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_CHAT_CONFIG` (
                                  `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                  `CONFIG_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '설정버전',
                                  `LATEST_YN` varchar(10) NOT NULL DEFAULT 'Y' COMMENT '최종버전여부',
                                  `LLM_MODEL_ID` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'anthropic.claude-3-haiku-20240307-v1:0' COMMENT 'LLM모델ID',
                                  `MAX_TOKENS` int NOT NULL DEFAULT '4092' COMMENT '최대토큰수',
                                  `STOP_SEQUENCES` varchar(1000) NOT NULL DEFAULT '\n\nHuman' COMMENT '스톱문장',
                                  `TEMPERATURE` float NOT NULL DEFAULT '0' COMMENT '템퍼러처',
                                  `TOP_K` int NOT NULL DEFAULT '250' COMMENT '탑K',
                                  `TOP_P` float NOT NULL DEFAULT '0.99' COMMENT '탑P',
                                  `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                  `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                  `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                  `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                  `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                  UNIQUE KEY `INDEX_NAME` (`INDEX_NAME`,`CONFIG_VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='CHAT 설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_CHAT_CONFIG`
--

LOCK TABLES `TB_CHAT_CONFIG` WRITE;
/*!40000 ALTER TABLE `TB_CHAT_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_CHAT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_CHAT_FEEDBACK`
--

DROP TABLE IF EXISTS `TB_CHAT_FEEDBACK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_CHAT_FEEDBACK` (
                                    `ID` bigint NOT NULL AUTO_INCREMENT,
                                    `CHAT_TYPE` int DEFAULT NULL COMMENT '1: 일반 챗\r\n2 : 캔버스 챗\r\n3 : agent 챗',
                                    `ISLIKE` tinyint(1) DEFAULT NULL,
                                    `COMMENT_TYPE` text,
                                    `COMMENT_CONTENT` text,
                                    `CHAT_SNO` int DEFAULT NULL,
                                    `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                    `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                    `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                    `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '수정사용자ID',
                                    `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '수정사용자IP',
                                    `REG_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                    `SESSION_ID` varchar(100) DEFAULT NULL,
                                    PRIMARY KEY (`ID`),
                                    UNIQUE KEY `UK_CHAT_FEEDBACK_CHAT_SNO_TYPE` (`CHAT_SNO`,`CHAT_TYPE`),
                                    UNIQUE KEY `UK_CHAT_FEEDBACK_SESSION_CHAT_SNO_TYPE` (`SESSION_ID`,`CHAT_SNO`,`CHAT_TYPE`),
                                    KEY `IDX_CHAT_FEEDBACK_CHAT_SNO_TYPE` (`CHAT_SNO`,`CHAT_TYPE`),
                                    KEY `IDX_CHAT_FEEDBACK_SESSION_ID` (`SESSION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='채팅 피드백 (chatSno + chatType 조합은 유일해야 함)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_CHAT_FEEDBACK`
--

LOCK TABLES `TB_CHAT_FEEDBACK` WRITE;
/*!40000 ALTER TABLE `TB_CHAT_FEEDBACK` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_CHAT_FEEDBACK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_CHAT_HIST`
--

DROP TABLE IF EXISTS `TB_CHAT_HIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_CHAT_HIST` (
                                `CHAT_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                                `REPOSITORY_INDEX` varchar(100) DEFAULT NULL COMMENT '저장소',
                                `KNOWLEDGE_BASE_CONFIG` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'KNOWLEDGE_BASE_CONFIG',
                                `RETRIEVER_CONFIG` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'RETRIEVER_CONFIG',
                                `CHAT_CONFIG` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'CHAT_CONFIG',
                                `QUESTION` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '질문',
                                `REFINED_QUESTION` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '재정의된 질문',
                                `ANSWER` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '답변',
                                `CONTENTS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '응답 컨텐츠',
                                `SEARCH_TYPE` varchar(10) DEFAULT 'RAG' COMMENT '(RAG, XNG)',
                                `DEL_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제 여부',
                                `OLD_YN` varchar(5) NOT NULL DEFAULT 'N' COMMENT '초기여부',
                                `REG_YMD` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '생성YMD',
                                `REG_DTTM` timestamp NULL DEFAULT NULL COMMENT '생성일',
                                `REG_USER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '생성 아이디',
                                `REG_USER_IP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '생성 IP',
                                `FEED_BACK` tinyint DEFAULT '0' COMMENT '1:좋아요, -1:싫어요, 0:미반응',
                                `SESSION_ID` varchar(40) DEFAULT NULL COMMENT 'Session ID',
                                `IMAGE_METADATA` text,
                                `MODEL_ID` varchar(100) DEFAULT 'gemini-2.0-flash' COMMENT '사용된 LLM 모델 ID',
                                `FILE_LIST` longtext COMMENT '개인 첨부파일 목록',
                                PRIMARY KEY (`CHAT_SNO`),
                                KEY `TB_CHAT_HIST_IDX_01` (`OLD_YN`,`REG_USER_ID`,`REPOSITORY_INDEX`)
) ENGINE=InnoDB AUTO_INCREMENT=760 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='chat 이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_CHAT_HIST`
--

LOCK TABLES `TB_CHAT_HIST` WRITE;
/*!40000 ALTER TABLE `TB_CHAT_HIST` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_CHAT_HIST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_ERROR_REQ`
--

DROP TABLE IF EXISTS `TB_ERROR_REQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_ERROR_REQ` (
                                `REQ_SEQ` int NOT NULL AUTO_INCREMENT COMMENT '오류신고일련번호',
                                `SETTING_IDX` bigint NOT NULL DEFAULT '0' COMMENT '저장소세팅 index',
                                `GENAI_HIST_IDX` bigint NOT NULL DEFAULT '0' COMMENT 'GenAI 이력 index',
                                `TITLE` varchar(300) DEFAULT NULL COMMENT '제목명',
                                `REQ_CONTENT` text COMMENT '문의내용',
                                `REQ_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '요청사용자ID',
                                `REQ_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '요청일시',
                                `ANSWER_CONTENT` text COMMENT '답변내용',
                                `ANSWER_USER_ID` varchar(64) DEFAULT NULL COMMENT '답변사용자ID',
                                `ANSWER_DTTM` timestamp NULL DEFAULT NULL COMMENT '답변일시',
                                `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'A' COMMENT '처리상태[A:접수, B:처리중, C:완료]',
                                `ATTACH_FILE_SNO` int DEFAULT '0' COMMENT '첨부파일ID',
                                `READ_CNT` int NOT NULL DEFAULT '0' COMMENT '조회횟수',
                                `DEL_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                                `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                PRIMARY KEY (`REQ_SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='오류신고';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_ERROR_REQ`
--

LOCK TABLES `TB_ERROR_REQ` WRITE;
/*!40000 ALTER TABLE `TB_ERROR_REQ` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_ERROR_REQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_EVAL_DATASET_EXPER`
--

DROP TABLE IF EXISTS `TB_EVAL_DATASET_EXPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_EVAL_DATASET_EXPER` (
                                         `EXPER_ID` varchar(100) NOT NULL COMMENT '평가실행ID : uuid',
                                         `EXPER_NM` varchar(500) NOT NULL COMMENT '평가실행명',
                                         `EXPER_DESC` varchar(500) NOT NULL COMMENT '평가설명',
                                         `EXPER_STAT` varchar(20) NOT NULL COMMENT 'EXPERIMENT 상태: SAVE, SUCC, FAIL',
                                         `EVAL_TYPE` varchar(10) NOT NULL COMMENT '평가타입 : AUTO, MANU',
                                         `OSE_IDX_NM` varchar(200) NOT NULL COMMENT 'Knowledgebase ID',
                                         `EXPER_CONFIG_SET` text NOT NULL COMMENT '평가 Config',
                                         `DATASET_ID` varchar(100) NOT NULL COMMENT '데이터셋ID : uuid',
                                         `EVAL_START_DTTM` varchar(20) DEFAULT NULL COMMENT '평가시작일시',
                                         `EVAL_END_DTTM` varchar(20) DEFAULT NULL COMMENT '평가종료일시',
                                         `EVAL_METRICS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '평가지표:faithfulness,answer_relevancy,context_recall,context_precision,answer_correctness',
                                         `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                         `REG_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '등록사용자ID',
                                         `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                         `UPDT_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '수정사용자ID',
                                         `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                         PRIMARY KEY (`EXPER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='평가 데이터셋 실횅';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_EVAL_DATASET_EXPER`
--

LOCK TABLES `TB_EVAL_DATASET_EXPER` WRITE;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_EXPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_EXPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_EVAL_DATASET_EXPER_RESULT`
--

DROP TABLE IF EXISTS `TB_EVAL_DATASET_EXPER_RESULT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_EVAL_DATASET_EXPER_RESULT` (
                                                `EXPER_ID` varchar(100) NOT NULL COMMENT '실행ID : uuid',
                                                `DATASET_NO` int NOT NULL COMMENT '데이터셋 NO.',
                                                `QUESTION` text NOT NULL COMMENT '질문',
                                                `CONTEXTS` text NOT NULL COMMENT '내용',
                                                `GROUND_TRUTH` text NOT NULL COMMENT '답변',
                                                `METADATA` text NOT NULL COMMENT 'Metadata',
                                                `EVOLUTION_TYPE` text NOT NULL COMMENT '질문타입:simple,multi_context,reasoning,conditional',
                                                `LLM_ANSWER` text NOT NULL COMMENT 'LLM 답변',
                                                `LLM_CONTEXTS` text NOT NULL COMMENT 'LLM 내용',
                                                `LLM_METADATA` text NOT NULL COMMENT 'LLM Metadata',
                                                `FAITHFULNESS` float NOT NULL DEFAULT '0' COMMENT '점수',
                                                `ANSWER_RELEVANCY` float NOT NULL DEFAULT '0' COMMENT '점수',
                                                `CONTEXT_RECALL` float NOT NULL DEFAULT '0' COMMENT '점수',
                                                `CONTEXT_PRECISION` float NOT NULL DEFAULT '0' COMMENT '점수',
                                                `ANSWER_CORRECTNESS` float NOT NULL DEFAULT '0' COMMENT '점수',
                                                `EVAL_START_DTTM` varchar(20) DEFAULT NULL COMMENT '평가시작일시',
                                                `EVAL_END_DTTM` varchar(20) DEFAULT NULL COMMENT '평가종료일시',
                                                `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                                `REG_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '등록사용자ID',
                                                `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                                `UPDT_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '수정사용자ID',
                                                `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                                PRIMARY KEY (`EXPER_ID`,`DATASET_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='평가 데이터셋 실횅 결과';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_EVAL_DATASET_EXPER_RESULT`
--

LOCK TABLES `TB_EVAL_DATASET_EXPER_RESULT` WRITE;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_EXPER_RESULT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_EXPER_RESULT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_EVAL_DATASET_ITEM`
--

DROP TABLE IF EXISTS `TB_EVAL_DATASET_ITEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_EVAL_DATASET_ITEM` (
                                        `DATASET_ID` varchar(100) NOT NULL COMMENT '데이터셋ID : uuid',
                                        `DATASET_NO` int NOT NULL COMMENT '데이터셋 NO.',
                                        `QUESTION` text NOT NULL COMMENT '질문',
                                        `CONTEXTS` text NOT NULL COMMENT '내용',
                                        `GROUND_TRUTH` text NOT NULL COMMENT '답변',
                                        `METADATA` text NOT NULL COMMENT 'Metadata',
                                        `EVOLUTION_TYPE` text NOT NULL COMMENT '질문타입:simple,multi_context,reasoning,conditional',
                                        `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                        `REG_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '등록사용자ID',
                                        `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                        `UPDT_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '수정사용자ID',
                                        `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                        `START_DTTM` varchar(50) DEFAULT NULL,
                                        `END_DTTM` varchar(50) DEFAULT NULL,
                                        PRIMARY KEY (`DATASET_ID`,`DATASET_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='평가 데이터셋 Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_EVAL_DATASET_ITEM`
--

LOCK TABLES `TB_EVAL_DATASET_ITEM` WRITE;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_ITEM` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_ITEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_EVAL_DATASET_MASTER`
--

DROP TABLE IF EXISTS `TB_EVAL_DATASET_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_EVAL_DATASET_MASTER` (
                                          `DATASET_ID` varchar(100) NOT NULL COMMENT '데이터셋ID : uuid',
                                          `DATASET_NM` varchar(500) NOT NULL COMMENT '데이터셋명',
                                          `DATASET_STAT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'DATASET 상태: SAVE, SUCC, FAIL',
                                          `OSE_IDX_NM` varchar(200) NOT NULL COMMENT 'Knowledgebase ID',
                                          `FILE_LIST` varchar(1000) NOT NULL DEFAULT '' COMMENT '대상파일',
                                          `DISTRIBUTIONS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '{simple:1}' COMMENT '질문비율:simple,multi_context,reasoning,conditional',
                                          `DATASET_SIZE` int NOT NULL COMMENT 'DATASET 사이즈',
                                          `CONFIG_SET` text NOT NULL COMMENT 'Dataset 생성 Config:데이터셋 생성 당시 Knowledgebase Config',
                                          `START_DTTM` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '데이터셋생성시작일시',
                                          `END_DTTM` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '데이터셋생성종료일시',
                                          `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                          `REG_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '등록사용자ID',
                                          `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                          `UPDT_USER_ID` varchar(64) DEFAULT 'admin' COMMENT '수정사용자ID',
                                          `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                          `FILE_LIST_EXCEL_QA` varchar(1000) DEFAULT NULL,
                                          PRIMARY KEY (`DATASET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='평가 데이터셋';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_EVAL_DATASET_MASTER`
--

LOCK TABLES `TB_EVAL_DATASET_MASTER` WRITE;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_MASTER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_EVAL_DATASET_MASTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_INDEX_ROLE`
--

DROP TABLE IF EXISTS `TB_INDEX_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_INDEX_ROLE` (
                                 `INDEX_ROLE_SNO` int NOT NULL AUTO_INCREMENT COMMENT '인덱스권한번호',
                                 `INDEX_ROLE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '인덱스 권한ID',
                                 `INDEX_ROLE_NM` varchar(50) NOT NULL COMMENT '인덱스권한명',
                                 `INDEX_ROLE_DESC` varchar(1000) DEFAULT NULL COMMENT 'INDEX권한설명',
                                 `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                 `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                                 `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                 `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                 `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                 `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                 `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                 `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                 PRIMARY KEY (`INDEX_ROLE_SNO`),
                                 UNIQUE KEY `TB_INDEX_ROLE_UNIQUE` (`INDEX_ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인덱스 권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_INDEX_ROLE`
--

LOCK TABLES `TB_INDEX_ROLE` WRITE;
/*!40000 ALTER TABLE `TB_INDEX_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_INDEX_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_INDEX_ROLE_INDEX_RLT`
--

DROP TABLE IF EXISTS `TB_INDEX_ROLE_INDEX_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_INDEX_ROLE_INDEX_RLT` (
                                           `INDEX_ROLE_SNO` int NOT NULL AUTO_INCREMENT COMMENT '인덱스권한번호',
                                           `OSE_IDX_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '인덱스ID',
                                           `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                           `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                           `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                           `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                           `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                           `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                           `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                           PRIMARY KEY (`INDEX_ROLE_SNO`,`OSE_IDX_NM`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인덱스 권한 인덱스 맵핑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_INDEX_ROLE_INDEX_RLT`
--

LOCK TABLES `TB_INDEX_ROLE_INDEX_RLT` WRITE;
/*!40000 ALTER TABLE `TB_INDEX_ROLE_INDEX_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_INDEX_ROLE_INDEX_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_INDEX_ROLE_USER_RLT`
--

DROP TABLE IF EXISTS `TB_INDEX_ROLE_USER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_INDEX_ROLE_USER_RLT` (
                                          `INDEX_ROLE_SNO` int NOT NULL AUTO_INCREMENT COMMENT '인덱스권한번호',
                                          `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
                                          `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                          `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                          `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                          `REG_USER_IP` varchar(23) NOT NULL COMMENT '등록사용자IP',
                                          `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                          `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                          `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                          PRIMARY KEY (`INDEX_ROLE_SNO`,`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인덱스 권한 사용자 맵핑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_INDEX_ROLE_USER_RLT`
--

LOCK TABLES `TB_INDEX_ROLE_USER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_INDEX_ROLE_USER_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_INDEX_ROLE_USER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_KNOWLEDGE_BASE`
--

DROP TABLE IF EXISTS `TB_KNOWLEDGE_BASE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_KNOWLEDGE_BASE` (
                                     `IDX` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                                     `REPO_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '저장소명',
                                     `OSE_IDX_NM` varchar(200) DEFAULT NULL COMMENT '오픈서치 Index 이름',
                                     `DESCRIPTION` varchar(1000) DEFAULT NULL COMMENT '지식 베이스 설명',
                                     `IMAGE` varchar(1000) DEFAULT NULL COMMENT '지식 베이스 이미지',
                                     `LANGUAGE` varchar(10) DEFAULT NULL COMMENT '문서 언어',
                                     `VIEW_ROLE` varchar(1) DEFAULT NULL COMMENT '열람 권한 (전사, 부분, 팀, 개인, 별도지정)',
                                     `FILE_TYPE` varchar(10) DEFAULT NULL COMMENT '등록 파일 유형 (pdf, jpg, excel, word)',
                                     `LAYOUT` varchar(10) DEFAULT NULL COMMENT '문서 Layout (복합(자동 인식), 메뉴얼, 법률, Q&A, Book)',
                                     `EXTRACT_TYPE` varchar(10) DEFAULT NULL COMMENT '추출 항목 (텍스트만, 이미지, 표)',
                                     `CHUNKING_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '기본 청킹 방법 (크기지정, 목차별 , 페이지)',
                                     `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Y' COMMENT '사용여부',
                                     `DEL_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제여부',
                                     `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                     `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                     `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                     `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                     `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                     `REG_STATUS` varchar(20) DEFAULT 'INIT' COMMENT '현재 생성 진행 상태',
                                     `REPO_SUBNM` varchar(100) DEFAULT NULL,
                                     PRIMARY KEY (`IDX`),
                                     UNIQUE KEY `UQ_INDEX` (`OSE_IDX_NM`)
) ENGINE=InnoDB AUTO_INCREMENT=824 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='지식 저장소';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_KNOWLEDGE_BASE`
--

LOCK TABLES `TB_KNOWLEDGE_BASE` WRITE;
/*!40000 ALTER TABLE `TB_KNOWLEDGE_BASE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_KNOWLEDGE_BASE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_KNOWLEDGE_BASE_CONFIG`
--

DROP TABLE IF EXISTS `TB_KNOWLEDGE_BASE_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_KNOWLEDGE_BASE_CONFIG` (
                                            `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                            `CONFIG_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '설정버전',
                                            `LATEST_YN` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '최종버전여부',
                                            `CHUNKING_STRATEGY` varchar(100) NOT NULL DEFAULT 'by_title' COMMENT '청킹전략',
                                            `EMBED_MODEL_ID` varchar(500) NOT NULL DEFAULT 'amazon.titan-embed-text-v2:0' COMMENT '임배드모델ID',
                                            `MODE` varchar(100) NOT NULL DEFAULT 'elements' COMMENT '청킹모드',
                                            `STRATEGY` varchar(100) NOT NULL DEFAULT 'hi_res' COMMENT '이미지 분할 전략',
                                            `HI_RES_MODEL_NAME` varchar(100) NOT NULL DEFAULT 'yolox' COMMENT 'HI RES 모델명',
                                            `EXTRACT_IMAGES_IN_PDF` tinyint(1) NOT NULL DEFAULT '1' COMMENT '이미지추출여부',
                                            `SKIP_INFER_TABLE_TYPES` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '테이블 미추출 문서타입',
                                            `PDF_INFER_TABLE_STRUCTURE` tinyint(1) DEFAULT '1' COMMENT '테이블HTML여부',
                                            `EXTRACT_IMAGE_BLOCK_TO_PAYLOAD` tinyint(1) NOT NULL DEFAULT '0' COMMENT '이미지저장여부',
                                            `MAX_CHARACTERS` int NOT NULL DEFAULT '4096' COMMENT '최대문자수',
                                            `NEW_AFTER_N_CHARS` int NOT NULL DEFAULT '4000' COMMENT '분할문자수',
                                            `COMBINE_TEXT_UNDER_N_CHARS` int NOT NULL DEFAULT '2000' COMMENT '단락문자수',
                                            `LANGUAGES` varchar(100) NOT NULL DEFAULT 'kor+eng' COMMENT '언어',
                                            `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                            `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                            `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                            `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                            `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                            UNIQUE KEY `INDEX_NAME` (`INDEX_NAME`,`CONFIG_VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='지식저장소 설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_KNOWLEDGE_BASE_CONFIG`
--

LOCK TABLES `TB_KNOWLEDGE_BASE_CONFIG` WRITE;
/*!40000 ALTER TABLE `TB_KNOWLEDGE_BASE_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_KNOWLEDGE_BASE_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_LLM_MODEL`
--

DROP TABLE IF EXISTS `TB_LLM_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_LLM_MODEL` (
                                `LLM_MODEL_ID` varchar(500) NOT NULL COMMENT 'LLM모델ID',
                                `MODEL_GROUP` varchar(100) NOT NULL COMMENT '모델그룹-BEDROCK, GEMINI',
                                `MODEL_TYPE` varchar(100) NOT NULL COMMENT '모델타입-LLM, EMBEDDING',
                                `DIMENSION` int DEFAULT NULL,
                                `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                PRIMARY KEY (`LLM_MODEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='LLM 모델';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_LLM_MODEL`
--

LOCK TABLES `TB_LLM_MODEL` WRITE;
/*!40000 ALTER TABLE `TB_LLM_MODEL` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_LLM_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MCP_BOOKMARK`
--

DROP TABLE IF EXISTS `TB_MCP_BOOKMARK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MCP_BOOKMARK` (
                                   `MCP_SRVR_CNTN_ID` varchar(50) NOT NULL COMMENT 'MCP 서버 접속 ID',
                                   `USER_ID` varchar(50) NOT NULL COMMENT '사용자 ID',
                                   `REG_DT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                   `REG_USER_ID` varchar(50) NOT NULL COMMENT '등록자 ID',
                                   `UPD_DT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                   `UPD_USER_ID` varchar(50) NOT NULL COMMENT '수정자 ID',
                                   PRIMARY KEY (`MCP_SRVR_CNTN_ID`,`USER_ID`),
                                   KEY `IDX_MCP_BOOKMARK_USER_ID` (`USER_ID`),
                                   KEY `IDX_MCP_BOOKMARK_REG_DT` (`REG_DT`),
                                   CONSTRAINT `TB_MCP_BOOKMARK_ibfk_1` FOREIGN KEY (`MCP_SRVR_CNTN_ID`) REFERENCES `TB_MCP_SRVR_CNTN_INFO` (`MCP_SRVR_CNTN_ID`) ON DELETE CASCADE,
                                   CONSTRAINT `TB_MCP_BOOKMARK_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `TB_SYS_USER` (`USER_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MCP 북마크';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MCP_BOOKMARK`
--

LOCK TABLES `TB_MCP_BOOKMARK` WRITE;
/*!40000 ALTER TABLE `TB_MCP_BOOKMARK` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_MCP_BOOKMARK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MCP_METADATA`
--

DROP TABLE IF EXISTS `TB_MCP_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MCP_METADATA` (
                                   `MCP_METADATA_SNO` bigint NOT NULL AUTO_INCREMENT COMMENT 'MCP-Metadata 관계 일련번호',
                                   `MCP_SRVR_CNTN_ID` varchar(40) NOT NULL COMMENT 'MCP서버접속ID',
                                   `METADATA_SNO` bigint NOT NULL COMMENT '메타데이터 일련번호',
                                   `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                                   PRIMARY KEY (`MCP_METADATA_SNO`),
                                   UNIQUE KEY `uk_mcp_metadata` (`MCP_SRVR_CNTN_ID`,`METADATA_SNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MCP-메타데이터 관계';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MCP_METADATA`
--

LOCK TABLES `TB_MCP_METADATA` WRITE;
/*!40000 ALTER TABLE `TB_MCP_METADATA` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_MCP_METADATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MCP_SRVR_CNTN_INFO`
--

DROP TABLE IF EXISTS `TB_MCP_SRVR_CNTN_INFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MCP_SRVR_CNTN_INFO` (
                                         `MCP_SRVR_CNTN_ID` varchar(50) NOT NULL DEFAULT (uuid()) COMMENT 'MCP서버접속ID',
                                         `MCP_SRVR_CNTN_JSON` text NOT NULL COMMENT 'MCP서버접속JSON',
                                         `MCP_SRVR_CNTN_JSON_FULL` text COMMENT 'MCP서버접속JSON전체',
                                         `MCP_SRVR_NM` varchar(100) NOT NULL COMMENT 'MCP서버명',
                                         `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                         `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                         `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                         `UPDT_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                         `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                         `MCP_SERVER_URL` varchar(100) DEFAULT NULL,
                                         `MCP_SRVR_CNTN_JSON_FULL_PLAIN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
                                         `SUBTITLE` varchar(200) DEFAULT NULL COMMENT 'MCP 서버 부제목',
                                         `AUTH_SCOPE` varchar(10) DEFAULT 'PUBLIC' COMMENT '인증 범위 (PERSONAL|PUBLIC)',
                                         `PUBLIC_SCOPE` varchar(10) DEFAULT 'PUB' COMMENT '공개 유형 (PUB|PRI|PRJ)',
                                         `PROVIDER` varchar(100) DEFAULT NULL COMMENT '제공자',
                                         `CONNECT_TYPE` varchar(20) DEFAULT 'STDIO' COMMENT '서버 통신 유형 (STDIO|SSE)',
                                         `DESCRIPTION` text COMMENT '설명',
                                         `VENDOR` varchar(100) DEFAULT NULL,
                                         PRIMARY KEY (`MCP_SRVR_CNTN_ID`),
                                         UNIQUE KEY `TB_MCP_SRVR_CNTN_INFO_MCP_SRVR_NM_IDX` (`MCP_SRVR_NM`) USING BTREE,
                                         CONSTRAINT `CHK_AUTH_SCOPE` CHECK ((`AUTH_SCOPE` in (_utf8mb4'PERSONAL',_utf8mb4'PUBLIC')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MCP서버접속정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MCP_SRVR_CNTN_INFO`
--

LOCK TABLES `TB_MCP_SRVR_CNTN_INFO` WRITE;
/*!40000 ALTER TABLE `TB_MCP_SRVR_CNTN_INFO` DISABLE KEYS */;
INSERT INTO `TB_MCP_SRVR_CNTN_INFO` VALUES ('4ceb0a69-1b3e-497f-b428-1d6fe7a79557','{\r\n  \"time\": {\r\n    \"command\": \"python\",\r\n    \"args\": [\"-m\", \"mcp_server_time\"]\r\n  },\r\n  \"gcalendar-mcp\": {\r\n    \"command\": \"python\",\r\n    \"args\": [\r\n      \"service/mcp_servers/google_calendar_tool.py\"\r\n    ],\r\n    \"transport\": \"stdio\"\r\n  }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8\r\nI60SwtYNscbiRvA89mgtFDopLjKsrbslp6ejpTbrb4p8RmcoHn1uL8sebzHkLy26W8leadYdkKmP\r\nq/TLEW3jVUoT+Q8JS/T99KAhv0QGx7enEtX/np5FGtTpDj5tzP4eUKEnTeQ79jbRwhA+wsjekZaL\r\noRyaOGXEYnx4QygBDBHyrF/RRWaZwdBMLt2E3EVPfgrkLVypEkdN7T27KaRuOgdOD9WSoGSIie5O\r\nBWAaR0H6utMVs/VM','Google Calendar','2025-06-18 16:55:45','air@megazone.com','2025-06-19 11:06:37','air@megazone.com','127.0.0.1',NULL,'{\r\n  \"gcalendar-mcp\": {\r\n    \"command\": \"python\",\r\n    \"args\": [\r\n      \"service/mcp_servers/google_calendar_tool.py\"\r\n    ],\r\n    \"transport\": \"stdio\"\r\n  }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('570c3033-def4-44e4-8b3a-f9b523222136','{\r\n    \"calculator\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/calculator.py\"]\r\n    }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8\r\nI60SwtYNscbiRvA89mgtFDopLjKsrbuIie5OBWAaR0H6utMVs/VM','Caculator','2025-05-14 11:24:01','air@megazone.com','2025-05-14 13:18:49','air@megazone.com','127.0.0.1',NULL,'{\r\n    \"calculator\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/calculator.py\"]\r\n    }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('570c3033-def4-44e4-8b3a-f9b523222137','{\r\n    \"google-gmail-server\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/gmail_server.py\"]\r\n    }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8\r\nI60SwtYNscbiRvA89mgtFDopLjKsrbuIie5OBWAaR0H6utMVs/VM','Gmail MCP Server','2025-05-14 11:24:01','air@megazone.com','2025-05-14 13:18:49','air@megazone.com','127.0.0.1',NULL,'{\r\n    \"google-gmail-server\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/gmail_server.py\"],\r\n      \"env\": {\r\n        \"GOOGLE_SERVICE_ACCOUNT_JSON\": \"{GOOGLE_SERVICE_ACCOUNT_JSON}\"\r\n      }\r\n    }\r\n}','Google Gmail 기반 메일 관리 MCP 서버','PERSONAL','PUB','AIR Development Team','STDIO',NULL,'Google'),('dd5e66de-8e79-49a7-9d13-d5622f1b2510','{\r\n  \"mcp-atlassian\": {\r\n    \"command\": \"python\",\r\n    \"args\": [\r\n      \"service/mcp_servers/confluence_server.py\"\r\n    ],\r\n    \"env\": {\r\n      \"CONFLUENCE_INSTANCE_URL\": \"{CONFLUENCE_INSTANCE_URL}\",\r\n      \"CONFLUENCE_USERNAME\": \"{CONFLUENCE_USERNAME}\",\r\n      \"CONFLUENCE_API_TOKEN\": \"{CONFLUENCE_API_TOKEN}\"\r\n    },\r\n    \"transport\": \"stdio\"\r\n  }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8','Confluence MCP Server','2025-04-17 10:06:25','air@megazone.com','2025-05-23 13:47:09','air@megazone.com','127.0.0.1','','{\r\n  \"mcp-atlassian\": {\r\n    \"command\": \"python\",\r\n    \"args\": [\r\n      \"service/mcp_servers/confluence_server.py\"\r\n    ],\r\n    \"env\": {\r\n      \"CONFLUENCE_INSTANCE_URL\": \"{CONFLUENCE_INSTANCE_URL}\",\r\n      \"CONFLUENCE_USERNAME\": \"{CONFLUENCE_USERNAME}\",\r\n      \"CONFLUENCE_API_TOKEN\": \"{CONFLUENCE_API_TOKEN}\"\r\n    },\r\n    \"transport\": \"stdio\"\r\n  }\r\n}',NULL,'PERSONAL','PUB',NULL,'STDIO',NULL,'Atlassian'),('dd5e66de-8e79-49a7-9d13-d5622f1b2512','{\r\n    \"awslabs.core-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\r\n        \"awslabs.core-mcp-server@latest\"\r\n      ],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\"\r\n      },\r\n      \"autoApprove\": [],\r\n      \"disabled\": false\r\n    }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8','AWS Core MCP Server','2025-04-17 10:06:25','air@megazone.com','2025-05-23 13:47:09','air@megazone.com','127.0.0.1','','{\r\n    \"awslabs.core-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\r\n        \"awslabs.core-mcp-server@latest\"\r\n      ],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\"\r\n      },\r\n      \"autoApprove\": [],\r\n      \"disabled\": false\r\n    }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('dd5e66de-8e79-49a7-9d13-d5622f1b2514','{\r\n    \"awslabs.aws-documentation-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-documentation-mcp-server@latest\"],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\",\r\n        \"AWS_DOCUMENTATION_PARTITION\": \"aws\"\r\n      },\r\n      \"disabled\": false,\r\n      \"autoApprove\": []\r\n    }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8','AWS Documentation MCP Server','2025-04-17 10:06:25','air@megazone.com','2025-05-23 13:47:09','air@megazone.com','127.0.0.1','','{\r\n    \"awslabs.aws-documentation-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-documentation-mcp-server@latest\"],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\",\r\n        \"AWS_DOCUMENTATION_PARTITION\": \"aws\"\r\n      },\r\n      \"disabled\": false,\r\n      \"autoApprove\": []\r\n    }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('dd5e66de-8e79-49a7-9d13-d5622f1b2515','{\r\n  \"awslabs.cost-analysis-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-pricing-mcp-server@latest\"],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\",\r\n        \"AWS_PROFILE\": \"your-aws-profile\"\r\n      },\r\n      \"disabled\": false,\r\n      \"autoApprove\": []\r\n   }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8','AWS Cost Analysis','2025-04-17 10:06:25','air@megazone.com','2025-05-23 13:47:09','air@megazone.com','127.0.0.1','','{\r\n  \"awslabs.cost-analysis-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-pricing-mcp-server@latest\"],\r\n      \"env\": {\r\n        \"AWS_ACCESS_KEY_ID\" : \"ASIAIOSFODNN7EXAMPLE\",\r\n        \"AWS_SECRET_ACCESS_KEY\" : \"wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY\"\r\n      },\r\n      \"disabled\": false,\r\n      \"autoApprove\": []\r\n  } \r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('dd5e66de-8e79-49a7-9d13-d5622f1b2516','{\r\n  \"awslabs.aws-diagram-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-diagram-mcp-server\"],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\"\r\n      },\r\n      \"autoApprove\": [],\r\n      \"disabled\": false\r\n  }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8','AWS Diagram MCP Server','2025-04-17 10:06:25','air@megazone.com','2025-05-23 13:47:09','air@megazone.com','127.0.0.1','','{\r\n  \"awslabs.aws-diagram-mcp-server\": {\r\n      \"command\": \"uvx\",\r\n      \"args\": [\"awslabs.aws-diagram-mcp-server\"],\r\n      \"env\": {\r\n        \"FASTMCP_LOG_LEVEL\": \"ERROR\"\r\n      },\r\n      \"autoApprove\": [],\r\n      \"disabled\": false\r\n  }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL),('knowledge-base','{\r\n    \"rag\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/rag_server.py\"]\r\n    }\r\n}','bFRmU876BdbBnKgPwzpXvc0w+xNVIXnaJMlzhk/GL2HR9f+olgwMqxDI8Hs5ABlqIy/KE6q4h5/8\r\nI60SwtYNscbiRvA89mgtFDopLjKsrbuIie5OBWAaR0H6utMVs/VM','RAG','2025-06-30 19:45:00','air@megazone.com','2025-06-30 19:45:09','air@megazone.com','127.0.0.1',NULL,'{\r\n    \"rag\": {\r\n      \"command\": \"python3\",\r\n      \"args\": [\"service/mcp_servers/rag_server.py\"]\r\n    }\r\n}',NULL,'PUBLIC','PUB',NULL,'STDIO',NULL,NULL);
/*!40000 ALTER TABLE `TB_MCP_SRVR_CNTN_INFO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MCP_SRVR_CNTN_INFO_KEY`
--

DROP TABLE IF EXISTS `TB_MCP_SRVR_CNTN_INFO_KEY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MCP_SRVR_CNTN_INFO_KEY` (
                                             `MCP_SRVR_CNTN_ID` varchar(50) NOT NULL COMMENT 'MCP서버접속ID',
                                             `ITEM_KEY` varchar(50) NOT NULL COMMENT '항목키',
                                             `ITEM_VL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '항목값',
                                             `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                             `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                             `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                             `UPDT_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                             `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                             PRIMARY KEY (`MCP_SRVR_CNTN_ID`,`ITEM_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MCP서버접속정보-KEY';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MCP_SRVR_CNTN_INFO_KEY`
--

LOCK TABLES `TB_MCP_SRVR_CNTN_INFO_KEY` WRITE;
/*!40000 ALTER TABLE `TB_MCP_SRVR_CNTN_INFO_KEY` DISABLE KEYS */;
INSERT INTO `TB_MCP_SRVR_CNTN_INFO_KEY` VALUES ('013a0df0-79b7-457f-bbf1-a28d6b16ff0e','host','V5AXHjISRccvy0WlRSgbnw==','2025-06-27 18:59:23','sungyup@mz.co.kr','2025-06-27 18:59:23','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),('013a0df0-79b7-457f-bbf1-a28d6b16ff0e','port','hoI4YT0vd3Z3XAbGm1UEcA==','2025-06-27 18:59:23','sungyup@mz.co.kr','2025-06-27 18:59:23','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),('26c5cbba-84b8-445f-8e8e-0aace48df838','x-api-key','cUyvdTBZRP9P1Rdt6x4NPTEAzoi5Xa+ezWIEc8Xr9Gi6XqZ0uWMLhxEfGQ+JFqOX','2025-05-27 07:27:34','eungkyunglee@mz.co.kr','2025-05-27 07:27:34','eungkyunglee@mz.co.kr','143.0.2.91'),('28856ec2-18e4-4a48-a8de-437ae36a1e94','MOZO_API_TOKEN','i+Xc2V35OvHvzHoCtF8bcLM1CL8JPFkaKZEgtIyDGOAfEdGXGj5JdHLTQmuiZxds','2025-05-23 13:47:23','bgkim@mz.co.kr','2025-05-23 13:47:23','bgkim@mz.co.kr','143.0.2.204'),('28856ec2-18e4-4a48-a8de-437ae36a1e94','TAVILY_API_KEY','tekREV5ZzP4fYkZTAr6uuBxAtsJpcBmRHQNYWtvBymWbPYwDDGrGHnXlbLF91Egn','2025-05-23 13:47:23','bgkim@mz.co.kr','2025-05-23 13:47:23','bgkim@mz.co.kr','143.0.2.204'),('29357425-46af-4f4b-b7c4-7a0de89445cf','SLACK_API_KEY','2RZOLLxWDUM3FQgHpkMqP0dgKdECrM5Od5xE0PhH9kpMBfKybfmQtQl65sO4GMvu','2025-05-16 16:33:08','eungkyunglee@mz.co.kr','2025-05-16 16:33:08','eungkyunglee@mz.co.kr','143.0.3.56'),('570c3033-def4-44e4-8b3a-f9b523222136','TAVILY_API_KEY','tekREV5ZzP4fYkZTAr6uuBxAtsJpcBmRHQNYWtvBymWbPYwDDGrGHnXlbLF91Egn','2025-05-14 13:18:49','eungkyunglee@mz.co.kr','2025-05-14 13:18:49','eungkyunglee@mz.co.kr','143.0.2.246'),('c824f288-7205-4abb-ac5b-c8cf57993c22','NOTION_API_KEY','209K34YIM25SdWp1A1n8Pf7ymzA+nyPflZ86v1hnZGDIrk6mB8xPfSHvGI8Q3qa/It1gm1oJGVLd\nnPc9Dz4Pig==','2025-06-10 15:13:42','eungkyunglee@mz.co.kr','2025-06-10 15:13:42','eungkyunglee@mz.co.kr','143.0.3.223'),('cecb27df-d434-4b2c-8ad4-de099913be71','CONFLUENCE_TOKEN','jFX3iQOr8mV+bC35DCYalA8TH+aFMQtGuZ3o3vf9LMqoQk4o9Ifjtak04ozmpyR9PITV6dfUW/bW\n6m4qeggS0jlTC37oobVoJUP7h/TGiFfxoyuKMdHIoRGoLnYELUPUrvlx6rK/74siKEZyrV18+cLt\nu8wu3EYmYSyJXgeUwhRRsYOCFgzVaaOiaiL1H+PypXf0Yxf/mDmfY35gX0icf5zZHQIFttAH/Vh3\nd4SfH41LuigP96N3U52JBAE2Xmn7vHgckyQvxMpuGSMubmre2w==','2025-05-23 13:36:59','bgkim@mz.co.kr','2025-05-23 13:36:59','bgkim@mz.co.kr','143.0.3.75'),('cecb27df-d434-4b2c-8ad4-de099913be71','MOZO_API_TOKEN','i+Xc2V35OvHvzHoCtF8bcLM1CL8JPFkaKZEgtIyDGOAfEdGXGj5JdHLTQmuiZxds','2025-05-23 13:36:59','bgkim@mz.co.kr','2025-05-23 13:36:59','bgkim@mz.co.kr','143.0.3.75'),('cecb27df-d434-4b2c-8ad4-de099913be71','TAVILY_API_KEY','tekREV5ZzP4fYkZTAr6uuBxAtsJpcBmRHQNYWtvBymWbPYwDDGrGHnXlbLF91Egn','2025-05-23 13:36:59','bgkim@mz.co.kr','2025-05-23 13:36:59','bgkim@mz.co.kr','143.0.3.75'),('dd5e66de-8e79-49a7-9d13-d5622f1b2509','CONFLUENCE_TOKEN','jFX3iQOr8mV+bC35DCYalA8TH+aFMQtGuZ3o3vf9LMqoQk4o9Ifjtak04ozmpyR9PITV6dfUW/bW\n6m4qeggS0jlTC37oobVoJUP7h/TGiFfxoyuKMdHIoRGoLnYELUPUrvlx6rK/74siKEZyrV18+cLt\nu8wu3EYmYSyJXgeUwhRRsYOCFgzVaaOiaiL1H+PypXf0Yxf/mDmfY35gX0icf5zZHQIFttAH/Vh3\nd4SfH41LuigP96N3U52JBAE2Xmn7vHgckyQvxMpuGSMubmre2w==','2025-05-23 13:47:09','bgkim@mz.co.kr','2025-05-23 13:47:09','bgkim@mz.co.kr','143.0.2.204'),('dd5e66de-8e79-49a7-9d13-d5622f1b2509','JIRA_TOKEN','jFX3iQOr8mV+bC35DCYalA8TH+aFMQtGuZ3o3vf9LMqoQk4o9Ifjtak04ozmpyR9PITV6dfUW/bW\n6m4qeggS0jlTC37oobVoJUP7h/TGiFfxoyuKMdHIoRGoLnYELUPUrvlx6rK/74siKEZyrV18+cLt\nu8wu3EYmYSyJXgeUwhRRsYOCFgzVaaOiaiL1H+PypXf0Yxf/mDmfY35gX0icf5zZHQIFttAH/Vh3\nd4SfH41LuigP96N3U52JBAE2Xmn7vHgckyQvxMpuGSMubmre2w==','2025-05-23 13:47:09','bgkim@mz.co.kr','2025-05-23 13:47:09','bgkim@mz.co.kr','143.0.2.204'),('dd5e66de-8e79-49a7-9d13-d5622f1b2509','MOZO_API_TOKEN','i+Xc2V35OvHvzHoCtF8bcLM1CL8JPFkaKZEgtIyDGOAfEdGXGj5JdHLTQmuiZxds','2025-05-23 13:47:09','bgkim@mz.co.kr','2025-05-23 13:47:09','bgkim@mz.co.kr','143.0.2.204'),('dd5e66de-8e79-49a7-9d13-d5622f1b2509','TAVILY_API_KEY','tekREV5ZzP4fYkZTAr6uuBxAtsJpcBmRHQNYWtvBymWbPYwDDGrGHnXlbLF91Egn','2025-05-23 13:47:09','bgkim@mz.co.kr','2025-05-23 13:47:09','bgkim@mz.co.kr','143.0.2.204');
/*!40000 ALTER TABLE `TB_MCP_SRVR_CNTN_INFO_KEY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_METADATA`
--

DROP TABLE IF EXISTS `TB_METADATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_METADATA` (
                               `METADATA_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq',
                               `CONTENT` varchar(15) NOT NULL COMMENT '내용',
                               `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
                               PRIMARY KEY (`METADATA_SNO`),
                               UNIQUE KEY `TB_METADATA_UNIQUE` (`METADATA_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_METADATA`
--

LOCK TABLES `TB_METADATA` WRITE;
/*!40000 ALTER TABLE `TB_METADATA` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_METADATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MODEL`
--

DROP TABLE IF EXISTS `TB_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MODEL` (
                            `MODEL_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '모델 ID (UUID)',
                            `MODEL_NAME` varchar(255) NOT NULL COMMENT '모델이름',
                            `MODEL_GROUP_SNO` bigint unsigned NOT NULL COMMENT 'Model 공급사 Seq',
                            `MODEL_TYPE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'LLM' COMMENT '모델 타입 (LLM, EMBEDDING 등)',
                            `DIMENSION` int DEFAULT NULL COMMENT '임베딩 차원수 (임베딩 모델인 경우)',
                            `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                            `REG_USER_ID` varchar(100) DEFAULT 'system' COMMENT '등록사용자ID',
                            `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                            `UPDT_USER_ID` varchar(100) DEFAULT 'system' COMMENT '수정사용자ID',
                            `UPDT_USER_IP` varchar(45) DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                            `DEL_YN` varchar(1) DEFAULT 'N' COMMENT '삭제 여부',
                            `USE_YN` varchar(1) DEFAULT 'Y' COMMENT '사용 여부',
                            `DESCRIPTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '모델 설명',
                            `PROPERTIES` longtext COMMENT '모델 단위로 적용되는 환경 변수 (JSON)',
                            `SUBTITLE` text,
                            PRIMARY KEY (`MODEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MODEL`
--

LOCK TABLES `TB_MODEL` WRITE;
/*!40000 ALTER TABLE `TB_MODEL` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_MODEL_GROUP`
--

DROP TABLE IF EXISTS `TB_MODEL_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_MODEL_GROUP` (
                                  `MODEL_GROUP_SNO` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Model 공급사 Seq',
                                  `MODEL_GROUP_NAME` varchar(255) NOT NULL COMMENT '공급사 이름',
                                  `REG_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
                                  `REG_USER_ID` varchar(100) DEFAULT 'system' COMMENT '생성 아이디',
                                  `UPDT_USER_ID` varchar(100) DEFAULT 'system' COMMENT '수정 아이디',
                                  `UPDT_USER_IP` varchar(45) DEFAULT '127.0.0.1' COMMENT '사용자 IP',
                                  `DEL_YN` varchar(1) DEFAULT 'N' COMMENT '삭제 여부',
                                  `USE_YN` varchar(1) DEFAULT 'Y' COMMENT '사용 여부',
                                  `DESCRIPTION` varchar(200) DEFAULT NULL COMMENT '설명',
                                  `PROPERTIES` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '모델 공급사 단위로 적용되는 환경 변수 (JSON)',
                                  `UPDT_DTTM` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정 일시',
                                  `MODEL_PROPERTIES` longtext COMMENT 'MODEL 생성에서 사용되는 Properties Template (JSON)',
                                  PRIMARY KEY (`MODEL_GROUP_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_MODEL_GROUP`
--

LOCK TABLES `TB_MODEL_GROUP` WRITE;
/*!40000 ALTER TABLE `TB_MODEL_GROUP` DISABLE KEYS */;
INSERT INTO `TB_MODEL_GROUP` VALUES (1,'AWS Bedrock','2025-06-25 07:20:00','system','SYSTEM','127.0.0.1','N','Y','AWS에서 다양한 생성형 AI 모델(Titan, Claude, Llama 등)을 통합 API로 제공하는 플랫폼입니다.','[{\"name\":\"Access Key\",\"key\":\"AWS_ACCESS_KEY_ID\",\"value\":\"\"},{\"name\":\"Secret Key\",\"key\":\"AWS_SECRET_ACCESS_KEY\",\"value\":\""},{\"name\":\"Test 전용 Properties\",\"key\":\"AWS_BEDROCK_TEST_PROPERTIES\",\"value\":\"this_is_test_key\"}]','2025-07-09 05:45:29','[{\"key\":\"region\",\"name\":\"Region\",\"value\":\"\"}]'));
/*!40000 ALTER TABLE `TB_MODEL_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PARSER`
--

DROP TABLE IF EXISTS `TB_PARSER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PARSER` (
                             `PARSER_ID` bigint NOT NULL AUTO_INCREMENT COMMENT '파서 고유 ID',
                             `PARSER_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파서 이름',
                             `PARSER_DESCRIPTION` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '파서 설명',
                             `SUBTITLE_INFO` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '서브 타이틀 정보',
                             `SUPPLIER_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '공급사명',
                             `VERSION_INFO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '버전 정보',
                             `PARSER_TYPE` enum('INTERNAL','EXTERNAL') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INTERNAL' COMMENT '파서 유형 (내부파서/외부파서)',
                             `PARSER_URL` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파서 URL (외부파서인 경우)',
                             `IS_PUBLIC` tinyint(1) NOT NULL DEFAULT '1' COMMENT '공개 여부 (1: 공개, 0: 비공개)',
                             `CREATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
                             `UPDATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 수정일시',
                             `CREATED_BY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '생성자',
                             `UPDATED_BY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
                             PRIMARY KEY (`PARSER_ID`),
                             KEY `IDX_PARSER_NAME` (`PARSER_NAME`),
                             KEY `IDX_PARSER_TYPE` (`PARSER_TYPE`),
                             KEY `IDX_IS_PUBLIC` (`IS_PUBLIC`),
                             KEY `IDX_CREATED_AT` (`CREATED_AT`),
                             KEY `IDX_PARSER_SEARCH` (`PARSER_NAME`,`PARSER_TYPE`,`IS_PUBLIC`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='파서 정보 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PARSER`
--

LOCK TABLES `TB_PARSER` WRITE;
/*!40000 ALTER TABLE `TB_PARSER` DISABLE KEYS */;
INSERT INTO `TB_PARSER` VALUES (1,'Unstructured Parser','다양한 문서 유형(PDF, HTML, DOCX 등)을 구조화된 텍스트로 변환하는 범용 파서입니다.','다양한 포맷의 문서를 구조화된 텍스트로 손쉽게 파싱합니다.','Unstructured.io','Ver 0.7.2','EXTERNAL','https://parser.internal/api',1,'2025-10-15 05:20:30','2025-10-15 05:20:30','SYSTEM','SYSTEM'),(2,'PDF Parser','PDF 문서를 텍스트로 변환하는 내부 파서입니다.','PDF 문서를 빠르고 정확하게 텍스트로 변환합니다.','AIR Studio','Ver 1.0.0','INTERNAL',NULL,1,'2025-09-25 06:31:19','2025-09-25 06:31:19','SYSTEM','SYSTEM'),(3,'HTML Parser','HTML 문서를 텍스트로 변환하는 내부 파서입니다.','HTML 태그를 제거하고 순수 텍스트를 추출합니다.','AIR Studio','Ver 1.0.0','INTERNAL',NULL,1,'2025-09-25 06:31:19','2025-09-25 06:31:19','SYSTEM','SYSTEM'),(4,'DOCX Parser','Microsoft Word DOCX 문서를 텍스트로 변환하는 내부 파서입니다.','DOCX 문서의 모든 텍스트 내용을 추출합니다.','AIR Studio','Ver 1.0.0','INTERNAL',NULL,1,'2025-09-25 06:31:19','2025-09-25 06:31:19','SYSTEM','SYSTEM'),(9,'pymupdf4llm+paddleocr','pymupdf4llm+paddleocr 조합한 parser 입니다.','pymupdf4llm+paddleocr 조합한 parser 입니다.','AIR Studio','Ver 1.0.0','INTERNAL',NULL,1,'2025-08-27 01:18:02','2025-08-27 01:18:02','SYSTEM','SYSTEM');
/*!40000 ALTER TABLE `TB_PARSER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT`
--

DROP TABLE IF EXISTS `TB_PROMPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT` (
                             `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                             `PROMPT_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '프롬프트명',
                             `PROMPT_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '버전',
                             `PROMPT_NO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                             `PROMPT_TYPE` varchar(10) DEFAULT NULL COMMENT '프롬프트구분:시스템프롬프트, 사용자프롬프트 등',
                             `AGENT_TYPE` varchar(10) DEFAULT NULL COMMENT '에이전트종류: 전처리,QNA,연관질문 등',
                             `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '프롬프트 내용',
                             `PROMPT_DESC` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '프롬프트설명',
                             `PROMPT_ETC1` varchar(100) DEFAULT NULL COMMENT 'dmmy',
                             `PROMPT_ETC2` varchar(100) DEFAULT NULL COMMENT 'dmmy',
                             `USE_YN` varchar(5) DEFAULT 'Y' COMMENT '사용 여부',
                             `DEL_YN` varchar(1) DEFAULT 'N' COMMENT '삭제 여부',
                             `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                             `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                             `REG_USER_IP` varchar(23) DEFAULT NULL COMMENT '등록사용자IP',
                             `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                             `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                             `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                             PRIMARY KEY (`PROMPT_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=970 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT`
--

LOCK TABLES `TB_PROMPT` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT_INDEX_RLT`
--

DROP TABLE IF EXISTS `TB_PROMPT_INDEX_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT_INDEX_RLT` (
                                       `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                                       `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                       `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                       `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                       `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                       `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                       `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                       `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                       PRIMARY KEY (`PROMPT_SNO`,`INDEX_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 인덱스 Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT_INDEX_RLT`
--

LOCK TABLES `TB_PROMPT_INDEX_RLT` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT_INDEX_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT_INDEX_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT_INDEX_USER_RLT`
--

DROP TABLE IF EXISTS `TB_PROMPT_INDEX_USER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT_INDEX_USER_RLT` (
                                            `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                                            `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                            `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID[사용자이메일주소]',
                                            `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'KNOWLEDGE,AGENT',
                                            `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                            `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                            `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                            `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                            `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                            `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                            PRIMARY KEY (`PROMPT_SNO`,`INDEX_NAME`,`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=895 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 인덱스 사용자 Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT_INDEX_USER_RLT`
--

LOCK TABLES `TB_PROMPT_INDEX_USER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT_INDEX_USER_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT_INDEX_USER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT_MASTER`
--

DROP TABLE IF EXISTS `TB_PROMPT_MASTER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT_MASTER` (
                                    `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                                    `PROMPT_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '프롬프트명',
                                    `PROMPT_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '버전',
                                    `PROMPT_NO` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                    `PROMPT_TYPE` varchar(10) DEFAULT NULL COMMENT '프롬프트구분:시스템프롬프트, 사용자프롬프트 등',
                                    `AGENT_TYPE` varchar(10) DEFAULT NULL COMMENT '에이전트종류: 전처리,QNA,연관질문 등',
                                    `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '프롬프트 내용',
                                    `PROMPT_DESC` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '프롬프트설명',
                                    `PROMPT_ETC1` varchar(100) DEFAULT NULL COMMENT 'dmmy',
                                    `PROMPT_ETC2` varchar(100) DEFAULT NULL COMMENT 'dmmy',
                                    `USE_YN` varchar(5) DEFAULT 'Y' COMMENT '사용 여부',
                                    `DEL_YN` varchar(1) DEFAULT 'N' COMMENT '삭제 여부',
                                    `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                    `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                    `REG_USER_IP` varchar(23) DEFAULT NULL COMMENT '등록사용자IP',
                                    `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                    `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                    `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                    PRIMARY KEY (`PROMPT_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=837 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT_MASTER`
--

LOCK TABLES `TB_PROMPT_MASTER` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT_MASTER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT_MASTER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT_RLT`
--

DROP TABLE IF EXISTS `TB_PROMPT_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT_RLT` (
                                 `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                                 `PROMPT_RLT_CD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'KNOWLEDGE(10) AGENT(20)',
                                 `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                 `AGENT_ID` varchar(500) DEFAULT NULL COMMENT '에이전트 ID',
                                 `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID[사용자이메일주소] or null',
                                 `USER_DFN_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '사용자 프롬프트 여부',
                                 `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                 `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                 `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                 `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                 `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                 `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                 PRIMARY KEY (`PROMPT_SNO`,`INDEX_NAME`,`USER_ID`),
                                 CONSTRAINT `TB_PROMPT_RLT_chk_1` CHECK (((`INDEX_NAME` is not null) or (`AGENT_ID` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=1178 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 인덱스, 프롬프트 인덱스 사용자, 프롬프트 에이전트 사용자 Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT_RLT`
--

LOCK TABLES `TB_PROMPT_RLT` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_PROMPT_USER_RLT`
--

DROP TABLE IF EXISTS `TB_PROMPT_USER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_PROMPT_USER_RLT` (
                                      `PROMPT_SNO` int NOT NULL AUTO_INCREMENT COMMENT '프롬프트번호',
                                      `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID[사용자이메일주소]',
                                      `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                      `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                      `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                      `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                      `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                      `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                      PRIMARY KEY (`PROMPT_SNO`,`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=837 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 사용자 Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_PROMPT_USER_RLT`
--

LOCK TABLES `TB_PROMPT_USER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_PROMPT_USER_RLT` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_PROMPT_USER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_RAG_PIPELINE_SETTING`
--

DROP TABLE IF EXISTS `TB_RAG_PIPELINE_SETTING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_RAG_PIPELINE_SETTING` (
                                           `PK_ID` bigint NOT NULL AUTO_INCREMENT COMMENT '고유 ID',
                                           `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '이름',
                                           `DESCRIPTION` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '설명',
                                           `FK_PARSER_ID` bigint NOT NULL COMMENT '파서 ID',
                                           `STRATEGY` varchar(100) NOT NULL DEFAULT 'hi_res' COMMENT '이미지 분할 전략',
                                           `HI_RES_MODEL_NAME` varchar(100) NOT NULL DEFAULT 'yolox' COMMENT 'HI RES 모델명',
                                           `EXTRACT_IMAGES_IN_PDF` tinyint(1) NOT NULL DEFAULT '1' COMMENT '이미지추출여부',
                                           `EXTRACT_IMAGE_BLOCK_TO_PAYLOAD` tinyint(1) NOT NULL DEFAULT '0' COMMENT '이미지저장여부',
                                           `SKIP_INFER_TABLE_TYPES` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '테이블 미추출 문서타입',
                                           `CHUNKING_STRATEGY` varchar(100) NOT NULL DEFAULT 'by_title' COMMENT '청킹전략',
                                           `MODE` varchar(100) NOT NULL DEFAULT 'elements' COMMENT '청킹모드',
                                           `PDF_INFER_TABLE_STRUCTURE` tinyint(1) DEFAULT '1' COMMENT '테이블HTML여부',
                                           `MAX_CHARACTERS` int NOT NULL DEFAULT '4096' COMMENT '최대문자수',
                                           `NEW_AFTER_N_CHARS` int NOT NULL DEFAULT '4000' COMMENT '분할문자수',
                                           `COMBINE_TEXT_UNDER_N_CHARS` int NOT NULL DEFAULT '2000' COMMENT '단락문자수',
                                           `LANGUAGES` varchar(100) NOT NULL DEFAULT 'kor+eng' COMMENT '언어',
                                           `REGULAR_EXPRESSION` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '정규식',
                                           `USE_YN` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '공유 유',
                                           `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                           `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                           `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                           `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                           `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                           PRIMARY KEY (`PK_ID`),
                                           KEY `IDX_FK_PARSER_ID` (`FK_PARSER_ID`),
                                           KEY `IDX_REG_DTTM` (`REG_DTTM`),
                                           CONSTRAINT `FK_RAG_PIPELINE_PARSER` FOREIGN KEY (`FK_PARSER_ID`) REFERENCES `TB_PARSER` (`PARSER_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='RAG DATA 파이프라인 설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_RAG_PIPELINE_SETTING`
--

LOCK TABLES `TB_RAG_PIPELINE_SETTING` WRITE;
/*!40000 ALTER TABLE `TB_RAG_PIPELINE_SETTING` DISABLE KEYS */;
INSERT INTO `TB_RAG_PIPELINE_SETTING` VALUES (20,'Section-Based Document Analyzer','- Title/section/paragraph-driven analysis\r\n- Best for documents with clear titles/sections/headers\r\n- Enables section-level evidence citation\r\n- Typical sources: technical documents, wikis, manuals, structured reports',4,'auto','',1,0,'','by_title','elements',0,1000,500,200,'kor+eng','','Y','2025-08-26 09:25:28','air@megazone.com','2025-08-29 08:51:35','air@megazone.com','127.0.0.1'),(21,'General-Purpose Document Analyzer','- Page-based analyzer for general documents\r\n- Best suited for documents with a standardized, page-level layout\r\n- Typical sources: reports, slide decks (PPT), contracts, insurance policy booklets, legal documents, regulatory manuals',2,'fast','',1,0,'','by_page','elements',0,1000,500,200,'kor+eng','','Y','2025-08-26 09:25:36','air@megazone.com','2025-08-29 09:35:02','air@megazone.com','127.0.0.1'),(22,'unstructured_parser','unstructured_parser',1,'fast','',0,0,'','by_title','elements',0,1000,500,200,'kor+eng','','N','2025-08-26 09:26:17','air@megazone.com','2025-08-29 08:59:35','kangmj@mz.co.kr','127.0.0.1'),(26,'paddleocr_parser','paddleocr_parser',3,'ocr_only','',0,0,'','by_title','elements',0,1000,500,200,'kor+eng','','N','2025-08-26 09:52:28','air@megazone.com','2025-08-29 07:44:05','kangmj@mz.co.kr','127.0.0.1'),(33,'pymupdf4llm+paddleocr_parser','pymupdf4llm+paddleocr',9,'auto','',1,1,'','by_title','elements',0,1000,500,200,'kor+eng','','N','2025-08-27 01:18:59','air@megazone.com','2025-08-29 07:43:56','kangmj@mz.co.kr','127.0.0.1'),(34,'Semantic Document Analyzer','- Suited for documents with frequent topic shifts\r\n- Works well when topics change often across items (e.g., competitor analyses)\r\n- Effective for collections of semantically similar content (e.g., customer feedback)\r\n- Typical sources: analytical reports, reviews/surveys/summaries, customer-feedback compilations',4,'auto','',1,0,'','by_similarity','elements',0,1000,500,200,'kor+eng','','Y','2025-08-29 08:39:45','air@megazone.com','2025-08-29 08:49:01','air@megazone.com','127.0.0.1'),(35,'Narrative Document Analyzer','- Optimized for continuous, prose-style content\r\n- Handles documents mixing headers, paragraphs, and lists\r\n- Typical sources: news articles, blogs, meeting minutes, wikis',4,'auto','',1,0,'','basic','elements',0,1000,500,200,'kor+eng','','Y','2025-08-29 08:53:32','air@megazone.com','2025-08-29 08:53:32','air@megazone.com','127.0.0.1'),(36,'Page-Based Document Analyzer','- Page-level analysis where each page is a meaningful unit\r\n- Facilitates precise page-number citation\r\n- Effective for pages containing tables/figures/charts\r\n- Typical sources: reports, slide decks (PPT), contracts, insurance policy booklets, legal and regulatory documents',4,'auto','',1,0,'','by_page','elements',0,1000,500,200,'kor+eng','','Y','2025-08-29 08:55:17','air@megazone.com','2025-08-29 08:55:17','air@megazone.com','127.0.0.1');
/*!40000 ALTER TABLE `TB_RAG_PIPELINE_SETTING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_RETRIEVER_CONFIG`
--

DROP TABLE IF EXISTS `TB_RETRIEVER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_RETRIEVER_CONFIG` (
                                       `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                       `CONFIG_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '설정버전',
                                       `LATEST_YN` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '최종버전여부',
                                       `EMBED_MODEL_ID` varchar(500) NOT NULL DEFAULT 'amazon.titan-embed-text-v2:0' COMMENT '임배드모델ID',
                                       `HYBRID_SEARCH_DEBUGGER` varchar(100) NOT NULL DEFAULT 'None' COMMENT '서치디버깅모드',
                                       `MINIMUM_SHOULD_MATCH` int NOT NULL DEFAULT '0' COMMENT '최소반환수',
                                       `FILTER` varchar(1000) NOT NULL DEFAULT '' COMMENT '서치필터',
                                       `FUSION_ALGORITHM` varchar(100) NOT NULL DEFAULT 'RRF' COMMENT '퓨전알고리즘',
                                       `ENSEMBLE_WEIGHTS` varchar(100) NOT NULL DEFAULT '.51|.49' COMMENT '검색비율',
                                       `RERANKER` tinyint(1) NOT NULL DEFAULT '0' COMMENT '리랭킹여부',
                                       `RERANKER_ENDPOINT_NAME` varchar(1000) NOT NULL DEFAULT '' COMMENT '리랭킹엔드포인트',
                                       `PARENT_DOCUMENT` tinyint(1) NOT NULL DEFAULT '1' COMMENT '부모문서검색여부',
                                       `RAG_FUSION` tinyint(1) NOT NULL DEFAULT '0' COMMENT '라그퓨전',
                                       `QUERY_AUGMENTATION_SIZE` int NOT NULL DEFAULT '2' COMMENT '검색증강크기',
                                       `HYDE` tinyint(1) NOT NULL DEFAULT '0' COMMENT '하이드여부',
                                       `HYDE_QUERY` varchar(1000) NOT NULL DEFAULT 'web_search' COMMENT '하이드쿼리',
                                       `COMPLEX_DOC` tinyint(1) NOT NULL DEFAULT '1' COMMENT '복합문서여부',
                                       `ASYNC_MODE` tinyint(1) NOT NULL DEFAULT '1' COMMENT '비동기모드',
                                       `K` int NOT NULL DEFAULT '3' COMMENT '반환문서수',
                                       `VERBOSE` tinyint(1) NOT NULL DEFAULT '1' COMMENT '로깅여부',
                                       `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                       `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                       `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                       `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                       `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                       UNIQUE KEY `INDEX_NAME` (`INDEX_NAME`,`CONFIG_VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='검색 설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_RETRIEVER_CONFIG`
--

LOCK TABLES `TB_RETRIEVER_CONFIG` WRITE;
/*!40000 ALTER TABLE `TB_RETRIEVER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_RETRIEVER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SESSION`
--

DROP TABLE IF EXISTS `TB_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SESSION` (
                              `SESSION_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT (uuid()) COMMENT 'Session ID',
                              `SESSION_NM` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Session 이름',
                              `SESSION_TYPE` int NOT NULL DEFAULT '0' COMMENT 'Session Type (0: Chat/1: Agent/2: Cavnas)',
                              `REG_USER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '생성 아이디',
                              `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                              `REG_USER_IP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '생성 IP',
                              `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                              `DEL_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '삭제 여부',
                              `PINNED_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '고정 여부',
                              `LAST_CHAT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '마지막 대화 일시',
                              PRIMARY KEY (`SESSION_ID`),
                              UNIQUE KEY `TEMP_TB_SESSION_UNIQUE` (`SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='[TEMP] Session 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SESSION`
--

--
-- Table structure for table `TB_SYS_BATCH`
--

DROP TABLE IF EXISTS `TB_SYS_BATCH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_BATCH` (
                                `BATCH_SE_CD` varchar(50) NOT NULL COMMENT '배치구분코드[BATCH_SE_CD - 공통코드 참조]',
                                `BATCH_TP` varchar(10) NOT NULL COMMENT '배치유형[BATCH_TP - D:일배치,M:월배치,W:주배치,P:수동배치]',
                                `BATCH_EXEC_DT` varchar(20) NOT NULL COMMENT '배치실행일시[M:YYYYMM, D:YYYYMMDD, P:YYYYMMDDHHMISSP6]',
                                `BATCH_ST_DT` varchar(20) DEFAULT NULL COMMENT '배치시작일시',
                                `BATCH_ED_DT` varchar(20) DEFAULT NULL COMMENT '배치종료일시',
                                `EXEC_MS` varchar(20) DEFAULT NULL COMMENT '소요시간[MS3자리]',
                                `SUCCESS_YN` varchar(1) DEFAULT NULL COMMENT '성공여부[SUCCESS_YN - N:실패,Y:성공]',
                                `FAIL_RSN` text COMMENT '실패사유',
                                `ST_DT` datetime DEFAULT NULL COMMENT '시작일시',
                                `ED_DT` datetime DEFAULT NULL COMMENT '종료일시',
                                PRIMARY KEY (`BATCH_SE_CD`,`BATCH_TP`,`BATCH_EXEC_DT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='배치실행이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_BATCH`
--

LOCK TABLES `TB_SYS_BATCH` WRITE;
/*!40000 ALTER TABLE `TB_SYS_BATCH` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_SYS_BATCH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_BATCH_SCHEDULE`
--

DROP TABLE IF EXISTS `TB_SYS_BATCH_SCHEDULE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_BATCH_SCHEDULE` (
                                         `BATCH_SE_CD` varchar(50) NOT NULL COMMENT '배치구분코드[BATCH_SE_CD - 공통코드 참조]',
                                         `BATCH_SE_NM` varchar(100) DEFAULT NULL COMMENT '배치구분명',
                                         `CRON_TEXT` varchar(20) NOT NULL COMMENT 'CRON표현식[CRON 표현]',
                                         `BATCH_TP` varchar(10) NOT NULL COMMENT '배치유형[BATCH_TP - D:일배치,M:월배치,W:주배치,P:수동배치]',
                                         `EXEC_WKODAY` varchar(1) DEFAULT NULL COMMENT '실행요일[매주선택시-0: 일요일, 1:월요일, 2:월요일, 3:화요일, 4:수요일, 5:목요일, 6: 토요일]',
                                         `EXEC_DAY` varchar(2) DEFAULT NULL COMMENT '실행일자[매월선택시-1:1일, 2: 2일...28: 28일, L: 마지막일]',
                                         `EXEC_TM` varchar(10) NOT NULL COMMENT '실행시간[시:분:초(HH24:MI:SS)]',
                                         `RM` text COMMENT '비고',
                                         `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                         `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                         `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                         `UPDT_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                         `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                         PRIMARY KEY (`BATCH_SE_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='배치스케쥴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_BATCH_SCHEDULE`
--

LOCK TABLES `TB_SYS_BATCH_SCHEDULE` WRITE;
/*!40000 ALTER TABLE `TB_SYS_BATCH_SCHEDULE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_SYS_BATCH_SCHEDULE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_CODE`
--

DROP TABLE IF EXISTS `TB_SYS_CODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_CODE` (
                               `CD_GROUP_ID` varchar(64) NOT NULL COMMENT '코드그룹ID',
                               `CD_ID` varchar(64) NOT NULL COMMENT '코드ID',
                               `PA_CD_ID` varchar(100) DEFAULT NULL COMMENT '상위코드ID',
                               `CD_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '코드명',
                               `CD_DESC` varchar(1000) DEFAULT NULL COMMENT '코드설명',
                               `CD_LVL` int NOT NULL DEFAULT '1' COMMENT '코드레벨',
                               `CD_ORDER` int NOT NULL DEFAULT '10' COMMENT '순서',
                               `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                               `DEL_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                               `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                               `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                               `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                               `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                               `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                               PRIMARY KEY (`CD_GROUP_ID`,`CD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 코드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_CODE`
--

LOCK TABLES `TB_SYS_CODE` WRITE;
/*!40000 ALTER TABLE `TB_SYS_CODE` DISABLE KEYS */;
INSERT INTO `TB_SYS_CODE` VALUES ('ADMIN_TYPE_CD','GE',NULL,'GENERAL','일반사용자',1,30,'Y','N','2023-12-04 02:21:04','system','2023-12-04 02:21:04','system','127.0.0.1'),('ADMIN_TYPE_CD','NN',NULL,'NONE','없음',1,90,'Y','N','2024-05-28 03:19:29','admin','2024-05-28 03:19:29','admin','0:0:0:0:0:0:0:1'),('ADMIN_TYPE_CD','OA',NULL,'ORG. ADMIN','소속회사관리',1,20,'Y','N','2023-12-04 02:21:04','system','2023-12-04 02:21:04','system','127.0.0.1'),('ADMIN_TYPE_CD','SA',NULL,'SUPER ADMIN','전사관리',1,10,'Y','N','2023-12-04 02:21:04','system','2023-12-04 02:21:04','system','127.0.0.1'),('AGENT_TOOLS','web_search',NULL,'web_search','Search Internet',1,10,'Y','N','2025-02-27 01:52:49','system','2025-02-27 01:52:49','system','127.0.0.1'),('AGENT_TOOLS','wikipedia_search',NULL,'wikipedia_search','Search Wikipedia',1,20,'Y','N','2025-02-27 01:52:49','system','2025-02-28 05:38:42','jooyoonpark@mz.co.kr','143.0.3.61'),('AGENT_TYPE','10',NULL,'CHAT','Chatting Agent',1,10,'Y','N','2024-12-24 04:53:56','system','2024-12-24 04:53:56','system','127.0.0.1'),('AGENT_TYPE','20',NULL,'WEB_QUESTION','WEB Chatting Agent - 질문 재가공',1,20,'Y','N','2025-01-14 04:59:45','system','2025-01-14 04:59:45','system','127.0.0.1'),('AGENT_TYPE','30',NULL,'REL_QSTN','relation question Agent',1,30,'Y','N','2025-01-14 05:04:00','system','2025-01-14 05:04:00','system','127.0.0.1'),('AGENT_TYPE','40',NULL,'WEB_KEYWORD','WEB Chatting Agent - 검색을 위한 키워드 추출',1,40,'Y','N','2025-01-21 08:16:55','system','2025-01-21 08:16:55','system','127.0.0.1'),('AGENT_TYPE','50',NULL,'WEB_ANSWER','WEB Chatting Agent - 사용자에게 답변',1,50,'Y','N','2025-01-21 09:27:51','system','2025-01-21 09:27:51','system','127.0.0.1'),('AGENT_TYPE','60',NULL,'DOC_QUESTION','Document Chatting Agent - 질문 재가공',1,60,'Y','N','2025-02-06 05:20:09','system','2025-02-06 05:20:09','system','127.0.0.1'),('BATCH_SE_CD','CABI',NULL,'회계 기본 인덱스 생성','Create an Accounting Basic Index',1,20,'Y','N','2024-06-12 07:47:46','jaeyoungbae@mz.co.kr','2024-06-12 07:47:46','jaeyoungbae@mz.co.kr','0:0:0:0:0:0:0:1'),('BATCH_SE_CD','CACI',NULL,'회계 마감공지 인덱스 생성','Create Accounting Closing notice Index',1,30,'Y','N','2024-06-12 07:47:46','jaeyoungbae@mz.co.kr','2024-06-12 07:47:46','jaeyoungbae@mz.co.kr','0:0:0:0:0:0:0:1'),('BATCH_SE_CD','SYOI',NULL,'조직정보동기화','SYnchronize Organization Information',1,10,'Y','N','2024-06-03 00:59:52','admin','2024-06-03 00:59:52','admin','0:0:0:0:0:0:0:1'),('BATCH_TP','D',NULL,'매일','매일',1,10,'Y','N','2023-12-19 07:01:49','system','2023-12-19 07:01:49','system','127.0.0.1'),('BATCH_TP','M',NULL,'매월','매월',1,30,'Y','N','2023-12-19 07:01:49','system','2023-12-19 07:01:49','system','127.0.0.1'),('BATCH_TP','P',NULL,'수동배치','수동배치',1,40,'Y','N','2023-12-19 07:01:49','system','2023-12-19 07:01:49','system','127.0.0.1'),('BATCH_TP','W',NULL,'매주','매주',1,20,'Y','N','2023-12-19 07:01:49','system','2023-12-19 07:01:49','system','127.0.0.1'),('CHUNKING_MODE','elements',NULL,'elements',NULL,1,20,'Y','N','2024-07-30 05:53:36','kimchanggu@mz.co.kr','2024-07-30 05:53:36','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_MODE','single',NULL,'single',NULL,1,10,'Y','N','2024-07-30 05:53:27','kimchanggu@mz.co.kr','2024-07-30 05:53:27','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY','basic',NULL,'basic',NULL,1,20,'Y','N','2024-07-30 05:53:53','kimchanggu@mz.co.kr','2024-07-30 05:53:53','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY','by_page',NULL,'by_page',NULL,1,30,'Y','N','2024-07-30 05:54:09','kimchanggu@mz.co.kr','2024-07-30 05:54:09','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY','by_similarity',NULL,'by_similarity',NULL,1,40,'Y','N','2024-07-30 05:54:09','kimchanggu@mz.co.kr','2024-07-30 05:54:09','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY','by_title',NULL,'by_title',NULL,1,10,'Y','N','2024-07-30 05:53:53','kimchanggu@mz.co.kr','2024-07-30 05:53:53','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY','by_title(reg-expression)',NULL,'by_title(reg-expression)',NULL,1,50,'Y','N','2024-12-16 04:01:43','kyungminpark@mz.co.kr','2024-12-16 04:01:43','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('DEL_YN','N',NULL,'미삭제','미삭제',1,10,'Y','N','2023-12-15 05:17:31','system','2023-12-15 05:17:31','system','127.0.0.1'),('DEL_YN','Y',NULL,'삭제','삭제',1,20,'Y','N','2023-12-15 05:17:31','system','2024-08-13 04:23:54','jaeyoungbae@mz.co.kr','0:0:0:0:0:0:0:1'),('EMBED_MODEL','amazon.titan-embed-text-v2:0',NULL,'AWS-titan-embed-text-v2',NULL,1,10,'Y','N','2024-07-30 02:59:58','kimchanggu@mz.co.kr','2024-07-30 02:59:58','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('EMBED_MODEL','embedding-passage',NULL,'embedding-passage',NULL,1,10,'Y','N','2025-03-04 01:58:56','system','2025-03-04 01:58:56','system','127.0.0.1'),('EMBED_MODEL','embedding-query',NULL,'embedding-query',NULL,1,10,'Y','N','2025-03-04 01:58:56','system','2025-03-04 01:58:56','system','127.0.0.1'),('EMBED_MODEL','models/embedding-001',NULL,'GEMINI-models/embedding-001',NULL,1,20,'Y','N','2024-08-16 06:05:17','system','2024-08-16 06:05:17','system','0:0:0:0:0:0:0:1'),('EMBED_MODEL','text-embedding-3-small',NULL,'OPENAI-text-embedding-3-small',NULL,1,30,'Y','N','2024-08-21 08:26:51','system','2024-08-21 08:26:51','system','0:0:0:0:0:0:0:1'),('FUSION_ALGORITHM','RRF',NULL,'RRF',NULL,1,10,'Y','N','2024-07-25 05:21:01','admin','2024-07-25 05:21:01','admin','0:0:0:0:0:0:0:1'),('FUSION_ALGORITHM','simple_weighted',NULL,'simple_weighted',NULL,1,20,'Y','N','2024-07-25 05:21:01','admin','2024-07-25 05:21:01','admin','0:0:0:0:0:0:0:1'),('HI_RES_MODEL','detectron2_onnx',NULL,'detectron2_onnx',NULL,1,10,'Y','N','2024-07-25 04:29:30','admin','2024-07-25 04:29:30','admin','0:0:0:0:0:0:0:1'),('HI_RES_MODEL','yolox',NULL,'yolox',NULL,1,20,'Y','N','2024-07-25 04:29:30','admin','2024-07-25 04:29:30','admin','0:0:0:0:0:0:0:1'),('HI_RES_MODEL','yolox_quantized',NULL,'yolox_quantized',NULL,1,30,'Y','N','2024-07-25 04:30:50','admin','2024-07-25 04:30:50','admin','0:0:0:0:0:0:0:1'),('HYBRID_SEARCH_DEBUGGER','lexical',NULL,'lexical',NULL,1,20,'Y','N','2024-07-25 05:20:43','admin','2024-07-25 05:20:43','admin','0:0:0:0:0:0:0:1'),('HYBRID_SEARCH_DEBUGGER','None',NULL,'None',NULL,1,30,'Y','N','2024-07-25 05:20:43','admin','2024-07-25 05:20:43','admin','0:0:0:0:0:0:0:1'),('HYBRID_SEARCH_DEBUGGER','semantic',NULL,'semantic',NULL,1,10,'Y','N','2024-07-25 05:20:43','admin','2024-07-25 05:20:43','admin','0:0:0:0:0:0:0:1'),('HYDE_QUERY','arguana',NULL,'arguana',NULL,1,30,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','dbpedia_entity',NULL,'dbpedia_entity',NULL,1,60,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','fiqa',NULL,'fiqa',NULL,1,50,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','mr_tydi',NULL,'mr_tydi',NULL,1,80,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','sci_fact',NULL,'sci_fact',NULL,1,20,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','trec_covid',NULL,'trec_covid',NULL,1,40,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','trec_news',NULL,'trec_news',NULL,1,70,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('HYDE_QUERY','web_search',NULL,'web_search',NULL,1,10,'Y','N','2024-07-30 06:05:02','kimchanggu@mz.co.kr','2024-07-30 06:05:02','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('IMAGE_STRATEGY','auto',NULL,'auto',NULL,1,10,'Y','N','2024-07-30 05:56:39','kimchanggu@mz.co.kr','2024-07-30 05:56:39','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('IMAGE_STRATEGY','fast',NULL,'fast',NULL,1,40,'Y','N','2024-07-30 05:56:39','kimchanggu@mz.co.kr','2024-07-30 05:56:39','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('IMAGE_STRATEGY','hi_res',NULL,'hi_res',NULL,1,20,'Y','N','2024-07-30 05:56:39','kimchanggu@mz.co.kr','2024-07-30 05:56:39','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('IMAGE_STRATEGY','ocr_only',NULL,'ocr_only',NULL,1,30,'Y','N','2024-07-30 05:56:39','kimchanggu@mz.co.kr','2024-07-30 05:56:39','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('JBTTL_TP','010',NULL,'CEO','Chief Executive Officer, 최고경영자',1,10,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','020',NULL,'CHRO','Chief Human Resources Officer, 최고인사책임자',1,20,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','030',NULL,'CFO','Chief Financial Officer, 최고재무책임자',1,30,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','040',NULL,'CSO','Chief Security Officer 또는 Chief Strategy Officer, 최고보안책임자 또는 최고전략책임자',1,40,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','050',NULL,'CAO','Chief Analytics Officer, 최고분석책임자',1,50,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','060',NULL,'CISO','Chief Information Security Officer, 최고정보보안책임자',1,60,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','070',NULL,'COO','Chief Operating Officer, 최고운영책임자',1,70,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','100',NULL,'부사장',NULL,1,80,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','200',NULL,'본부장',NULL,1,90,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','300',NULL,'대표',NULL,1,100,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','400',NULL,'센터장',NULL,1,110,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','401',NULL,'소장',NULL,1,120,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','402',NULL,'감사',NULL,1,130,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','500',NULL,'그룹장',NULL,1,140,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','600',NULL,'팀장',NULL,1,150,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','601',NULL,'TF장','Task Force의 장, 특정 과제를 수행하는 임시 조직의 장',1,160,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:15:18','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','700',NULL,'리더',NULL,1,170,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','800',NULL,'매니저',NULL,1,180,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','990',NULL,'인턴',NULL,1,190,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('JBTTL_TP','999',NULL,'-',NULL,1,200,'Y','N','2024-05-23 02:14:47','admin','2024-05-23 02:14:47','admin','0:0:0:0:0:0:0:1'),('LANGUAGES','eng',NULL,'eng',NULL,1,30,'Y','N','2024-07-25 04:32:31','admin','2024-07-25 04:32:31','admin','0:0:0:0:0:0:0:1'),('LANGUAGES','kor',NULL,'kor',NULL,1,20,'Y','N','2024-07-25 04:32:31','admin','2024-07-25 04:32:31','admin','0:0:0:0:0:0:0:1'),('LANGUAGES','kor+eng',NULL,'kor+eng',NULL,1,10,'Y','N','2024-07-25 04:32:31','admin','2024-07-25 04:32:31','admin','0:0:0:0:0:0:0:1'),('LLM_MODEL','anthropic.claude-3-5-sonnet-20240620-v1:0',NULL,'anthropic.claude-3-5-sonnet',NULL,1,40,'Y','N','2024-08-09 02:04:37','jmkwon@mz.co.kr','2024-08-09 02:04:37','jmkwon@mz.co.kr','143.0.3.98'),('LLM_MODEL','anthropic.claude-3-haiku-20240307-v1:0',NULL,'anthropic.claude-3-haiku',NULL,1,10,'Y','N','2024-07-30 03:00:57','kimchanggu@mz.co.kr','2024-07-30 03:00:57','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('LLM_MODEL','anthropic.claude-3-sonnet-20240229-v1:0',NULL,'anthropic.claude-3-sonnet',NULL,1,20,'Y','N','2024-07-30 03:01:14','kimchanggu@mz.co.kr','2024-07-30 03:01:14','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('LLM_MODEL','anthropic.claude-v2',NULL,'anthropic.claude-v2',NULL,1,30,'Y','N','2024-08-04 23:01:19','admin','2024-08-04 23:01:19','admin','0:0:0:0:0:0:0:1'),('LLM_MODEL','exaone-v3-0-7-8b-instruct',NULL,'exaone-v3.0-7.8b',NULL,1,10,'Y','N','2025-02-07 06:06:22','system','2025-02-07 06:06:22','system','127.0.0.1'),('LLM_MODEL','gemini-1.5-flash',NULL,'gemini-1.5-flash',NULL,1,70,'Y','N','2024-08-19 06:04:43','joohyucklee@mz.co.kr','2024-08-19 06:04:43','joohyucklee@mz.co.kr','143.0.3.207'),('LLM_MODEL','gemini-1.5-pro',NULL,'gemini-1.5-pro',NULL,1,50,'Y','N','2024-08-16 05:51:28','system','2024-08-16 05:51:28','system','0:0:0:0:0:0:0:1'),('LLM_MODEL','gemini-pro',NULL,'gemini-pro','gemini-1.0-pro',1,40,'Y','N','2024-08-16 03:49:52','system','2024-08-19 06:05:00','joohyucklee@mz.co.kr','143.0.3.207'),('LLM_MODEL','gpt-4o',NULL,'gpt-4o','gpt-4o',1,80,'Y','N','2024-08-21 08:24:56','system','2024-08-21 08:24:56','system','143.0.3.207'),('LLM_MODEL','meta.llama3-8b-instruct-v1:0',NULL,'meta.llama3-8b','meta.llama3-8b',1,90,'Y','N','2024-08-23 01:25:33','joohyucklee@mz.co.kr','2024-08-23 01:25:33','joohyucklee@mz.co.kr','143.0.3.148'),('LLM_MODEL','solar-1-mini-chat',NULL,'solar-1-mini-chat',NULL,1,10,'Y','N','2024-10-25 02:11:25','system','2024-10-25 02:11:25','system','127.0.0.1'),('LLM_MODEL','solar-pro',NULL,'solar-pro','solar-pro',1,20,'Y','N','2024-10-25 02:11:25','system','2024-10-25 02:11:25','system','127.0.0.1'),('LLM_MODEL','us.anthropic.claude-3-7-sonnet-20250219-v1:0',NULL,'anthropic.claude-3-7-sonnet','us.anthropic.claude-3-7-sonnet-20250219-v1:0',1,100,'Y','N','2024-10-25 02:11:25','system','2024-10-25 02:11:25','system','127.0.0.1'),('MENU_SE','G',NULL,'그룹','그룹',1,10,'Y','N','2023-12-13 03:44:08','system','2023-12-13 03:44:08','system','127.0.0.1'),('MENU_SE','P',NULL,'팝업','팝업',1,30,'Y','N','2023-12-13 03:44:09','system','2023-12-13 03:44:09','system','127.0.0.1'),('MENU_SE','U',NULL,'URL링크','URL링크',1,20,'Y','N','2023-12-13 03:44:08','system','2023-12-13 03:44:08','system','127.0.0.1'),('MENU_TYPE','G',NULL,'메뉴그룹','메뉴그룹',1,10,'Y','N','2023-12-13 03:44:08','system','2023-12-13 03:44:08','system','127.0.0.1'),('MENU_TYPE','M',NULL,'메뉴','메뉴',1,20,'Y','N','2023-12-13 03:44:08','system','2023-12-13 03:44:08','system','127.0.0.1'),('MENU_TYPE','P',NULL,'페이지','페이지',1,30,'Y','N','2023-12-13 03:44:08','system','2023-12-13 03:44:08','system','127.0.0.1'),('PROMPT_TYPE','H','10','human','human',1,20,'Y','N','2025-01-02 08:30:23','system','2025-01-02 08:30:23','system','127.0.0.1'),('PROMPT_TYPE','S','10','system','system',1,10,'Y','N','2024-12-24 04:43:30','system','2024-12-24 04:43:30','system','127.0.0.1'),('PROMPT_TYPE','U','10','user','user',1,30,'Y','N','2024-12-24 04:44:10','system','2024-12-24 04:44:10','system','127.0.0.1'),('REG_STATUS','COMPLETED',NULL,'완료','완료',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REG_STATUS','INIT',NULL,'기본정보','기본정보',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REG_STATUS','LLM',NULL,'모델설정','모델설정',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REG_STATUS','LOAD',NULL,'적재','적재',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REG_STATUS','PIPELINE',NULL,'파이프라인설정','파이프라인설정',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REG_STATUS','RETRIEVAL',NULL,'검색','검색',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('REQ_STATUS_ST','A',NULL,'접수','접수',1,10,'Y','N','2024-06-04 04:02:20','kyungminpark@mz.co.kr','2024-06-04 04:02:20','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('REQ_STATUS_ST','B',NULL,'처리중','처리중',1,20,'Y','N','2024-06-04 04:02:20','kyungminpark@mz.co.kr','2024-06-04 04:02:20','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('REQ_STATUS_ST','C',NULL,'완료','완료',1,30,'Y','N','2024-06-04 04:02:20','kyungminpark@mz.co.kr','2024-06-04 04:02:20','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('RETIRE_YN','N',NULL,'재직중','재직중',1,10,'Y','N','2023-12-15 05:19:21','system','2023-12-15 05:19:21','system','127.0.0.1'),('RETIRE_YN','Y',NULL,'퇴사','퇴사',1,20,'Y','N','2023-12-15 05:19:20','system','2023-12-15 05:19:20','system','127.0.0.1'),('SKIP_INFER_TABLE_TYPES','heic',NULL,'heic',NULL,1,60,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SKIP_INFER_TABLE_TYPES','jpg',NULL,'jpg',NULL,1,20,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SKIP_INFER_TABLE_TYPES','pdf',NULL,'pdf',NULL,1,10,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SKIP_INFER_TABLE_TYPES','png',NULL,'png',NULL,1,30,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SKIP_INFER_TABLE_TYPES','xls',NULL,'xls',NULL,1,40,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SKIP_INFER_TABLE_TYPES','xlsx',NULL,'xlsx',NULL,1,50,'Y','N','2024-07-30 05:58:56','kimchanggu@mz.co.kr','2024-07-30 05:58:56','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('STATUS','A',NULL,'접수','접수',1,10,'Y','N','2024-05-29 07:34:30','admin','2024-05-29 07:34:30','admin','0:0:0:0:0:0:0:1'),('STATUS','B',NULL,'처리중','처리중',1,20,'Y','N','2024-05-29 07:34:30','admin','2024-05-29 07:34:30','admin','0:0:0:0:0:0:0:1'),('STATUS','C',NULL,'완료','완료',1,30,'Y','N','2024-05-29 07:34:31','admin','2024-05-29 07:34:31','admin','0:0:0:0:0:0:0:1'),('SUCCESS_YN','N',NULL,'실패','실패',1,20,'Y','N','2023-12-19 07:38:19','system','2023-12-19 07:38:19','system','127.0.0.1'),('SUCCESS_YN','Y',NULL,'성공','성공',1,10,'Y','N','2023-12-19 07:38:19','system','2023-12-19 07:38:19','system','127.0.0.1'),('TIMEZONE','CAAST',NULL,'캐나다·노바스코샤','UTC-04:00',1,110,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CACST',NULL,'캐나다·매니토바','UTC-06:00',1,90,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CAEST',NULL,'캐나다·온타리오','UTC-05:00',1,100,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CAMST',NULL,'캐나다·캘거리','UTC-07:00',1,80,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CANST',NULL,'캐나다·세인트존스','UTC-03:30',1,120,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CAPST',NULL,'캐나다·밴쿠버','UTC-08:00',1,70,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','CNCST',NULL,'중국','UTC+08:00',1,130,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','HKHKT',NULL,'홍콩','UTC+08:00',1,20,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','JSJST',NULL,'일본','UTC+09:00',1,140,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','KRKST',NULL,'대한민국','UTC+09:00',1,10,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','USCST',NULL,'미국·텍사스','UTC-06:00',1,40,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','USEST',NULL,'미국·뉴욕','UTC-05:00',1,30,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','USMST',NULL,'미국·콜로라도','UTC-07:00',1,50,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','USPST',NULL,'미국·캘리포니아','UTC-08:00',1,60,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('TIMEZONE','VNICT',NULL,'베트남','UTC+07:00',1,150,'Y','N','2025-09-25 06:14:38','system','2025-09-25 06:14:38','system','127.0.0.1'),('USE_YN','N',NULL,'미사용','미사용',1,20,'Y','N','2023-12-15 05:16:22','system','2023-12-15 05:16:22','system','127.0.0.1'),('USE_YN','Y',NULL,'사용','사용',1,10,'Y','N','2023-12-15 05:16:22','system','2023-12-15 05:16:22','system','127.0.0.1'),('USER_PRPT_TP','regular_expression',NULL,'regular_expression',NULL,1,10,'Y','N','2024-12-17 00:31:23','system','2024-12-17 00:31:23','eungkyunglee@mz.co.kr','127.0.0.1'),('YN',' Y',NULL,'예','예',1,10,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1'),('YN','N',NULL,'아니오','아니오',1,20,'Y','N','2024-03-04 08:07:18','admin','2024-03-04 08:07:18','admin','127.0.0.1');
/*!40000 ALTER TABLE `TB_SYS_CODE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_CODE_GROUP`
--

DROP TABLE IF EXISTS `TB_SYS_CODE_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_CODE_GROUP` (
                                     `CD_GROUP_ID` varchar(64) NOT NULL COMMENT '코드그룹ID',
                                     `PARENT_CD_GROUP_ID` varchar(64) DEFAULT NULL COMMENT '상위코드그룹ID',
                                     `CD_GROUP_NM` varchar(100) NOT NULL COMMENT '코드그룹명',
                                     `CD_GROUP_DESC` varchar(1000) DEFAULT NULL COMMENT '코드그룹설명',
                                     `USE_YN` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                     `DEL_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                                     `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                     `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                     `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                     `UPDT_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                     `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                     PRIMARY KEY (`CD_GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템코드그룹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_CODE_GROUP`
--

LOCK TABLES `TB_SYS_CODE_GROUP` WRITE;
/*!40000 ALTER TABLE `TB_SYS_CODE_GROUP` DISABLE KEYS */;
INSERT INTO `TB_SYS_CODE_GROUP` VALUES ('ADMIN_TYPE_CD',NULL,'관리자유형',NULL,'Y','N','2023-12-28 02:48:15','jackie','2025-03-24 11:14:18','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('AGENT_TOOLS',NULL,'에이전트 도구',NULL,'Y','N','2025-02-27 13:19:47','system','2025-03-24 11:14:18','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('AGENT_TYPE',NULL,'에이전트유형',NULL,'Y','N','2024-12-24 12:52:01','system','2024-12-24 12:52:01','system','127.0.0.1'),('BATCH_SE_CD',NULL,'배치구분',NULL,'Y','N','2023-12-28 02:48:15','jackie','2023-12-28 02:48:15','jackie','127.0.0.1'),('BATCH_TP',NULL,'배치유형',NULL,'Y','N','2023-12-22 08:19:32','jackie','2023-12-22 08:22:22','jackie','127.0.0.1'),('CHUNKING_MODE',NULL,'청킹모드',NULL,'Y','N','2024-07-30 14:53:06','kimchanggu@mz.co.kr','2024-07-30 14:53:06','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('CHUNKING_STRATEGY',NULL,'청킹전략',NULL,'Y','N','2024-07-30 14:52:51','kimchanggu@mz.co.kr','2024-07-30 14:52:51','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('DEL_YN',NULL,'삭제여부',NULL,'Y','N','2023-12-22 04:25:05','system','2023-12-22 08:22:22','jackie','127.0.0.1'),('EMBED_MODEL',NULL,'임베딩모델',NULL,'Y','N','2024-07-25 13:26:16','admin','2024-07-25 13:26:16','admin','0:0:0:0:0:0:0:1'),('FUSION_ALGORITHM',NULL,'퓨전알고리즘',NULL,'Y','N','2024-07-25 14:20:18','admin','2024-07-25 14:20:18','admin','0:0:0:0:0:0:0:1'),('HI_RES_MODEL',NULL,'HI RES 모델명',NULL,'Y','N','2024-07-25 13:28:53','admin','2024-07-25 13:28:53','admin','0:0:0:0:0:0:0:1'),('HYBRID_SEARCH_DEBUGGER',NULL,'서치디버깅모드',NULL,'Y','N','2024-07-25 14:20:18','admin','2024-07-25 14:20:18','admin','0:0:0:0:0:0:0:1'),('HYDE_QUERY',NULL,'하이드쿼리',NULL,'Y','N','2024-07-30 15:04:17','kimchanggu@mz.co.kr','2024-07-30 15:04:17','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('IMAGE_STRATEGY',NULL,'이미지 분할 전략',NULL,'Y','N','2024-07-30 14:56:09','kimchanggu@mz.co.kr','2024-07-30 14:56:09','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('JBTTL_TP',NULL,'직책 유형',NULL,'Y','N','2024-05-23 02:02:43','admin','2024-05-23 02:02:43','admin','0:0:0:0:0:0:0:1'),('LANGUAGES',NULL,'지식저장소 언어 구분',NULL,'Y','N','2024-07-25 13:31:56','admin','2024-07-25 13:31:56','admin','0:0:0:0:0:0:0:1'),('LLM_MODEL',NULL,'LLM모델',NULL,'Y','N','2024-07-25 15:10:51','admin','2024-07-25 15:10:51','admin','0:0:0:0:0:0:0:1'),('LLM_MODEL_TYPE',NULL,'LLM모델유형',NULL,'Y','N','2024-05-28 08:30:01','admin','2024-05-28 08:30:01','admin','0:0:0:0:0:0:0:1'),('MENU_SE',NULL,'메뉴구분',NULL,'Y','N','2023-12-28 03:24:10','jackie','2023-12-28 03:24:10','jackie','127.0.0.1'),('MENU_TYPE',NULL,'메뉴유형',NULL,'Y','N','2023-12-28 03:24:10','jackie','2023-12-28 03:24:10','jackie','127.0.0.1'),('PROMPT_TYPE','AGENT_TYPE','프롬프트유형',NULL,'Y','N','2024-12-24 12:51:02','system','2024-12-24 12:51:02','system','127.0.0.1'),('REG_STATUS',NULL,'REG상태',NULL,'Y','N','2024-03-04 08:06:56','admin','2024-06-04 04:16:31','jaeyoungbae@mz.co.kr','0:0:0:0:0:0:0:1'),('REQ_STATUS_ST',NULL,'처리상태',NULL,'Y','N','2024-06-04 04:00:55','kyungminpark@mz.co.kr','2024-06-04 04:00:55','kyungminpark@mz.co.kr','0:0:0:0:0:0:0:1'),('RETIRE_YN',NULL,'퇴사여부',NULL,'Y','N','2023-12-28 03:26:48','jackie','2023-12-28 03:26:48','jackie','127.0.0.1'),('SKIP_INFER_TABLE_TYPES',NULL,'테이블 미추출 문서타입',NULL,'Y','N','2024-07-30 14:57:35','kimchanggu@mz.co.kr','2024-07-30 14:57:35','kimchanggu@mz.co.kr','0:0:0:0:0:0:0:1'),('SUCCESS_YN',NULL,'성공여부',NULL,'Y','N','2023-12-28 03:45:44','jackie','2023-12-28 03:45:44','jackie','127.0.0.1'),('TIMEZONE',NULL,'국가 타임존코드','사용자 국가타임존','Y','N','2025-09-25 15:14:37','system','2025-09-25 15:14:37','system','127.0.0.1'),('USE_YN',NULL,'사용여부',NULL,'Y','N','2023-12-22 04:25:05','system','2023-12-22 04:25:05','system','127.0.0.1'),('USER_PRPT_TP','','사용자 프로퍼티 유형','','Y','N','2024-12-17 09:27:37','system','2024-12-17 09:27:37','eungkyunglee@gmz.co.kr','127.0.0.1'),('YN',NULL,'여부',NULL,'Y','N','2024-03-04 08:06:56','admin','2024-06-04 04:16:31','jaeyoungbae@mz.co.kr','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `TB_SYS_CODE_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_COMPANY`
--

DROP TABLE IF EXISTS `TB_SYS_COMPANY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_COMPANY` (
                                  `COMPANY_CD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '회사코드',
                                  `PA_COMPANY_CD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '상위회사코드',
                                  `COMPANY_NM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '회사명',
                                  `RPRSV_NM` varchar(50) DEFAULT NULL COMMENT '대표자명',
                                  `BRNO` varchar(20) DEFAULT NULL COMMENT '사업자번호',
                                  `TELNO` varchar(20) DEFAULT NULL COMMENT '전화번호',
                                  `ZIP` varchar(20) DEFAULT NULL COMMENT '우편번호',
                                  `ADDR` varchar(100) DEFAULT NULL COMMENT '주소',
                                  `DADDR` varchar(150) DEFAULT NULL COMMENT '상세주소',
                                  `COMPANY_LVL` int NOT NULL DEFAULT '1' COMMENT '회사레벨',
                                  `SORT_SN` int NOT NULL DEFAULT '1' COMMENT '정렬순번',
                                  `USE_YN` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                  `DEL_YN` varchar(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                                  `RM` text COMMENT '비고',
                                  `REG_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '등록아이디',
                                  `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                  `UPDT_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '수정아이디',
                                  `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                  PRIMARY KEY (`COMPANY_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회사';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_COMPANY`
--

LOCK TABLES `TB_SYS_COMPANY` WRITE;
/*!40000 ALTER TABLE `TB_SYS_COMPANY` DISABLE KEYS */;
INSERT INTO `TB_SYS_COMPANY` VALUES ('0000','0','회사없음',NULL,NULL,NULL,NULL,NULL,NULL,1,999,'Y','N',NULL,'system','2024-06-20 09:56:16','system','2024-06-20 09:56:16');
/*!40000 ALTER TABLE `TB_SYS_COMPANY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_DEPT`
--

DROP TABLE IF EXISTS `TB_SYS_DEPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_DEPT` (
                               `COMPANY_CD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '회사코드',
                               `DEPT_CD` varchar(50) NOT NULL COMMENT '부서코드',
                               `PA_DEPT_CD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '상위부서코드',
                               `DEPT_LOC` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '부서경로',
                               `DEPT_CD_LOC` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '부서코드경로',
                               `DEPT_NM` varchar(100) NOT NULL COMMENT '부서명',
                               `DEPT_LVL` int NOT NULL DEFAULT '1' COMMENT '부서레벨',
                               `SORT_SN` int NOT NULL DEFAULT '1' COMMENT '정렬순번',
                               `USE_YN` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                               `DEL_YN` varchar(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                               `RM` text COMMENT '비고',
                               `REG_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '등록아이디',
                               `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                               `UPDT_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '수정아이디',
                               `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                               PRIMARY KEY (`COMPANY_CD`,`DEPT_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='부서';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_DEPT`
--

LOCK TABLES `TB_SYS_DEPT` WRITE;
/*!40000 ALTER TABLE `TB_SYS_DEPT` DISABLE KEYS */;
INSERT INTO `TB_SYS_DEPT` VALUES ('0000','0000','0','전체사용자','0000','전체사용자',1,1,'Y','N',NULL,'system','2025-04-30 11:22:10','system','2025-04-30 11:22:10');
/*!40000 ALTER TABLE `TB_SYS_DEPT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_EMP`
--

DROP TABLE IF EXISTS `TB_SYS_EMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_EMP` (
                              `EMP_NO` varchar(50) NOT NULL COMMENT '사원번호[사원영문명]',
                              `ERP_EMP_SEQ` varchar(32) DEFAULT NULL COMMENT 'ERP사원번호',
                              `EMP_NM` varchar(100) NOT NULL COMMENT '사원명',
                              `EML_ADDR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '사용자이메일',
                              `COMPANY_CD` bigint DEFAULT NULL COMMENT '회사코드',
                              `DEPT_CD` varchar(50) DEFAULT NULL COMMENT '부서코드',
                              `JBTTL_CD` varchar(20) DEFAULT NULL COMMENT '직책코드',
                              `USE_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                              `REG_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '등록아이디',
                              `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                              `UPDT_USER_ID` varchar(50) NOT NULL DEFAULT 'system' COMMENT '수정아이디',
                              `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                              PRIMARY KEY (`EMP_NO`),
                              KEY `CM_SY_EMP_CO_CD_IDX` (`COMPANY_CD`,`EMP_NO`) USING BTREE,
                              KEY `CM_SY_EMP_EMP_NM_IDX` (`COMPANY_CD`,`EMP_NM`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_EMP`
--

LOCK TABLES `TB_SYS_EMP` WRITE;
/*!40000 ALTER TABLE `TB_SYS_EMP` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_SYS_EMP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MASTER_CONFIG`
--

DROP TABLE IF EXISTS `TB_SYS_MASTER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MASTER_CONFIG` (
                                        `MASTER_SNO` int NOT NULL AUTO_INCREMENT COMMENT '설정번호',
                                        `SYS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '시스템타입',
                                        `SYS_KEY` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '시스템키',
                                        `USE_YN` varchar(1) DEFAULT 'Y' COMMENT '사용여부',
                                        `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                        `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '등록사용자ID',
                                        `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                        `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '수정사용자ID',
                                        `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                        PRIMARY KEY (`MASTER_SNO`),
                                        UNIQUE KEY `TB_SYS_MASTER_UN` (`SYS_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 설정 마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MASTER_CONFIG`
--

LOCK TABLES `TB_SYS_MASTER_CONFIG` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MASTER_CONFIG` DISABLE KEYS */;
INSERT INTO `TB_SYS_MASTER_CONFIG` VALUES (3,'2FA','1506540FAC','Y','2025-02-04 06:06:53','admin','2025-03-12 06:53:38','jinwookchoi@mz.co.kr','0:0:0:0:0:0:0:1'),(4,'2FA','15065480A2','Y','2025-02-04 06:06:53','admin','2025-03-12 06:53:39','jinwookchoi@mz.co.kr','0:0:0:0:0:0:0:1'),(76,'MSK','15065500AA','Y','2025-02-04 06:06:53','admin','2025-03-12 06:53:39','jinwookchoi@mz.co.kr','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `TB_SYS_MASTER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MASTER_RESOURCE`
--

DROP TABLE IF EXISTS `TB_SYS_MASTER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MASTER_RESOURCE` (
                                          `SYS_KEY` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '시스템키',
                                          `VARCHAR_1` varchar(20) NOT NULL,
                                          `VARCHAR_2` varchar(30) NOT NULL,
                                          `VARCHAR_3` varchar(50) NOT NULL,
                                          `VARCHAR_4` varchar(100) DEFAULT NULL,
                                          `NUMERIC_1` decimal(10,0) DEFAULT NULL,
                                          `NUMERIC_2` decimal(10,0) DEFAULT NULL,
                                          `NUMERIC_3` decimal(10,0) DEFAULT NULL,
                                          `TIMESTAMP_1` timestamp NULL DEFAULT NULL,
                                          `TIMESTAMP_2` timestamp NULL DEFAULT NULL,
                                          `TIMESTAMP_3` timestamp NULL DEFAULT NULL,
                                          `SYS_DESC` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '시스템설명',
                                          `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                          `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '등록사용자ID',
                                          `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                          `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'system' COMMENT '수정사용자ID',
                                          `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                          PRIMARY KEY (`SYS_KEY`,`VARCHAR_2`,`VARCHAR_1`,`VARCHAR_3`),
                                          CONSTRAINT `TB_SYS_MASTER_RESOURCE_FK` FOREIGN KEY (`SYS_KEY`) REFERENCES `TB_SYS_MASTER_CONFIG` (`SYS_KEY`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 설정 리소스';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MASTER_RESOURCE`
--

LOCK TABLES `TB_SYS_MASTER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MASTER_RESOURCE` DISABLE KEYS */;
INSERT INTO `TB_SYS_MASTER_RESOURCE` VALUES ('15065500AA','fsMsk','useYn','N','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-07-09 00:57:02','system','2025-07-09 00:57:02','system','127.0.0.1');
/*!40000 ALTER TABLE `TB_SYS_MASTER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MENU`
--

DROP TABLE IF EXISTS `TB_SYS_MENU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MENU` (
                               `MENU_SNO` int NOT NULL AUTO_INCREMENT COMMENT '메뉴ID',
                               `UPPER_MENU_SNO` int DEFAULT NULL COMMENT '상위메뉴ID',
                               `MENU_NM` varchar(50) NOT NULL COMMENT '메뉴명',
                               `MENU_URL` varchar(1000) DEFAULT NULL COMMENT '메뉴URL',
                               `MENU_DESC` varchar(1000) DEFAULT NULL COMMENT '메뉴설명',
                               `TEMPLATE_NM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '템플릿명[portal:포털, admin:관리자]',
                               `IMG_INFO` varchar(50) DEFAULT NULL COMMENT '아이콘 정보:최상위 메뉴에 사용되는 아이콘 정보',
                               `MENU_ORDER` int NOT NULL DEFAULT '999999' COMMENT '순서',
                               `MENU_LVL` int NOT NULL DEFAULT '0' COMMENT '메뉴레벨',
                               `MENU_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '메뉴유형[G:메뉴그룹, M:메뉴, P:페이지]',
                               `MENU_SE` varchar(20) DEFAULT NULL COMMENT '메뉴구분[G:그룹, U:URL링크, P:팝업]',
                               `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                               `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부',
                               `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                               `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                               `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                               `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                               `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                               PRIMARY KEY (`MENU_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=3310 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 메뉴';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MENU`
--

LOCK TABLES `TB_SYS_MENU` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MENU` DISABLE KEYS */;
INSERT INTO `TB_SYS_MENU` VALUES (1000,0,'사용자 및 권한 관리','','사용자 및 권한 관리','admin','SystemIcon',1000,0,'G','G','Y','N','2023-11-27 12:09:48','system','2025-06-30 05:04:47','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(1001,1000,'사용자','/admin/auth/users','사용자관리','admin',NULL,1001,0,'M','U','Y','N','2023-11-27 12:20:34','system','2025-07-11 06:04:26','demo@mz.co.kr','59.10.176.51'),(1002,1000,'메뉴 권한','/admin/auth/menu-roles','권한관리','admin',NULL,1002,0,'M','U','Y','N','2023-11-27 12:15:22','system','2025-07-11 06:52:05','demo@mz.co.kr','59.10.176.51'),(1003,1000,'지식 저장소 권한','/admin/auth/repo-roles','','admin',NULL,1003,0,'M','U','Y','N','2024-05-22 14:17:36','admin','2025-07-11 06:05:16','demo@mz.co.kr','59.10.176.51'),(1004,1000,'Agent 권한 관리','/admin/auth/agent-roles','','admin',NULL,1004,0,'M','U','Y','N','2025-06-05 10:33:07','admin','2025-07-11 06:05:57','demo@mz.co.kr','59.10.176.51'),(1100,0,'기능 및 모델 관리','','Prompt Management','admin',NULL,1100,0,'G','G','Y','N','2025-05-14 09:23:09','admin','2025-06-30 05:05:52','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(1101,1100,'공급사 인증','/admin/features/providers','공급사 인증 관리','admin',NULL,1101,0,'M','U','Y','N','2025-07-09 06:52:44','sungyup@mz.co.kr','2025-07-11 06:06:23','demo@mz.co.kr','59.10.176.51'),(1102,1100,'모델','/admin/features/models','모델 관리 ','admin',NULL,1102,0,'M','U','Y','N','2025-07-09 06:54:23','sungyup@mz.co.kr','2025-07-11 06:06:43','demo@mz.co.kr','59.10.176.51'),(1103,1100,'프롬프트','/admin/features/prompts','','admin',NULL,1103,0,'M','U','Y','N','2025-05-14 09:23:45','admin','2025-07-11 06:06:53','demo@mz.co.kr','59.10.176.51'),(1105,1100,'파서','/admin/features/parsers','파서 관리','admin',NULL,1105,0,'M','U','Y','N','2025-07-09 06:55:59','sungyup@mz.co.kr','2025-07-11 06:29:21','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(1106,1100,'MCP 서버','/admin/features/mcp-servers','MCP 서버 관리','admin',NULL,1106,0,'M','U','Y','N','2025-06-27 06:03:05','sungyup@mz.co.kr','2025-07-11 06:07:08','demo@mz.co.kr','59.10.176.51'),(1200,0,'시스템 설정','','시스템 설정','admin',NULL,1200,0,'G','G','Y','N','2025-06-27 06:05:39','sungyup@mz.co.kr','2025-06-30 05:05:46','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(1201,1200,'메뉴','/admin/system/menus','메뉴 관리','admin',NULL,1201,0,'M','U','Y','N','2025-06-27 06:08:45','sungyup@mz.co.kr','2025-07-11 06:07:26','demo@mz.co.kr','59.10.176.51'),(1202,1200,'공통 코드','/admin/system/codes','공통 코드 관리','admin',NULL,1202,0,'M','U','Y','N','2025-06-27 06:09:34','sungyup@mz.co.kr','2025-07-11 06:07:34','demo@mz.co.kr','59.10.176.51'),(1203,1200,'보안','/admin/system/security','보안 관리','admin',NULL,1203,0,'M','U','Y','N','2025-06-27 06:09:56','sungyup@mz.co.kr','2025-07-11 06:09:33','demo@mz.co.kr','59.10.176.51'),(1400,0,'운영 및 모니터링','','운영 및 모니터링','admin',NULL,1400,0,'G','G','Y','N','2024-12-17 09:05:24','kyungminpark@mz.co.kr','2025-06-30 05:05:37','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(1401,1400,'대화 사용 현황','/admin/monitoring/usage-status','','admin',NULL,1401,0,'M','U','Y','N','2024-12-17 09:51:24','kyungminpark@mz.co.kr','2025-07-11 06:08:19','demo@mz.co.kr','59.10.176.51'),(1402,1400,'대화 로그','/admin/monitoring/chat-logs','','admin',NULL,1402,0,'M','U','Y','N','2024-12-17 09:45:14','kyungminpark@mz.co.kr','2025-07-11 06:08:11','demo@mz.co.kr','59.10.176.51'),(1403,1400,'VOC','/admin/monitoring/voc','VOC 관리','admin',NULL,1403,0,'M','U','Y','N','2025-07-09 06:58:03','sungyup@mz.co.kr','2025-07-11 06:29:44','sungyup@mz.co.kr','0:0:0:0:0:0:0:1'),(2000,0,'에이전트 관리','','에이전트 ','studio',NULL,2000,0,'G','G','Y','N','2025-07-14 08:58:16','system','2025-11-05 05:56:34','air@megazone.com','0:0:0:0:0:0:0:1'),(2001,2000,'에이전트','/studio/agent','에이전트','studio',NULL,2001,0,'M','U','Y','N','2025-07-14 08:58:16','system','2025-11-05 05:57:34','air@megazone.com','0:0:0:0:0:0:0:1'),(2100,0,'RAG 관리',NULL,NULL,'studio',NULL,2100,0,'G',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2101,2100,'지식 베이스',NULL,NULL,'studio',NULL,2101,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2102,2100,'문서 인덱스',NULL,NULL,'studio',NULL,2102,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2103,2100,'검색 쿼리',NULL,NULL,'studio',NULL,2103,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2104,2100,'RAG 플레이그라운드',NULL,NULL,'studio',NULL,2104,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2200,0,'RAG 평가',NULL,NULL,'studio',NULL,2200,0,'G',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2201,2200,'평가 데이터셋',NULL,NULL,'studio',NULL,2201,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(2202,2200,'평가 관리',NULL,NULL,'studio',NULL,2202,0,'M',NULL,'Y','N','2025-07-14 09:00:44','system','2025-07-14 09:00:44','system','127.0.0.1'),(3301,1100,'RAG 전처리 파이프라인','/admin/features/rag-pipeline','RAG 전처리 파이프라인 관리','admin',NULL,1106,0,'M','U','Y','N','2025-08-28 18:08:30','system','2025-08-29 16:47:39','system','59.10.176.51'),(3302,0,'새로운 대화 시작','/account/searchResult?type=Chat','새로운 대화 시작','chat',NULL,1001,0,'M','U','Y','N','2025-11-05 05:41:20','air@megazone.com','2025-11-05 05:41:20','air@megazone.com','0:0:0:0:0:0:0:1'),(3303,0,'새로운 Canvas 시작','/account/searchResult?type=Canvas','새로운 Canvas 시작','chat',NULL,1002,0,'M','U','Y','N','2025-11-05 05:42:22','air@megazone.com','2025-11-05 05:42:22','air@megazone.com','0:0:0:0:0:0:0:1'),(3304,0,'AIR 에이전트','/account/agentSearch','AIR 에이전트','chat',NULL,1003,0,'M','U','Y','N','2025-11-05 05:42:56','air@megazone.com','2025-11-05 05:42:56','air@megazone.com','0:0:0:0:0:0:0:1'),(3305,0,'현황 대시보드','/studio/dashboard','현황 대시보드','studio',NULL,1000,0,'M','U','Y','N','2025-11-05 05:44:06','air@megazone.com','2025-11-05 05:47:51','air@megazone.com','0:0:0:0:0:0:0:1'),(3306,0,'MCP 서버 스토어','/studio/myMcp','MCP 서버 스토어','studio',NULL,1100,0,'M','U','Y','N','2025-11-05 05:52:14','air@megazone.com','2025-11-05 05:52:14','air@megazone.com','0:0:0:0:0:0:0:1'),(3307,0,'대시보드','','대시보드','admin',NULL,1,0,'G','G','Y','N','2025-11-05 06:00:40','air@megazone.com','2025-11-05 06:00:40','air@megazone.com','0:0:0:0:0:0:0:1'),(3308,3307,'통합 대시보드','/admin/dashboard/overview','통합 대시보드','admin',NULL,1,0,'M','U','Y','N','2025-11-05 06:01:33','air@megazone.com','2025-11-05 06:01:33','air@megazone.com','0:0:0:0:0:0:0:1'),(3309,1100,'인증 및 접근','/admin/features/mcp-auth','MCP 서버 인증 및 접근 관리','admin',NULL,1109,0,'M','U','Y','N','2025-11-05 06:04:40','air@megazone.com','2025-11-05 06:04:52','air@megazone.com','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `TB_SYS_MENU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MENU_ROLE`
--

DROP TABLE IF EXISTS `TB_SYS_MENU_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MENU_ROLE` (
                                    `MENU_ROLE_SNO` int NOT NULL AUTO_INCREMENT COMMENT '메뉴권한번호',
                                    `MENU_ROLE_CD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '관리자권한코드',
                                    `MENU_ROLE_NM` varchar(50) DEFAULT NULL COMMENT '관리자권한명',
                                    `MENU_ROLE_DESC` varchar(1000) DEFAULT NULL COMMENT '관리자권한설명',
                                    `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                    `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                    `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                    `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                    `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                    `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                    `COMPANY_CD` varchar(100) NOT NULL DEFAULT 'MZC',
                                    PRIMARY KEY (`MENU_ROLE_SNO`),
                                    UNIQUE KEY `TB_SYS_MENU_ROLE_UNIQUE` (`MENU_ROLE_CD`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 메뉴 권한';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MENU_ROLE`
--

LOCK TABLES `TB_SYS_MENU_ROLE` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE` DISABLE KEYS */;
INSERT INTO `TB_SYS_MENU_ROLE` VALUES (1,'ADMIN','관리자','관리자Role','Y','2023-11-02 07:29:50','system','2023-11-02 07:29:50','system','127.0.0.1','MZC'),(2,'ADVANCED_USER','고급 사용자',NULL,'Y','2025-07-14 11:16:31','system','2025-07-14 08:49:48','system','127.0.0.1','MZC'),(3,'GENERAL_USER','일반 사용자','','Y','2023-11-27 02:28:11','system','2025-07-14 11:16:10','system','0:0:0:0:0:0:0:1','MZC');
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MENU_ROLE_RLT`
--

DROP TABLE IF EXISTS `TB_SYS_MENU_ROLE_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MENU_ROLE_RLT` (
                                        `MENU_ROLE_SNO` int NOT NULL COMMENT '메뉴권한번호',
                                        `MENU_SNO` int NOT NULL COMMENT '메뉴순번',
                                        `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                                        `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                        `REG_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                        `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                        `UPDT_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                                        `UPDT_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                                        PRIMARY KEY (`MENU_ROLE_SNO`,`MENU_SNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템 메뉴 역할 맵핑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MENU_ROLE_RLT`
--

LOCK TABLES `TB_SYS_MENU_ROLE_RLT` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE_RLT` DISABLE KEYS */;
INSERT INTO `TB_SYS_MENU_ROLE_RLT` VALUES (1,1000,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1001,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1002,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1003,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1004,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1100,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1101,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1102,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1103,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1105,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1106,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1200,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1201,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1202,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1203,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1400,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1401,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1402,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,1403,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2000,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2001,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2100,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2101,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2102,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2103,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2104,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2200,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2201,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,2202,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3301,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3302,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3303,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3304,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3305,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3306,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3307,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3308,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(1,3309,'Y','2025-11-05 06:05:51','air@megazone.com','2025-11-05 06:05:51','air@megazone.com','0:0:0:0:0:0:0:1'),(2,2000,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2001,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2100,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2101,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2102,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2103,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2104,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2200,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2201,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,2202,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,3000,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,3100,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,3200,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(2,3300,'Y','2025-07-14 11:24:48','air@megazone.com','2025-07-14 11:24:48','air@megazone.com','59.10.176.51'),(3,3000,'Y','2025-07-14 10:14:49','system','2025-07-14 10:14:49','system','127.0.0.1'),(3,3100,'Y','2025-07-14 10:14:49','system','2025-07-14 10:14:49','system','127.0.0.1'),(3,3200,'Y','2025-07-14 10:14:49','system','2025-07-14 10:14:49','system','127.0.0.1'),(3,3300,'Y','2025-07-14 10:14:49','system','2025-07-14 10:14:49','system','127.0.0.1');
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MENU_ROLE_USER_RLT`
--

DROP TABLE IF EXISTS `TB_SYS_MENU_ROLE_USER_RLT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MENU_ROLE_USER_RLT` (
                                             `MENU_ROLE_SNO` int NOT NULL COMMENT '메뉴권한번호',
                                             `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID',
                                             `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                             `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                             `REG_USER_IP` varchar(23) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                             PRIMARY KEY (`MENU_ROLE_SNO`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='시스템메뉴권한-사용자매핑';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MENU_ROLE_USER_RLT`
--

LOCK TABLES `TB_SYS_MENU_ROLE_USER_RLT` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE_USER_RLT` DISABLE KEYS */;
INSERT INTO `TB_SYS_MENU_ROLE_USER_RLT` VALUES (1,'air@megazone.com','2025-07-14 15:58:38','system','127.0.0.1'),(2,'air@megazone.com','2025-07-14 19:03:28','system','127.0.0.1'),(3,'air@megazone.com','2025-07-14 19:10:22','system','127.0.0.1');
/*!40000 ALTER TABLE `TB_SYS_MENU_ROLE_USER_RLT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_MENU_TRANSLATION`
--

DROP TABLE IF EXISTS `TB_SYS_MENU_TRANSLATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_MENU_TRANSLATION` (
                                           `FK_MENU_SNO` int NOT NULL COMMENT 'MENU ID',
                                           `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                           `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT',
                                           PRIMARY KEY (`FK_MENU_SNO`,`LANGUAGE_CODE`),
                                           CONSTRAINT `FK_SYS_MENU_TRANSLATION_SYS_MENU` FOREIGN KEY (`FK_MENU_SNO`) REFERENCES `TB_SYS_MENU` (`MENU_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MENU 다국어 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_MENU_TRANSLATION`
--

LOCK TABLES `TB_SYS_MENU_TRANSLATION` WRITE;
/*!40000 ALTER TABLE `TB_SYS_MENU_TRANSLATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_SYS_MENU_TRANSLATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_SYS_USER`
--

DROP TABLE IF EXISTS `TB_SYS_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_SYS_USER` (
                               `USER_ID` varchar(64) NOT NULL COMMENT '사용자ID[사용자이메일주소]',
                               `USER_NM` varchar(64) NOT NULL COMMENT '사용자이름',
                               `PASSWORD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '$2a$10$kbOjY0wlfcom69B990s5e.wnfHadaD9taa9afIOM7T8cXrBXBqKaS' COMMENT '패스워드',
                               `ADMIN_TYPE` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NN' COMMENT '관리자유형',
                               `EMP_NO` varchar(50) DEFAULT NULL COMMENT '사원번호',
                               `ERP_EMP_NO` varchar(32) DEFAULT NULL COMMENT 'ERP사원번호',
                               `COMPANY_CD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0000' COMMENT '회사코드',
                               `DEPT_CD` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0000' COMMENT '부서코드',
                               `JBTTL_CD` varchar(20) DEFAULT NULL COMMENT '직책코드',
                               `JBTTL_CD_NM` varchar(100) DEFAULT NULL COMMENT '직책명',
                               `COMPANY_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '회사없음' COMMENT '회사명',
                               `DEPT_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '부서없음' COMMENT '부서명',
                               `DEPT_LOC` varchar(500) DEFAULT NULL COMMENT '부서경로',
                               `DEPT_CD_LOC` varchar(500) DEFAULT NULL COMMENT '부서코드경로',
                               `EMP_YN` varchar(1) NOT NULL DEFAULT 'N' COMMENT '사원여부',
                               `USE_YN` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
                               `SECRET_CODE` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '/Jae9m3Mai2vWNuuVgGyMA==' COMMENT '시크릿코드',
                               `REG_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                               `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                               `UPDT_DTTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                               `UPDT_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '수정사용자ID',
                               `UPDT_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '수정사용자IP',
                               `LOCALE` varchar(20) DEFAULT NULL COMMENT '국가[언어]',
                               `LAST_LOGIN_DT` varchar(20) DEFAULT NULL COMMENT '마지막 로그인',
                               `TIMEZONE` varchar(10) DEFAULT 'KRKST' COMMENT '사용자 타임존',
                               PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사용자';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_SYS_USER`
--

LOCK TABLES `TB_SYS_USER` WRITE;
/*!40000 ALTER TABLE `TB_SYS_USER` DISABLE KEYS */;
INSERT INTO `TB_SYS_USER` VALUES ('air@megazone.com','AIR 관리자','$2a$10$Pd2TfpEWZdES8JWeOVy0GeMflQvBMrxEqsSoshU7.E9vPS9LAXBpa','SA',NULL,NULL,'0000','0000',NULL,NULL,'회사없음','부서없음',NULL,NULL,'N','Y','/Jae9m3Mai2vWNuuVgGyMA==','2025-07-14 18:40:13','system','2025-07-14 18:40:13','system','127.0.0.1',NULL,'2025-11-05 16:39:02','KRKST');
/*!40000 ALTER TABLE `TB_SYS_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_TTSQL_FIELD`
--

DROP TABLE IF EXISTS `TB_TTSQL_FIELD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_TTSQL_FIELD` (
                                  `kor_col_nm` varchar(200) DEFAULT NULL COMMENT '한글 컬럼명',
                                  `eng_col_nm` varchar(200) DEFAULT NULL COMMENT '영어 컬럼명',
                                  `col_desc` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '컬럼 상세',
                                  `db_nm` varchar(200) DEFAULT NULL COMMENT '데이터베이스명',
                                  `tbl_nm` varchar(200) DEFAULT NULL COMMENT '테이블 명',
                                  `data_type` varchar(200) DEFAULT NULL COMMENT '데이터 타입',
                                  `pk_yn` varchar(1) DEFAULT NULL COMMENT 'pk 여부',
                                  `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                  `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                  `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                  `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                  `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TTSQL 초기 인뎃스설정 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_TTSQL_FIELD`
--

LOCK TABLES `TB_TTSQL_FIELD` WRITE;
/*!40000 ALTER TABLE `TB_TTSQL_FIELD` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_TTSQL_FIELD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TB_USER_PRPT_CONFIG`
--

DROP TABLE IF EXISTS `TB_USER_PRPT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TB_USER_PRPT_CONFIG` (
                                       `INDEX_NAME` varchar(500) NOT NULL COMMENT '인덱스명',
                                       `CONFIG_VERSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '설정버전',
                                       `USER_PRPT_TP` varchar(100) NOT NULL DEFAULT '' COMMENT 'PRPT_TYPE RE 등등',
                                       `USER_PRPT_VAL` varchar(3000) NOT NULL DEFAULT '' COMMENT 'PROPERTY 값',
                                       `USER_PRPT_DESC` varchar(100) NOT NULL DEFAULT '' COMMENT 'PROPERTYdummy 컬럼',
                                       `USE_YN` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N' COMMENT '사용여부',
                                       `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                       `REG_USER_ID` varchar(64) DEFAULT NULL COMMENT '등록사용자ID',
                                       `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
                                       `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                       `UPDT_USER_IP` varchar(23) NOT NULL COMMENT '수정사용자IP',
                                       PRIMARY KEY (`INDEX_NAME`,`CONFIG_VERSION`,`USER_PRPT_TP`),
                                       UNIQUE KEY `IDX_PRPT_CONFIG` (`INDEX_NAME`,`CONFIG_VERSION`,`USER_PRPT_TP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='지식저장소 설정';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TB_USER_PRPT_CONFIG`
--

LOCK TABLES `TB_USER_PRPT_CONFIG` WRITE;
/*!40000 ALTER TABLE `TB_USER_PRPT_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `TB_USER_PRPT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEMP_TB_MODEL`
--

DROP TABLE IF EXISTS `TEMP_TB_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMP_TB_MODEL` (
                                 `MODEL_SNO` int NOT NULL AUTO_INCREMENT COMMENT 'Model 일련번호 (PK)',
                                 `MODEL_ID` varchar(200) NOT NULL COMMENT '실제 Model Vendor에 전달할 Model ID',
                                 `MODEL_NAME` varchar(100) NOT NULL COMMENT '모델의 이름 (UI 노출 용도)',
                                 `MODEL_GROUP_SNO` int NOT NULL COMMENT 'TB_MODEL_GROUP의 PK (Foreign Key)',
                                 `MODEL_CRED_ID` varchar(36) NOT NULL COMMENT 'TB_MODEL_CRED의 PK (UUID4)',
                                 `MODEL_TYPE` varchar(10) NOT NULL COMMENT 'Model 타입 (LLM|EMBED)',
                                 `MODEL_PROPERTIES` longtext COMMENT 'TB_MODEL_GROUP의 MODEL_PROPERTIES 기반의 Model Config (JSON 구조)',
                                 `GROUP_PROPERTIES` longtext COMMENT 'TB_MODEL_GROUP의 GROUP_PROPERTIES 기반의 공급사 Config (JSON 구조)',
                                 `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '모델 설명',
                                 `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                 `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                 `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                 `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                 `REG_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                 `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                 `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                 `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                 `SUBTITLE` varchar(100) DEFAULT NULL COMMENT '부제목',
                                 PRIMARY KEY (`MODEL_SNO`),
                                 UNIQUE KEY `UQ_MODEL_ID` (`MODEL_ID`),
                                 KEY `IDX_MODEL_GROUP_SNO` (`MODEL_GROUP_SNO`),
                                 KEY `IDX_MODEL_CRED_ID` (`MODEL_CRED_ID`),
                                 KEY `IDX_MODEL_TYPE` (`MODEL_TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEMP_TB_MODEL`
--

LOCK TABLES `TEMP_TB_MODEL` WRITE;
/*!40000 ALTER TABLE `TEMP_TB_MODEL` DISABLE KEYS */;
INSERT INTO `TEMP_TB_MODEL` VALUES (1,'anthropic.claude-3-5-sonnet-20240620-v1:0','Claude Sonnet 3.5',1,'c5388545-8586-4418-a1f9-b3a85a0ccb2c','LLM','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\",\"value\":\"2048\"}]','[{\"key\":\"region\",\"name\":\"Region\",\"value\":\"ap-northeast-2\"}]','중간 크기의 LLM으로 언어 이해와 창의적 응답에 강점을 가진 모델입니다.','N','N','2025-07-10 02:19:25','air@megazone.com','127.0.0.1','2025-11-05 07:46:46',NULL,NULL,'정밀하고 안정적인 응답'),(2,'amazon.titan-embed-text-v2:0','Amazon Titan Embedding Text 2.0',1,'c5388545-8586-4418-a1f9-b3a85a0ccb2c','EMBED','[{\"key\":\"dimension\",\"name\":\"dimension\",\"value\":\"1024\"}]','[{\"key\":\"region\",\"name\":\"Region\",\"value\":\"ap-northeast-2\"}]','다양한 언어의 문장을 고차원 벡터로 변환하여 의미 기반 검색, 분류, 유사도 분석 등에 활용 가능한 고성능 임베딩 모델입니다.','N','N','2025-07-11 02:31:37','air@megazone.com','127.0.0.1','2025-11-05 07:46:46',NULL,NULL,'고성능 텍스트 임베딩'),(3,'gpt-4.1','Azure OpenAI GPT 4.1',2,'1ced6e80-5e00-11f0-a2d4-0a550d67e511','LLM','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\",\"value\":\"2048\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\",\"value\":\"[\\\"User:\\\"]\"}]','[{\"key\":\"azure_deployment\",\"name\":\"azure_deployment\",\"value\":\"gpt-4.1\"}]','OpenAI 최신 GPT 시리즈로, 복잡한 작업도 고정밀도로 처리할 수 있는 강력한 모델입니다.','N','N','2025-07-11 02:38:52','air@megazone.com','127.0.0.1','2025-11-05 07:46:46',NULL,NULL,'최신 GPT, 고정확도 제공'),(4,'claude-3-5-sonnet@20240620','Claude Sonnet 3.5',3,'2468200f-5e1b-11f0-a2d4-0a550d67e511','LLM','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\",\"value\":\"2048\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\",\"value\":\"[\\\"User:\\\"]\"}]','[{\"key\":\"location\",\"name\":\"Location\",\"value\":\"asia-southeast1\"}]','고성능 언어 처리 모델로 다양한 질문에 대해 안정적이고 일관된 응답을 제공합니다.','N','N','2025-07-11 05:55:22','air@megazone.com','127.0.0.1','2025-11-05 07:46:46',NULL,NULL,'정밀하고 안정적인 응답'),(5,'publishers/google/models/gemini-2.5-flash','Gemini 2.5 Flash',3,'2468200f-5e1b-11f0-a2d4-0a550d67e511','LLM','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\",\"value\":\"4096\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\",\"value\":\"[\\\"User:\\\"]\"}]','[{\"key\":\"location\",\"name\":\"Location\",\"value\":\"us-central1\"}]','실시간 반응 속도에 최적화된 모델로 빠른 처리와 경량화된 활용이 가능한 멀티모달 LLM입니다.','N','N','2025-07-11 05:55:22','air@megazone.com','127.0.0.1','2025-11-05 07:46:46',NULL,NULL,'빠른 응답, 실시간 최적화');
/*!40000 ALTER TABLE `TEMP_TB_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEMP_TB_MODEL_CRED`
--

DROP TABLE IF EXISTS `TEMP_TB_MODEL_CRED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMP_TB_MODEL_CRED` (
                                      `MODEL_CRED_ID` varchar(36) NOT NULL DEFAULT (uuid()) COMMENT 'Model Credential ID (PK, UUID4)',
                                      `CRED_NAME` varchar(100) NOT NULL COMMENT '인증 정보 이름 (동일한 인증 방식이지만 다른 인증 데이터 관리용)',
                                      `MODEL_CRED_TEMP_SNO` int NOT NULL COMMENT 'TB_MODEL_CRED_TEMP의 PK (Foreign Key)',
                                      `PROPERTIES` longtext COMMENT 'TB_MODEL_CRED_TEMP의 PROPERTIES 기반의 인증 정보 (JSON 구조)',
                                      `MODEL_GROUP_SNO` int NOT NULL COMMENT 'TB_MODEL_GROUP의 PK (Foreign Key)',
                                      `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '인증 정보 설명',
                                      `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                      `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                      `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                      `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                      `REG_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                      `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                      `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                      `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                      PRIMARY KEY (`MODEL_CRED_ID`),
                                      UNIQUE KEY `UQ_CRED_NAME_GROUP` (`CRED_NAME`,`MODEL_GROUP_SNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 인증 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEMP_TB_MODEL_CRED`
--

LOCK TABLES `TEMP_TB_MODEL_CRED` WRITE;
/*!40000 ALTER TABLE `TEMP_TB_MODEL_CRED` DISABLE KEYS */;
/*!40000 ALTER TABLE `TEMP_TB_MODEL_CRED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEMP_TB_MODEL_CRED_TEMP`
--

DROP TABLE IF EXISTS `TEMP_TB_MODEL_CRED_TEMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMP_TB_MODEL_CRED_TEMP` (
                                           `MODEL_CRED_TEMP_SNO` int NOT NULL AUTO_INCREMENT COMMENT 'Model Credential Template 일련번호 (PK)',
                                           `CRED_NAME` varchar(100) NOT NULL COMMENT '인증 방식 이름',
                                           `MODEL_GROUP_SNO` int NOT NULL COMMENT 'TB_MODEL_GROUP의 PK (Foreign Key)',
                                           `PROPERTIES` longtext COMMENT '인증 방식의 구성 Template (JSON 구조)',
                                           `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '인증 방식 설명',
                                           `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                           `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                           `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                           `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                           `REG_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                           `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                           `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                           `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                           PRIMARY KEY (`MODEL_CRED_TEMP_SNO`),
                                           UNIQUE KEY `UQ_CRED_NAME_GROUP` (`CRED_NAME`,`MODEL_GROUP_SNO`),
                                           KEY `IDX_MODEL_GROUP_SNO` (`MODEL_GROUP_SNO`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 인증 방식 템플릿';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEMP_TB_MODEL_CRED_TEMP`
--

LOCK TABLES `TEMP_TB_MODEL_CRED_TEMP` WRITE;
/*!40000 ALTER TABLE `TEMP_TB_MODEL_CRED_TEMP` DISABLE KEYS */;
INSERT INTO `TEMP_TB_MODEL_CRED_TEMP` VALUES (1,'ACCESS KEY 기반 인증',1,'[{\"key\":\"AWS_ACCESS_KEY_ID\",\"name\":\"Access Key ID\"},{\"key\":\"AWS_SECRET_ACCESS_KEY\",\"name\":\"Secret Access Key\"}]','Access Key 기반 인증','Y','N','2025-07-10 02:39:50','system','127.0.0.1','2025-07-10 02:39:50',NULL,NULL),(2,'Azure OpenAI 인증',2,'[{\"name\":\"AZURE_OPENAI_ENDPOINT\",\"key\":\"AZURE_OPENAI_ENDPOINT\"},{\"name\":\"AZURE_OPENAI_API_KEY\",\"key\":\"AZURE_OPENAI_API_KEY\"},{\"name\":\"AZURE_OPENAI_API_VERSION\",\"key\":\"AZURE_OPENAI_API_VERSION\"}]','API Key 기반 인증','Y','N','2025-07-11 02:38:11','system','127.0.0.1','2025-07-14 09:37:55',NULL,NULL),(3,'Google Cloud Credential을 통한 인증',3,'[{\"name\":\"Google Cloud Credential\",\"key\":\"GOOGLE_CLOUD_CREDENTIAL\"}]',NULL,'Y','N','2025-07-11 05:46:54','system','127.0.0.1','2025-07-14 09:37:55',NULL,NULL),(4,'OpenAI 인증',7,'[{\"name\":\"OPENAI_API_KEY\",\"key\":\"OPENAI_API_KEY\"}]','API Key 기반 인증','Y','N','2025-07-11 11:38:11','system','127.0.0.1','2025-11-06 16:08:17',NULL,NULL);
/*!40000 ALTER TABLE `TEMP_TB_MODEL_CRED_TEMP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEMP_TB_MODEL_GROUP`
--

DROP TABLE IF EXISTS `TEMP_TB_MODEL_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEMP_TB_MODEL_GROUP` (
                                       `MODEL_GROUP_SNO` int NOT NULL AUTO_INCREMENT COMMENT 'Model Group 일련번호 (PK)',
                                       `MODEL_GROUP_NAME` varchar(100) NOT NULL COMMENT '모델 공급 업체 이름',
                                       `MODEL_PROPERTIES` longtext COMMENT 'TB_MODEL에 적용할 Model Config Template (JSON 구조)',
                                       `GROUP_PROPERTIES` longtext COMMENT 'TB_MODEL에 적용할 모델 공급사 Config Template (JSON 구조)',
                                       `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '모델 그룹 설명',
                                       `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부 (Y/N)',
                                       `DEL_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '삭제여부 (Y/N)',
                                       `REG_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                       `REG_USER_ID` varchar(64) NOT NULL DEFAULT 'system' COMMENT '등록사용자ID',
                                       `REG_USER_IP` varchar(23) NOT NULL DEFAULT '127.0.0.1' COMMENT '등록사용자IP',
                                       `UPDT_DTTM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                       `UPDT_USER_ID` varchar(64) DEFAULT NULL COMMENT '수정사용자ID',
                                       `UPDT_USER_IP` varchar(23) DEFAULT NULL COMMENT '수정사용자IP',
                                       PRIMARY KEY (`MODEL_GROUP_SNO`),
                                       UNIQUE KEY `UQ_MODEL_GROUP_NAME` (`MODEL_GROUP_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 공급 업체 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEMP_TB_MODEL_GROUP`
--

LOCK TABLES `TEMP_TB_MODEL_GROUP` WRITE;
/*!40000 ALTER TABLE `TEMP_TB_MODEL_GROUP` DISABLE KEYS */;
INSERT INTO `TEMP_TB_MODEL_GROUP` VALUES (1,'AWS Bedrock','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\"}]','[{\"key\":\"region\",\"name\":\"리전 등록\"}]','AWS에서 다양한 생성형 AI 모델(Titan, Claude, Llama 등)을 통합 API로 제공하는 플랫폼입니다.','Y','N','2025-07-10 02:22:35','air@megazone.com','127.0.0.1','2025-11-05 07:47:11','air@megazone.com','127.0.0.1'),(2,'Azure OpenAI','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\"}]','[{\"key\":\"azure_deployment\",\"name\":\"Azure Development\"}]','MS Azure에서 OpenAI의 GPT 모델을 엔터프라이즈 환경과 보안 기능과 함께 API로 제공합니다.','Y','N','2025-07-11 02:36:38','air@megazone.com','127.0.0.1','2025-11-05 07:47:11','air@megazone.com',NULL),(3,'Google Cloud Vertex AI','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\"}]','[{\"key\":\"location\",\"name\":\"Location\"}]','구글 클라우드의 통합 AI 플랫폼으로, 데이터 준비부터 모델 개발·배포까지 전 과정을 지원합니다.','Y','N','2025-07-11 05:43:19','air@megazone.com','127.0.0.1','2025-11-05 07:47:11','air@megazone.com','127.0.0.1'),(7,'OpenAI','[{\"key\":\"max_tokens\",\"name\":\"Max Tokens\"},{\"key\":\"stop_sequences\",\"name\":\"스톱문장\"}]','[{\"key\":\"baseUrl\",\"name\":\"BaseUrl\"}]','다양한 AI 모델(API)을 제공하는 대표적 모델 벤더로, GPT·DALL·E 등 고성능 언어·비전 모델을 서비스합니다','Y','N','2025-08-14 04:19:04','air@megazone.com','127.0.0.1','2025-11-05 07:47:11','air@megazone.com',NULL);
/*!40000 ALTER TABLE `TEMP_TB_MODEL_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `VW_RECURSIVE_COMPANY_TREE`
--

DROP TABLE IF EXISTS `VW_RECURSIVE_COMPANY_TREE`;
/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_COMPANY_TREE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `VW_RECURSIVE_COMPANY_TREE` AS SELECT
                                                        1 AS `VIEW_TYPE`,
                                                        1 AS `PA_KEY`,
                                                        1 AS `KEY`,
                                                        1 AS `LABEL`,
                                                        1 AS `COMPANY_CD`,
                                                        1 AS `COMPANY_NM`,
                                                        1 AS `COMPANY_CD_LOC`,
                                                        1 AS `COMPANY_NM_LOC`,
                                                        1 AS `COMPANY_LVL`,
                                                        1 AS `SN2`,
                                                        1 AS `CNT`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `VW_RECURSIVE_DEPT`
--

DROP TABLE IF EXISTS `VW_RECURSIVE_DEPT`;
/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_DEPT`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `VW_RECURSIVE_DEPT` AS SELECT
                                                1 AS `COMPANY_CD`,
                                                1 AS `DEPT_CD`,
                                                1 AS `DEPT_NM`,
                                                1 AS `DEPT_CD_PATH`,
                                                1 AS `DEPT_NM_PATH`,
                                                1 AS `PA_DEPT_CD`,
                                                1 AS `PA_DEPT_NM`,
                                                1 AS `DEPT_LVL`,
                                                1 AS `SORT_SN`,
                                                1 AS `USE_YN`,
                                                1 AS `LEVEL`,
                                                1 AS `SN2`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `VW_RECURSIVE_DEPT_TREE`
--

DROP TABLE IF EXISTS `VW_RECURSIVE_DEPT_TREE`;
/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_DEPT_TREE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `VW_RECURSIVE_DEPT_TREE` AS SELECT
                                                     1 AS `VIEW_TYPE`,
                                                     1 AS `PA_KEY`,
                                                     1 AS `KEY`,
                                                     1 AS `LABEL`,
                                                     1 AS `COMPANY_CD`,
                                                     1 AS `DEPT_CD`,
                                                     1 AS `DEPT_NM`,
                                                     1 AS `DEPT_CD_LOC`,
                                                     1 AS `DEPT_LOC`,
                                                     1 AS `PA_DEPT_CD`,
                                                     1 AS `PA_DEPT_NM`,
                                                     1 AS `DEPT_LVL`,
                                                     1 AS `SORT_SN`,
                                                     1 AS `LEVEL`,
                                                     1 AS `SN2`,
                                                     1 AS `CNT`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `VW_RECURSIVE_MENU`
--

DROP TABLE IF EXISTS `VW_RECURSIVE_MENU`;
/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_MENU`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `VW_RECURSIVE_MENU` AS SELECT
                                                1 AS `MENU_SNO`,
                                                1 AS `UPPER_MENU_SNO`,
                                                1 AS `UPPER_MENU_NM`,
                                                1 AS `MENU_NM`,
                                                1 AS `MENU_SNO_PATH`,
                                                1 AS `MENU_NM_PATH`,
                                                1 AS `MENU_URL`,
                                                1 AS `IMG_INFO`,
                                                1 AS `MENU_ORDER`,
                                                1 AS `MENU_LVL`,
                                                1 AS `MENU_TYPE`,
                                                1 AS `MENU_SE`,
                                                1 AS `LEVEL`,
                                                1 AS `TEMPLATE_NM`,
                                                1 AS `USE_YN`,
                                                1 AS `DEL_YN`,
                                                1 AS `SN2`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `VW_USER_TREE`
--

DROP TABLE IF EXISTS `VW_USER_TREE`;
/*!50001 DROP VIEW IF EXISTS `VW_USER_TREE`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `VW_USER_TREE` AS SELECT
                                           1 AS `VIEW_TYPE`,
                                           1 AS `PA_KEY`,
                                           1 AS `KEY`,
                                           1 AS `LABEL`,
                                           1 AS `COMPANY_CD`,
                                           1 AS `DEPT_CD`,
                                           1 AS `USER_ID`,
                                           1 AS `USER_NM`,
                                           1 AS `JBTTL_CD`,
                                           1 AS `JBTTL_CD_NM`,
                                           1 AS `DEPT_CD_LOC`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'genai_init'
--

--
-- Dumping routines for database 'genai_init'
--
/*!50003 DROP FUNCTION IF EXISTS `FN_CONVERT_TO_DATETIME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_CONVERT_TO_DATETIME`(
    p_utc_datetime DATETIME,
    p_timezone_offset VARCHAR(20)
) RETURNS datetime
    DETERMINISTIC
BEGIN
    DECLARE v_offset VARCHAR(10);
    DECLARE v_hour INT;
    DECLARE v_minute INT;


    IF p_timezone_offset IS NULL OR p_timezone_offset = '' THEN
        SET v_offset = '+09:00';
    ELSE
        SET v_offset = REPLACE(p_timezone_offset, 'UTC', '');
    END IF;

    -- 시간과 분을 정수로 분리
    SET v_hour = CAST(SUBSTRING_INDEX(v_offset, ':', 1) AS SIGNED);
    SET v_minute = CAST(SUBSTRING_INDEX(v_offset, ':', -1) AS SIGNED);

    -- 시간 값에서 9시간을 뺌
    SET v_hour = v_hour - 9;

    -- 새로운 오프셋 문자열로 재구성
    SET v_offset = CONCAT(
            IF(v_hour >= 0, '+', '-'),
            LPAD(ABS(v_hour), 2, '0'),
            ':',
            LPAD(ABS(v_minute), 2, '0')
                   );

    -- CONVERT_TZ의 결과(DATETIME)를 그대로 반환
    RETURN CONVERT_TZ(p_utc_datetime, 'UTC', v_offset);
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_CONVERT_TO_TIMESTAMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_CONVERT_TO_TIMESTAMP`(
    p_utc_datetime DATETIME,
    p_timezone_offset VARCHAR(20)
) RETURNS timestamp
    DETERMINISTIC
BEGIN
    DECLARE v_offset VARCHAR(10);
    DECLARE v_hour INT;
    DECLARE v_minute INT;

    IF p_timezone_offset IS NULL OR p_timezone_offset = '' THEN
        SET v_offset = '+09:00';
    ELSE
        SET v_offset = REPLACE(p_timezone_offset, 'UTC', '');
    END IF;

    -- 시간과 분을 정수로 분리
    SET v_hour = CAST(SUBSTRING_INDEX(v_offset, ':', 1) AS SIGNED);
    SET v_minute = CAST(SUBSTRING_INDEX(v_offset, ':', -1) AS SIGNED);

    -- 시간 값에서 9시간을 뺌
    SET v_hour = v_hour - 9;

    -- 새로운 오프셋 문자열로 재구성
    SET v_offset = CONCAT(
            IF(v_hour >= 0, '+', '-'),
            LPAD(ABS(v_hour), 2, '0'),
            ':',
            LPAD(ABS(v_minute), 2, '0')
                   );

    -- CONVERT_TZ의 결과를 TIMESTAMP로 변환하여 반환
    RETURN CONVERT_TZ(p_utc_datetime, 'UTC', v_offset);
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_CONVERT_VARCHAR_DATETIME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_CONVERT_VARCHAR_DATETIME`(
    p_utc_datetime_str VARCHAR(14),
    p_timezone_offset VARCHAR(20)
) RETURNS varchar(14) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE v_offset VARCHAR(10);
    DECLARE v_hour INT;
    DECLARE v_minute INT;
    DECLARE v_utc_datetime DATETIME;
    DECLARE v_converted_datetime DATETIME;

    -- 입력된 VARCHAR가 비어있으면 NULL 반환
    IF p_utc_datetime_str IS NULL OR p_utc_datetime_str = '' THEN
        RETURN NULL;
    END IF;

    -- 입력된 VARCHAR('YYYYMMDDHHMISS')를 DATETIME 타입으로 변환
    SET v_utc_datetime = STR_TO_DATE(p_utc_datetime_str, '%Y%m%d%H%i%s');

    -- 타임존 오프셋이 없으면 기본값 '+09:00' (KST) 설정
    IF p_timezone_offset IS NULL OR p_timezone_offset = '' THEN
        SET v_offset = '+09:00';
    ELSE
        SET v_offset = REPLACE(p_timezone_offset, 'UTC', '');
    END IF;

    -- 오프셋에서 시간과 분을 정수로 분리
    SET v_hour = CAST(SUBSTRING_INDEX(v_offset, ':', 1) AS SIGNED);
    SET v_minute = CAST(SUBSTRING_INDEX(v_offset, ':', -1) AS SIGNED);

    -- 핵심 로직: 시간 값에서 9시간을 뺌
    SET v_hour = v_hour - 9;

    -- 새로운 오프셋 문자열로 재구성
    SET v_offset = CONCAT(
            IF(v_hour >= 0, '+', '-'),
            LPAD(ABS(v_hour), 2, '0'),
            ':',
            LPAD(ABS(v_minute), 2, '0')
                   );

    -- UTC 시간을 계산된 새로운 오프셋 기준으로 시간 변환
    SET v_converted_datetime = CONVERT_TZ(v_utc_datetime, 'UTC', v_offset);

    -- 변환된 DATETIME을 다시 'YYYYMMDDHHMISS' 형식의 VARCHAR로 변환하여 반환
    RETURN DATE_FORMAT(v_converted_datetime, '%Y%m%d%H%i%s');
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_DEC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_DEC`(encrypted_data TEXT, secret_key TEXT) RETURNS text CHARSET utf8mb4
BEGIN
    RETURN CASE
               WHEN encrypted_data IS NULL THEN ''
               ELSE CONVERT(AES_DECRYPT(FROM_BASE64(encrypted_data), secret_key) USING UTF8MB3)
        END;
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_ENC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_ENC`(data TEXT, secret_key TEXT) RETURNS text CHARSET utf8mb4
BEGIN
    RETURN TO_BASE64(AES_ENCRYPT(data, secret_key));
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_GET_CD_NM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_GET_CD_NM`(
    P_GRP_CD         VARCHAR(50),
    P_CM_CD          VARCHAR(50)
) RETURNS varchar(200) CHARSET utf8mb4
BEGIN
    DECLARE RTN_NM VARCHAR(200) DEFAULT '';
    SELECT IF(IFNULL(CD_ID, '') = '', CD_ID, CD_NM)
    INTO RTN_NM
    FROM (
             SELECT CD_GROUP_ID
                  , CD_ID
                  , CD_NM
             FROM TB_SYS_CODE
             WHERE CD_GROUP_ID = P_GRP_CD
               AND CD_ID = P_CM_CD
         ) A;

    SET RTN_NM = CASE
                     WHEN P_GRP_CD = 'JBTTL_TP' THEN IF(IFNULL(RTN_NM, '') = '', '', RTN_NM)
                     ELSE IF(IFNULL(RTN_NM, '') = '', P_CM_CD, RTN_NM)
        END;
    RETURN RTN_NM;
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_GET_USER_NM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_GET_USER_NM`(
    P_USER_ID VARCHAR(50)
) RETURNS varchar(200) CHARSET utf8mb4
BEGIN
    DECLARE RTN_NM VARCHAR(200) DEFAULT '';
    SELECT USER_NM
    INTO RTN_NM
    FROM TB_SYS_USER
    WHERE USER_ID = P_USER_ID;
    RETURN IF(IFNULL(RTN_NM, '') = '', P_USER_ID, RTN_NM);
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_REPLACE_FIND_IN_SET` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `FN_REPLACE_FIND_IN_SET`(P_STR VARCHAR(2000)) RETURNS varchar(2000) CHARSET utf8mb4
BEGIN
    RETURN REGEXP_REPLACE(TRIM(P_STR), '[[:space:]]*,[[:space:]]*', ',');
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GET_PROMPT_WITH_RLT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `SP_GET_PROMPT_WITH_RLT`(
    IN P_AGENT_ID      VARCHAR(100),
    IN P_INDEX_NAME    VARCHAR(100),
    IN P_USER_ID       VARCHAR(100),
    IN P_PROMPT_TYPE   VARCHAR(10),
    IN P_AGENT_TYPE    VARCHAR(10)
)
BEGIN
    IF P_PROMPT_TYPE = 'H' THEN
        IF EXISTS (
            SELECT 1
            FROM TB_PROMPT_RLT
            WHERE USE_YN = 'Y'
              AND PROMPT_RLT_CD = P_AGENT_TYPE
              AND (
                (P_INDEX_NAME IS NOT NULL AND INDEX_NAME = P_INDEX_NAME)
                    OR (P_AGENT_ID IS NOT NULL AND AGENT_ID = P_AGENT_ID)
                )
              AND USER_DFN_YN = 'Y'
              AND USER_ID = P_USER_ID
        ) THEN
            SELECT
                P.PROMPT_SNO,
                P.PROMPT_TYPE,
                P.AGENT_TYPE,
                P.CONTENT AS PROMPT_CONTENT
            FROM TB_PROMPT_RLT R
                     JOIN TB_PROMPT P ON R.PROMPT_SNO = P.PROMPT_SNO
            WHERE R.USE_YN = 'Y'
              AND R.PROMPT_RLT_CD = P_AGENT_TYPE
              AND (
                (P_INDEX_NAME IS NOT NULL AND R.INDEX_NAME = P_INDEX_NAME)
                    OR (P_AGENT_ID IS NOT NULL AND R.AGENT_ID = P_AGENT_ID)
                )
              AND R.USER_DFN_YN = 'Y'
              AND R.USER_ID = P_USER_ID
              AND P.USE_YN = 'Y'
              AND P.DEL_YN = 'N'
              AND P.PROMPT_TYPE = P_PROMPT_TYPE
              AND P.AGENT_TYPE = P_AGENT_TYPE
            ORDER BY P.PROMPT_VERSION DESC
            LIMIT 1;

        ELSEIF EXISTS (
            SELECT 1
            FROM TB_PROMPT_RLT
            WHERE USE_YN = 'Y'
              AND PROMPT_RLT_CD = P_AGENT_TYPE
              AND (
                (P_INDEX_NAME IS NOT NULL AND INDEX_NAME = P_INDEX_NAME)
                    OR (P_AGENT_ID IS NOT NULL AND AGENT_ID = P_AGENT_ID)
                )
              AND USER_DFN_YN = 'N'
        ) THEN
            SELECT
                P.PROMPT_SNO,
                P.PROMPT_TYPE,
                P.AGENT_TYPE,
                P.CONTENT AS PROMPT_CONTENT
            FROM TB_PROMPT_RLT R
                     JOIN TB_PROMPT P ON R.PROMPT_SNO = P.PROMPT_SNO
            WHERE R.USE_YN = 'Y'
              AND R.PROMPT_RLT_CD = P_AGENT_TYPE
              AND (
                (P_INDEX_NAME IS NOT NULL AND R.INDEX_NAME = P_INDEX_NAME)
                    OR (P_AGENT_ID IS NOT NULL AND R.AGENT_ID = P_AGENT_ID)
                )
              AND R.USER_DFN_YN = 'N'
              AND P.USE_YN = 'Y'
              AND P.DEL_YN = 'N'
              AND P.PROMPT_TYPE = P_PROMPT_TYPE
              AND P.AGENT_TYPE = P_AGENT_TYPE
            ORDER BY P.PROMPT_VERSION DESC
            LIMIT 1;

        ELSE
            SELECT
                PROMPT_SNO,
                PROMPT_TYPE,
                AGENT_TYPE,
                CONTENT AS PROMPT_CONTENT
            FROM TB_PROMPT
            WHERE USE_YN = 'Y'
              AND DEL_YN = 'N'
              AND PROMPT_TYPE = P_PROMPT_TYPE
              AND AGENT_TYPE = P_AGENT_TYPE
            ORDER BY PROMPT_VERSION DESC
            LIMIT 1;
        END IF;

    ELSE
        SELECT
            PROMPT_SNO,
            PROMPT_TYPE,
            AGENT_TYPE,
            CONTENT AS PROMPT_CONTENT
        FROM TB_PROMPT
        WHERE USE_YN = 'Y'
          AND DEL_YN = 'N'
          AND PROMPT_TYPE = P_PROMPT_TYPE
          AND AGENT_TYPE = P_AGENT_TYPE
        ORDER BY PROMPT_VERSION DESC
        LIMIT 1;
    END IF;
END //
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `VW_RECURSIVE_COMPANY_TREE`
--

/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_COMPANY_TREE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    /*!50001 VIEW `VW_RECURSIVE_COMPANY_TREE` AS with recursive `RECURSIVE_COMPANY` as (select '0' AS `PA_KEY`,`C`.`COMPANY_CD` AS `KEY`,`C`.`COMPANY_NM` AS `LABEL`,`C`.`PA_COMPANY_CD` AS `PA_COMPANY_CD`,`C`.`COMPANY_CD` AS `COMPANY_CD`,`C`.`COMPANY_NM` AS `COMPANY_NM`,`C`.`COMPANY_CD` AS `COMPANY_CD_LOC`,`C`.`COMPANY_NM` AS `COMPANY_NM_LOC`,`C`.`COMPANY_LVL` AS `COMPANY_LVL`,(`C`.`SORT_SN` * pow(1000,(`CM`.`MAX_COMPANY_LVL` - 1))) AS `SN2` from (`TB_SYS_COMPANY` `C` join (select max(`TB_SYS_COMPANY`.`COMPANY_LVL`) AS `MAX_COMPANY_LVL` from `TB_SYS_COMPANY`) `CM`) where (`C`.`PA_COMPANY_CD` = '0') union all select `C`.`PA_COMPANY_CD` AS `PA_KEY`,`C`.`COMPANY_CD` AS `KEY`,`C`.`COMPANY_NM` AS `LABEL`,`C`.`PA_COMPANY_CD` AS `PA_COMPANY_CD`,`C`.`COMPANY_CD` AS `COMPANY_CD`,`C`.`COMPANY_NM` AS `COMPANY_NM`,concat(`RC`.`COMPANY_CD`,'>',`C`.`COMPANY_CD`) AS `COMPANY_CD_LOC`,concat(`RC`.`COMPANY_NM`,'>',`C`.`COMPANY_NM`) AS `COMPANY_NM_LOC`,`C`.`COMPANY_LVL` AS `COMPANY_LVL`,(`RC`.`SN2` + (`C`.`SORT_SN` * pow(1000,(`CM`.`MAX_COMPANY_LVL` - (1 + `RC`.`COMPANY_LVL`))))) AS `SN2` from ((`TB_SYS_COMPANY` `C` join `RECURSIVE_COMPANY` `RC` on((`RC`.`COMPANY_CD` = `C`.`PA_COMPANY_CD`))) join (select max(`TB_SYS_COMPANY`.`COMPANY_LVL`) AS `MAX_COMPANY_LVL` from `TB_SYS_COMPANY`) `CM`)) select 'C' AS `VIEW_TYPE`,`C`.`PA_KEY` AS `PA_KEY`,`C`.`KEY` AS `KEY`,`C`.`LABEL` AS `LABEL`,`C`.`COMPANY_CD` AS `COMPANY_CD`,`C`.`COMPANY_NM` AS `COMPANY_NM`,`C`.`COMPANY_CD_LOC` AS `COMPANY_CD_LOC`,`C`.`COMPANY_NM_LOC` AS `COMPANY_NM_LOC`,`C`.`COMPANY_LVL` AS `COMPANY_LVL`,`C`.`SN2` AS `SN2`,count(`U`.`COMPANY_CD`) AS `CNT` from (`RECURSIVE_COMPANY` `C` join `VW_USER_TREE` `U` on((`C`.`COMPANY_CD_LOC` like concat('%',`U`.`COMPANY_CD`,'%')))) group by `C`.`COMPANY_CD` order by `C`.`SN2` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `VW_RECURSIVE_DEPT`
--

/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_DEPT`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    /*!50001 VIEW `VW_RECURSIVE_DEPT` AS with recursive `RECURSIVE_DEPT` as (select `D`.`COMPANY_CD` AS `COMPANY_CD`,`D`.`DEPT_CD` AS `DEPT_CD`,`D`.`DEPT_NM` AS `DEPT_NM`,cast(`D`.`DEPT_CD` as char(1000) charset utf8mb4) AS `DEPT_CD_PATH`,cast(`D`.`DEPT_NM` as char(1000) charset utf8mb4) AS `DEPT_NM_PATH`,`D`.`PA_DEPT_CD` AS `PA_DEPT_CD`,cast('' as char(50) charset utf8mb4) AS `PA_DEPT_NM`,`D`.`DEPT_LVL` AS `DEPT_LVL`,`D`.`SORT_SN` AS `SORT_SN`,`D`.`USE_YN` AS `USE_YN`,1 AS `LEVEL`,(`D`.`SORT_SN` * pow(1000,(`DM`.`MAX_DEPT_LVL` - 1))) AS `SN2` from (`TB_SYS_DEPT` `D` join (select max(`TB_SYS_DEPT`.`DEPT_LVL`) AS `MAX_DEPT_LVL` from `TB_SYS_DEPT`) `DM`) where (ifnull(`D`.`PA_DEPT_CD`,'') = '0') union all select `D`.`COMPANY_CD` AS `COMPANY_CD`,`D`.`DEPT_CD` AS `DEPT_CD`,`D`.`DEPT_NM` AS `DEPT_NM`,concat(`RD`.`DEPT_CD_PATH`,'>',`D`.`DEPT_CD`) AS `DEPT_CD_PATH`,concat(`RD`.`DEPT_NM_PATH`,'>',`D`.`DEPT_NM`) AS `DEPT_NM_PATH`,`D`.`PA_DEPT_CD` AS `PA_DEPT_CD`,`RD`.`DEPT_NM` AS `PA_DEPT_NM`,`D`.`DEPT_LVL` AS `DEPT_LVL`,`D`.`SORT_SN` AS `SORT_SN`,`D`.`USE_YN` AS `USE_YN`,(1 + `RD`.`LEVEL`) AS `LEVEL`,(`RD`.`SN2` + (`D`.`SORT_SN` * pow(1000,(`DM`.`MAX_DEPT_LVL` - (1 + `RD`.`LEVEL`))))) AS `SN2` from ((`TB_SYS_DEPT` `D` join `RECURSIVE_DEPT` `RD` on(((`RD`.`COMPANY_CD` = `D`.`COMPANY_CD`) and (`RD`.`DEPT_CD` = `D`.`PA_DEPT_CD`)))) join (select max(`TB_SYS_DEPT`.`DEPT_LVL`) AS `MAX_DEPT_LVL` from `TB_SYS_DEPT`) `DM`)) select `RECURSIVE_DEPT`.`COMPANY_CD` AS `COMPANY_CD`,`RECURSIVE_DEPT`.`DEPT_CD` AS `DEPT_CD`,`RECURSIVE_DEPT`.`DEPT_NM` AS `DEPT_NM`,`RECURSIVE_DEPT`.`DEPT_CD_PATH` AS `DEPT_CD_PATH`,`RECURSIVE_DEPT`.`DEPT_NM_PATH` AS `DEPT_NM_PATH`,`RECURSIVE_DEPT`.`PA_DEPT_CD` AS `PA_DEPT_CD`,`RECURSIVE_DEPT`.`PA_DEPT_NM` AS `PA_DEPT_NM`,`RECURSIVE_DEPT`.`DEPT_LVL` AS `DEPT_LVL`,`RECURSIVE_DEPT`.`SORT_SN` AS `SORT_SN`,`RECURSIVE_DEPT`.`USE_YN` AS `USE_YN`,`RECURSIVE_DEPT`.`LEVEL` AS `LEVEL`,`RECURSIVE_DEPT`.`SN2` AS `SN2` from `RECURSIVE_DEPT` where ((ifnull(`RECURSIVE_DEPT`.`DEPT_NM_PATH`,'') = '') or (not((`RECURSIVE_DEPT`.`DEPT_NM_PATH` like 'A10%')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `VW_RECURSIVE_DEPT_TREE`
--

/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_DEPT_TREE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    /*!50001 VIEW `VW_RECURSIVE_DEPT_TREE` AS with recursive `RECURSIVE_DEPT` as (select `D`.`COMPANY_CD` AS `PA_KEY`,concat(`D`.`COMPANY_CD`,'>',`D`.`DEPT_CD`) AS `KEY`,`D`.`DEPT_NM` AS `LABEL`,`D`.`COMPANY_CD` AS `COMPANY_CD`,`D`.`DEPT_CD` AS `DEPT_CD`,`D`.`DEPT_NM` AS `DEPT_NM`,`D`.`DEPT_CD_LOC` AS `DEPT_CD_LOC`,`D`.`DEPT_LOC` AS `DEPT_LOC`,`D`.`PA_DEPT_CD` AS `PA_DEPT_CD`,cast('' as char(50) charset utf8mb4) AS `PA_DEPT_NM`,`D`.`DEPT_LVL` AS `DEPT_LVL`,`D`.`SORT_SN` AS `SORT_SN`,1 AS `LEVEL`,(`D`.`SORT_SN` * pow(1000,(`DM`.`MAX_DEPT_LVL` - 1))) AS `SN2` from (`TB_SYS_DEPT` `D` join (select `TB_SYS_DEPT`.`COMPANY_CD` AS `COMPANY_CD`,max(`TB_SYS_DEPT`.`DEPT_LVL`) AS `MAX_DEPT_LVL` from `TB_SYS_DEPT` group by `TB_SYS_DEPT`.`COMPANY_CD`) `DM` on((`DM`.`COMPANY_CD` = `D`.`COMPANY_CD`))) where ((ifnull(`D`.`PA_DEPT_CD`,'') = '0') and (`D`.`USE_YN` = 'Y')) union all select concat(`D`.`COMPANY_CD`,'>',`D`.`PA_DEPT_CD`) AS `PA_KEY`,concat(`D`.`COMPANY_CD`,'>',`D`.`DEPT_CD`) AS `KEY`,`D`.`DEPT_NM` AS `LABEL`,`D`.`COMPANY_CD` AS `COMPANY_CD`,`D`.`DEPT_CD` AS `DEPT_CD`,`D`.`DEPT_NM` AS `DEPT_NM`,`D`.`DEPT_CD_LOC` AS `DEPT_CD_LOC`,`D`.`DEPT_LOC` AS `DEPT_LOC`,`D`.`PA_DEPT_CD` AS `PA_DEPT_CD`,`RD`.`DEPT_NM` AS `PA_DEPT_NM`,`D`.`DEPT_LVL` AS `DEPT_LVL`,`D`.`SORT_SN` AS `SORT_SN`,(1 + `RD`.`LEVEL`) AS `LEVEL`,(`RD`.`SN2` + (`D`.`SORT_SN` * pow(1000,(`DM`.`MAX_DEPT_LVL` - (1 + `RD`.`LEVEL`))))) AS `SN2` from ((`TB_SYS_DEPT` `D` join `RECURSIVE_DEPT` `RD` on(((`RD`.`COMPANY_CD` = `D`.`COMPANY_CD`) and (`RD`.`DEPT_CD` = `D`.`PA_DEPT_CD`)))) join (select `TB_SYS_DEPT`.`COMPANY_CD` AS `COMPANY_CD`,max(`TB_SYS_DEPT`.`DEPT_LVL`) AS `MAX_DEPT_LVL` from `TB_SYS_DEPT` group by `TB_SYS_DEPT`.`COMPANY_CD`) `DM` on((`DM`.`COMPANY_CD` = `D`.`COMPANY_CD`))) where (`D`.`USE_YN` = 'Y')) select 'D' AS `VIEW_TYPE`,`D`.`PA_KEY` AS `PA_KEY`,`D`.`KEY` AS `KEY`,`D`.`LABEL` AS `LABEL`,`D`.`COMPANY_CD` AS `COMPANY_CD`,`D`.`DEPT_CD` AS `DEPT_CD`,`D`.`DEPT_NM` AS `DEPT_NM`,`D`.`DEPT_CD_LOC` AS `DEPT_CD_LOC`,`D`.`DEPT_LOC` AS `DEPT_LOC`,`D`.`PA_DEPT_CD` AS `PA_DEPT_CD`,`D`.`PA_DEPT_NM` AS `PA_DEPT_NM`,`D`.`DEPT_LVL` AS `DEPT_LVL`,`D`.`SORT_SN` AS `SORT_SN`,`D`.`LEVEL` AS `LEVEL`,`D`.`SN2` AS `SN2`,count(`U`.`DEPT_CD`) AS `CNT` from (`RECURSIVE_DEPT` `D` join `VW_USER_TREE` `U` on(((`U`.`COMPANY_CD` = `D`.`COMPANY_CD`) and (`U`.`DEPT_CD_LOC` like concat('%',`D`.`DEPT_CD`,'%'))))) where ((ifnull(`D`.`DEPT_LOC`,'0000') = '0000') or (not((`D`.`DEPT_LOC` like 'A10%')))) group by `D`.`COMPANY_CD`,`D`.`DEPT_CD` order by `D`.`SN2` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `VW_RECURSIVE_MENU`
--

/*!50001 DROP VIEW IF EXISTS `VW_RECURSIVE_MENU`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    /*!50001 VIEW `VW_RECURSIVE_MENU` AS with recursive `RECURSIVE_MENU` as (select `M`.`MENU_SNO` AS `MENU_SNO`,`M`.`UPPER_MENU_SNO` AS `UPPER_MENU_SNO`,cast((case when (`M`.`TEMPLATE_NM` = 'admin') then '관리자메뉴' else '사용자메뉴' end) as char(50) charset utf8mb4) AS `UPPER_MENU_NM`,`M`.`MENU_NM` AS `MENU_NM`,cast(`M`.`MENU_SNO` as char(1000) charset utf8mb4) AS `MENU_SNO_PATH`,cast(`M`.`MENU_NM` as char(1000) charset utf8mb4) AS `MENU_NM_PATH`,`M`.`MENU_URL` AS `MENU_URL`,`M`.`IMG_INFO` AS `IMG_INFO`,`M`.`MENU_ORDER` AS `MENU_ORDER`,`M`.`MENU_LVL` AS `MENU_LVL`,`M`.`MENU_TYPE` AS `MENU_TYPE`,`M`.`MENU_SE` AS `MENU_SE`,1 AS `LEVEL`,`M`.`TEMPLATE_NM` AS `TEMPLATE_NM`,`M`.`USE_YN` AS `USE_YN`,`M`.`DEL_YN` AS `DEL_YN`,(`M`.`MENU_ORDER` * pow(1000,(`MM`.`MAX_MENU_LVL` - 1))) AS `SN2` from (`TB_SYS_MENU` `M` join (select max(`TB_SYS_MENU`.`MENU_LVL`) AS `MAX_MENU_LVL` from `TB_SYS_MENU`) `MM`) where (`M`.`UPPER_MENU_SNO` = '0') union all select `CM`.`MENU_SNO` AS `MENU_SNO`,`CM`.`UPPER_MENU_SNO` AS `UPPER_MENU_SNO`,`RM`.`MENU_NM` AS `UPPER_MENU_NM`,`CM`.`MENU_NM` AS `MENU_NM`,concat(`RM`.`MENU_SNO_PATH`,'>',`CM`.`MENU_SNO`) AS `MENU_SNO_PATH`,concat(`RM`.`MENU_NM_PATH`,'>',`CM`.`MENU_NM`) AS `MENU_NM_PATH`,`CM`.`MENU_URL` AS `MENU_URL`,`CM`.`IMG_INFO` AS `IMG_INFO`,`CM`.`MENU_ORDER` AS `MENU_ORDER`,`CM`.`MENU_LVL` AS `MENU_LVL`,`CM`.`MENU_TYPE` AS `MENU_TYPE`,`CM`.`MENU_SE` AS `MENU_SE`,(1 + `RM`.`LEVEL`) AS `LEVEL`,`CM`.`TEMPLATE_NM` AS `TEMPLATE_NM`,`CM`.`USE_YN` AS `USE_YN`,`CM`.`DEL_YN` AS `DEL_YN`,(`RM`.`SN2` + (`CM`.`MENU_ORDER` * pow(1000,(`MM`.`MAX_MENU_LVL` - (1 + `RM`.`LEVEL`))))) AS `SN2` from ((`TB_SYS_MENU` `CM` join `RECURSIVE_MENU` `RM` on((`RM`.`MENU_SNO` = `CM`.`UPPER_MENU_SNO`))) join (select max(`TB_SYS_MENU`.`MENU_LVL`) AS `MAX_MENU_LVL` from `TB_SYS_MENU`) `MM`)) select `RECURSIVE_MENU`.`MENU_SNO` AS `MENU_SNO`,`RECURSIVE_MENU`.`UPPER_MENU_SNO` AS `UPPER_MENU_SNO`,`RECURSIVE_MENU`.`UPPER_MENU_NM` AS `UPPER_MENU_NM`,`RECURSIVE_MENU`.`MENU_NM` AS `MENU_NM`,`RECURSIVE_MENU`.`MENU_SNO_PATH` AS `MENU_SNO_PATH`,`RECURSIVE_MENU`.`MENU_NM_PATH` AS `MENU_NM_PATH`,`RECURSIVE_MENU`.`MENU_URL` AS `MENU_URL`,`RECURSIVE_MENU`.`IMG_INFO` AS `IMG_INFO`,`RECURSIVE_MENU`.`MENU_ORDER` AS `MENU_ORDER`,`RECURSIVE_MENU`.`MENU_LVL` AS `MENU_LVL`,`RECURSIVE_MENU`.`MENU_TYPE` AS `MENU_TYPE`,`RECURSIVE_MENU`.`MENU_SE` AS `MENU_SE`,`RECURSIVE_MENU`.`LEVEL` AS `LEVEL`,`RECURSIVE_MENU`.`TEMPLATE_NM` AS `TEMPLATE_NM`,`RECURSIVE_MENU`.`USE_YN` AS `USE_YN`,`RECURSIVE_MENU`.`DEL_YN` AS `DEL_YN`,`RECURSIVE_MENU`.`SN2` AS `SN2` from `RECURSIVE_MENU` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `VW_USER_TREE`
--

/*!50001 DROP VIEW IF EXISTS `VW_USER_TREE`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    /*!50001 VIEW `VW_USER_TREE` AS select 'U' AS `VIEW_TYPE`,concat(ifnull(`C`.`COMPANY_CD`,'0000'),'>',ifnull(`D`.`DEPT_CD`,'0000')) AS `PA_KEY`,`U`.`USER_ID` AS `KEY`,`U`.`USER_NM` AS `LABEL`,ifnull(`C`.`COMPANY_CD`,'0000') AS `COMPANY_CD`,ifnull(`D`.`DEPT_CD`,'0000') AS `DEPT_CD`,`U`.`USER_ID` AS `USER_ID`,`U`.`USER_NM` AS `USER_NM`,ifnull(`U`.`JBTTL_CD`,'') AS `JBTTL_CD`,ifnull(`U`.`JBTTL_CD_NM`,'') AS `JBTTL_CD_NM`,ifnull(`D`.`DEPT_CD_LOC`,'0000') AS `DEPT_CD_LOC` from ((`TB_SYS_USER` `U` left join `TB_SYS_COMPANY` `C` on((`U`.`COMPANY_CD` = `C`.`COMPANY_CD`))) left join `TB_SYS_DEPT` `D` on(((`D`.`COMPANY_CD` = `U`.`COMPANY_CD`) and (`D`.`DEPT_CD` = `U`.`DEPT_CD`)))) order by ifnull(`C`.`COMPANY_CD`,'0000'),ifnull(`D`.`DEPT_CD`,'0000'),ifnull(`U`.`JBTTL_CD`,''),`U`.`USER_NM` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-05 17:03:47
-- TB_AUTH_INFO_TEMPLATE_TRANSLATION 테이블 생성
-- 인증 정보 템플릿 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_AUTH_INFO_TEMPLATE_TRANSLATION`;
CREATE TABLE `TB_AUTH_INFO_TEMPLATE_TRANSLATION` (
                                                     `FK_TEMPLATE_ID` varchar(40) NOT NULL COMMENT '템플릿 ID',
                                                     `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                     `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"templateName": "템플릿명", "description": "설명"})',
                                                     PRIMARY KEY (`FK_TEMPLATE_ID`,`LANGUAGE_CODE`),
                                                     CONSTRAINT `FK_AUTH_TEMPLATE_TRANSLATION_TEMPLATE` FOREIGN KEY (`FK_TEMPLATE_ID`) REFERENCES `TB_AUTH_INFO_TEMPLATE` (`TEMPLATE_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인증 정보 템플릿 다국어 테이블';

-- TB_AUTH_INFO_TEMPLATE_FIELD_TRANSLATION 테이블 생성
-- 인증 정보 템플릿 필드 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_AUTH_INFO_TEMPLATE_FIELD_TRANSLATION`;
CREATE TABLE `TB_AUTH_INFO_TEMPLATE_FIELD_TRANSLATION` (
                                                           `FK_FIELD_SNO` bigint unsigned NOT NULL COMMENT '필드 순번',
                                                           `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                           `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"fieldName": "필드명", "description": "설명"})',
                                                           PRIMARY KEY (`FK_FIELD_SNO`,`LANGUAGE_CODE`),
                                                           CONSTRAINT `FK_AUTH_FIELD_TRANSLATION_FIELD` FOREIGN KEY (`FK_FIELD_SNO`) REFERENCES `TB_AUTH_INFO_TEMPLATE_FIELD` (`FIELD_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='인증 정보 템플릿 필드 다국어 테이블';

-- TB_SYS_CODE_GROUP_TRANSLATION 테이블 생성
-- 코드그룹 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_SYS_CODE_GROUP_TRANSLATION`;
CREATE TABLE `TB_SYS_CODE_GROUP_TRANSLATION` (
                                                 `FK_CD_GROUP_ID` varchar(64) NOT NULL COMMENT '코드그룹ID',
                                                 `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                 `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"cdGroupNm": "코드그룹명", "cdGroupDesc": "코드그룹설명"})',
                                                 PRIMARY KEY (`FK_CD_GROUP_ID`,`LANGUAGE_CODE`),
                                                 CONSTRAINT `FK_CODE_GROUP_TRANSLATION_CODE_GROUP` FOREIGN KEY (`FK_CD_GROUP_ID`) REFERENCES `TB_SYS_CODE_GROUP` (`CD_GROUP_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='코드그룹 다국어 테이블';

-- TB_SYS_CODE_TRANSLATION 테이블 생성
-- 코드 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_SYS_CODE_TRANSLATION`;
CREATE TABLE `TB_SYS_CODE_TRANSLATION` (
                                           `FK_CD_GROUP_ID` varchar(64) NOT NULL COMMENT '코드그룹ID',
                                           `FK_CD_ID` varchar(64) NOT NULL COMMENT '코드ID',
                                           `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                           `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"cdNm": "코드명", "cdDesc": "코드설명"})',
                                           PRIMARY KEY (`FK_CD_GROUP_ID`,`FK_CD_ID`,`LANGUAGE_CODE`),
                                           CONSTRAINT `FK_CODE_TRANSLATION_CODE` FOREIGN KEY (`FK_CD_GROUP_ID`, `FK_CD_ID`) REFERENCES `TB_SYS_CODE` (`CD_GROUP_ID`, `CD_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='코드 다국어 테이블';

-- TB_SYS_MENU_ROLE_TRANSLATION 테이블 생성
-- 메뉴 역할 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_SYS_MENU_ROLE_TRANSLATION`;
CREATE TABLE `TB_SYS_MENU_ROLE_TRANSLATION` (
                                                `FK_MENU_ROLE_SNO` int NOT NULL COMMENT '메뉴 역할 순번',
                                                `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"menuRoleNm": "역할명"})',
                                                PRIMARY KEY (`FK_MENU_ROLE_SNO`,`LANGUAGE_CODE`),
                                                CONSTRAINT `FK_MENU_ROLE_TRANSLATION_MENU_ROLE` FOREIGN KEY (`FK_MENU_ROLE_SNO`) REFERENCES `TB_SYS_MENU_ROLE` (`MENU_ROLE_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='메뉴 역할 다국어 테이블';

-- TEMP_TB_MODEL_CRED_TEMP_TRANSLATION 테이블 생성
-- 모델 인증 방식 템플릿 다국어 번역 테이블
DROP TABLE IF EXISTS `TEMP_TB_MODEL_CRED_TEMP_TRANSLATION`;
CREATE TABLE `TEMP_TB_MODEL_CRED_TEMP_TRANSLATION` (
                                                       `FK_MODEL_CRED_TEMP_SNO` int NOT NULL COMMENT '모델 인증 방식 템플릿 순번',
                                                       `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                       `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"credName": "인증방식명", "description": "설명"})',
                                                       PRIMARY KEY (`FK_MODEL_CRED_TEMP_SNO`,`LANGUAGE_CODE`),
                                                       CONSTRAINT `FK_MODEL_CRED_TEMP_TRANSLATION_MODEL_CRED_TEMP` FOREIGN KEY (`FK_MODEL_CRED_TEMP_SNO`) REFERENCES `TEMP_TB_MODEL_CRED_TEMP` (`MODEL_CRED_TEMP_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 인증 방식 템플릿 다국어 테이블';

-- TEMP_TB_MODEL_CRED_TRANSLATION 테이블 생성
-- 모델 인증 정보 다국어 번역 테이블
DROP TABLE IF EXISTS `TEMP_TB_MODEL_CRED_TRANSLATION`;
CREATE TABLE `TEMP_TB_MODEL_CRED_TRANSLATION` (
                                                  `FK_MODEL_CRED_ID` varchar(36) NOT NULL COMMENT '모델 인증 정보 ID',
                                                  `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                  `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"credName": "인증정보명", "description": "설명"})',
                                                  PRIMARY KEY (`FK_MODEL_CRED_ID`,`LANGUAGE_CODE`),
                                                  CONSTRAINT `FK_MODEL_CRED_TRANSLATION_MODEL_CRED` FOREIGN KEY (`FK_MODEL_CRED_ID`) REFERENCES `TEMP_TB_MODEL_CRED` (`MODEL_CRED_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 인증 정보 다국어 테이블';

-- TEMP_TB_MODEL_TRANSLATION 테이블 생성
-- 모델 다국어 번역 테이블
DROP TABLE IF EXISTS `TEMP_TB_MODEL_TRANSLATION`;
CREATE TABLE `TEMP_TB_MODEL_TRANSLATION` (
                                             `FK_MODEL_SNO` int NOT NULL COMMENT '모델 순번',
                                             `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                             `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"description": "설명", "subtitle": "부제목"})',
                                             PRIMARY KEY (`FK_MODEL_SNO`,`LANGUAGE_CODE`),
                                             CONSTRAINT `FK_MODEL_TRANSLATION_MODEL` FOREIGN KEY (`FK_MODEL_SNO`) REFERENCES `TEMP_TB_MODEL` (`MODEL_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 다국어 테이블';

-- TB_PROMPT_TRANSLATION 테이블 생성
-- 프롬프트 다국어 번역 테이블
DROP TABLE IF EXISTS `TB_PROMPT_TRANSLATION`;
CREATE TABLE `TB_PROMPT_TRANSLATION` (
                                         `FK_PROMPT_SNO` int NOT NULL COMMENT '프롬프트 순번',
                                         `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                         `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"promptNm": "프롬프트명", "promptDesc": "프롬프트설명"})',
                                         PRIMARY KEY (`FK_PROMPT_SNO`,`LANGUAGE_CODE`),
                                         CONSTRAINT `FK_PROMPT_TRANSLATION_PROMPT` FOREIGN KEY (`FK_PROMPT_SNO`) REFERENCES `TB_PROMPT` (`PROMPT_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='프롬프트 다국어 테이블';

-- TEMP_TB_MODEL_GROUP_TRANSLATION 테이블 생성
-- 모델 공급사(Provider) 다국어 번역 테이블
DROP TABLE IF EXISTS `TEMP_TB_MODEL_GROUP_TRANSLATION`;
CREATE TABLE `TEMP_TB_MODEL_GROUP_TRANSLATION` (
                                                   `FK_MODEL_GROUP_SNO` int NOT NULL COMMENT '모델 공급사 순번',
                                                   `LANGUAGE_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '언어코드',
                                                   `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'CONTENT (JSON 형태: {"modelGroupName": "공급사명", "description": "설명"})',
                                                   PRIMARY KEY (`FK_MODEL_GROUP_SNO`,`LANGUAGE_CODE`),
                                                   CONSTRAINT `FK_MODEL_GROUP_TRANSLATION_MODEL_GROUP` FOREIGN KEY (`FK_MODEL_GROUP_SNO`) REFERENCES `TEMP_TB_MODEL_GROUP` (`MODEL_GROUP_SNO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='모델 공급사 다국어 테이블';

-- TB_SYS_MENU_TRANSLATION 테이블에 삽입할 다국어 번역 데이터
-- CONTENT는 JSON 형태: {"menuNm": "메뉴명", "menuDesc": "메뉴설명"}
-- 기존 데이터는 제외하고 새로 추가할 데이터만 포함

-- 1000: 사용자 및 권한 관리


INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1000, 'en', '{"menuNm": "User and Permission Management", "menuDesc": "User and Permission Management"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1000, 'ja', '{"menuNm": "ユーザーおよび権限管理", "menuDesc": "ユーザーおよび権限管理"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1000, 'vi', '{"menuNm": "Quản lý người dùng và quyền hạn", "menuDesc": "Quản lý người dùng và quyền hạn"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1000, 'zh-HK', '{"menuNm": "用戶及權限管理", "menuDesc": "用戶及權限管理"}');

-- 1001: 사용자
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1001, 'en', '{"menuNm": "User", "menuDesc": "User"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1001, 'ja', '{"menuNm": "ユーザー", "menuDesc": "ユーザー"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1001, 'vi', '{"menuNm": "Người dùng", "menuDesc": "Người dùng"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1001, 'zh-HK', '{"menuNm": "用戶", "menuDesc": "用戶"}');

-- 1002: 메뉴 권한
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1002, 'en', '{"menuNm": "Menu Permission", "menuDesc": "Menu Permission"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1002, 'ja', '{"menuNm": "メニュー権限", "menuDesc": "メニュー権限"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1002, 'vi', '{"menuNm": "Quyền truy cập menu", "menuDesc": "Quyền truy cập menu"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1002, 'zh-HK', '{"menuNm": "選單權限", "menuDesc": "選單權限"}');

-- 1003: 지식 저장소 권한
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1003, 'en', '{"menuNm": "Knowledge Base Permissions", "menuDesc": "Knowledge Base Permissions"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1003, 'ja', '{"menuNm": "ナレッジベースの権限", "menuDesc": "ナレッジベースの権限"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1003, 'vi', '{"menuNm": "Quyền truy cập kho kiến thức", "menuDesc": "Quyền truy cập kho kiến thức"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1003, 'zh-HK', '{"menuNm": "知識庫權限", "menuDesc": "知識庫權限"}');

-- 1004: Agent 권한 관리
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1004, 'en', '{"menuNm": "Agent Permissions", "menuDesc": "Agent Permissions"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1004, 'ja', '{"menuNm": "エージェント権限", "menuDesc": "エージェント権限"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1004, 'vi', '{"menuNm": "Quyền truy cập Agent", "menuDesc": "Quyền truy cập Agent"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1004, 'zh-HK', '{"menuNm": "代理權限", "menuDesc": "代理權限"}');

-- 1100: 기능 및 모델 관리
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1100, 'en', '{"menuNm": "Feature and Model Management", "menuDesc": "Feature and Model Management"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1100, 'ja', '{"menuNm": "機能およびモデル管理", "menuDesc": "機能およびモデル管理"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1100, 'vi', '{"menuNm": "Quản lý chức năng và mô hình", "menuDesc": "Quản lý chức năng và mô hình"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1100, 'zh-HK', '{"menuNm": "功能及模型管理", "menuDesc": "功能及模型管理"}');

-- 1101: 공급사 인증
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1101, 'en', '{"menuNm": "Provider Authentication", "menuDesc": "Provider Authentication"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1101, 'ja', '{"menuNm": "プロバイダー認証", "menuDesc": "プロバイダー認証"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1101, 'vi', '{"menuNm": "Xác thực nhà cung cấp", "menuDesc": "Xác thực nhà cung cấp"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1101, 'zh-HK', '{"menuNm": "供應商認證", "menuDesc": "供應商認證"}');

-- 1102: 모델
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1102, 'en', '{"menuNm": "Model", "menuDesc": "Model"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1102, 'ja', '{"menuNm": "モデル", "menuDesc": "モデル"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1102, 'vi', '{"menuNm": "Mô hình", "menuDesc": "Mô hình"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1102, 'zh-HK', '{"menuNm": "模型", "menuDesc": "模型"}');

-- 1103: 프롬프트
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1103, 'en', '{"menuNm": "Prompt", "menuDesc": "Prompt"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1103, 'ja', '{"menuNm": "プロンプト", "menuDesc": "プロンプト"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1103, 'vi', '{"menuNm": "Lời nhắc", "menuDesc": "Lời nhắc"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1103, 'zh-HK', '{"menuNm": "提示", "menuDesc": "提示"}');

-- 1105: 파서
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1105, 'en', '{"menuNm": "Parser", "menuDesc": "Parser"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1105, 'ja', '{"menuNm": "パーサー", "menuDesc": "パーサー"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1105, 'vi', '{"menuNm": "Bộ phân tích cú pháp", "menuDesc": "Bộ phân tích cú pháp"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1105, 'zh-HK', '{"menuNm": "解析器", "menuDesc": "解析器"}');

-- 1106: MCP 서버
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1106, 'en', '{"menuNm": "MCP Server", "menuDesc": "MCP Server"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1106, 'ja', '{"menuNm": "MCPサーバー", "menuDesc": "MCPサーバー"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1106, 'vi', '{"menuNm": "Máy chủ MCP", "menuDesc": "Máy chủ MCP"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1106, 'zh-HK', '{"menuNm": "MCP 伺服器", "menuDesc": "MCP 伺服器"}');

-- 1107: RAG 전처리 파이프라인
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1107, 'en', '{"menuNm": "RAG Data Pipeline", "menuDesc": "RAG Data Pipeline"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1107, 'ja', '{"menuNm": "RAGデータパイプライン", "menuDesc": "RAGデータパイプライン"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1107, 'vi', '{"menuNm": "Đường ống xử lý dữ liệu RAG", "menuDesc": "Đường ống xử lý dữ liệu RAG"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1107, 'zh-HK', '{"menuNm": "RAG 數據管道", "menuDesc": "RAG 數據管道"}');

-- 1200: 시스템 설정
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1200, 'en', '{"menuNm": "System Settings", "menuDesc": "System Settings"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1200, 'ja', '{"menuNm": "システム設定", "menuDesc": "システム設定"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1200, 'vi', '{"menuNm": "Cài đặt hệ thống", "menuDesc": "Cài đặt hệ thống"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1200, 'zh-HK', '{"menuNm": "系統設定", "menuDesc": "系統設定"}');

-- 1201: 메뉴
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1201, 'en', '{"menuNm": "Menu", "menuDesc": "Menu"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1201, 'ja', '{"menuNm": "メニュー", "menuDesc": "メニュー"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1201, 'vi', '{"menuNm": "Trình đơn", "menuDesc": "Trình đơn"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1201, 'zh-HK', '{"menuNm": "選單", "menuDesc": "選單"}');

-- 1202: 공통 코드
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1202, 'en', '{"menuNm": "Common Code", "menuDesc": "Common Code"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1202, 'ja', '{"menuNm": "共通コード", "menuDesc": "共通コード"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1202, 'vi', '{"menuNm": "Mã chung", "menuDesc": "Mã chung"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1202, 'zh-HK', '{"menuNm": "通用代碼", "menuDesc": "通用代碼"}');

-- 1203: 보안
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1203, 'en', '{"menuNm": "Security", "menuDesc": "Security"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1203, 'ja', '{"menuNm": "セキュリティ", "menuDesc": "セキュリティ"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1203, 'vi', '{"menuNm": "Bảo mật", "menuDesc": "Bảo mật"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1203, 'zh-HK', '{"menuNm": "保安", "menuDesc": "保安"}');

-- 1400: 운영 및 모니터링
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1400, 'en', '{"menuNm": "Operation and Monitoring", "menuDesc": "Operation and Monitoring"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1400, 'ja', '{"menuNm": "運用およびモニタリング", "menuDesc": "運用およびモニタリング"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1400, 'vi', '{"menuNm": "Vận hành và giám sát", "menuDesc": "Vận hành và giám sát"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1400, 'zh-HK', '{"menuNm": "營運及監控", "menuDesc": "營運及監控"}');

-- 1401: 대화 사용 현황
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1401, 'en', '{"menuNm": "Conversation Usage Status", "menuDesc": "Conversation Usage Status"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1401, 'ja', '{"menuNm": "会話利用状況", "menuDesc": "会話利用状況"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1401, 'vi', '{"menuNm": "Tình trạng sử dụng hội thoại", "menuDesc": "Tình trạng sử dụng hội thoại"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1401, 'zh-HK', '{"menuNm": "對話使用狀況", "menuDesc": "對話使用狀況"}');

-- 1402: 대화 로그
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1402, 'en', '{"menuNm": "Conversation Log", "menuDesc": "Conversation Log"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1402, 'ja', '{"menuNm": "会話ログ", "menuDesc": "会話ログ"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1402, 'vi', '{"menuNm": "Nhật ký hội thoại", "menuDesc": "Nhật ký hội thoại"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1402, 'zh-HK', '{"menuNm": "對話日誌", "menuDesc": "對話日誌"}');

-- 1403: VOC
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1403, 'en', '{"menuNm": "VOC", "menuDesc": "VOC"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1403, 'ja', '{"menuNm": "VOC", "menuDesc": "VOC"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1403, 'vi', '{"menuNm": "VOC", "menuDesc": "VOC"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (1403, 'zh-HK', '{"menuNm": "VOC", "menuDesc": "VOC"}');

-- 3301: 인증 및 접근
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3301, 'en', '{"menuNm": "Authentication and Access", "menuDesc": "Authentication and Access"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3301, 'ja', '{"menuNm": "認証とアクセス", "menuDesc": "認証とアクセス"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3301, 'vi', '{"menuNm": "Xác thực và truy cập", "menuDesc": "Xác thực và truy cập"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3301, 'zh-HK', '{"menuNm": "認證及存取", "menuDesc": "認證及存取"}');

-- 3304: 대시보드
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3304, 'en', '{"menuNm": "Dashboard", "menuDesc": "Dashboard"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3304, 'ja', '{"menuNm": "ダッシュボード", "menuDesc": "ダッシュボード"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3304, 'vi', '{"menuNm": "Bảng điều khiển", "menuDesc": "Bảng điều khiển"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3304, 'zh-HK', '{"menuNm": "儀表板", "menuDesc": "儀表板"}');

-- 3305: 통합 대시보드
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3305, 'en', '{"menuNm": "Integrated Dashboard", "menuDesc": "Integrated Dashboard"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3305, 'ja', '{"menuNm": "統合ダッシュボード", "menuDesc": "統合ダッシュボード"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3305, 'vi', '{"menuNm": "Bảng điều khiển tích hợp", "menuDesc": "Bảng điều khiển tích hợp"}');
INSERT INTO TB_SYS_MENU_TRANSLATION (FK_MENU_SNO, LANGUAGE_CODE, CONTENT) VALUES (3305, 'zh-HK', '{"menuNm": "綜合儀表板", "menuDesc": "綜合儀表板"}');

create table TB_PROJECT
(
    PROJECT_ID           varchar(50)                             primary key comment '프로젝트 ID',
    TITLE                varchar(50)                             not null comment '프로젝트명',
    DESCRIPTION          varchar(200)                            not null comment '프로젝트 설명',
    START_DTTM            timestamp                            not null comment '시작일',
    END_DTTM              timestamp                             not null comment '종료일',
    LIMIT_TYPE           varchar(10)           default 'DAILY'   not null comment '한도 유형(DAILY, TOTAL)',
    LIMIT_LLM_TOKEN       INT UNSIGNED         default '100000'    not null comment 'LLM 토큰 한도',
    LIMIT_EMBEDDING_TOKEN INT UNSIGNED         default '100000'    not null comment '임베딩 토큰 한도',
    LLM_USED_TOKEN INT UNSIGNED DEFAULT 0 COMMENT '사용된 LLM 토큰 수',
    EMBEDDING_USED_TOKEN INT UNSIGNED DEFAULT 0 COMMENT '사용된 임베딩 토큰 수',
    APPROVAL_STATUS     varchar(10)   default 'REQUEST'          not null comment '승인 상태(REQUEST, APPROVED)',
    PROJECT_STATUS      varchar(10)   default 'PENDING'          not null comment '프로젝트 상태(PENDING, RUNNING, CLOSED, DELETED)',
    DEL_DTTM             timestamp                               null comment '삭제일시',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시'
)
    comment '프로젝트 테이블';

CREATE INDEX idx_project_status
    ON TB_PROJECT(PROJECT_STATUS);

CREATE INDEX idx_approval_status
    ON TB_PROJECT(APPROVAL_STATUS);

CREATE INDEX idx_approval_project_status
    ON TB_PROJECT(APPROVAL_STATUS, PROJECT_STATUS);

CREATE INDEX idx_status_dates
    ON TB_PROJECT(PROJECT_STATUS, START_DTTM, END_DTTM);


create table TB_PROJECT_KEY
(
    PROJECT_KEY_SNO      bigint unsigned auto_increment comment '프로젝트 KEY SNO'    primary key,
    PROJECT_ID           varchar(50)                             not null comment '프로젝트 ID',
    ACCESS_KEY           varchar(100)                            not null comment '액세스 키',
    SECRET_KEY           varchar(100)                            not null comment '시크릿 키',
    ISSUE_DTTM           timestamp       default current_timestamp not null comment '발급 일시',
    EXPIRE_DTTM          timestamp       default current_timestamp not null comment '만료 일시',
    REISSUANCE_CYCLE     varchar(20)     default 'THREE_MONTH'      not null comment '재발급 주기(월) (THREE_MONTH, SIX_MONTHm, NINE_MONTH, TWELVE_MONTH)',
    BEFORE_EXPIRE_NOTICE varchar(20)     default 'THREE_DAYS'      not null comment '만료 전 알림(일) (THREE_DAYS, SEVEN_DAYS, TEN_DAYS)',
    REQUEST_COUNT        INT UNSIGNED      default 0              not null comment '요청 횟수',
    STATUS               varchar(10)    default 'ACTIVE'         not null comment '상태(ACTIVE, EXPIRED, REISSUED)',
    EXTENSION_COUNT     INT UNSIGNED      default 0              not null comment '연장 횟수',
    IS_INITIAL         BOOLEAN           default true           not null comment '초기 키 여부',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시',

    CONSTRAINT fk_project_key_project
        FOREIGN KEY (PROJECT_ID)
            REFERENCES TB_PROJECT(PROJECT_ID)
)
    comment '프로젝트 KEY 테이블';

CREATE INDEX idx_project_id
    ON TB_PROJECT_KEY(PROJECT_ID);

CREATE UNIQUE INDEX idx_access_key
    ON TB_PROJECT_KEY(ACCESS_KEY);


create table TB_PROJECT_USER
(
    PROJECT_USER_SNO     bigint unsigned auto_increment comment '프로젝트 사용자 SNO'    primary key,
    PROJECT_ID           varchar(50)                             not null comment '프로젝트 ID',
    USER_ID              varchar(64)                            not null comment '사용자 ID',
    PROJECT_ROLE         varchar(20)       default 'MEMBER'     not null comment '프로젝트 역할(OWNER, MEMBER)',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시',

    CONSTRAINT uk_project_user UNIQUE (PROJECT_ID, USER_ID),

    CONSTRAINT fk_project_user_project
        FOREIGN KEY (PROJECT_ID)
            REFERENCES TB_PROJECT(PROJECT_ID),
    CONSTRAINT fk_project_user_user
        FOREIGN KEY (USER_ID)
            REFERENCES TB_SYS_USER(USER_ID)
)
    comment '프로젝트 사용자 테이블';

CREATE INDEX idx_project_user
    ON TB_PROJECT_USER(PROJECT_ID, USER_ID);

create table TB_PROJECT_MODEL
(
    PROJECT_MODEL_SNO     bigint unsigned auto_increment comment '프로젝트 모델 SNO'    primary key,
    PROJECT_ID           varchar(50)                             not null comment '프로젝트 ID',
    MODEL_SNO              int                           not null comment '모델 SNO',
    MODEL_STATUS               varchar(10)    default 'RUNNING'         not null comment '상태(RUNNING, STOP, DELETED)',
    LIMIT_TOKEN           INT UNSIGNED         default 10000       not null comment '모델 토큰 한도',
    USED_TOKEN            INT UNSIGNED         default 0              not null comment '사용된 토큰',
    REQUEST_COUNT        INT UNSIGNED      default 0              not null comment '요청 횟수',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시',

    CONSTRAINT uk_project_model UNIQUE (PROJECT_ID, MODEL_SNO),

    CONSTRAINT fk_project_model_project
        FOREIGN KEY (PROJECT_ID)
            REFERENCES TB_PROJECT(PROJECT_ID),
    CONSTRAINT fk_project_model_model
        FOREIGN KEY (MODEL_SNO)
            REFERENCES TEMP_TB_MODEL(MODEL_SNO)
)
    comment '프로젝트 모델 테이블';
CREATE INDEX idx_project_model
    ON TB_PROJECT_MODEL(PROJECT_ID, MODEL_SNO);
CREATE INDEX idx_token_usage
    ON TB_PROJECT_MODEL(USED_TOKEN, LIMIT_TOKEN);


create table TB_PROJECT_RESOURCE
(
    PROJECT_RESOURCE_SNO     bigint unsigned auto_increment comment '프로젝트 리소스 SNO'    primary key,
    PROJECT_ID           varchar(50)                             not null comment '프로젝트 ID',
    RESOURCE_SNO          bigint unsigned                  not null comment '리소스 SNO',
    TYPE                 varchar(20)                             not null comment '리소스 유형(KNOWLEDGE, INTERNAL_AGENT, EXTERNAL AGENT)',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시',

    CONSTRAINT uk_project_resource
        UNIQUE (PROJECT_ID, RESOURCE_SNO, TYPE),
    CONSTRAINT fk_project_resource_project
        FOREIGN KEY (PROJECT_ID)
            REFERENCES TB_PROJECT(PROJECT_ID)
)
    comment '프로젝트 리소스 테이블';

CREATE INDEX idx_project_id
    ON TB_PROJECT_RESOURCE(PROJECT_ID);

CREATE INDEX idx_project_type
    ON TB_PROJECT_RESOURCE(PROJECT_ID, TYPE);


create table TB_PROJECT_HISTORY
(
    PROJECT_HISTORY_SNO     bigint unsigned auto_increment comment '프로젝트 이력 SNO'    primary key,
    PROJECT_ID           varchar(50)                             not null comment '프로젝트 ID',
    ACTION         varchar(20)                             not null comment '액션 유형',
    CONTENT              varchar(500)                            null comment '액션 내용',
    RESULT               varchar(10)                            null comment '액션 결과',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시',

    CONSTRAINT fk_project_history_project
        FOREIGN KEY (PROJECT_ID)
            REFERENCES TB_PROJECT(PROJECT_ID)
)
    comment '프로젝트 이력 테이블';

CREATE INDEX idx_project_id_reg_dttm
    ON TB_PROJECT_HISTORY(PROJECT_ID, REG_DTTM DESC);
CREATE INDEX idx_project_action
    ON TB_PROJECT_HISTORY(PROJECT_ID, ACTION, REG_DTTM DESC);


create table TB_PROJECT_SETTING
(
    PROJECT_SETTING_SNO     bigint unsigned auto_increment comment '프로젝트 설정 SNO'    primary key,
    PROJECT_APPROVAL   varchar(20)     default 'MANUAL'       not null comment '승인 설정(AUTO, MANUAL)',
    LIMIT_TYPE           varchar(10)           default 'DAILY'   not null comment '한도 유형(DAILY, TOTAL)',
    LIMIT_LLM_TOKEN       INT UNSIGNED         default '100000'    not null comment 'LLM 토큰 한도',
    LIMIT_EMBEDDING_TOKEN INT UNSIGNED         default '100000'    not null comment '임베딩 토큰 한도',
    REISSUANCE_CYCLE     varchar(20)     default 'THREE_MONTH'      not null comment '재발급 주기(월) (THREE_MONTH, SIX_MONTHm, NINE_MONTH, TWELVE_MONTH)',
    BEFORE_EXPIRE_NOTICE varchar(20)     default 'THREE_DAYS'      not null comment '만료 전 알림(일) (THREE_DAYS, SEVEN_DAYS, TEN_DAYS)',
    IS_USE           BOOLEAN           default true           not null comment '사용 여부',
    AUTH_TIMEOUT       INT UNSIGNED         default 15           not null comment '인증 타임아웃(분)',
    REG_USER_ID   varchar(64)  default 'system'                 not null comment '등록사용자ID',
    REG_DTTM             timestamp    DEFAULT CURRENT_TIMESTAMP        not null comment '생성일시',
    UPDT_USER_ID  varchar(64)  default 'system'                   not null comment '수정사용자ID',
    UPDT_DTTM            timestamp   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP not null comment '수정일시'
)
    comment '프로젝트 설정 테이블';


INSERT INTO TB_PROJECT_SETTING (PROJECT_APPROVAL, LIMIT_TYPE, LIMIT_LLM_TOKEN, LIMIT_EMBEDDING_TOKEN, REISSUANCE_CYCLE, BEFORE_EXPIRE_NOTICE, IS_USE,AUTH_TIMEOUT, REG_USER_ID, REG_DTTM, UPDT_USER_ID, UPDT_DTTM) VALUES
    ('MANUAL', 'DAILY', 100000, 100000, 'THREE_MONTHS', 'THREE_DAYS', true, 15, 'air@megazone.com', NOW(), 'air@megazone.com', NOW());




CREATE TABLE IF NOT EXISTS TB_BATCH_HISTORY (
                                                BATCH_HISTORY_ID BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '배치 이력 ID',
                                                JOB_NAME VARCHAR(100) NOT NULL COMMENT '잡명',
                                                JOB_TYPE VARCHAR(50) NOT NULL COMMENT '잡 타입',
                                                START_TIME DATETIME NOT NULL COMMENT '시작시간',
                                                END_TIME DATETIME COMMENT '종료시간',
                                                STATUS VARCHAR(20) NOT NULL COMMENT '상태 (RUNNING, SUCCESS, FAILED)',
                                                TARGET_COUNT INT DEFAULT 0 COMMENT '대상 건수',
                                                PROCESSED_COUNT INT DEFAULT 0 COMMENT '처리 건수',
                                                FAILED_COUNT INT DEFAULT 0 COMMENT '실패 건수',
                                                ERROR_MESSAGE TEXT COMMENT '오류 메시지',
                                                REG_DTTM DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                                UPDT_DTTM DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
                                                INDEX IDX_JOB_NAME (JOB_NAME),
                                                INDEX IDX_START_TIME (START_TIME),
                                                INDEX IDX_STATUS (STATUS)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='배치 실행 이력';
-- Spring Batch MySQL Schema

ALTER TABLE TEMP_TB_MODEL_GROUP
    ADD COLUMN VENDOR_TYPE VARCHAR(20) DEFAULT NULL COMMENT 'Vendor Type (AWS, AZURE, GOOGLE)' AFTER MODEL_GROUP_NAME;

-- 기존 데이터에 VENDOR_TYPE 값 설정
UPDATE TEMP_TB_MODEL_GROUP SET VENDOR_TYPE = 'AWS' WHERE MODEL_GROUP_NAME = 'AWS Bedrock';
UPDATE TEMP_TB_MODEL_GROUP SET VENDOR_TYPE = 'AZURE' WHERE MODEL_GROUP_NAME = 'Azure OpenAI';
UPDATE TEMP_TB_MODEL_GROUP SET VENDOR_TYPE = 'GOOGLE' WHERE MODEL_GROUP_NAME = 'Google Cloud Vertex AI';


-- 토큰 사용량 테이블
CREATE TABLE IF NOT EXISTS TB_TOKEN_USAGE (
                                              TOKEN_USAGE_ID BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '토큰 사용량 ID',
                                              REQUEST_ID VARCHAR(50) NOT NULL UNIQUE COMMENT '요청 ID (중복 방지용)',
                                              PROJECT_ID VARCHAR(50) NOT NULL COMMENT '프로젝트 ID',
                                              PROJECT_ACCESS_KEY VARCHAR(100) COMMENT '프로젝트 액세스 키',
                                              USER_ID VARCHAR(50) NOT NULL COMMENT '사용자 ID',
                                              MODEL_ID VARCHAR(100) NOT NULL COMMENT '모델 ID',
                                              MODEL_SNO BIGINT COMMENT '모델 일련번호',
                                              INPUT_TOKENS INT UNSIGNED DEFAULT 0 COMMENT '입력 토큰 수',
                                              OUTPUT_TOKENS INT UNSIGNED DEFAULT 0 COMMENT '출력 토큰 수',
                                              TOTAL_TOKENS INT UNSIGNED DEFAULT 0 COMMENT '총 토큰 수',
                                              TIMESTAMP DATETIME NOT NULL COMMENT '사용 시각',
                                              REG_DTTM DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
                                              INDEX IDX_PROJECT_ID (PROJECT_ID),
                                              INDEX IDX_USER_ID (USER_ID),
                                              INDEX IDX_MODEL_SNO (MODEL_SNO),
                                              INDEX IDX_TIMESTAMP (TIMESTAMP),
                                              INDEX IDX_REQUEST_ID (REQUEST_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='토큰 사용량';

SET FOREIGN_KEY_CHECKS = 1;
