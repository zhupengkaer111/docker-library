-- ----------------------------
-- 设备数据表
-- ----------------------------
create table device_data
(
    device_id  bigint    not null,
    product_id bigint    not null,
    msg_type   int2      not null,
    key        varchar   not null,
    event_ts   timestamp WITHOUT TIME ZONE not null,
    update_ts  timestamp not null,
    bool_val   boolean,
    str_val    varchar,
    long_val   bigint,
    double_val double precision,
    json_val   json,
    "transaction_id" varchar COLLATE "pg_catalog"."default",
    CONSTRAINT ts_kv_pk PRIMARY KEY (device_id, key, event_ts)
);
-- ----------------------------
-- 转换成超表
-- ----------------------------
SELECT create_hypertable('device_data','event_ts');

-- ----------------------------
-- 每一天切分一个块
-- 根据实际情况修改
-- ----------------------------
SELECT set_chunk_time_interval('device_data', INTERVAL '1 day');

-- ----------------------------
-- 创建数据保留策略
-- 1 day 数据保留时间 （根据实际情况修改）
---返回一个ID
-- ----------------------------
SELECT add_retention_policy('device_data', INTERVAL '1 day');


-- ----------------------------
-- 设置每5分钟运行JOB,1007是SELECT add_retention_policy得出的结果
-- 1007 由上一步返回的 （需要根据实际情况进行修改）
--5 minutes 每5分钟执行一次（需要根据实际情况进行修改）
-- ----------------------------
SELECT alter_job(1000, schedule_interval => INTERVAL '5 minutes', next_start => '2020-03-15 09:00:00.0+00');

-- ----------------------------
-- 删除1天前的trunk
-- ----------------------------
SELECT drop_chunks('device_data', INTERVAL '1 day');



-- ----------------------------
-- 实时表
-- ----------------------------
create table device_data_rt
(
    device_id  bigint    not null,
    product_id bigint    not null,
    msg_type   int2      not null,
    key        varchar   not null,
    event_ts   timestamp WITHOUT TIME ZONE not null,
    update_ts  timestamp not null,
    bool_val   boolean,
    str_val    varchar,
    long_val   bigint,
    double_val double precision,
    json_val   json,
    CONSTRAINT kv_pk PRIMARY KEY (device_id, key)
);

-- auto-generated definition
create table device_log
(
    device_id  bigint    not null,
    product_id bigint    not null,
    key        varchar   not null,
    event_ts   timestamp not null,
    update_ts  timestamp not null,
    value      varchar,
    constraint device_log_kv_pk
        primary key (device_id, key, event_ts)
);

alter table device_log
    owner to ulm2;

create index device_log_event_ts_idx
    on device_log (event_ts desc);

