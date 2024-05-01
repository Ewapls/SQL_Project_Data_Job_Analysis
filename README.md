# Introduction
🔬Dive into the data job market! Focusing on data analyst roles, this project explores 💸 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🤓 SQL queries? Let's check them out here: [project_sql folder](/project_sql/)

# Background
With the curiosity to know a little more about the data analyst job market more effectively, this project was born from that desire to look at top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
- **Power Bi:** For my data visualization in which you can dive into different data science rols not only Data Analyst, so you can get insights easily though visualizations and filters.

# The Analysis
Each query for this project aimed at investigating specific aspects of data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and locaiton, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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
    job_location = 'Anywhere'        AND
    salary_year_avg is not null
Order BY
    salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range** Top 10 paying data analyst roles span from $184,000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\top_paying_jobs_query1.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT 🤖 generated this graph from my SQL query results*


### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

![Top Paying Roles](assets\query_3.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analytics; Chat GPT 🤖 generated this graph from my SQL query results.*


### 3. In-Demand Skills For Data Analytics
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
Select 
        skills.skills               as skill_name,
        count(skills_to_job.job_id) as demand_count
From job_postings_fact
Inner Join skills_job_dim as skills_to_job on job_postings_fact.job_id = skills_to_job.job_id
Inner Join skills_dim as skills on skills_to_job.skill_id = skills.skill_id
Where job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.job_work_from_home = True
Group by skill_name
Order by demand_count desc
Limit 5
```

Here's the breakdown of the most demanded skills for data analysts in 2023:
- **SQL and Excel** remaining fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming and Visualization Tools** like Python, Tableau and Power Bi are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| skill_name | demand_count |
|------------|--------------|
| sql        | 7291         |
| excel      | 4611         |
| python     | 4330         |
| tableau    | 3745         |
| power bi   | 2609         |

*The top 5 most demanded skills for data analysts in 2023. *


### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

Here's the breakdown of the results for top paying skills for Data Analysts:
- **Emergence of Big Data Technologies:** Skills like PySpark, Databricks, and Elasticsearch are among the top-paying skills. 
- **Cloud Computing Skills in Demand:** Cloud platforms like GCP (Google Cloud Platform) and related services such as Kubernetes are highly valued skills in top-paying data analyst jobs. 
- **Focus on Data Science and Machine Learning:** Skills like Pandas, NumPy, and scikit-learn are among the top-paying skills, indicating a strong emphasis on data science and machine learning capabilities in the data analyst roles.

| skill_name      | avg_salary |
|-----------------|------------|
| pyspark         | 208172     |
| bitbucket       | 189155     |
| watson          | 160515     |
| couchbase       | 160515     |
| datarobot       | 155486     |
| gitlab          | 154500     |
| swift           | 153750     |
| jupyter         | 152777     |
| pandas          | 151821     |
| elasticsearch   | 145000     |

*Table of the average salary for the top 10 paying skills for data analysts*


### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

| skill_id | skill_name | demand_count | avg_salary |
|----------|------------|--------------|------------|
| 8        | go         | 27           | 115320     |
| 234      | confluence | 11           | 114210     |
| 97       | hadoop     | 22           | 113193     |
| 80       | snowflake  | 37           | 112948     |
| 74       | azure      | 34           | 111225     |
| 77       | bigquery   | 13           | 109654     |
| 76       | aws        | 32           | 108317     |
| 4        | java       | 17           | 106906     |
| 194      | ssis       | 12           | 106683     |
| 233      | jira       | 20           | 104918     |

*Table of the most optimal skills for data analyst sorted by salary*

Here's the breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and %100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.

- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis. 

- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highligh the critical role of data visualization and business intelligence in deriving actionable insights from data.

- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval and management expertise.

# What I Learned
Throughout this project, I've turbocharged my SQL toolkit with some serious firepower:

-**🧩 Complex Query Crafting:** Mastered the art of advanced SQL, marging tables and using WITH for the use of CTEs.

-**➕ Data Aggregation** Got cozy with GROUP BY and turned aggregate funcitons like COUNT() and AVG() into my data-summarizing sidekicks.

- **🤯 Analytical Thinking** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

- **🎨 Visualization Implementation** Adding a [Power Bi visualization](dashboard_DataScience_JobPosting.pbix) for leveling up my storytelling skill, also the visualization can apply to gain different insights not only about the role of Data Analyst.


# Clonclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries,the highest at $650,000!!!

2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs required advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary. 

3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.

4. **Skills with Higher Salaries**: Specialized skills, shuch as SVN and Solidity, are asoociated with the highest average salaries, indicating a premium on niche expertise.

5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
This project enhanced my SQL skills tackling some data from the real world and not one pre adjusted for practicing. Also, it gave me valuable insights into the data analyst job market which I'm looking forward to be a part of. All the finding from this analysis serve me as a guide to prioritize the optimal skills (high-demand and high-salary) to enter in this competitive job market. I even built a [dashboard](dashboard_DataScience_JobPosting.pbix) for anyone that wants to look for trends, skills and get insights for whatever data science rol you are striving.
