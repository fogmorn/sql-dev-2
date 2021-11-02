-- Задание 4. При помощи SQL-запросов исправить данные в базе.


-- 4.1 Все продажи за январь 2019 года для аптек города Ставрополя сохранились в базе со знаком минус.
--     Необходимо написать запрос, который исправит кол-во на положительное значение только для данных продаж.

UPDATE sale SET quantity=quantity*-1
WHERE locality_id=(
    SELECT id FROM locality WHERE name = 'Ставрополь'
    ) AND quantity<0;



-- 4.2 Произошло задвоение данных в таблице продаж для аптеки с ИД № 5. Необходимо удалить дубликаты.

DELETE FROM sale
WHERE id IN (
      SELECT MAX(id) FROM sale
      GROUP BY sale_time, good_id, pharmacy_id, quantity
      HAVING COUNT(id)>1
      ) AND pharmacy_id=5;