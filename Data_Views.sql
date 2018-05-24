-- Bounce DE - update 
select 
a.AccountID
,a.OYBAccountID					
,a.JobID							
,a.ListID							
,a.BatchID							
,a.SubscriberID					
,a.SubscriberKey					
,a.EventDate						
,a.IsUnique						
,a.Domain							
,a.BounceCategoryID				
,a.BounceCategory					
,a.BounceSubcategoryID				
,a.BounceSubcategory				
,a.BounceTypeID					
,a.BounceType						
,left(a.smtpbouncereason, 4000) as [smtpbouncereason]
,left(a.SMTPMessage, 4000)	as [SMTPMessage]			
,a.SMTPCode						
,a.TriggererSendDefinitionObjectID
,a.TriggeredSendCustomerKey	
from _Bounce a
left join Bounce b on a.subscriberkey = b.subscriberkey
where b.subscriberkey is null 
and b.EventDate is null

-- Click DE - update
select
  x.AccountID
, x.Jobid
, x.domain
, x.SubscriberKey
, x.SubscriberID
, x.ListID
, x.EventDate
, x.BatchID
, x.isUnique
, x.URL
, x.linkName
, x.LinkContent
, x.TriggererSendDefinitionObjectID
, x.TriggeredSendCustomerKey
from (
    select
          e.AccountID
        , e.Jobid
        , e.domain
        , e.SubscriberKey
        , e.SubscriberID
        , e.ListID
        , e.EventDate
        , e.BatchID
        , e.isUnique 
        , e.URL
        , e.linkName
        , e.LinkContent
        , e.TriggererSendDefinitionObjectID
        , e.TriggeredSendCustomerKey
        , row_number() over(partition by e.jobid, e.subscriberid, e.LinkContent order by e.eventDate desc) row
    from _Click e
    where
    e.jobid is not null
    and e.eventDate is not null
    and e.SubscriberID is not null
    and e.ListID is not null
    and e.BatchID is not null
    and e.subscriberid not in (
        select
        t.SubscriberID
        from Click t
        where  t.AccountID	 = e.AccountID
and t.OYBAccountID = e.OYBAccountID
and t.JobID = e.JobID
and t.ListID = e.ListID
and t.BatchID = e.BatchID
and t.SubscriberID = e.SubscriberID
and t.SubscriberKey = e.SubscriberKey
and t.EventDate = e.EventDate
and t.Domain = e.Domain
and t.URL = e.URL
and t.LinkName = e.LinkName
and t.LinkContent = e.LinkContent
and t.IsUnique = e.IsUnique
and t.TriggererSendDefinitionObjectID = e.TriggererSendDefinitionObjectID
and t.TriggeredSendCustomerKey = e.TriggeredSendCustomerKey

     )
) x
where x.row = 1





-- Complaint - update

select
a.AccountID		
,a.OYBAccountID	
,a.JobID			
,a.ListID			
,a.BatchID			
,a.SubscriberID	
,a.SubscriberKey	
,a.EventDate		
,a.IsUnique		
,a.Domain			
from _Complaint a
left join Complaint b on a.subscriberkey = b.subscriberkey
where b.subscriberkey is null 
and b.EventDate is null


-- Coupon
select * from _Coupon

-- FTAF
select * from _FTAF

--  Job
select * from _Job
where jobid not in ( select jobid from Job)

-- Open
select
x.AccountID						
, x.OYBAccountID					
, x.JobID							
, x.ListID							
, x.BatchID							
, x.SubscriberID					
, x.SubscriberKey					
, x.EventDate						
, x.Domain							
, x.IsUnique						
, x.TriggererSendDefinitionObjectID	
, x.TriggeredSendCustomerKey			
from (
    select
    e.AccountID						
	, e.OYBAccountID					
	, e.JobID							
	, e.ListID							
	, e.BatchID							
	, e.SubscriberID					
	, e.SubscriberKey					
	, e.EventDate						
	, e.Domain							
	, e.IsUnique						
	, e.TriggererSendDefinitionObjectID	
	, e.TriggeredSendCustomerKey
    , row_number() over(partition by e.jobid, e.subscriberid order by e.eventDate desc) row
   	from _Open e
    where
    e.jobid is not null
    and e.eventDate is not null
    and e.SubscriberID is not null
    and e.ListID is not null
    and e.BatchID is not null
    and e.subscriberid not in (
        select o.subscriberid
        from [Open] o
        where o.jobid = e.jobid
        and o.subscriberid = e.subscriberid
        and o.eventdate = e.eventdate
    )
    
) x
where x.row = 1

-- Sent
select
x.AccountID
, x.OYBAccountID
, x.JobID
, x.ListID
, x.BatchID
, x.SubscriberID
, x.SubscriberKey
, x.EventDate
, x.Domain
, x.TriggererSendDefinitionObjectID
, x.TriggeredSendCustomerKey		
from (
	select
    e.AccountID
	, e.OYBAccountID
	, e.JobID
	, e.ListID
	, e.BatchID
	, e.SubscriberID
	, e.SubscriberKey
	, e.EventDate
	, e.Domain
	, e.TriggererSendDefinitionObjectID
	, e.TriggeredSendCustomerKey
    , row_number() over(partition by e.jobid, e.subscriberid order by e.eventDate desc) row
   	from _Sent e
    where
    e.jobid is not null
    and e.eventDate is not null
    and e.SubscriberID is not null
    and e.ListID is not null
    and e.BatchID is not null
    and e.subscriberid not in (
        select o.subscriberid
        from [Sent] o
        where o.jobid = e.jobid
        and o.subscriberid = e.subscriberid
        and o.eventdate = e.eventdate
    )
    
) x
where x.row = 1


-- Subscribers
select * from _Subscribers e
where   e.subscriberid not in (
        select o.subscriberid
        from [Subscribers] o
    )

-- UndeliverableSMS
select * from _UndeliverableSMS e
where   e.subscriberid not in (
        select o.subscriberid
        from [UndeliverableSMS] o
    )

-- Unsubscribe
select * from _Unsubscribe e
where   e.subscriberid not in (
        select o.subscriberid
        from [Unsubscribe] o
    )

-- Journey - overwrite
select * from _Journey 

-- Journey Activity - overwrite
select * from _JourneyActivity 

-- MobileSubscription - overwrite
SELECT 
_CreatedBy AS CreatedBy,
_OptOutMethodID AS OptOutMethodID,
_MobileNumber AS MobileNumber,
_OptInDate AS OptInDate,
_Source AS Source,
_OptOutStatusID AS OptOutStatusID,
_OptOutDate AS OptOutDate,
_ModifiedBy AS ModifiedBy,
_SourceObjectId AS SourceObjectId,
_SubscriptionDefinitionID AS SubscriptionDefinitionID,
_CreatedDate AS CreatedDate,
_OptInStatusID AS OptInStatusID,
_OptInMethodID AS OptInMethodID,
_ModifiedDate AS ModifiedDate
FROM _MobileSubscription

