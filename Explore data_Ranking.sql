-- Exploratory Data Analysis

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP By company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP By country
ORDER BY 2 DESC;

SELECT*
FROM layoffs_staging2;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP By YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP By stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP By `MONTH`
ORDER BY 1 ASC;


WITH Rolling_total As 
(SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP By `MONTH`
ORDER BY 1 ASC
)
SELECT`MONTH`, total_off,
SUM(total_off) OVER(ORDER BY`MONTH`) AS rolling_total 
FROM Rolling_total;




SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP By company
ORDER BY 2 DESC;

SELECT company,YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP By company,YEAR(`date`)
ORDER BY 3 DESC ;

-- RANKING

WITH company_Year (company,years, total_laid_off) AS
(
SELECT company,YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP By company,YEAR(`date`))
,
Company_Year_Rank AS
(
SELECT*, DENSE_RANK() OVER(partition by years ORDER BY total_laid_off DESC) As Ranking
FROM company_Year
WHERE years IS NOT NULL)

SELECT*
from Company_Year_Rank
WHERE Ranking <= 5
;




