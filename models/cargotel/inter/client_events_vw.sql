

select distinct
    "event_id" as event_id,
    "user_id" as user_id,
    client_events."id" as id,
    "username" as user_name,
    "cmt" as cmt,
    "client_id" as client_id,
    client_events."timestamp" as timestamp,
    "descr" as event_description,
    customer_name_vw.customer_name,
    customer_name_vw.customer_business
from vdp_datawarehouse_test.cargotel.client_events
left join
    vdp_datawarehouse_test.cargotel.client_events_ref
    on client_events_ref."id" = client_events."event_id"
left join
    (select distinct "id", "username" from vdp_datawarehouse_test.cargotel.users) users
    on users."id" = client_events."user_id"
left join
    vdp_datawarehouse_test.cargotel.customer_name_vw
    on customer_name_vw.cons_id = client_events."client_id"
