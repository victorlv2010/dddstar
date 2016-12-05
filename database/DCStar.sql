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
   EVENT_CONTENT        varchar(100) comment '�¼�����',
   EVENT_TIME           datetime comment '�¼�ʱ��',
   EVENT_TYPE           char comment '1�����ݱȶԸ澯�¼���2���ܹ��ȶԸ澯�¼���3�����ݿ������¼�',
   COMPARE_FLAG         char comment '1���Ƚ��飬2���Ƚ϶�',
   COMPARE_ID           int comment '���ݱȽ����Ƚ϶�ID',
   SCHEMA_COMPAIR_ID    int comment '�ܹ��ȶ�ID',
   DATABASE_ID          int comment '���ݿ�����ID',
   EVENT_SOURCE         varchar(100) comment 'д���ݱȽ϶����ƣ��ܹ��ȶ����ƣ����ݿ���������',
   primary key (ID)
);

alter table ALERT_EVENT_HISTORY comment '�澯�¼���ʷ';

/*==============================================================*/
/* Table: DATABASE_CONNS                                        */
/*==============================================================*/
create table DATABASE_CONNS
(
   ID                   int not null comment 'ID',
   DB_NAME              varchar(100) comment '���ݿ�����',
   BUSINESS_NAME        varchar(100) comment 'ҵ��ϵͳ����',
   DB_ACCOUNT           varchar(50) comment '���ݿ��ʺ�',
   DB_PASSWORD          varchar(50) comment '���ݿ�����',
   DB_IP                varchar(20) comment 'IP��ַ',
   DB_PORT              varchar(20) comment '�˿�',
   SID                  varchar(30) comment '�����������ݿ�����',
   AGENT_IP             varchar(20) comment 'AgentIP',
   AGENT_PORT           varchar(20) comment 'Agent�˿�',
   AGENT_CONN_FLAG      char comment '0��jdbcֱ�����ӣ�1��Agent����',
   DB_TYPE              int comment '���ݿ�����',
   DETECT_ONOFF         char comment '0:�رգ�1���������',
   LATEST_DETECT_TIME   datetime comment '������ʱ��',
   JDBC_CONN_STATUS     char comment '0:�쳣��1������',
   AGENT_CONN_STATUS    char comment '0:�쳣��1������',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table DATABASE_CONNS comment '���ݿ����ӱ�';

/*==============================================================*/
/* Table: DATABASE_TYPE                                         */
/*==============================================================*/
create table DATABASE_TYPE
(
   ID                   int not null comment 'ID',
   DB_TYPE_NAME         varchar(20) comment '���ݿ���������',
   DB_DESC              varchar(30) comment '���ݿ�����',
   primary key (ID)
);

alter table DATABASE_TYPE comment '���ݿ����ͱ�';

/*==============================================================*/
/* Table: DATA_COMPARE_COLUMNS                                  */
/*==============================================================*/
create table DATA_COMPARE_COLUMNS
(
   ID                   int not null comment 'ID',
   GROUP_ID             int comment '�Ƚ���ID',
   PAIR_ID              int comment '�Ƚ϶�ID',
   SOURCE_COLUMN_NAME   varchar(30) comment 'Դ����',
   SOURCE_DATATYPE      varchar(30) comment 'Դ����������',
   SOURCE_DATA_LENGTH   int comment 'Դ���������ͳ���',
   TARGET_COLUMN_NAME   varchar(30) comment 'Ŀ������',
   TARGET_DATATYPE      varchar(30) comment 'Ŀ������������',
   TARGET_DATA_LENGTH   int comment 'Ŀ�����������ͳ���',
   IS_KEY               char comment 'N:���ǣ�Y����',
   IS_CLOB              char comment 'N:���ǣ�Y����',
   IS_BLOB              char comment 'N:���ǣ�Y����',
   IS_DATE              char comment 'N:���ǣ�Y����',
   IS_DATETIME          char comment 'N:���ǣ�Y����',
   primary key (ID)
);

alter table DATA_COMPARE_COLUMNS comment '���ݱȽ��б�';

/*==============================================================*/
/* Table: DATA_COMPARE_GROUPS                                   */
/*==============================================================*/
create table DATA_COMPARE_GROUPS
(
   ID                   int not null comment 'ID',
   GROUP_NAME           varchar(50) comment '���ݱȽ�������',
   SOURCE_CONN_ID       int comment 'Դ���ݿ�����ID',
   TARGET_CONN_ID       int comment 'Ŀ�����ݿ�����ID',
   JOB_FLAG             char comment '0:�޵��ȣ�1���е�������',
   PAIR_COUNT           int comment '�Ƚ϶�����',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table DATA_COMPARE_GROUPS comment '���ݱȽ����';

/*==============================================================*/
/* Table: DATA_COMPARE_PAIRS                                    */
/*==============================================================*/
create table DATA_COMPARE_PAIRS
(
   ID                   int not null comment 'ID',
   PAIR_NAME            varchar(50) comment '���ݱȽ϶�����',
   GROUP_ID             int comment '���ݱȽ���ID',
   SOURCE_SCHEMA        varchar(30) comment 'ԴSCHEMA�������ݿ⣩',
   SOURCE_TABLE_NAME    varchar(30) comment 'Դ������',
   SOURCE_WHERE         varchar(300) comment 'Դ��������',
   TARGET_SCHEMA        varchar(30) comment 'Ŀ��SCHEMA�������ݿ⣩',
   TARGET_TABLE_NAME    varchar(30) comment 'Ŀ�������',
   TARGET_WHERE         varchar(300) comment 'Ŀ���������',
   VALID_STATUS         char comment '0��δ��֤��1����֤��Ч��2����֤��Ч',
   JOB_FLAG             char comment '0:�޵��ȣ�1���е�������',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table DATA_COMPARE_PAIRS comment '���ݱȽ϶Ա�';

/*==============================================================*/
/* Table: DATA_COMPARE_REPORT                                   */
/*==============================================================*/
create table DATA_COMPARE_REPORT
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '�Ƚ����Ƚ϶�ID',
   COMPARE_NAME         varchar(50) comment '�Ƚ����Ƚ϶�����',
   GROUP_FLAG           char comment '0:�Ƚ϶ԣ�1���Ƚ���',
   INTERNAL_GROUP_FLAG  char comment '0�������Ƚϣ�1���������ڱȽ�',
   SOURCE_TABLE_NAME    varchar(30) comment 'Դ����',
   SOURCE_COUNT         int comment 'Դ��¼��',
   TARGET_TABLE_NAME    varchar(30) comment 'Ŀ�����',
   TARGET_COUNT         int comment 'Ŀ���¼��',
   DIFF_COUNT           int comment '������',
   ALERT_FLAG           char comment '0�����澯��1���澯',
   START_TIME           datetime comment '��ʼʱ��',
   END_TIME             datetime comment '����ʱ��',
   DURATION             int comment '��ʱ',
   REPORT_URL           varchar(100) comment '�ȶԱ���',
   primary key (ID)
);

alter table DATA_COMPARE_REPORT comment '���ݱȶԱ���';

/*==============================================================*/
/* Table: DB_TYPE_ITEM_RELATION                                 */
/*==============================================================*/
create table DB_TYPE_ITEM_RELATION
(
   ID                   int not null comment 'ID',
   DB_TYPE_ID           int comment '���ݿ�����ID',
   ITEM_ID              int comment '�ȶ���ID',
   primary key (ID)
);

alter table DB_TYPE_ITEM_RELATION comment '���ݿ�������ܹ��ȶ��������ϵ��';

/*==============================================================*/
/* Table: EMAIL_SEND_HISTORY                                    */
/*==============================================================*/
create table EMAIL_SEND_HISTORY
(
   ID                   int not null comment 'ID',
   EMAIL_SUBJECT        varchar(200) comment '�ʼ�����',
   EMAIL_CONTENT        varchar(300) comment '�ʼ�����',
   EMAIL_ADDR           varchar(2000) comment '��������',
   EMAIL_TYPE           char comment '1:���ݱȶԱ���, 2:�ܹ��ȶԱ���, 3:���ݱȶԸ澯�¼�, 4:�ܹ��ȶԸ澯�¼�, 5:���ݿ����Ӹ澯�¼�',
   EMAIL_ATTACH         varchar(200) comment '�ʼ�����',
   SEND_STATUS          char comment '0:ʧ�ܣ�1���ɹ�',
   SEND_TIME            datetime comment '����ʱ��',
   primary key (ID)
);

alter table EMAIL_SEND_HISTORY comment '�ʼ�������ʷ';

/*==============================================================*/
/* Table: JOB_DATA_COMPARE                                      */
/*==============================================================*/
create table JOB_DATA_COMPARE
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '�Ƚ����Ƚ϶�ID',
   COMPARE_TYPE         char comment '1:�Ƚ��飬2���Ƚ϶�',
   SCHEDULE_TYPE        char comment '1��ÿ��, 2:ÿ��, 3��ÿ��, 4������, 5�����ظ�',
   SCHEDULE_VALUE       varchar(50) comment '����ֵ���������ָ���磺1��2��3��7�����磺1��5��8��10��20��last',
   SCHEDULE_TIME        varchar(10) comment '����ʱ��',
   LATEST_RUN_TIME      datetime comment '���ִ��ʱ��',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table JOB_DATA_COMPARE comment '���ݱȶ�������ȱ�';

/*==============================================================*/
/* Table: JOB_SCHEMA_COMPARE                                    */
/*==============================================================*/
create table JOB_SCHEMA_COMPARE
(
   ID                   int not null comment 'ID',
   COMPARE_ID           int comment '�ܹ��ȶ�ID',
   SCHEDULE_TYPE        char comment '1��ÿ��, 2:ÿ��, 3��ÿ��, 4������, 5�����ظ�',
   SCHEDULE_VALUE       varchar(50) comment '����ֵ',
   SCHEDULE_TIME        varchar(10) comment '����ʱ��',
   LATEST_RUN_TIME      datetime comment '���ִ��ʱ��',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������'
);

alter table JOB_SCHEMA_COMPARE comment '�ܹ��ȶ�������ȱ�';

/*==============================================================*/
/* Table: MODULES                                               */
/*==============================================================*/
create table MODULES
(
   ID                   int not null comment 'ID',
   MODULE_NAME          varchar(30) comment 'ģ������',
   MODULE_DESC          varchar(50) comment '����',
   primary key (ID)
);

alter table MODULES comment '����ģ���';

/*==============================================================*/
/* Table: ROLES                                                 */
/*==============================================================*/
create table ROLES
(
   ID                   int not null comment 'ID',
   ROLE_NAME            varchar(30) comment '��ɫ����',
   ROLE_DESC            varchar(50) comment '��ɫ����',
   primary key (ID)
);

alter table ROLES comment '��ɫ��';

/*==============================================================*/
/* Table: ROLE_PRIVILEGES                                       */
/*==============================================================*/
create table ROLE_PRIVILEGES
(
   ID                   int not null comment 'ID',
   ROLE_ID              int comment '��ɫID',
   MODULE_ID            int comment 'ģ��ID',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table ROLE_PRIVILEGES comment '��ɫȨ�ޱ�';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_ITEMS                                  */
/*==============================================================*/
create table SCHEMA_COMPARE_ITEMS
(
   ID                   int comment 'ID',
   ITEM_NAME            varchar(30) comment '�ܹ��ȶ�������',
   ITEM_DESC            varchar(50) comment '����'
);

alter table SCHEMA_COMPARE_ITEMS comment '�ܹ��ȶ����';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_PAIRS                                  */
/*==============================================================*/
create table SCHEMA_COMPARE_PAIRS
(
   ID                   int not null comment 'ID',
   SOURCE_CONN_ID       int comment 'Դ���ݿ�����ID',
   SOURCE_SCHEMA        varchar(30) comment 'ԴSCHEMA�������ݿ⣩',
   TARGET_CONN_ID       int comment 'Ŀ�����ݿ�����ID',
   TARGET_SCHEMA        varchar(30) comment 'Ŀ��SCHEMA�������ݿ⣩',
   COMPARE_ITEMS        varchar(50) comment '�ȶ���������ָ�磺1��2��3��4��5��6',
   JOB_FLAG             char comment '0:�޵��ȣ�1���е�������',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFTY_TIME         datetime comment '�޸�ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table SCHEMA_COMPARE_PAIRS comment '�ܹ��ȶԱ�';

/*==============================================================*/
/* Table: SCHEMA_COMPARE_REPORT                                 */
/*==============================================================*/
create table SCHEMA_COMPARE_REPORT
(
   ID                   int not null comment 'ID',
   PAIR_ID              int comment '�ܹ��ȶ�ID',
   PAIR_NAME            varchar(50) comment '�ܹ��ȶ�����',
   SOURCE_DB_NAME       varchar(50) comment 'Դ���ݿ�����',
   TARGET_DB_NAME       varchar(50) comment 'Ŀ�����ݿ�����',
   START_TIME           datetime comment '��ʼʱ��',
   END_TIME             datetime comment '����ʱ��',
   DURATION             int comment '��ʱ',
   ALERT_FLAG           char comment '0�����澯��1���澯',
   REPORT_URL           varchar(100) comment '�ȶԱ���',
   primary key (ID)
);

alter table SCHEMA_COMPARE_REPORT comment '�ܹ��ȶԱ���';

/*==============================================================*/
/* Table: SMS_SEND_HISTORY                                      */
/*==============================================================*/
create table SMS_SEND_HISTORY
(
   ID                   int comment 'ID',
   SMS_CONTENT          varchar(300) comment '��������',
   SMS_NO               varchar(2000) comment '���պ���',
   SEND_TIME            datetime comment '����ʱ��',
   SEND_STATUS          char comment '0:ʧ�ܣ�1���ɹ�',
   EVENT_TYPE           char comment '1�����ݱȶԸ澯�¼�, 2���ܹ��ȶԸ澯�¼�, 3�����ݿ������¼�'
);

alter table SMS_SEND_HISTORY comment '���ŷ�����ʷ';

/*==============================================================*/
/* Table: SYS_APPLICATION_CONFIG                                */
/*==============================================================*/
create table SYS_APPLICATION_CONFIG
(
   ID                   int not null comment 'ID',
   APPLICATION_NAME     varchar(50) comment 'Ӧ������',
   LOGO_ADDR            varchar(50) comment 'Ӧ��LOGO',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table SYS_APPLICATION_CONFIG comment 'ϵͳӦ�����ñ�';

/*==============================================================*/
/* Table: SYS_EMAIL_CONFIG                                      */
/*==============================================================*/
create table SYS_EMAIL_CONFIG
(
   ID                   int not null comment 'ID',
   EMAIL_SERVER_ADDR    varchar(50) comment '�ʼ���������ַ',
   EMAIL_SERVER_PORT    varchar(20) comment '�ʼ��������˿�',
   SENDER_EMAIL         varchar(50) comment '��������',
   EMAIL_PASSWORD       varchar(50) comment '��������',
   EMAIL_SERVICE_STATUS char comment '0���ʼ�����ֹͣ��1���ʼ���������',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table SYS_EMAIL_CONFIG comment 'ϵͳ�ʼ��������ñ�';

/*==============================================================*/
/* Table: SYS_LICENSE                                           */
/*==============================================================*/
create table SYS_LICENSE
(
   ID                   int not null comment 'ID',
   LICENSE_MODULE       varchar(30) comment '���ģ��',
   LICENSE_LIMIT        datetime comment '�������',
   primary key (ID)
);

alter table SYS_LICENSE comment 'ϵͳlicense��';

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
create table SYS_LOG
(
   ID                   int not null comment 'ID',
   IP_ADDR              varchar(20) comment 'IP��ַ',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   LEVEL_ONE            varchar(30) comment 'һ��ģ��',
   LEVEL_TWO            varchar(30) comment '����ģ��',
   LEVEL_THREE          varchar(30) comment '����ģ��',
   OPERATION_CONTENT    varchar(500) comment '��������',
   OPERATION_TIME       datetime comment '����ʱ��',
   primary key (ID)
);

alter table SYS_LOG comment 'ϵͳ��־��';

/*==============================================================*/
/* Table: SYS_RETENTION_POLICY                                  */
/*==============================================================*/
create table SYS_RETENTION_POLICY
(
   ID                   int not null comment 'ID',
   RETENTION_NAME       varchar(80) comment '������������',
   RETENTION_DURATION   int comment '����ʱ����2-12����',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table SYS_RETENTION_POLICY comment '��������';

/*==============================================================*/
/* Table: SYS_SMS_CONFIG                                        */
/*==============================================================*/
create table SYS_SMS_CONFIG
(
   ID                   int not null comment 'ID',
   SMS_MODE             char comment '1:����èģʽ��2������ƽ̨ģʽ',
   SMS_PORT             varchar(30) comment 'д��COM1��COM2��COM3��',
   SMS_PLAT_ADDR        varchar(100) comment '����ƽ̨��ַ',
   SMS_PLAT_APPKEY      varchar(30) comment '����ƽ̨appkey',
   SMS_PLAT_SECRET      varchar(60) comment '����ƽ̨secret',
   SMS_PLAT_SIGNATURE   varchar(30) comment '����ƽ̨ǩ��',
   SMS_PLAT_TEMPLATE_CODE varchar(30) comment '����ƽ̨ģ�����',
   SMS_SERVICE_STATUS   char comment '0��ֹͣ����״̬��1�����÷���״̬',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table SYS_SMS_CONFIG comment 'ϵͳ���ŷ������ñ�';

/*==============================================================*/
/* Table: SYS_THRESHOLD_CONFIG                                  */
/*==============================================================*/
create table SYS_THRESHOLD_CONFIG
(
   ID                   int not null comment 'ID',
   THRESHOLD_NAME       varchar(50) comment '��ֵ����',
   THRESHOLD_VALUE      int comment '��ֵ',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table SYS_THRESHOLD_CONFIG comment 'ϵͳ��ֵ���ñ�';

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create table USERS
(
   ID                   int not null comment 'ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   USER_NAME            varchar(30) comment '�û�����',
   ROLE_ID              int comment '1:ϵͳ����Ա��2����ͨ����Ա��3����ͨ�û�',
   MOBILE               varchar(30) comment '�ֻ�����',
   EMAIL                varchar(50) comment '�����ַ',
   EMAIL_SUBSCRIBE_ONOFF char comment '0���أ�1����',
   SMS_SUBSCRIBE_ONOFF  char comment '0���أ�1����',
   STATUS               char comment '0:ͣ�ã�1������',
   CREATE_TIME          datetime comment '����ʱ��',
   MODIFY_TIME          datetime comment '�޸�ʱ��',
   primary key (ID)
);

alter table USERS comment '�û���';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_CONN_EVENT                             */
/*==============================================================*/
create table USER_SUBSCRIBE_CONN_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '�û�ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   DATABASE_ID          int comment '���ݿ�����ID',
   ALL_FLAG             char comment '1�����мܹ��ȶ�',
   CREATE_TIME          datetime comment '����ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table USER_SUBSCRIBE_CONN_EVENT comment '�û����ݿ����Ӹ澯�¼����ı�';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_DATACOMPARE_EVENT                      */
/*==============================================================*/
create table USER_SUBSCRIBE_DATACOMPARE_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '�û�ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   COMPARE_FLAG         char comment '1���Ƚ��飬2���Ƚ϶�',
   COMPARE_ID           int comment '�Ƚ����Ƚ϶�ID',
   ALL_FLAG             char comment '1:ѡ�����бȽ���',
   CREATE_TIME          datetime comment '����ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table USER_SUBSCRIBE_DATACOMPARE_EVENT comment '�û����ݱȶԸ澯�¼����ı�';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_DATACOMPARE_REPORT                     */
/*==============================================================*/
create table USER_SUBSCRIBE_DATACOMPARE_REPORT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '�û�ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   COMPARE_FLAG         char comment '1���Ƚ��飬2���Ƚ϶�',
   COMPARE_ID           int comment '�Ƚ����Ƚ϶�ID',
   ALL_FLAG             char comment '1:ѡ�����бȽ���',
   CREATE_TIME          datetime comment '����ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table USER_SUBSCRIBE_DATACOMPARE_REPORT comment '�û����ݱȶԱ��涩�ı�';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_SCHEMACOMPARE_EVENT                    */
/*==============================================================*/
create table USER_SUBSCRIBE_SCHEMACOMPARE_EVENT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '�û�ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   SCHEMA_COMPARE_ID    int comment '�ܹ��ȶ�ID',
   ALL_FLAG             char comment '1�����мܹ��ȶ�',
   CREATE_TIME          datetime comment '����ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table USER_SUBSCRIBE_SCHEMACOMPARE_EVENT comment '�û��ܹ��ȶԸ澯�¼����ı�';

/*==============================================================*/
/* Table: USER_SUBSCRIBE_SCHEMACOMPARE_REPORT                   */
/*==============================================================*/
create table USER_SUBSCRIBE_SCHEMACOMPARE_REPORT
(
   ID                   int not null comment 'ID',
   USER_ID              int comment '�û�ID',
   USER_ACCOUNT         varchar(30) comment '�û��ʺ�',
   SCHEMA_COMPARE_ID    int comment '�ܹ��ȶ�ID',
   ALL_FLAG             char comment '1�����мܹ��ȶ�',
   CREATE_TIME          datetime comment '����ʱ��',
   USER_NAME            varchar(30) comment '������',
   primary key (ID)
);

alter table USER_SUBSCRIBE_SCHEMACOMPARE_REPORT comment '�û��ܹ��ȶԱ��涩�ı�';

