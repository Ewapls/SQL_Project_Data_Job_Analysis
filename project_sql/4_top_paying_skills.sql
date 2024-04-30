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

/*
Here is a breakdown of the results for top paying skills for Data Analysts.
- Emergence of Big Data Technologies: Skills like PySpark, Databricks, and Elasticsearch are among the top-paying skills. 
- Cloud Computing Skills in Demand: Cloud platforms like GCP (Google Cloud Platform) and related services such as Kubernetes 
    are highly valued skills in top-paying data analyst jobs. 
- Focus on Data Science and Machine Learning: Skills like Pandas, NumPy, and scikit-learn are among the top-paying skills, 
    indicating a strong emphasis on data science and machine learning capabilities in the data analyst roles.


[
  {
    "skill_name": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "watson",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill_name": "swift",
    "avg_salary": "153750"
  },
  {
    "skill_name": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skill_name": "pandas",
    "avg_salary": "151821"
  },
  {
    "skill_name": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skill_name": "golang",
    "avg_salary": "145000"
  },
  {
    "skill_name": "numpy",
    "avg_salary": "143513"
  },
  {
    "skill_name": "databricks",
    "avg_salary": "141907"
  },
  {
    "skill_name": "linux",
    "avg_salary": "136508"
  },
  {
    "skill_name": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "127000"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "126103"
  },
  {
    "skill_name": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skill_name": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skill_name": "notion",
    "avg_salary": "125000"
  },
  {
    "skill_name": "scala",
    "avg_salary": "124903"
  },
  {
    "skill_name": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skill_name": "gcp",
    "avg_salary": "122500"
  },
  {
    "skill_name": "microstrategy",
    "avg_salary": "121619"
  }
]

*/