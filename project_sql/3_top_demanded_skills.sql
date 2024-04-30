/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
        providing insights into the most valuable skills for job seekers.
*/

Select 
        skills.skills               as skill_name,
        count(skills_to_job.job_id) as skill_in_jobs_count
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner Join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.job_work_from_home = True
Group by skill_name
Order by skill_in_jobs_count desc
Limit 5