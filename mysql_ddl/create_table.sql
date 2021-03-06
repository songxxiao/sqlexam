create table account_admin
(
    id                    int auto_increment    primary key,
    password              varchar(255)                 null,
    pwd_md5               varchar(32)                  null,
    name                  varchar(255)                 not null comment '名字',
    mail                  varchar(100)  default ''     not null,
    company_name          varchar(255)  default ''     not null comment '公司名',
    manager               varchar(255)  default ''     not null,
    status                int           default 0      not null,
    phone                 varchar(100)                 not null,
    qq                    varchar(255)                 not null,
    we_chat               varchar(255)  default ''     not null,
    comment               text                         not null,
    sys_admin             int(2)        default 0      null,
    balance               double(20, 4) default 0.0000 not null comment '账户余额',
    usable_balance        double(20, 4) default 0.0000 not null comment '账户可用余额',
    all_cost              double(20, 4) default 0.0000 not null comment '素材交易平台账户总消耗',
    wx_open_id            varchar(255)  default ''     not null comment '微信公众号openid',
    head                  varchar(255)                 not null comment '头像',
    province              varchar(255)                 not null comment '省',
    city                  varchar(255)                 not null comment '城市',
    speciality            varchar(2000)                not null comment '特长',
    work_url              varchar(5000)                not null comment '作品',
    license_url           varchar(255)                 not null comment '营业执照',
    license_code          varchar(255)  default ''     not null comment '营业执照编码',
    identity_card_url     varchar(255)                 not null comment '身份证',
    able_withdraw_balance double(20, 4)                not null comment '可提现金额',
    income                double(20, 4)                not null comment '收入',
    company_type          int                          not null comment '公司类型',
    authority             varchar(255)                 not null comment '功能权限，1：智投，2：视界',
    create_time           timestamp                    null,
    update_time           timestamp                    null on update CURRENT_TIMESTAMP,
    sign_agreement        int           default 2      not null comment '是否签订了用户协议',
    permission_outsource  int                          not null comment '可以拥有外包权限，1：可以',
    supervisor_company    int                          not null comment '上级公司，不为0表示外包公司',
    is_test               int           default 0      not null,
    deliver_tag           int           default 0      not null comment '指派标签',
    score                 double(20, 2) default 0.00   not null comment '分数',
    business_license      varchar(2048) default ''     null comment '营业执照',
    domain_prefix         varchar(100)  default ''     not null,
    create_id             int           default 0      not null comment '创建来源',
    create_creator_limit  int           default 0      not null comment '创建创作团队数量限制',
    role_template         varchar(128)  default ''     not null comment '项目素材共享权限',
    adv_url               varchar(2048)                null comment '前端页面url，可用于灰度发布',
    company_property      text                         null comment '功能配置',
    constraint mail
        unique (mail)
)
    comment '后台管理员用户表' charset = utf8mb4;

-- ------------------------------------------------------------------------------------------

CREATE TABLE `ad_unit` (
  `company_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `vendor_id` bigint(20) NOT NULL,
  `vendor_account_id` bigint(20) NOT NULL,
  `campaign_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `campaign_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `ad_unit_id` bigint(20) NOT NULL,
  `ad_unit_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `ad_unit_status` bigint(20) NOT NULL,
  `ad_unit_ocpx_action_type` bigint(20) NOT NULL,
  `ad_unit_bid_type` bigint(20) NOT NULL,
  `ad_unit_cpa_bid` bigint(20) NOT NULL,
  `ad_unit_bid` bigint(20) NOT NULL,
  `ad_unit_budget_type` bigint(20) NOT NULL,
  `ad_unit_day_budget` bigint(20) NOT NULL,
  `ad_unit_week_budget` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `target_type` bigint(20) NOT NULL,
  `cost_sum` bigint(20) NOT NULL,
  `impression_sum` bigint(20) NOT NULL,
  `click_sum` bigint(20) NOT NULL,
  `content_impression_sum` bigint(20) NOT NULL,
  `content_click_sum` bigint(20) NOT NULL,
  `app_activation_sum` bigint(20) NOT NULL,
  `app_activation_cost` bigint(20) NOT NULL,
  `app_activation_rate` bigint(20) NOT NULL,
  `app_register_sum` bigint(20) NOT NULL,
  `app_register_cost` bigint(20) NOT NULL,
  `app_register_rate` bigint(20) NOT NULL,
  `app_pay_amount_sum` bigint(20) NOT NULL,
  `app_pay_cost` bigint(20) NOT NULL,
  `app_pay_sum` bigint(20) NOT NULL,
  `form_count_sum` bigint(20) NOT NULL,
  `form_cost` bigint(20) NOT NULL,
  `cost_p_1d` bigint(20) NOT NULL,
  `cost_p_7d` bigint(20) NOT NULL,
  `impression_p_7d` bigint(20) NOT NULL,
  `click_p_7d` bigint(20) NOT NULL,
  `contentImpression_p_7d` bigint(20) NOT NULL,
  `content_click_p_7d` bigint(20) NOT NULL,
  `app_activation_p_7d` bigint(20) NOT NULL,
  `app_register_p_7d` bigint(20) NOT NULL,
  `app_pay_p_7d` bigint(20) NOT NULL,
  `app_download_start_p_7d` bigint(20) NOT NULL,
  `app_download_complete_p_7d` bigint(20) NOT NULL,
  `form_count_p_7d` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

