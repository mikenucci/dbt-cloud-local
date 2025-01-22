
{{ config(materialized='table') }}

with opportunity_overview as (
    select
        o.id as opp_id,
        a.id as account_id,
        a.name as account_name,
        o.name as opportunity_name,
        o.stage_name,
        o.stage_prior_to_closed_lost_c as stage_prior_to_closed_lost,
        u.name as account_owner,
        ur.name as account_owner_role,
        u1.name as opportunity_owner,
        ur1.name as opportunity_owner_role,
        u2.name as opportunity_sourced_by,
        ur2.name as opportunity_sourced_by_role,
        u3.name as opportunity_booked_by,
        ur3.name as opportunity_booked_by_role,
        u4.name as opportunity_created_by,
        ur4.name as opportunity_created_by_role,
        o.type as opp_type,
        a.type as account_type,
        o.close_date,
        round(o.annual_recurring_revenue_c,2) as arr,
        o.opportunity_source_c as opportunity_source,
        o.lead_source,
        o.lead_detail_c as lead_detail,
        a.last_zoom_activity_c as last_zoom_activity,
        o.price_per_agent_c as px_per_agent,
        o.link_to_how_to_win_doc_c as link_to_how_to_win_doc,
        o.loss_reason_c as loss_reason,
        o.loss_reason_details_c as loss_reason_details,
        date(o.created_date) as opp_create_date,
        round(o.amount, 2) as amount,
        round(o.number_of_agent_c, 0) as number_of_agents
    from salesforce.account as a
    inner join salesforce.opportunity as o on a.id = o.account_id
    inner join salesforce.user as u on a.owner_id = u.id
    inner join salesforce.user as u1 on o.owner_id = u1.id
    inner join salesforce.user as u2 on o.sourced_by_c = u2.id
    inner join salesforce.user as u3 on o.booked_by_c = u3.id
    inner join salesforce.user as u4 on o.created_by_id = u4.id
    inner join salesforce.user_role as ur on u.user_role_id = ur.id
    inner join salesforce.user_role as ur1 on u1.user_role_id = ur1.id
    inner join salesforce.user_role as ur2 on u2.user_role_id = ur2.id
    inner join salesforce.user_role as ur3 on u3.user_role_id = ur3.id
    inner join salesforce.user_role as ur4 on u4.user_role_id = ur4.id
)

select *
from opportunity_overview

