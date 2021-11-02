-- Задание 3.


-- 3.1 Рассчитать среднюю цену типов товаров по всем аптекам и отсортировать по убыванию (от большей цены к меньшей).

SELECT good_type.name, AVG(price)
FROM price
LEFT JOIN good ON price.good_id=good.id
LEFT JOIN good_type ON good.type_id = good_type.id
GROUP BY good_type.name
ORDER BY AVG(price) DESC;



-- 3.2 Вывести 10 самых продаваемых товаров (по кол-ву упаковок) за май 2019 года по всем аптекам города Краснодара (от большего к меньшему).

SELECT good.name, SUM(quantity)
FROM sale
LEFT JOIN good ON sale.good_id=good.id
LEFT JOIN pharmacy ON pharmacy_id=pharmacy.id
WHERE pharmacy.locality_id='1' AND to_char(sale_time, 'YYYY-MM')='2018-05'
GROUP BY good.name
ORDER BY SUM(quantity) DESC;



-- 3.3 Вывести товары и кол-во уникальных аптек, где данный товар продавался в течение 2019 года.

SELECT good.name, COUNT(DISTINCT pharmacy_id)
FROM sale
LEFT JOIN good ON sale.good_id=good.id
WHERE to_char(sale_time, 'YYYY')='2019'
GROUP BY good.name;



-- 3.4 Вывести товары, которые в 2018 году не продавались в городе Краснодаре, но продавались где-то еще.

SELECT DISTINCT good.name
FROM
  (SELECT sale.id, good_id, pharmacy_id, locality_id
   FROM sale
   LEFT JOIN pharmacy ON pharmacy_id=pharmacy.id
   WHERE to_char(sale_time, 'YYYY')='2018'
     AND pharmacy.locality_id<>(SELECT id FROM locality WHERE name='Краснодар')
  ) sale_other
LEFT JOIN
  (SELECT sale.id, good_id, pharmacy_id, locality_id
   FROM sale
   LEFT JOIN pharmacy ON sale.pharmacy_id=pharmacy.id
   WHERE to_char(sale_time, 'YYYY')='2018'
     AND pharmacy.locality_id=(SELECT id FROM locality WHERE name='Краснодар')
  ) AS sale_krd
ON sale_krd.good_id=sale_other.good_id
LEFT JOIN good ON sale_other.good_id=good.id
WHERE sale_krd.good_id IS NULL;



-- 3.5 Вывести 3 города, в котором находится больше всего аптек.

SELECT locality.name, COUNT(pharmacy.id)
FROM pharmacy
LEFT JOIN locality ON pharmacy.locality_id=locality.id
GROUP BY locality.name
ORDER BY COUNT(pharmacy.id) DESC
LIMIT 3;



-- 3.6 Выбрать товары, которые за 2018 год продавались не менее 10 упаковок в месяц, и среди них выбрать самую дорогую продажу.
--     Вывести поля дата, аптека, город, товар, цена.

SELECT s.sale_time, pharmacy.name, locality.name, good.name, s.price
FROM
(
  SELECT sale.id, sale.sale_time, sale.good_id, sale.pharmacy_id,
      sale.quantity, price.price, price.price*sale.quantity AS price_total
  FROM
    (SELECT DISTINCT good_id
     FROM sale
     WHERE to_char(sale_time, 'YYYY')='2018'
     GROUP BY good_id, to_char(sale_time, 'YYYY-MM')
  HAVING SUM(quantity)>=10) AS g
  LEFT JOIN sale ON g.good_id=sale.good_id
       AND to_char(sale_time, 'YYYY')='2018'
  LEFT JOIN price ON price.good_id=sale.good_id
       AND price.pharmacy_id=sale.pharmacy_id
) AS s
LEFT JOIN good ON s.good_id=good.id
LEFT JOIN pharmacy ON s.pharmacy_id=pharmacy.id
LEFT JOIN locality ON pharmacy.locality_id=locality.id
ORDER BY s.price_total DESC
LIMIT 1;