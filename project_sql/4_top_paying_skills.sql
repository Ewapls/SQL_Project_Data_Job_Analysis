/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analyst and
    helps identify the most financially rewarding skills to acquire or improve
*/

Select 
    skills.skills as skill_name,
    round(avg(job_postings_fact.salary_year_avg), 0)  as avg_salary
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner Join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where   
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg is not null
        AND job_postings_fact.job_work_from_home = True
Group by 
    skill_name
Order by avg_salary desc
Limit 25