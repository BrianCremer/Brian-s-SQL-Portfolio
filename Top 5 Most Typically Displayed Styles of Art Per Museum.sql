-- PostgreSQL query that shows the top 5 most typically displayed styles of art.
 
SELECT style, name, frequent_styles
FROM (
    SELECT work.style,
           museum.name,
           COUNT(work.style) AS frequent_styles,
           ROW_NUMBER() OVER (PARTITION BY museum.name ORDER BY COUNT(work.style) DESC) AS row_num
    FROM museum
    INNER JOIN work ON museum.museum_id = work.museum_id
    WHERE museum.name IN ('Solomon R. Guggenheim Museum',
                           'The Museum of Modern Art',
                           'The Tate Gallery',
                           'The State Hermitage Museum',
                           'Thussen-Bornemisza Museum')
    GROUP BY 1, 2
) AS ranked_styles
WHERE row_num <= 5
ORDER BY name, frequent_styles DESC;


