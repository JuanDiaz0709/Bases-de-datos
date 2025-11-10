-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(actor.actor_id) AS num_films
FROM
    actor
        JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id;

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.

SELECT actor.actor_id,actor.first_name,actor.last_name,count(actor.actor_id) AS num_films
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
group by actor.actor_id
having (count(actor.actor_id) >= 20);

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.

SELECT 
    language.language_id,
    COUNT(film.language_id) AS language_id,
    language.name AS films_in_language
FROM
    film
        JOIN
    language ON film.language_id = language.language_id
GROUP BY film.language_id;

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.

SELECT 
    film.language_id,
    language.name AS language_name,
    AVG(film.length) AS avg_length
FROM
    film
        JOIN
    language ON film.language_id = language.language_id
GROUP BY film.language_id;

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.

SELECT 
    inventory.film_id,
    film.title,
    COUNT(inventory.inventory_id) AS copies
FROM
    inventory
        JOIN
    film ON inventory.film_id = film.film_id
GROUP BY inventory.film_id;

-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.

SELECT 
    inventory.film_id,
    film.title,
    COUNT(inventory.inventory_id) AS copies_5plus
FROM
    inventory
        JOIN
    film ON inventory.film_id = film.film_id
GROUP BY inventory.film_id
HAVING COUNT(inventory.inventory_id) >= 5;

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.

SELECT 
    inventory.inventory_id, COUNT(rental.rental_id) AS rentals
FROM
    inventory
        JOIN
    rental USING (inventory_id)
GROUP BY rental.inventory_id;

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_rentals
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY rental.customer_id;

-- 9:  Lista los clientes con 30 o más alquileres acumulados.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS rentals_30plus
FROM
    customer
        JOIN
    rental USING (customer_id)
GROUP BY rental.customer_id
HAVING rentals_30plus >= 30;

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY customer.customer_id;

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
GROUP BY customer.customer_id
HAVING total_amount >= 200;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.

SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    COUNT(payment.payment_id) AS payments_processed
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY payment.staff_id;

-- 13:  Para cada empleado, muestra el importe total procesado.

SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    SUM(payment.amount) AS total_processed
FROM
    staff
        JOIN
    payment USING (staff_id)
GROUP BY payment.staff_id;

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.

SELECT 
    store.store_id,
    COUNT(inventory.inventory_id) AS total_inventory_items
FROM
    store
        JOIN
    inventory USING (store_id)
GROUP BY inventory.store_id;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.

SELECT 
    store.store_id,
    COUNT(customer.store_id) AS customers_in_store
FROM
    store
        JOIN
    customer USING (store_id)
GROUP BY store_id;

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.

SELECT 
    store.store_id, COUNT(staff.staff_id) AS staff_in_store
FROM
    store
        JOIN
    staff USING (store_id)
GROUP BY store_id;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).

SELECT 
    address.address_id,
    address.address,
    COUNT(store.store_id) AS stores_here
FROM
    address
        JOIN
    store USING (address_id)
GROUP BY address.address_id;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.

SELECT 
    address.address_id,
    address.address,
    COUNT(staff.staff_id) AS staff_here
FROM
    address
        JOIN
    staff USING (address_id)
GROUP BY address.address_id;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.

SELECT 
    address.address_id,
    address.address,
    COUNT(customer.customer_id) AS customers_here
FROM
    address
        JOIN
    customer USING (address_id)
GROUP BY address.address_id;

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.

SELECT 
    city.city_id,
    city.city,
    COUNT(address.address_id) AS addresses_in_city
FROM
    city
        JOIN
    address USING (city_id)
GROUP BY city.city_id;

-- 21:  Para cada país, cuenta cuántas ciudades existen.

SELECT 
    country.country_id,
    country.country,
    COUNT(city.city_id) AS cities_in_contry
FROM
    country
        JOIN
    city USING (country_id)
GROUP BY country.country_id;


-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.

SELECT 
    language.language_id,
    language.name,
    AVG(film.length) AS avg_length
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY language_id
HAVING avg_length > 90 AND avg_length < 120;


-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).

SELECT 
    film.film_id,
    film.title,
    COUNT(rental.inventory_id) AS total_rentals
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY film.film_id;

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(payment.payment_date) AS payments_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    payment.payment_date LIKE '2005-%'
GROUP BY customer_id;


-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).

SELECT 
    film.film_id, film.title, AVG(film.rental_rate) AS avg_rate
FROM
    film
        JOIN
    inventory USING (film_id)
GROUP BY film.film_id;

-- 26:  Para cada actor, muestra la duración media (length) de sus películas.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    AVG(film.length) AS avg_length_by_actor
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY film_actor.actor_id;

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
SELECT 
    city.city_id,
    city.city,
    COUNT(address.address_id) AS total_addresses
FROM
    customer
        INNER JOIN
    address USING (address_id)
        INNER JOIN
    city USING (city_id)
GROUP BY address.city_id
HAVING COUNT(address.address_id) <= 2;

-- 28:  Para cada película, cuenta cuántos actores tiene asociados. 

SELECT 
    film.film_id,
    film.title,
    COUNT(film_actor.actor_id) AS actors_in_film
FROM
    film
        JOIN
    film_actor USING (film_id)
GROUP BY film.film_id;


-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).

SELECT 
    category.category_id,
    COUNT(film_category.film_id) AS films_in_category
FROM
    category
        JOIN
    film_category USING (category_id)
GROUP BY category.category_id;

-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.

SELECT 
    store.store_id,
    COUNT(rental.rental_id) AS rentals_by_store_inventory
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    rental USING (inventory_id)
GROUP BY store.store_id;

-- ==============================================

-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS

-- ==============================================

-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(film.film_id) AS films_by_actor
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY actor.actor_id
HAVING films_by_actor > 15;

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.

SELECT 
    category.category_id,
    category.name,
    COUNT(film.film_id) AS films_in_category
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category.category_id;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.

SELECT 
    film.film_id,
    film.title,
    COUNT(rental.rental_id) AS rentals_of_film
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY film.film_id;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_2005
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    payment USING (rental_id)
GROUP BY customer.customer_id
HAVING total_2005 >= 150;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.

SELECT 
    store.store_id,
    SUM(payment.amount) AS revenue_by_store_staff
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
GROUP BY store.store_id;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).

SELECT 
    city.city_id,
    city.city,
    COUNT(staff.staff_id) AS staff_in_city
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    staff USING (address_id)
GROUP BY city.city_id;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).

SELECT 
    city.city_id,
    city.city,
    COUNT(store.store_id) AS stores_in_city
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    store USING (address_id)
GROUP BY city.city_id;

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    AVG(film.length) AS avg_len_2006
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    film.release_year LIKE '2006%'
GROUP BY actor.actor_id;

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.

SELECT 
    category.category_id,
    category.name,
    AVG(film.length) AS avg_len
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category.category_id
HAVING avg_len > 120;

-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.

SELECT 
    language.language_id,
    language.name,
    SUM(film.rental_rate) AS sum_rates
FROM
    language
        JOIN
    film USING (language_id)
GROUP BY language.language_id;

-- si haces un "SELECT SUM(rental_rate) FROM film;" el resultado es igual a de este consulta, lo que pide el enunciado es eso 

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS weekend_rentals
FROM
    rental
        JOIN
    customer USING (customer_id)
WHERE
    DAYOFWEEK(rental.rental_date) IN (1 , 7)
GROUP BY customer.customer_id;


-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(DISTINCT (film.film_id)) AS distinct_films
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
GROUP BY actor.actor_id;

-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).

SELECT 
    city.city_id,
    city.city,
    COUNT(customer.customer_id) AS customers_in_city
FROM
    customer
        JOIN
    address USING (address_id)
        JOIN
    city USING (city_id)
GROUP BY city.city_id;

-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.

SELECT 
    category.category_id,
    category.name,
    COUNT(DISTINCT (film_actor.actor_id)) AS actors_in_category
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    film_actor USING (film_id)
GROUP BY category.category_id;

-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.

SELECT 
    store.store_id, COUNT(inventory.inventory_id) AS copies_2006
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
WHERE
    film.release_year LIKE '2006%'
GROUP BY store.store_id;

-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_amount
FROM
    customer
        JOIN
    payment USING (customer_id)
        JOIN
    staff USING (staff_id)
WHERE
    staff.store_id = 1
GROUP BY customer.customer_id;

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.

SELECT 
    film.film_id,
    film.title,
    COUNT(actor.actor_id) AS actors_lastname_len5plus
FROM
    film
        JOIN
    film_actor USING (film_id)
        JOIN
    actor USING (actor_id)
WHERE
    LENGTH(actor.last_name) >= 5
GROUP BY film.film_id;

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.

SELECT 
    category.category_id, SUM(film.length) AS total_length
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category.category_id;

-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.

SELECT 
    city.city_id, city.city, SUM(payment.amount) AS total_paid
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
GROUP BY city.city_iddioma.

SELECT language.language_id, language.name, count(distinct(actor.actor_id)) AS actors_in_language
FROM language
JOIN film USING (language_id)
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
GROUP BY language.language_id;

-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.

SELECT 
    store.store_id,
    COUNT(customer.customer_id) AS active_customers
FROM
    address
        JOIN
    store USING (address_id)
        JOIN
    customer USING (store_id)
WHERE
    customer.active = 1
GROUP BY store.store_id;

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(DISTINCT (inventory.inventory_id)) AS rentals_2006
FROM
    customer
        JOIN
    rental USING (customer_id)
        JOIN
    inventory USING (inventory_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
WHERE
    rental.rental_date LIKE '2006%'
GROUP BY customer.customer_id;

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.

SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    COUNT(DISTINCT (customer.customer_id)) AS distinct_customers_paid
FROM
    staff
        JOIN
    payment USING (staff_id)
        JOIN
    customer USING (customer_id)
GROUP BY staff.staff_id;


-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.

SELECT 
    city.city_id,
    city.city,
    COUNT(rental.rental_id) AS rentals_2006_by_city
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    rental USING (customer_id)
WHERE
    rental.rental_date LIKE '2006%'
GROUP BY city.city_id;

-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.

SELECT 
    category.category_id,
    category.name,
    AVG(film.replacement_cost) AS avg_replacement_cost
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category.category_id;

-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).

SELECT 
    store.store_id, SUM(payment.amount) AS revenue_2006
FROM
    store
        JOIN
    staff USING (store_id)
        JOIN
    payment USING (staff_id)
WHERE
    payment.payment_date LIKE '2006%'
GROUP BY store.store_id;

-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(film.film_id) AS films_title_len_gt12
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
WHERE
    LENGTH(film.title) >= 12
GROUP BY actor.actor_id;


-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.

SELECT 
    city.city_id, city.city, SUM(payment.amount)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
WHERE
    payment.payment_date LIKE '2006%'
GROUP BY city.city_id
HAVING SUM(payment.amount) >= 300;


-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.

SELECT 
    category.category_id,
    category.name,
    COUNT(film.film_id) AS films_pg_pg13
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
WHERE
    film.rating LIKE 'PG%' OR 'PG-13'
GROUP BY category.category_id; 

-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_paid_by_staff2
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    payment.staff_id = 2
GROUP BY customer.customer_id;

-- ==============================================

-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS

-- ==============================================

-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.

SELECT 
    city.city_id, city.city, COUNT(customer.customer_id)
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
GROUP BY city.city_id
HAVING COUNT(customer.customer_id) >= 10;

-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(rental.rental_id) AS rentals_for_actor
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY actor.actor_id
ORDER BY actor.actor_id ASC	;

-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.

SELECT 
    category.category_id,
    category.name,
    SUM(payment.amount) AS revenue_by_category
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY category.category_id
ORDER BY category.category_id ASC;


-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.

SELECT 
    city.city_id,
    city.city,
    SUM(payment.amount) AS total_paid_2005
FROM
    city
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
WHERE
    payment.payment_date LIKE '2005%'
GROUP BY city.city_id;

-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.

SELECT 
    store.store_id,
    COUNT(DISTINCT (film_actor.actor_id)) AS distinct_actors_in_store_inventory
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
        JOIN
    film_actor USING (film_id)
GROUP BY store_id;

-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.

SELECT 
    language.language_id,
    language.name,
    COUNT(rental.rental_id) AS rentals_in_language
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY language.language_id;

-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(DISTINCT (MONTH(payment.payment_date))) AS active_months_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment.payment_date) = 2005
GROUP BY customer.customer_id;


-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).

SELECT 
    category.category_id,
    category.name,
    AVG(film.length) AS avg_length_rented
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY category.category_id;

-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).

SELECT 
    country.country_id,
    country.country,
    COUNT(customer.customer_id) AS customers_in_country
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
GROUP BY country.country_id;

-- 70:  Para cada país, suma los importes pagados por sus clientes.

-- NO HAY UN ORDEN ESPECIFICADO, PERO LOS RESULTADOS SON IGUALES.
SELECT 
    country.country_id,
    country.country,
    SUM(payment.amount) AS total_paid_by_country
FROM
    country
        JOIN
    city USING (country_id)
        JOIN
    address USING (city_id)
        JOIN
    customer USING (address_id)
        JOIN
    payment USING (customer_id)
GROUP BY country.country_id;

-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.

SELECT 
    store.store_id,
    COUNT(DISTINCT (category.category_id)) AS distinct_categories_in_store
FROM
    store
        JOIN
    inventory USING (store_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
        JOIN
    category USING (category_id)
GROUP BY store.store_id;

-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).

SELECT 
    store.store_id,
    category.category_id,
    category.name,
    SUM(payment.amount) AS revenue
FROM
    store
        JOIN
    staff ON store.store_id = staff.store_id
        JOIN
    payment ON staff.staff_id = payment.staff_id
        JOIN
    rental ON payment.rental_id = rental.rental_id
        JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        JOIN
    film ON inventory.film_id = film.film_id
        JOIN
    film_category ON film.film_id = film_category.film_id
        JOIN
    category ON film_category.category_id = category.category_id
GROUP BY store.store_id , category.category_id;

-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(DISTINCT (store.store_id)) AS stores_with_actor_films_rented
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    staff USING (staff_id)
        JOIN
    store ON staff.store_id = store.store_id
GROUP BY actor.actor_id;

-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.

SELECT 
    category.category_id,
    category.name,
    COUNT(DISTINCT (rental.customer_id)) AS distinct_customers
FROM
    category
        JOIN
    film_category ON category.category_id = film_category.category_id
        JOIN
    film ON film_category.film_id = film.film_id
        JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.category_id;



-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.

SELECT 
    l.language_id,
    l.name,
    COUNT(DISTINCT (fa.actor_id)) AS actors_in_rented_language_films
FROM
    language l
        JOIN
    film f ON l.language_id = f.language_id
        JOIN
    film_actor fa ON f.film_id = fa.film_id
        JOIN
    inventory i ON i.film_id = f.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY l.language_id;


-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).

SELECT 
    co.country_id,
    co.country,
    COUNT(DISTINCT (s.store_id)) AS distinct_categories_in_store
FROM
    country co
        JOIN
    city ci ON co.country_id = ci.country_id
        JOIN
    address a ON ci.city_id = a.city_id
        JOIN
    store s ON a.address_id = s.address_id
GROUP BY co.country_id;

-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.

-- NO HAY UN ORDEN ESPECIFICADO, PERO LOS RESULTADOS SON IGUALES.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS same_day_returns
FROM
    rental r
        JOIN
    customer c ON c.customer_id = r.customer_id
WHERE
    DATE(r.return_date) = DATE(r.rental_date)
GROUP BY c.customer_id;

-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.

SELECT 
    st.store_id,
    COUNT(DISTINCT (p.customer_id)) AS distinct_customers_2005
FROM
    payment p
        JOIN
    staff s ON p.staff_id = s.staff_id
        JOIN
    store st ON s.store_id = st.store_id
WHERE
    YEAR(p.payment_date) = 2005
GROUP BY st.store_id;

-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.

-- ESTA CONSULTA DEVUELVE EL MISMO RESULTADO QUE ESTA EN REPOSITORIO
SELECT 
    c.category_id,
    c.name,
    COUNT(DISTINCT (r.inventory_id)) AS rentals_long_title
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    f.length > 15
GROUP BY category_id;

-- ESTA CONSULTA ES LA QUE YO CREO QUE DEBERIA SER LA RESPUESTA CORRECTA A ESE ENUNCIADO
SELECT 
    c.category_id,
    c.name,
    COUNT(DISTINCT (r.inventory_id)) AS rentals_long_title
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    LENGTH(f.title) > 15
GROUP BY category_id;

-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.

SELECT 
    c.country_id,
    c.country,
    SUM(p.amount) AS revenue_by_country_staff
FROM
    country c
        JOIN
    city ct ON c.country_id = ct.country_id
        JOIN
    address a ON ct.city_id = a.city_id
        JOIN
    staff s ON a.address_id = s.address_id
        JOIN
    payment p ON s.staff_id = p.staff_id
GROUP BY c.country_id;

-- ==============================================

-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS

-- ==============================================

-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(p.amount * 1.21), 2) AS total_with_vat_21
FROM
    customer c
        JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.

SELECT 
    HOUR(rental.rental_date) AS rental_hour,
    COUNT(*) AS rentals_in_hour
FROM
    rental
GROUP BY HOUR(rental.rental_date)
ORDER BY rental_hour;

-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.

SELECT 
    st.store_id, AVG(f.length) AS avg_length_2005
FROM
    store st
        JOIN
    inventory i ON st.store_id = i.store_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
WHERE
    YEAR(r.rental_date) = '2005'
GROUP BY st.store_id
HAVING avg_length_2005 >= 100;

-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.

SELECT 
    c.category_id,
    c.name,
    AVG(f.replacement_cost) AS avg_replacement_sundays
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    WEEKDAY(r.rental_date) = 6
GROUP BY c.category_id;

-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).

SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS night_shift_amount
FROM
    staff s
        JOIN
    payment p ON s.staff_id = p.staff_id
WHERE
    TIME(p.payment_date) BETWEEN '00:00:00' AND '06:00:00'
GROUP BY s.staff_id;

-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).

SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(f.film_id) AS films_with_love
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
WHERE
    f.title LIKE '%LOVE%'
GROUP BY a.actor_id
ORDER BY a.actor_id ASC;

-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.

SELECT 
    l.language_id,
    l.name,
    SUM(p.amount) AS total_amount_in_language
FROM
    language l
        JOIN
    film f ON l.language_id = f.language_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY l.language_id;

-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT (DAYOFYEAR(r.rental_date))) AS active_days_2005
FROM
    customer c
        JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    YEAR(r.rental_date) = 2005
GROUP BY c.customer_id;

-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.

SELECT 
    c.category_id,
    c.name,
    AVG(LENGTH(f.title)) AS avg_title_len_rented
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id;

-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).

SELECT 
    s.store_id,
    COUNT(DISTINCT r.customer_id) AS distinct_customers_q1_2006
FROM
    rental r
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    store s ON i.store_id = s.store_id
WHERE
    MONTH(r.rental_date) BETWEEN 0 AND 2
GROUP BY i.store_id;



-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.

SELECT 
    c.country_id,
    c.country,
    COUNT(DISTINCT (cat.category_id)) AS distinct_categories_rented_by_country
FROM
    country c
        JOIN
    city ct ON c.country_id = ct.country_id
        JOIN
    address a ON ct.city_id = a.city_id
        JOIN
    customer cs ON a.address_id = cs.address_id
        JOIN
    rental r ON cs.customer_id = r.customer_id
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    film f ON i.film_id = f.film_id
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category cat ON fc.category_id = cat.category_id
GROUP BY c.country_id;

-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.

SELECT 
    p.customer_id, ROUND(AVG(p.amount), 2) AS avg_payment
FROM
    payment p
GROUP BY p.customer_id
HAVING COUNT(*) >= 10
ORDER BY p.customer_id ASC;


-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.

SELECT 
    c.category_id,
    c.name,
    COUNT(DISTINCT (f.film_id)) AS pricey_rented_films
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    f.replacement_cost > 20
GROUP BY c.category_id;

-- 94:  Para cada tienda, suma los importes pagados en fines de semana.

SELECT 
    s.store_id, SUM(p.amount) AS weekend_revenue
FROM
    store s
        JOIN
    staff st ON s.store_id = st.store_id
        JOIN
    payment p ON st.staff_id = p.staff_id
WHERE
    WEEKDAY(p.payment_date) IN (5 , 6)
GROUP BY s.store_id
ORDER BY s.store_id;


-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).

SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(DISTINCT (r.customer_id)) AS distinct_customers
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY a.actor_id
HAVING COUNT(DISTINCT (r.customer_id)) >= 5;

-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.

SELECT 
    l.language_id,
    l.name,
    COUNT(DISTINCT (f.title)) AS films_starting_A_rented
FROM
    language l
        JOIN
    film f ON l.language_id = f.language_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    f.title LIKE 'A%'
GROUP BY l.language_id;


-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.

SELECT 
    c.country_id, c.country, SUM(p.amount) AS total_amount
FROM
    country c
        JOIN
    city ct ON c.country = ct.country_id
        JOIN
    address a ON ct.city_id = a.city_id
        JOIN
    customer cs ON a.address_id = cs.address_id
        JOIN
    payment p ON cs.customer_id = p.customer_id
GROUP BY c.country_id
HAVING total_amount >= 1000;

-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    DATEDIFF(MAX(r.rental_date), MIN(r.rental_date)) AS days_between_first_last_2005
FROM
    rental r
        JOIN
    customer c ON r.customer_id = c.customer_id
WHERE
    r.rental_date >= '2005-01-01'
        AND r.rental_date < '2006-01-01'
GROUP BY r.customer_id
HAVING COUNT(c.customer_id) >= 5
ORDER BY r.customer_id;


--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).

-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.

SELECT 
    s.store_id, ROUND(AVG(p.amount), 2) AS avg_payment_2006
FROM
    store s
        JOIN
    staff st ON s.store_id = st.store_id
        JOIN
    payment p ON st.staff_id = p.staff_id
WHERE
    YEAR(p.payment_date) = 2006
GROUP BY s.store_id;

-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.

SELECT 
    c.category_id,
    c.name,
    AVG(f.length) AS avg_length_rented_2006
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON fc.film_id = f.film_id
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    YEAR(r.rental_date) = 2006
GROUP BY c.category_id
ORDER BY avg_length_rented_2006 DESC;