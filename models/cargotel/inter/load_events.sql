
with
    cuser as (select * from {{ ref("users") }}),
    ref_event as (select * from {{ ref("ref_event") }}),
    parent_loads as (select * from {{ ref("parent_loads") }}),
    child_loads as (select * from {{ ref("child_loads") }}),
    loads as (select * from {{ ref("parent_and_child_loads") }}),
    core as (
        select distinct
            a."user_added" as user_added,
            a."event_id" as event_id,

            a."load_id" as load_id,
            -- PARENT_CHILD_LOAD_MAP.parent_id as p_id,
            -- a."load_id" as load_id,
            a."user_id" as user_id,
            a."id" as event_unique_id,
            -- a."id" as id,
            a."cmt" as cmt,
            a."timestamp" as event_datetime,
            a."most_recent" as most_recent,
            cuser.username,
            cuser.groupname,
            loads.cons_id,

            ref_event."descr" as "descr"

        from vdp_datawarehouse_test.cargotel.load_events as a
        left join ref_event on (a."event_id" = ref_event."id")
        left join cuser on (a."user_id" = cuser.id)
        left join loads on (a."load_id" = loads.id)
    )
select
    user_added,
    event_id,
    load_id as event_load_id,
    b.parent_id as load_id,
    user_id,
    event_unique_id,
    cmt,
    event_datetime,
    most_recent,
    username,
    groupname,
    cons_id,
    "descr"
from core
left join
    vdp_datawarehouse_test.cargotel.parent_child_load_map b on (core.load_id = b.id)
