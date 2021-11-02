# sql-dev-2
Тестовое задание на должность PL/pgSQL разработчика.

## Задание 1

По таблице ниже при помощи SQL-запросов:

1. Разработать структуру таблиц;
2. Выбрать правильные типы данных для столбцов и добавить указанные ограничения;
3. При необходимости добавить недостающие столбцы и таблицы;
4. Добавить первичные ключи, индексы и связи между таблицами.

| Таблица        | Столбец         | Ограничения             | Возможные значения     |
| -------------- |-----------------| ------------------------|------------------------|
| **Товары**     | Название        | Обязательно и уникально |                        |
|                | Жизненно-важный | Обязательно             | Да / Нет               |
|                | Тип товара      | Обязательно             | Множество значений     |
|                | Рецептурность   | Необязательно           | Множество значений     |
| **Аптеки**     | Название        | Обязательно             |                        |
|                | Населенный пункт| Обязательно             | Множество значений     |
|                | Формат аптеки   | Обязательно             | Множество значений     |
| **Продажи**    | Время продажи   | Обязательно             | В формате "дата+время" |
|                | Аптека          | Обязательно             |                        |
|                | Товар           | Обязательно             |                        |
|                | Кол-во упаковок | Обязательно             |                        |
|                | Цена            | Обязательно             |                        |

[Решение. Задание 1](Task1.sql)

## Задание 2

Разработать хранимые процедуры для добавления/изменения/удаления товаров.  
В процедуры необходимо добавить проверки входных данных согласно таблице выше.  
В случае ввода некорректных данных выводить текст с читабельной ошибкой.

[Решение. Задание 2](Task2.sql)

## Задание 3

Написать SQL-запросы:
1. Рассчитать среднюю цену типов товаров по всем аптекам и отсортировать по убыванию (от большей цены к меньшей).
2. Вывести 10 самых продаваемых товаров (по кол-ву упаковок) за май 2019 года по всем аптекам города Краснодара (от большего к меньшему).
3. Вывести товары и кол-во уникальных аптек, где данный товар продавался в течение 2019 года.
4. Вывести товары, которые в 2018 году не продавались в городе Краснодаре, но продавались где-то еще.
5. Вывести 3 города, в котором находится больше всего аптек.
6. Выбрать товары, которые за 2018 год продавались не менее 10 упаковок в месяц, и среди них выбрать самую дорогую продажу. Вывести поля дата, аптека, город, товар, цена.

[Решение. Задание 3](Task3.sql)

## Задание 4

При помощи SQL-запросов исправить данные в базе:

1. Все продажи за январь 2019 года для аптек города Ставрополя сохранились в базе со знаком минус. Необходимо написать запрос, который исправит кол-во на положительное значение только для данных продаж.
2. Произошло задвоение данных в таблице продаж для аптеки с ИД № 5. Необходимо удалить дубликаты. Например, данные стали выглядеть следующим образом:

| Дата                | Товар   | Аптека   | Кол-во | Цена  |
|---------------------|---------|----------|--------|-------|
| 01.05.2019 13:59:59 | Товар 1 | Аптека 5 | 10     | 100,5 |
| 02.05.2019 14:50:54 | Товар 2 | Аптека 5 | 11     | 98,5  |
| 01.05.2019 13:59:59 | Товар 1 | Аптека 5 | 10     | 100,5 |
| 02.05.2019 14:50:54 | Товар 2 | Аптека 5 | 11     | 98,5  |
| ...                 | ...     | ...      | ...    | ...   |

[Решение. Задание 4](Task4.sql)


## Задание 5

Как при помощи SQL-запроса вывести список запросов, выполняющихся в настоящий момент на сервере?

[Решение. Задание 5](Task5.sql)
