-- 	Query 1: Who prefers energy drink more? (male/female/non-binary?)

SELECT dr.gender, count(dr.Gender) 
FROM dim_respondents as dr INNER JOIN
fact_survey_responses as fsr 
ON dr.Respondent_ID = fsr.Respondent_ID
GROUP BY dr.Gender;
  
    -- OR --
  
SELECT gender, COUNT(gender)
FROM dim_respondents
GROUP BY gender;

-- Query 2: Which age group prefers energy drinks more?

SELECT dr.Age, COUNT(fsr.Consume_frequency) AS EnergyDrinks
FROM dim_respondents as dr INNER JOIN
fact_survey_responses as fsr
ON dr.Respondent_ID = fsr.Respondent_ID
GROUP BY dr.Age ORDER BY EnergyDrinks DESC;  

	-- OR -- 

select Age, count(*) as Age_Prefrences
from dim_respondents
group by Age
order by Age_Prefrences desc;

-- Query 3: Which type of marketing reaches the most Youth (15-30)?

SELECT fsr.Marketing_Channels, 
COUNT(*) AS YouthReach_Count
FROM fact_survey_responses fsr
INNER JOIN dim_respondents dr  ON
fsr.Respondent_ID = dr.Respondent_ID
WHERE dr.Age IN ('15-18', '19-30')  
GROUP BY fsr.Marketing_Channels
ORDER BY YouthReach_Count DESC
LIMIT 1;

-- Query 4: Ingredients 

SELECT DISTINCT Ingredients_expected FROM fact_survey_responses;

-- Query 5: What are the preferred ingredients of energy drinks among respondents?

SELECT Ingredients_expected, COUNT(*) AS PreferredIngredients
FROM fact_survey_responses 
GROUP BY Ingredients_expected
ORDER BY PreferredIngredients DESC;

-- Query 6: What packaging preferences do respondents have for energy drinks?

SELECT DISTINCT packaging_preference FROM fact_survey_responses;

	-- OR -- 
    
SELECT packaging_preference, COUNT(*) AS PackageCount
FROM fact_survey_responses
GROUP BY Packaging_preference;

-- Query 7: Who are the current market leaders?

SELECT current_brands Brands, COUNT(*) Count
FROM fact_survey_responses 
GROUP BY Brands
ORDER BY Count DESC;

-- Query 8: What are the primary reasons consumers prefer those brands over ours?

SELECT DISTINCT reasons_for_choosing_brands FROM fact_survey_responses;

	-- OR --

SELECT Reasons_for_choosing_brands Brands,Count(*) CountBrands
FROM fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY CountBrands DESC;

-- Query 9: Which marketing channel can be used to reach more customers?

SELECT marketing_channels PreferredChannel, COUNT(*) Count
FROM fact_survey_responses
GROUP BY marketing_channels
ORDER BY Count DESC
LIMIT 1;

-- Query 10: What do people think about our brand? (overall rating)
 
SELECT taste_experience TasteExperience, COUNT(*) Count
FROM fact_survey_responses
GROUP BY TasteExperience
ORDER BY Count DESC;

	-- AND --

SELECT Brand_perception BrandRating, COUNT(*) Count
FROM fact_survey_responses
GROUP BY BrandRating
ORDER BY Count DESC;

-- Query 11: Which cities do we need to focus more on?

SELECT dc.city MoreFocusingCities, dc.Tier Tier, Count(dr.Respondent_ID) Count
FROM dim_cities dc INNER JOIN dim_respondents dr
ON dc.city_id = dr.city_id
GROUP BY dc.city, dc.Tier
ORDER BY Count;
 
-- Query 12: Where do respondents prefer to purchase energy drinks?

SELECT Purchase_location, COUNT(*) PreferenceCount
FROM fact_survey_responses
GROUP BY Purchase_location
ORDER BY PreferenceCount DESC;

-- Query 13: What are the typical consumption situations for energy drinks among respondents?

SELECT Typical_consumption_situations, COUNT(*) ConsumptionCount
FROM fact_survey_responses
GROUP BY Typical_consumption_situations
ORDER BY ConsumptionCount;

-- Query 14: What factors influence respondents' purchase decisions, such as price range and limited edition packaging?

SELECT price_range, COUNT(*) Counts
FROM fact_survey_responses
GROUP BY price_range
ORDER BY Counts;

SELECT Limited_edition_packaging, COUNT(*) as Counts
FROM fact_survey_responses
GROUP BY Limited_edition_packaging
ORDER BY Counts;

-- Query 15: Which area of business should we focus more on our product development? (Branding/taste/availability)

SELECT Reasons_for_choosing_brands, COUNT(*) as Counts
FROM fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY Counts DESC;

-- Query 16: What immediate improvements can we bring to the product?

SELECT Improvements_desired Imediate_improvements, COUNT(*) Counts
FROM fact_survey_responses
GROUP BY Improvements_desired
ORDER BY Counts DESC;

-- Query 17: Reasons Preventing Customers from Trying Energy Drinks

SELECT Reasons_preventing_trying, COUNT(*) Counts
FROM fact_survey_responses
GROUP BY Reasons_preventing_trying
ORDER BY Counts DESC;

-- Query 18: Are people Tried before?

SELECT Tried_before, COUNT(*) as Counts
FROM fact_survey_responses
GROUP BY Tried_before
ORDER BY Counts desc;

-- Query 19: people intrest in organic?

SELECT Interest_in_natural_or_organic, COUNT(*) as Count
FROM fact_survey_responses
GROUP BY Interest_in_natural_or_organic
ORDER BY Count desc;

-- Query 20: Age-wise Energy Drink Usage Contexts

SELECT dr.Age, fsr.Typical_consumption_situations ConsumptionSituations, COUNT(fsr.Typical_consumption_situations) Counts
FROM dim_respondents dr INNER JOIN fact_survey_responses fsr
ON dr.respondent_id = fsr.respondent_id
GROUP BY dr.Age, ConsumptionSituations
ORDER BY dr.Age;

-- Query 21: Purchase Location Counts in Percentage

SELECT 
    Purchase_location,
    COUNT(*) AS LocationCount,
    COUNT(*) * 1.0 / (SELECT COUNT(*) FROM fact_survey_responses) AS Percentage
FROM 
    fact_survey_responses
GROUP BY 
    Purchase_location
ORDER BY 
    LocationCount DESC;

