/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst Jobs from this query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills.
    helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_10_paying_jobs AS
(
Select 
    job_id,
    job_title,
    companies.name as company_name,
    salary_year_avg
From 
    job_postings_fact
Left Join 
    company_dim as companies on job_postings_fact.company_id = companies.company_id
Where 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'        AND
    salary_year_avg is not null
Order BY
    salary_year_avg DESC
LIMIT 10
)
Select 
    top_10_paying_jobs.*,
    skills.skills
From top_10_paying_jobs
INNER JOIN skills_job_dim as skills_to_job on top_10_paying_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Order by top_10_paying_jobs.salary_year_avg desc