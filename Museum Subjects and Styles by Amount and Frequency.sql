--This postgreSQL query creates a table that shows:
--the most frequently painted subject for each style of painting,
--how many paintings there were for the most frequently painted subject in that style,
--how many paintings there are in that style overall
--the percent of paintings in that style with the most frequent subject.
create table most_freq_subj_per_style as

with t as
(select subject.subject, work.style, 
(count(*) over (partition  by style)) as style_amount,
(count(*) over (partition by subject.subject)) as subject_amount,
(count(*) over (partition by subject.subject, style)) as subj_style_amount,
round((0.0+(count(*) over (partition by subject.subject, style)))/(count(*) over (partition  by style)),2) as subj_freq
from work
inner join subject on subject.work_id = work.work_id),

t_with_rn as
(select *,
row_number() over (partition by style order by subj_freq desc) as rn 
from t)

select subject
	,style
	,style_amount
	,subject_amount
	,subj_style_amount
	,subj_freq
from t_with_rn 
where rn = 1 and style is not null