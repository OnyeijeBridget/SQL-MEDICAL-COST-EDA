                      --- Exploratory Data Analysis OF THE MEDICAL_COST DATASET---

--- AIM: To find out the impact the following variables: age, sex, bmi, children, smoker, region, 
---      have on medical charges incurred by  patients.

--- number of patients, total medical charge, average medical charge, number of regions, average age, average bmi
SELECT 
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge,
    COUNT(DISTINCT region) Number_of_Regions,
    AVG(age) Average_Age,
    AVG(bmi) Average_BMI,
    SUM(children) Number_of_Children
FROM
    medical_cost
;

---- IMPACT BY REGION: The queries below explore the impact the different regions have on medical charges. 

---- patients by region (number of patients in each region and their impact on charges)
SELECT 
    region,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY region
ORDER BY Average_Medical_Charge DESC
;

--- region and gender  (explains the impact the gender in each region has on the medical charges incurred)
 SELECT 
    region,
    gender,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY region,
         gender
ORDER BY Number_of_Patients DESC, 
         Average_Medical_Charge DESC
;

--- region and smokers (what impact does smoking or not smoking have on patients medical charge?)
SELECT 
    region,
    smoker,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY region, 
         smoker
ORDER BY Average_Medical_Charge DESC
;

---- region and children (does having kids increase your medical charges? and 
---                       does the number of kids have play a role)
SELECT 
    region,
    children,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY region, 
         children
ORDER BY Number_of_Children DESC, 
         Average_Medical_Charge DESC
LIMIT 10         
;


--- IMPACT OF GENDER

---- number of patients by gender (does gender impact medical charges?)
SELECT 
    gender,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY gender
ORDER BY Average_Medical_Charge DESC
;

-- gender and region (does smoking and a patients gender impact his/her medical charges?)
SELECT 
    gender,
    region,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY gender, 
         region
ORDER BY Average_Medical_Charge DESC
;

--- gender and smoking (does smoking and a patients gender impact his/her medical charges?)
SELECT 
    gender,
    smoker,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY gender, 
         smoker
ORDER BY Average_Medical_Charge DESC
;

--- gender and age (does gender and a patients age group impact his/her medical charges?)
SELECT 
    gender,
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 39 THEN '21-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        WHEN age >= 60 THEN '60 and above'
    END AS Age_Group,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY gender, 
         Age_Group
ORDER BY Average_Medical_Charge DESC
;


--- gender and bmi (does gender and a patients bmi impact his/her medical charges?)
SELECT 
    gender,
    CASE
         WHEN bmi < 16 THEN 'less than 16.0'
        WHEN bmi BETWEEN 16 AND 18.4 THEN '16.0-18.4'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN '18.5-24.9'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN '25.0-29.9'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN '30.0-34.9'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN '35.0-39.9'
        WHEN bmi >= 40.0 THEN '>=40.0'
    END AS BMI_Group,
    CASE
        WHEN bmi < 16 THEN 'Severly Underweight'
        WHEN bmi BETWEEN 16 AND 18.4 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN 'Moderately Obese'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN 'Severly Obese'
        WHEN bmi >= 40.0 THEN 'Morbidly Obese'
    END AS BMI_Category,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY gender,
         BMI_Group,
         BMI_Category
ORDER BY Average_Medical_Charge DESC
;


--- IMPACT OF SMOKING: The codes below explore the impact smoking has on medical charges. 

---- patients that smoke and do not smoke 
SELECT 
    smoker,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY smoker
ORDER BY Average_Medical_Charge DESC
;

---- smoking and gender
SELECT 
    smoker,
    gender,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY smoker,
		 gender
ORDER BY Average_Medical_Charge DESC
;

--- smoking within each age_group (how many smokers and non-smokers fall within each age group, 
--- and how does it impact medical charges?)

SELECT 
    smoker,
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 39 THEN '21-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        WHEN age >= 60 THEN '60 and above'
    END AS Age_Group,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY smoker, 
         age_group
ORDER BY Average_Medical_Charge DESC
;

--- smoking and bmi (how does smoking affect the bmi of a patient, 
---					and how does it impact medical charges?)

SELECT 
    smoker,
    CASE
        WHEN bmi < 16 THEN 'less than 16.0'
        WHEN bmi BETWEEN 16 AND 18.4 THEN '16.0-18.4'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN '18.5-24.9'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN '25.0-29.9'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN '30.0-34.9'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN '35.0-39.9'
        WHEN bmi >= 40.0 THEN '>=40.0'
    END AS BMI_Group,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY smoker , BMI_Group
ORDER BY Average_Medical_Charge DESC
;

--- IMPACT OF BMI: The codes below explore the impact Body Mass Index has on medical charges. 

---- patients average BMI (AVG BMI of 1338 patients)
SELECT 
    AVG(bmi)
FROM
    medical_cost;
    

--- BMI groups and categories according to WHO
SELECT 
    CASE
        WHEN bmi < 16 THEN 'less than 16'
        WHEN bmi BETWEEN 16 AND 18.4 THEN '16.0-18.4'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN '18.5-24.9'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN '25.0-29.9'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN '30.0-34.9'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN '35.0-39.9'
        WHEN bmi >= 40.0 THEN '>=40'
    END AS BMI_Groups,
    CASE
        WHEN bmi <16 THEN 'severly underweight'
        WHEN bmi BETWEEN 16 AND 18.4 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN 'Moderately Obese'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN 'Severly Obese'
        WHEN bmi >= 40.0 THEN 'Morbidly Obese'
    END AS BMI_Category,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY BMI_Groups , BMI_Category
ORDER BY Average_Medical_Charge DESC
;

--- age and bmi impact (how does a patients age and bmi impact his medical charges?)
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 39 THEN '21-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        WHEN age >= 60 THEN '60 and above'
    END AS Age_Groups,
    CASE
        WHEN bmi < 16 THEN 'less than 16'
        WHEN bmi BETWEEN 16 AND 18.4 THEN '16.0-18.4'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN '18.5-24.9'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN '25.0-29.9'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN '30.0-34.9'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN '35.0-39.9'
        WHEN bmi >= 40.0 THEN '>=40'
    END AS BMI_Groups,
    CASE
        WHEN bmi < 16 THEN 'Severly Underweight'
        WHEN bmi BETWEEN 16 AND 18.4 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25.0 AND 29.9 THEN 'Overweight'
        WHEN bmi BETWEEN 30.0 AND 34.9 THEN 'Moderately Obese'
        WHEN bmi BETWEEN 35.0 AND 39.9 THEN 'Severly Obese'
        WHEN bmi >= 40.0 THEN 'Morbidly Obese'
    END AS BMI_Category,
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY Age_Groups, 
         BMI_Groups, 
         BMI_Category
ORDER BY Average_Medical_Charge DESC
LIMIT 10
;

---- impact of region and bmi on medical charges
SELECT 
    region,
    AVG(bmi),
    COUNT(Id) Number_of_Patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY region
ORDER BY Average_Medical_Charge DESC
;
   

 --- IMPACT OF AGE (Does a particular age demograhic pay less or more? 
---                 Also, how does in combination with other variables affect patients medical charges?) 
 
 --- average age of patients
 SELECT 
    ROUND(AVG(age))
FROM
    medical_cost
;
 
 --- average age per region
 SELECT 
    region, 
    ROUND(AVG(age))
FROM
    medical_cost
GROUP BY region
;


--- medical charges per age groups
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 39 THEN '21-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        WHEN age >= 60 THEN '60 and above'
    END AS Age_Group,
    CASE
        WHEN age BETWEEN 18 AND 20 THEN 'Young Adult'
        WHEN age BETWEEN 21 AND 39 THEN 'Adult'
        WHEN age BETWEEN 40 AND 59 THEN 'Middle Aged Adult'
        WHEN age >= 60 THEN 'Senior Citizen'
    END AS Categorization,
    COUNT(id) number_of_patients,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY Age_Group, 
         Categorization
ORDER BY Average_Medical_Charge DESC
;

--- IMPACT OF CHILDREN (Does having kids increase or decrease the bills incurred by patients?)

--- Number of children conceived by patients 
SELECT 
    SUM(children) Number_of_Children
FROM
    medical_cost
;
 
 
--- relationship between children, patients, and charges
SELECT 
    children, 
    COUNT(Id) Number_Of_Patients, 
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY 
   children
ORDER BY 
   Average_Medical_Charge DESC,
   SUM(children) DESC
;

--- impact conceived children and gender have on medical charges
SELECT 
    children,
    gender,
    COUNT(Id) Number_of_Patients,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY children,
         gender
ORDER BY Average_Medical_Charge DESC, 
         SUM(children) DESC
;
  
  
  --- impact children and smoking had on medical charges
  SELECT 
    children,
    smoker,
    COUNT(Id) Number_of_Patients,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY children,
         smoker
ORDER BY Average_Medical_Charge DESC, 
         SUM(children) DESC
;

 --- impact children and age had on medical charges
  SELECT 
    children,
    age,
    COUNT(Id) Number_of_Patients,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY children,
         age
ORDER BY Average_Medical_Charge DESC
LIMIT 20
;

--- impact children, gender and age had on medical charges
  SELECT 
    children,
    gender,
    age,
    COUNT(Id) Number_of_Patients,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY children,
         gender,
         age
ORDER BY Average_Medical_Charge DESC
LIMIT 20
;

--- impact children and age group had on medical charges
  SELECT 
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age BETWEEN 21 AND 39 THEN '21-39'
        WHEN age BETWEEN 40 AND 59 THEN '40-59'
        WHEN age >= 60 THEN '60 and above'
    END AS Age_Group,
    COUNT(Id) Number_of_Patients,
    SUM(children) Number_of_Children,
    SUM(charges) Total_Medical_Charge,
    AVG(charges) Average_Medical_Charge
FROM
    medical_cost
GROUP BY children,
         Age_Group
ORDER BY Average_Medical_Charge DESC
LIMIT 20
;
