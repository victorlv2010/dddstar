/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/12/5 10:29:01                           */
/*==============================================================*/


drop table if exists ALERT_EVENT_HISTORY;

drop table if exists DATABASE_CONNS;

drop table if exists DATABASE_TYPE;

drop table if exists DATA_COMPARE_COLUMNS;

drop table if exists DATA_COMPARE_GROUPS;

drop table if exists DATA_COMPARE_PAIRS;

drop table if exists DATA_COMPARE_REPORT;

drop table if exists DB_TYPE_ITEM_RELATION;

drop table if exists EMAIL_SEND_HISTORY;

drop table if exists JOB_DATA_COMPARE;

drop table if exists JOB_SCHEMA_COMPARE;

drop table if exists MODULES;

drop table if exists ROLES;

drop table if exists ROLE_PRIVILEGES;

drop table if exists SCHEMA_COMPARE_ITEMS;

drop table if exists SCHEMA_COMPARE_PAIRS;

drop table if exists SCHEMA_COMPARE_REPORT;

drop table if exists SMS_SEND_HISTORY;

drop table if exists SYS_APPLICATION_CONFIG;

drop table if exists SYS_EMAIL_CONFIG;

drop table if exists SYS_LICENSE;

drop table if exists SYS_LOG;

drop table if exists SYS_RETENTION_POLICY;

drop table if exists SYS_SMS_CONFIG;

drop table if exists SYS_THRESHOLD_CONFIG;

drop table if exists USERS;

drop table if exists USER_SUBSCRIBE_CONN_EVENT;

drop table if exists USER_SUBSCRIBE_DATACOMPARE_EVENT;

drop table if exists USER_SUBSCRIBE_DATACOMPARE_REPORT;

drop table if exists USER_SUBSCRIBE_SCHEMACOMPARE_EVENT;

drop table if exists USER_SUBSCRIBE_SCHEMACOMPARE_REPORT;

/*==============================================================*/
/* Table: ALERT_EVENT_HISTORY                                   */
/*==============================================================*/
create table ALERT_EVENT_HISTORY
(
   ID                   int not null comment 'ID',
   EVENT_CONTENT        varchar(100) comment '事件主题',
   EVENT_TIME           datetime comment '事件时间',
   EVENT_TYPE           char comment '1：数据比对告警事件，2：架构比对告警事件，3：数据库连接事件',
   COMPARE_FLAG         char comment '1：比较组，2：比较对',
   COMPARE_ID           int comment '数据比较组或比较对ID',
   SCHEMA_COMPAIR_ID    int comment '架构比对ID',
   DATABASE_ID          int comment '数据库连接ID',
   EVENT_SOURCE         varchar(100) comment '写数据比较对名称，架构比对名称，数据库连接名称',
   primary key (ID)
);

alter table ALERT_EVENT_HISTORY comment '告警事件历史';

/*==============================================================*/
/* Table: DATABASE_CONNS                                        */
/*==============================================================*/
create table DATABASE_CONNS
(
   ID                   int not null comment 'ID',
   DB_NAME              varchar(100) comment '数据库名称',
   BUSINESS_NAME        varchar(100) comment '业务系统名称',
   DB_ACCOUNT           varchar(50) comment '数据库帐号',
   DB_PASSWORD          varchar(50) comment '数据库密码',
   DB_IP                varchar(20) comment 'IP地址',
   DB_PORT              varchar(20) comment '端口',
   SID                  varchar(30) comment '服务名（数据库名）',
   AGENT_IP             varchar(20) comment 'AgentIP',
   AGENT_PORT           varchar(20) comment 'Agent端口',
   AGENT_CONN_FLAG      char comment '0：jdbc直接连接，1：Agent连接',
   DB_TYPE              int comment '数据库类型',
   DETECT_ONOFF         char comment '0:关闭，1：启用侦测',
   LATEST_DETECT_TIME   datetime comment '最近侦测时间',
   JDBC_CONN_STATUS     char comment '0:异常，1：正常',
   AGENT_CONN_STATUS    char comment '0:异常，1：正常',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table DATABASE_CONNS comment '数据库连接表';

/*==============================================================*/
/* Table: DATABASE_TYPE                                         */
/*==============================================================*/
create table DATABASE_TYPE
(
   ID                   int not null comment 'ID',
   DB_TYPE_NAME         varchar(20) comment '数据库类型名称',
   DB_DESC              varchar(30) comment '数据库描述',
   primary key (ID)
);

alter table DATABASE_TYPE comment '数据库类型表';

/*==============================================================*/
/* Table: DATA_COMPARE_COLUMNS                                  */
/*==============================================================*/
create table DATA_COMPARE_COLUMNS
(
   ID                   int not null comment 'ID',
   GROUP_ID             int comment '比较组ID',
   PAIR_ID              int comment '比较对ID',
   SOURCE_COLUMN_NAME   varchar(30) comment '源列名',
   SOURCE_DATATYPE      varchar(30) comment '源列数据类型',
   SOURCE_DATA_LENGTH   int comment '源列数据类型长度',
   TARGET_COLUMN_NAME   varchar(30) comment '目标列名',
   TARGET_DATATYPE      varchar(30) comment '目标列数据类型',
   TARGET_DATA_LENGTH   int comment '目标列数据类型长度',
   IS_KEY               char comment 'N:不是，Y：是',
   IS_CLOB              char comment 'N:不是，Y：是',
   IS_BLOB              char comment 'N:不是，Y：是',
   IS_DATE              char comment 'N:不是，Y：是',
   IS_DATETIME          char comment 'N:不是，Y：是',
   primary key (ID)
);

alter table DATA_COMPARE_COLUMNS comment '数据比较列表';

/*==============================================================*/
/* Table: DATA_COMPARE_GROUPS                                   */
/*==============================================================*/
create table DATA_COMPARE_GROUPS
(
   ID                   int not null comment 'ID',
   GROUP_NAME           varchar(50) comment '数据比较组名称',
   SOURCE_CONN_ID       int comment '源数据库连接ID',
   TARGET_CONN_ID       int comment '目标数据库连接ID',
   JOB_FLAG             char comment '0:无调度，1：有调度设置',
   PAIR_COUNT           int comment '比较对数量',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table DATA_COMPARE_GROUPS comment '数据比较组表';

/*==============================================================*/
/* Table: DATA_COMPARE_PAIRS                                    */
/*==============================================================*/
create table DATA_COMPARE_PAIRS
(
   ID                   int not null comment 'ID',
   PAIR_NAME            varchar(50) comment '数据比较对名称',
   GROUP_ID             int comment '数据比较组ID',
   SOURCE_SCHEMA        varchar(30) comment '源SCHEMA（或数据库）',
   SOURCE_TABLE_NAME    varchar(30) comment '源表名称',
   SOURCE_WHERE         varchar(300) comment '源过滤条件',
   TARGET_SCHEMA        varchar(30) comment '目标SCHEMA（或数据库）',
   TARGET_TABLE_NAME    varchar(30) comment '目标表名称',
   TARGET_WHERE         varchar(300) comment '目标过滤条件',
   VALID_STATUS         char comment '0：未验证，1：验证有效，2：验证无效',
   JOB_FLAG             char comment '0:无调度，1：有调度设置',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table DATA_COMPARE_PAIRS comment '数据比较对表';

/*==============================================================*/
/* Table: DATA_COMPARE_REPORT                                   */
/*==============================================================*/
create table DATA_COMPARE_REPORT
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '比较组或比较对ID',
   COMPARE_NAME         varchar(50) comment '比较组或比较对名称',
   GROUP_FLAG           char comment '0:比较对，1：比较组',
   INTERNAL_GROUP_FLAG  char comment '0：独立比较，1：属于组内比较',
   SOURCE_TABLE_NAME    varchar(30) comment '源表名',
   SOURCE_COUNT         int comment '源记录数',
   TARGET_TABLE_NAME    varchar(30) comment '目标表名',
   TARGET_COUNT         int comment '目标记录数',
   DIFF_COUNT           int comment '差异数',
   ALERT_FLAG           char comment '0：不告警，1：告警',
   START_TIME           datetime comment '开始时间',
   END_TIME             datetime comment '结束时间',
   DURATION             int comment '用时',
   REPORT_URL           varchar(100) comment '比对报告',
   primary key (ID)
);

alter table DATA_COMPARE_REPORT comment '数据比对报告';

/*==============================================================*/
/* Table: DB_TYPE_ITEM_RELATION                                 */
/*==============================================================*/
create table DB_TYPE_ITEM_RELATION
(
   ID                   int not null comment 'ID',
   DB_TYPE_ID           int comment '数据库类型ID',
   ITEM_ID              int comment '比对项ID',
   primary key (ID)
);

alter table DB_TYPE_ITEM_RELATION comment '数据库种类与架构比对项关联关系表';

/*==============================================================*/
/* Table: EMAIL_SEND_HISTORY                                    */
/*==============================================================*/
create table EMAIL_SEND_HISTORY
(
   ID                   int not null comment 'ID',
   EMAIL_SUBJECT        varchar(200) comment '邮件主题',
   EMAIL_CONTENT        varchar(300) comment '邮件内容',
   EMAIL_ADDR           varchar(2000) comment '接收邮箱',
   EMAIL_TYPE           char comment '1:数据比对报告, 2:架构比对报告, 3:数据比对告警事件, 4:架构比对告警事件, 5:数据库连接告警事件',
   EMAIL_ATTACH         varchar(200) comment '邮件附件',
   SEND_STATUS          char comment '0:失败，1：成功',
   SEND_TIME            datetime comment '发送时间',
   primary key (ID)
);

alter table EMAIL_SEND_HISTORY comment '邮件发送历史';

/*==============================================================*/
/* Table: JOB_DATA_COMPARE                                      */
/*==============================================================*/
create table JOB_DATA_COMPARE
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '比较组或比较对ID',
   COMPARE_TYPE         char comment '1:比较组，2：比较对',
   SCHEDULE_TYPE        char comment '1：每周, 2:每月, 3：每天, 4：立即, 5：不重复',
   SCHEDULE_VALUE       varchar(50) comment '调度值按“，”分割，周如：1，2，3，7；月如：1，5，8，10，20，last',
   SCHEDULE_TIME        varchar(10) comment '调度时间',
   LATEST_RUN_TIME      datetime comment '最近执行时间',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table JOB_DATA_COMPARE comment '数据比对任务调度表';

/*==============================================================*/
/* Table: JOB_SCHEMA_COMPARE                                    */
/*==============================================================*/
create table JOB_SCHEMA_COMPARE
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '架构比对ID',
   SCHEDULE_TYPE        char comment '1：每周, 2:每月, 3：每天, 4：立即, 5：不重复',
   SCHEDULE_VALUE       varchar(50) comment '调度值',
   SCHEDULE_TIME        varchar(10) comment '调度时间',
   LATEST_RUN_TIME      datetime comment '最近执行时间',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者'
);

alter table JOB_SCHEMA_COMPARE comment '架构比对任务调度表';

/*==============================================================*/
/* Table: MODULES                                               */
/*==============================================================*/
create table MODULES
(
   ID                   int not null comment 'ID',
   MODULE_NAME          varchar(30) comment '模块名称',
   MODULE_DESC          varchar(50) comment '描述',
   primary key (ID)
);

alter table MODULES comment '功能模块表';

/*==============================================================*/
/* Table: ROLES                                                 */
/*==============================================================*/
create table ROLES
(
   ID                   int not null comment 'ID',
   ROLE_NAME            varchar(30) comment '角色名称',
   ROLE_DESC            varchar(50) comment '角色描述',
   primary key (ID)
);

alter table ROLES comment '角色表';

/*==============================================================*/
/* Table: ROLE_PRIVILEGES                                       */
/*==============================================================*/
create table ROLE_PRIVILEGES
(
   ID                   int not null comment 'ID',
   ROLE_ID              int comment '角色ID',
   MODULE_ID            int comment '模块ID',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table ROLE_PRIVILEGES comment '角色权限表';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_ITEMS                                  */
/*==============================================================*/
create table SCHEMA_COMPARE_ITEMS
(
   ID                   int comment 'ID',
   ITEM_NAME            varchar(30) comment '架构比对项名称',
   ITEM_DESC            varchar(50) comment '描述'
);

alter table SCHEMA_COMPARE_ITEMS comment '架构比对项表';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_PAIRS                                  */
/*==============================================================*/
create table SCHEMA_COMPARE_PAIRS
(
   ID                   int not null comment 'ID',
   SOURCE_CONN_ID       int comment '源数据库连接ID',
   SOURCE_SCHEMA        varchar(30) comment '源SCHEMA（或数据库）',
   TARGET_CONN_ID       int comment '目标数据库连接ID',
   TARGET_SCHEMA        varchar(30) comment '目标SCHEMA（或数据库）',
   COMPARE_ITEMS        varchar(50) comment '比对项按“，”分割，如：1，2，3，4，5，6',
   JOB_FLAG             char comment '0:无调度，1：有调度设置',
   CREATE_TIME          datetime comment '创建时间',
   MODIFTY_TIME         datetime comment '修改时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table SCHEMA_COMPARE_PAIRS comment '架构比对表';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_REPORT                                 */
/*==============================================================*/
create table SCHEMA_COMPARE_REPORT
(
   ID                   int not null comment 'ID',
   PAIR_ID              int comment '架构比对ID',
   PAIR_NAME            varchar(50) comment '架构比对名称',
   SOURCE_DB_NAME       varchar(50) comment '源数据库名称',
   TARGET_DB_NAME       varchar(50) comment '目标数据库名称',
   START_TIME           datetime comment '开始时间',
   END_TIME             datetime comment '结束时间',
   DURATION             int comment '用时',
   ALERT_FLAG           char comment '0：不告警，1：告警',
   REPORT_URL           varchar(100) comment '比对报告',
   primary key (ID)
);

alter table SCHEMA_COMPARE_REPORT comment '架构比对报告';

/*==============================================================*/
/* Table: SMS_SEND_HISTORY                                      */
/*==============================================================*/
create table SMS_SEND_HISTORY
(
   ID                   int comment 'ID',
   SMS_CONTENT          varchar(300) comment '短信内容',
   SMS_NO               varchar(2000) comment '接收号码',
   SEND_TIME            datetime comment '发送时间',
   SEND_STATUS          char comment '0:失败，1：成功',
   EVENT_TYPE           char comment '1：数据比对告警事件, 2：架构比对告警事件, 3：数据库连接事件'
);

alter table SMS_SEND_HISTORY comment '短信发送历史';

/*==============================================================*/
/* Table: SYS_APPLICATION_CONFIG                                */
/*==============================================================*/
create table SYS_APPLICATION_CONFIG
(
   ID                   int not null comment 'ID',
   APPLICATION_NAME     varchar(50) comment '应用名称',
   LOGO_ADDR            varchar(50) comment '应用LOGO',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_APPLICATION_CONFIG comment '系统应用配置表';

/*==============================================================*/
/* Table: SYS_EMAIL_CONFIG                                      */
/*==============================================================*/
create table SYS_EMAIL_CONFIG
(
   ID                   int not null comment 'ID',
   EMAIL_SERVER_ADDR    varchar(50) comment '邮件服务器地址',
   EMAIL_SERVER_PORT    varchar(20) comment '邮件服务器端口',
   SENDER_EMAIL         varchar(50) comment '发送邮箱',
   EMAIL_PASSWORD       varchar(50) comment '邮箱密码',
   EMAIL_SERVICE_STATUS char comment '0：邮件服务停止，1：邮件服务启用',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_EMAIL_CONFIG comment '系统邮件服务配置表';

/*==============================================================*/
/* Table: SYS_LICENSE                                           */
/*==============================================================*/
create table SYS_LICENSE
(
   ID                   int not null comment 'ID',
   LICENSE_MODULE       varchar(30) comment '许可模块',
   LICENSE_LIMIT        datetime comment '许可期限',
   primary key (ID)
);

alter table SYS_LICENSE comment '系统license表';

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
create table SYS_LOG
(
   ID                   int not null comment 'ID',
   IP_ADDR              varchar(20) comment 'IP地址',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   LEVEL_ONE            varchar(30) comment '一级模块',
   LEVEL_TWO            varchar(30) comment '二级模块',
   LEVEL_THREE          varchar(30) comment '三级模块',
   OPERATION_CONTENT    varchar(500) comment '操作内容',
   OPERATION_TIME       datetime comment '操作时间',
   primary key (ID)
);

alter table SYS_LOG comment '系统日志表';

/*==============================================================*/
/* Table: SYS_RETENTION_POLICY                                  */
/*==============================================================*/
create table SYS_RETENTION_POLICY
(
   ID                   int not null comment 'ID',
   RETENTION_NAME       varchar(80) comment '保留策略名称',
   RETENTION_DURATION   int comment '保留时长：2-12个月',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_RETENTION_POLICY comment '保留策略';

/*==============================================================*/
/* Table: SYS_SMS_CONFIG                                        */
/*==============================================================*/
create table SYS_SMS_CONFIG
(
   ID                   int not null comment 'ID',
   SMS_MODE             char comment '1:短信猫模式，2：短信平台模式',
   SMS_PORT             varchar(30) comment '写：COM1，COM2，COM3等',
   SMS_PLAT_ADDR        varchar(100) comment '短信平台地址',
   SMS_PLAT_APPKEY      varchar(30) comment '短信平台appkey',
   SMS_PLAT_SECRET      varchar(60) comment '短信平台secret',
   SMS_PLAT_SIGNATURE   varchar(30) comment '短信平台签名',
   SMS_PLAT_TEMPLATE_CODE varchar(30) comment '短信平台模板代码',
   SMS_SERVICE_STATUS   char comment '0：停止服务状态，1：启用服务状态',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_SMS_CONFIG comment '系统短信服务配置表';

/*==============================================================*/
/* Table: SYS_THRESHOLD_CONFIG                                  */
/*==============================================================*/
create table SYS_THRESHOLD_CONFIG
(
   ID                   int not null comment 'ID',
   THRESHOLD_NAME       varchar(50) comment '阀值名称',
   THRESHOLD_VALUE      int comment '阀值',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table SYS_THRESHOLD_CONFIG comment '系统阀值配置表';

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS
(
   ID                   int not null comment 'ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   USER_NAME            varchar(30) comment '用户姓名',
   ROLE_ID              int comment '1:系统管理员，2：普通管理员，3：普通用户',
   MOBILE               varchar(30) comment '手机号码',
   EMAIL                varchar(50) comment '邮箱地址',
   EMAIL_SUBSCRIBE_ONOFF char comment '0：关，1：开',
   SMS_SUBSCRIBE_ONOFF  char comment '0：关，1：开',
   STATUS               char comment '0:停用，1：启用',
   CREATE_TIME          datetime comment '创建时间',
   MODIFY_TIME          datetime comment '修改时间',
   primary key (ID)
);

alter table USERS comment '用户表';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_CONN_EVENT                             */
/*==============================================================*/
create table USER_SUBSCRIBE_CONN_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '用户ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   DATABASE_ID          int comment '数据库连接ID',
   ALL_FLAG             char comment '1：所有架构比对',
   CREATE_TIME          datetime comment '创建时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table USER_SUBSCRIBE_CONN_EVENT comment '用户数据库连接告警事件订阅表';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_DATACOMPARE_EVENT                      */
/*==============================================================*/
create table USER_SUBSCRIBE_DATACOMPARE_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '用户ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   COMPARE_FLAG         char comment '1：比较组，2：比较对',
   COMPARE_ID           int comment '比较组或比较对ID',
   ALL_FLAG             char comment '1:选择所有比较组',
   CREATE_TIME          datetime comment '创建时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table USER_SUBSCRIBE_DATACOMPARE_EVENT comment '用户数据比对告警事件订阅表';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_DATACOMPARE_REPORT                     */
/*==============================================================*/
create table USER_SUBSCRIBE_DATACOMPARE_REPORT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '用户ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   COMPARE_FLAG         char comment '1：比较组，2：比较对',
   COMPARE_ID           int comment '比较组或比较对ID',
   ALL_FLAG             char comment '1:选择所有比较组',
   CREATE_TIME          datetime comment '创建时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table USER_SUBSCRIBE_DATACOMPARE_REPORT comment '用户数据比对报告订阅表';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_SCHEMACOMPARE_EVENT                    */
/*==============================================================*/
create table USER_SUBSCRIBE_SCHEMACOMPARE_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '用户ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   SCHEMA_COMPARE_ID    int comment '架构比对ID',
   ALL_FLAG             char comment '1：所有架构比对',
   CREATE_TIME          datetime comment '创建时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table USER_SUBSCRIBE_SCHEMACOMPARE_EVENT comment '用户架构比对告警事件订阅表';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_SCHEMACOMPARE_REPORT                   */
/*==============================================================*/
create table USER_SUBSCRIBE_SCHEMACOMPARE_REPORT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '用户ID',
   USER_ACCOUNT         varchar(30) comment '用户帐号',
   SCHEMA_COMPARE_ID    int comment '架构比对ID',
   ALL_FLAG             char comment '1：所有架构比对',
   CREATE_TIME          datetime comment '创建时间',
   USER_NAME            varchar(30) comment '创建者',
   primary key (ID)
);

alter table USER_SUBSCRIBE_SCHEMACOMPARE_REPORT comment '用户架构比对报告订阅表';

