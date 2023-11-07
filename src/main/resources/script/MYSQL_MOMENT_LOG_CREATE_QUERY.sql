DROP TABLE IF EXISTS `tb_mmt_raw_moment_log`;

CREATE TABLE `tb_mmt_raw_moment_log` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `REQUEST_JSON` text COMMENT '요청 json',
  `RESPONSE_JSON` text COMMENT '응답 json',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `CREATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자 모멘티 당일 로그';

DROP TABLE IF EXISTS `tb_mmt_total_moment_req_1`;

CREATE TABLE `tb_mmt_total_moment_req_1` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 누적 요청 횟수1';

DROP TABLE IF EXISTS `tb_mmt_total_moment_req_2`;

CREATE TABLE `tb_mmt_total_moment_req_2` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 누적 요청 횟수2';

DROP TABLE IF EXISTS `tb_mmt_total_moment_req_3`;

CREATE TABLE `tb_mmt_total_moment_req_3` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 누적 요청 횟수3';

DROP TABLE IF EXISTS `tb_mmt_total_moment_req_4`;

CREATE TABLE `tb_mmt_total_moment_req_4` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 누적 요청 횟수4';

DROP TABLE IF EXISTS `tb_mmt_total_moment_req_5`;

CREATE TABLE `tb_mmt_total_moment_req_5` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 누적 요청 횟수5';

DROP TABLE IF EXISTS `tb_mmt_daily_moment_req_1`;

CREATE TABLE `tb_mmt_daily_moment_req_1` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년월일',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 일별 요청 횟수1';

DROP TABLE IF EXISTS `tb_mmt_daily_moment_req_2`;

CREATE TABLE `tb_mmt_daily_moment_req_2` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년월일',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 일별 요청 횟수2';

DROP TABLE IF EXISTS `tb_mmt_daily_moment_req_3`;

CREATE TABLE `tb_mmt_daily_moment_req_3` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년월일',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 일별 요청 횟수3';

DROP TABLE IF EXISTS `tb_mmt_daily_moment_req_4`;

CREATE TABLE `tb_mmt_daily_moment_req_4` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년월일',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 일별 요청 횟수4';

DROP TABLE IF EXISTS `tb_mmt_daily_moment_req_5`;

CREATE TABLE `tb_mmt_daily_moment_req_5` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년월일',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 일별 요청 횟수5';

DROP TABLE IF EXISTS `tb_mmt_monthly_moment_req_1`;

CREATE TABLE `tb_mmt_monthly_moment_req_1` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YM` varchar(6) NOT NULL DEFAULT '' COMMENT '년월',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 월별 요청 횟수1';

DROP TABLE IF EXISTS `tb_mmt_monthly_moment_req_2`;

CREATE TABLE `tb_mmt_monthly_moment_req_2` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YM` varchar(6) NOT NULL DEFAULT '' COMMENT '년월',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 월별 요청 횟수2';

DROP TABLE IF EXISTS `tb_mmt_monthly_moment_req_3`;

CREATE TABLE `tb_mmt_monthly_moment_req_3` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YM` varchar(6) NOT NULL DEFAULT '' COMMENT '년월',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 월별 요청 횟수3';

DROP TABLE IF EXISTS `tb_mmt_monthly_moment_req_4`;

CREATE TABLE `tb_mmt_monthly_moment_req_4` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YM` varchar(6) NOT NULL DEFAULT '' COMMENT '년월',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 월별 요청 횟수4';

DROP TABLE IF EXISTS `tb_mmt_monthly_moment_req_5`;

CREATE TABLE `tb_mmt_monthly_moment_req_5` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `YM` varchar(6) NOT NULL DEFAULT '' COMMENT '년월',
  `COUNT` int(11) DEFAULT NULL COMMENT '횟수',
  PRIMARY KEY (`USER_ID`,`MOMENT_ID`, `YM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='모멘티 월별 요청 횟수5';

DROP TABLE IF EXISTS `tb_mmt_app_launch`;

CREATE TABLE `tb_mmt_app_launch` (
  `APP_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '앱 코드',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `LAST_LAUNCH_TIME` datetime DEFAULT NULL COMMENT '최종 실행 일시',
  `LAUNCH_COUNT` int(11) DEFAULT NULL COMMENT '누적 횟수',
  PRIMARY KEY (`APP_CODE`, `USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='앱 실행';

DROP TABLE IF EXISTS `tb_mmt_campaign_response`;

CREATE TABLE `tb_mmt_campaign_response` (
  `CAMPAIGN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '캠페인 아이디',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `VIEW_COUNT` int(11) DEFAULT NULL COMMENT '캠페인 노출 횟수',
  `RESPONSE_COUNT` int(11) DEFAULT NULL COMMENT '캠페인 반응 횟수',
  PRIMARY KEY (`CAMPAIGN_ID`, `USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='캠페인별 반응';

DROP TABLE IF EXISTS `tb_mmt_user_reward_hist`;

CREATE TABLE `tb_mmt_user_reward_hist` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `RWD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '리워드 아이디',
  `YMD` varchar(8) NOT NULL DEFAULT '' COMMENT '년/월/일',
  `COUNT` int(11) NOT NULL DEFAULT '0' COMMENT '횟수',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  PRIMARY KEY (`USER_ID`,`RWD_ID`,`YMD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자 리워드 수신 이력';

DROP TABLE IF EXISTS `tb_mmt_tmap_route`;

CREATE TABLE `tb_mmt_tmap_route` (
  `ROUTE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '주행이력 아이디',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘트 아이디',
  `DEPART_POI_ID` int(11) DEFAULT NULL COMMENT '출발지 POI ID',
  `DEPART_NAME` varchar(100) DEFAULT NULL COMMENT '출발지 명',
  `DEST_ADDR` varchar(200) DEFAULT NULL COMMENT '목적지 주소',
  `DEST_NAME` varchar(100) DEFAULT NULL COMMENT '목적지 명',
  `DEST_POI_ID` int(11) DEFAULT NULL COMMENT '목적지 POI ID',
  `TOTAL_TIME_MI` int(11) DEFAULT NULL COMMENT '주행 시간',
  `AVG_SPEED` int(11) DEFAULT NULL COMMENT '평균 속도',
  `MAX_SPEED` int(11) DEFAULT NULL COMMENT '최고 속도',
  `REQ_TIME_SS` varchar(17) DEFAULT NULL COMMENT '출발 일시',
  `TVAS_ESTIMATION_TIME_SS` varchar(17) DEFAULT NULL COMMENT '도착예정 일시',
  `REAL_ESTIMATION_TIME_SS` varchar(255) DEFAULT NULL COMMENT '실제도착 일시',
  `TOTAL_DISTANCE` int(11) DEFAULT NULL COMMENT '주행거리',
  `DEPART_X_POS` int(11) DEFAULT NULL COMMENT '출발지 X좌표',
  `DEPART_Y_POS` int(11) DEFAULT NULL COMMENT '출발지 Y좌표',
  `DEST_X_POS` int(11) DEFAULT NULL COMMENT '도착지 X좌표',
  `DEST_Y_POS` int(11) DEFAULT NULL COMMENT '도착지 Y좌표',
  `DEST_RP_FLAG` int(11) DEFAULT NULL COMMENT '목적지 FLAG',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  PRIMARY KEY (`ROUTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='T Map 주행이력';

DROP TABLE IF EXISTS `tb_mmt_tmap_ubi`;

CREATE TABLE `tb_mmt_tmap_ubi` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `JOIN_YN` varchar(1) NOT NULL DEFAULT 'N' COMMENT '가입여부',
  `DISTANCE` int(11) NOT NULL DEFAULT '0' COMMENT '주행거리',
  `POINT` int(11) NOT NULL DEFAULT '0' COMMENT '점수',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='T Map UBI';

DROP TABLE IF EXISTS `tb_mmt_tmap_dest`;

CREATE TABLE `tb_mmt_tmap_dest` (
  `DEST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '목적지 아이디',
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `MOMENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '모멘티 아이디',
  `DEST_NAME` varchar(100) DEFAULT NULL COMMENT '목적지명',
  `DEST_POI_ID` int(11) DEFAULT NULL COMMENT '목적지 POI ID',
  `DEST_POI_NAME` varchar(100) DEFAULT NULL COMMENT '목적지 POI NAME',
  `ESTIMATION_DISTANCE` int(11) DEFAULT NULL COMMENT '예상 경로거리',
  `ESTIMATION_TIME_MI` int(11) DEFAULT NULL COMMENT '예상소요시간',
  `DEST_ADDR` varchar(200) DEFAULT NULL COMMENT '목적지 주소',
  `DEPART_X_POS` int(11) DEFAULT NULL COMMENT '출발지 X좌표',
  `DEPART_Y_POS` int(11) DEFAULT NULL COMMENT '출발지 Y좌표',
  `DEST_X_POS` int(11) DEFAULT NULL COMMENT '목적지 X좌표',
  `DEST_Y_POS` int(11) DEFAULT NULL COMMENT '도착지 Y좌표',
  `TOTAL_DISTANCE` int(11) DEFAULT NULL COMMENT '주행거리',
  `TOTAL_TIME_MI` int(11) DEFAULT NULL COMMENT '주행시간',
  `ARRIVE_YN` varchar(1) DEFAULT NULL COMMENT '도착여부',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  PRIMARY KEY (`DEST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='T Map 목적지 정보';

CREATE FUNCTION distance_between (from_lat DECIMAL(6, 3), from_lng DECIMAL(6, 3), to_lat DECIMAL(6, 3), to_lng DECIMAL(6, 3)) RETURNS DECIMAL(11, 3)
	RETURN 6371 * 2 * ATAN2(SQRT(POW(SIN(RADIANS(to_lat - from_lat)/2), 2) + POW(SIN(RADIANS(to_lng - from_lng)/2), 2) * COS(RADIANS(from_lat)) * COS(RADIANS(to_lat))), SQRT(1 - POW(SIN(RADIANS(to_lat - from_lat)/2), 2) + POW(SIN(RADIANS(to_lng - from_lng)/2), 2) * COS(RADIANS(from_lat)) * COS(RADIANS(to_lat))));
	
CREATE TABLE `tb_mmt_poi_visit` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `POI_ID` int(11) NOT NULL DEFAULT '0' COMMENT 'POI 아이디',
  `SEQ` int(11) NOT NULL DEFAULT '0' COMMENT '순번',
  `COUNT` int(11) DEFAULT NULL COMMENT '방문횟수',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`USER_ID`,`POI_ID`,`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POI 방문';

CREATE TABLE `tb_mmt_poi_search` (
  `USER_ID` int(11) NOT NULL DEFAULT '0' COMMENT '사용자 아이디',
  `POI_ID` int(11) NOT NULL DEFAULT '0' COMMENT 'POI 아이디',
  `SEQ` int(11) NOT NULL DEFAULT '0' COMMENT '순번',
  `COUNT` int(11) DEFAULT NULL COMMENT '검색횟수',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`USER_ID`,`POI_ID`,`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POI 검색';

CREATE TABLE `tb_mmt_heimdall_history` (
  `HISTORY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '이력 아이디',
  `METHOD_NAME` varchar(40) NOT NULL DEFAULT '' COMMENT '전문명',
  `USER_KEY` varchar(100) NOT NULL DEFAULT '' COMMENT 'USER KEY',
  `CH_NAME` varchar(20) DEFAULT NULL COMMENT '채널명',
  `APP_CODE` varchar(20) DEFAULT NULL COMMENT '앱코드',
  `REGISTERED_APP_LIST` varchar(100) DEFAULT NULL COMMENT '등록된 앱 목록',
  `UPDATE_REQUEST_DATE` varchar(20) DEFAULT NULL COMMENT '등록요청일시',
  `PROCESS_TIME` int(11) DEFAULT NULL COMMENT '처리시간(milliseconds)',
  `RESULT` varchar(10) DEFAULT NULL COMMENT '성공여부',
  `CALL_TYPE` varchar(10) DEFAULT NULL COMMENT '반환 타입',
  `RESULT_TEXT` varchar(100) DEFAULT NULL COMMENT '반환 메시지',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '등록일시',
  PRIMARY KEY (`HISTORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='헤임달 provisioning 이력';