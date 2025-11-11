USE sakila;

-- Consulta 1: Clientes con al menos un alquiler
-- El gerente de la tienda desea conocer qué clientes han realizado alquileres de películas, sin incluir a aquellos que no han alquilado nada.

SELECT 
    c.customer_id AS id_cliente,
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo,
    COUNT(r.rental_id) AS cantidad_alquileres
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    c.store_id = 1
GROUP BY c.customer_id
ORDER BY cantidad_alquileres DESC
LIMIT 10;

-- Consulta 2: Todos los clientes y sus alquileres
-- El encargado de atención al cliente quiere un listado de todos los clientes registrados en el almacén 1 y el número de alquileres que han hecho, incluyendo clientes sin alquileres.

SELECT 
    c.customer_id AS id_cliente,
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo,
    COUNT(r.inventory_id) AS cantidad_alquileres
FROM
    customer c
        LEFT JOIN
    store s ON c.store_id = s.store_id
        LEFT JOIN
    rental r USING (customer_id)
WHERE
    s.store_id = 1
GROUP BY id_cliente 
UNION SELECT 
    c.customer_id AS id_cliente,
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo,
    COUNT(r.inventory_id) AS cantidad_alquileres
FROM
    customer c
        RIGHT JOIN
    store s ON c.store_id = s.store_id
        RIGHT JOIN
    rental r USING (customer_id)
WHERE
    r.inventory_id IS NULL
GROUP BY id_cliente
LIMIT 10;

-- Consulta 3: Actores y sus películas
-- El gerente de casting necesita un reporte de los actores y las películas en las que han actuado. Además, quiere incluir actores que aún no han participado en ninguna película.

SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor,
    f.title AS titulo_pelicula
FROM
    actor a
        LEFT JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        LEFT JOIN
    film f ON fa.film_id = f.film_id
LIMIT 234;

-- Consulta 4: Categorías y películas
-- El analista de inventario requiere un informe que muestre todas las categorías de películas junto con las películas asignadas a cada categoría. Es posible que existan categorías sin ninguna película asignada y (aunque en Sakila es poco común) películas sin categoría.

SELECT 
    c.category_id, c.name AS categoria, f.title AS pelicula
FROM
    category c
        LEFT JOIN
    film_category fc USING (category_id)
        LEFT JOIN
    film f USING (film_id) 
UNION SELECT 
    c.category_id, c.name AS categoria, f.title AS pelicula
FROM
    category c
        RIGHT JOIN
    film_category fc USING (category_id)
        RIGHT JOIN
    film f USING (film_id)
WHERE
    c.category_id IS NULL
LIMIT 10;


-- Consulta 5: Películas y sus actores
-- El director de contenido quiere un listado de las películas y los actores que participan en cada una, pero incluyendo películas que aún no tengan actor asignado.

SELECT 
    f.film_id,
    f.title,
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor
FROM
    film f
        LEFT JOIN
    film_actor fa USING (film_id)
        LEFT JOIN
    actor a USING (actor_id)
LIMIT 10;