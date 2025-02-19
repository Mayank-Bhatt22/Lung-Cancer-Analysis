# creating database and table to add the data
CREATE DATABASE Lungcancer;
USE Lungcancer;
CREATE TABLE lung_cancer_data (
    ID INT PRIMARY KEY,
    Country VARCHAR(255),
    Population_Size INT,
    Age INT,
    Gender VARCHAR(10),
    Smoker VARCHAR(3),
    Years_of_Smoking INT,
    Cigarettes_per_Day INT,
    Passive_Smoker VARCHAR(3),
    Family_History VARCHAR(3),
    Lung_Cancer_Diagnosis VARCHAR(3),
    Cancer_Stage VARCHAR(50),
    Survival_Years INT,
    Adenocarcinoma_Type VARCHAR(50),
    Air_Pollution_Exposure VARCHAR(10),
    Occupational_Exposure VARCHAR(3),
    Indoor_Pollution VARCHAR(3),
    Healthcare_Access VARCHAR(50),
    Early_Detection VARCHAR(3),
    Treatment_Type VARCHAR(50),
    Developed_or_Developing VARCHAR(50),
    Annual_Lung_Cancer_Deaths INT,
    Lung_Cancer_Prevalence_Rate FLOAT,
    Mortality_Rate FLOAT
);

# to see that all the data is posted correctly
SELECT * FROM lung_cancer_data;

# to send all the data from excel file to database 
SELECT @@secure_file_priv;
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lung_cancer_Dataset.csv'
INTO TABLE lung_cancer_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# to see the data 
SELECT * FROM lung_cancer_data;

# QUESTION AND THERE ANSWER 

# (PART 1 Basic Level)

# 1. Retrieve all records for individuals diagnosed with lung cancer.
SELECT * FROM lung_cancer_data 
WHERE Lung_Cancer_Diagnosis = 'Yes';

# 2. Count the number of smokers and non-smokers.
SELECT Smoker, COUNT(*) AS Count FROM lung_cancer_data 
GROUP BY Smoker;

# 3. List all unique cancer stages present in the dataset.
SELECT DISTINCT Cancer_Stage FROM lung_cancer_data;

# 4. Retrieve the average number of cigarettes smoked per day by smokers.
SELECT AVG(Cigarettes_per_Day) AS Avg_Cigs_Per_Day FROM lung_cancer_data 
WHERE Smoker = 'Yes';

# 5. Count the number of people exposed to high air pollution.
SELECT COUNT(*) AS High_Air_Pollution_Count FROM lung_cancer_data 
WHERE Air_Pollution_Exposure = 'High';

# 6. Find the top 5 countries with the highest lung cancer deaths.
SELECT Country, SUM(Annual_Lung_Cancer_Deaths) AS Total_Deaths FROM lung_cancer_data 
GROUP BY Country ORDER BY Total_Deaths DESC LIMIT 5;

# 7. Count the number of people diagnosed with lung cancer by gender.
SELECT Gender, COUNT(*) AS Count FROM lung_cancer_data 
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Gender;

# 8. Retrieve records of individuals older than 60 who are diagnosed with lung cancer.
SELECT * FROM lung_cancer_data 
WHERE Age > 60 AND Lung_Cancer_Diagnosis = 'Yes';

# (PART 2 Intermediate Level)

# 1. Find the percentage of smokers who developed lung cancer. (I used chatgpt for this one )
SELECT 
	(COUNT(CASE WHEN Lung_Cancer_Diagnosis = 'Yes' AND Smoker = 'Yes' THEN 1 END) * 100.0 / 
    COUNT(CASE WHEN Smoker = 'Yes' THEN 1 END)) AS Percentage_Smokers_With_Cancer
FROM lung_cancer_data;

# 2. Calculate the average survival years based on cancer stages.
SELECT Cancer_Stage, AVG(Survival_Years) AS Avg_Survival_Years FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Cancer_Stage;

# 3. Count the number of lung cancer patients based on passive smoking.
SELECT Passive_Smoker, COUNT(*) AS Cancer_Patient_Count FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Passive_Smoker;

# 4. Find the country with the highest lung cancer prevalence rate.
SELECT Country, MAX(Lung_Cancer_Prevalence_Rate) AS Max_Prevalence_Rate FROM lung_cancer_data
GROUP BY Country ORDER BY Max_Prevalence_Rate DESC LIMIT 1;

# 5. Identify the smoking years' impact on lung cancer.
SELECT Years_of_Smoking, COUNT(*) AS Cancer_Patient_Count FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Years_of_Smoking
ORDER BY Years_of_Smoking DESC;

# 6. Determine the mortality rate for patients with and without early detection.
SELECT Early_Detection, AVG(Mortality_Rate) AS Avg_Mortality_Rate FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Early_Detection;

# 7. Group the lung cancer prevalence rate by developed vs. developing countries.
SELECT Developed_or_Developing, AVG(Lung_Cancer_Prevalence_Rate) AS Avg_Prevalence_Rate FROM lung_cancer_data
GROUP BY Developed_or_Developing;

# (PART 3 Advanced Level)

# 1. Identify the correlation between lung cancer prevalence and air pollution levels.
SELECT Air_Pollution_Exposure, AVG(Lung_Cancer_Prevalence_Rate) AS Avg_Prevalence_Rate FROM lung_cancer_data
GROUP BY Air_Pollution_Exposure ORDER BY Avg_Prevalence_Rate DESC;

# 2. Find the average age of lung cancer patients for each country.
SELECT Country, AVG(Age) AS Avg_Age FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Country ORDER BY Avg_Age DESC;

# 3. Calculate the risk factor of lung cancer by smoker status, passive smoking, and family history.
SELECT Smoker, Passive_Smoker, Family_History, COUNT(*) AS Cancer_Cases FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Smoker, Passive_Smoker, Family_History ORDER BY Cancer_Cases DESC;

# 4. Rank countries based on their mortality rate.
SELECT Country, AVG(Mortality_Rate) AS Avg_Mortality_Rate FROM lung_cancer_data
GROUP BY Country ORDER BY Avg_Mortality_Rate DESC;

# 5. Determine if treatment type has a significant impact on survival years.
SELECT Treatment_Type, AVG(Survival_Years) AS Avg_Survival_Years FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Treatment_Type ORDER BY Avg_Survival_Years DESC;

# 6. Compare lung cancer prevalence in men vs. women across countries.
SELECT Country, Gender, COUNT(*) AS Cancer_Cases FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Country, Gender ORDER BY Country, Cancer_Cases DESC;

# 7. Find how occupational exposure, smoking, and air pollution collectively impact lung cancer rates.
SELECT Occupational_Exposure, Smoker, Air_Pollution_Exposure, COUNT(*) AS Cancer_Cases FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Occupational_Exposure, Smoker, Air_Pollution_Exposure ORDER BY Cancer_Cases DESC;

# 8. Analyze the impact of early detection on survival years.
SELECT Early_Detection, AVG(Survival_Years) AS Avg_Survival_Years FROM lung_cancer_data
WHERE Lung_Cancer_Diagnosis = 'Yes' GROUP BY Early_Detection ORDER BY Avg_Survival_Years DESC;

# I guess completing LeetCode SQL 50 and earning 4 stars on HackerRank in SQL has paid off!