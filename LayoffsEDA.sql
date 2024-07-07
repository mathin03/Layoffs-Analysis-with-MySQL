-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off=1
ORDER BY total_laid_off DESC;

SELECT company , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

SELECT industry , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  YEAR(`date`)
ORDER BY 2 DESC;

SELECT MONTH(`date`) as `month`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  MONTH(`date`)
ORDER BY `month`;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  stage
ORDER BY 2 DESC;

SELECT company , SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2;

SELECT *
FROM layoffs_staging2;

SELECT substring(`date`,1,7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `month`
ORDER BY `month`;

WITH rolling_total AS
(
SELECT substring(`date`,1,7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `month`
ORDER BY `month`
)
SELECT `month`,SUM(total_laid_off) OVER(ORDER BY `month`) AS roll_total 
FROM rolling_total;

SELECT company ,YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`);

WITH company_year (company, years, total_laid_off)  AS 
(
SELECT company ,YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
), Company_Years_Rank AS
(
SELECT *,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as `rank`
FROM company_year
WHERE years IS NOT NULL
ORDER BY `rank` ASC
)
SELECT *
FROM Company_Years_Rank;




