/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into 
*/

Select 
    job_id,
    job_title,
    companies.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
From 
    job_postings_fact
Left Join 
    company_dim as companies on job_postings_fact.company_id = companies.company_id
Where 
    job_title_short = 'Data Analyst' AND
    (job_location = 'Anywhere'       OR
    job_location like '%Peru%'     ) AND
    salary_year_avg is not null
Order BY
    salary_year_avg DESC
LIMIT 10