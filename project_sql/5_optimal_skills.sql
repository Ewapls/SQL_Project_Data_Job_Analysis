/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targests skills that offer job security (high demand) and financial benefits (high salaries),
        offering strategic insights for career development in data analysis
*/

WITH hight_demand_skills AS
(
Select 
    skills.skill_id,
    skills.skills               as skill_name,
    count(skills_to_job.job_id) as skill_in_jobs_count
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner Join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg is not null AND
        job_postings_fact.job_work_from_home = True
Group by 
    skills.skill_id
), high_average_salary as
(
Select 
    skills.skill_id,
    skills.skills as skill_name,
    round(avg(job_postings_fact.salary_year_avg), 0)  as avg_salary
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner Join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where   
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg is not null AND 
        job_postings_fact.job_work_from_home = True
Group by 
    skills.skill_id
)

Select 
    hight_demand_skills.skill_id,
    hight_demand_skills.skill_name,
    hight_demand_skills.skill_in_jobs_count as skill_demand_count,
    high_average_salary.avg_salary as skill_salary_high_demand
From hight_demand_skills 
Inner Join high_average_salary on hight_demand_skills.skill_id = high_average_salary.skill_id
Where hight_demand_skills.skill_in_jobs_count > 10
Order by 
    skill_salary_high_demand desc,
    skill_demand_count desc
Limit 25

-- Another more consice way
Select 
    skills.skill_id as skill_id,
    skills.skills as skill_name,
    count(skills_to_job.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg), 0) as avg_salary
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where 
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_work_from_home = True AND
    job_postings_fact.salary_year_avg is not null
Group by 
    skills.skill_id
Having
    count(skills_to_job.job_id) > 10
Order by 
    avg_salary desc,
    demand_count desc
Limit 25