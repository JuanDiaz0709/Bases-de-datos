USE ejemplos_tipos_join;

-- EJEMPLOS PRACTICOS DE LA GUIA:

SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        JOIN
    matriculas m ON m.id_alumno = a.id_alumno
ORDER BY a.id_alumno , m.id_matricula;


-- INNER JOIN : devuelve unicamente las filas que cumplen la condicion en ambas tablas
SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        INNER JOIN
    matriculas m ON m.id_alumno = a.id_alumno
ORDER BY a.id_alumno , m.id_matricula;

-- LEFT JOIN: Todo A y lo que case en B, si no casa, muestra las columnas de la derecha con un NULL
SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        LEFT JOIN
    matriculas m ON m.id_alumno = a.id_alumno
ORDER BY a.id_alumno , m.id_matricula;

-- RIGHT JOIN: Todo B y lo que case en A. Util para detectar huerfanas a la derecha. Muestra un NULL donde no hay coincidencia, en la izquierda
SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        RIGHT JOIN
    matriculas m ON m.id_alumno = a.id_alumno
ORDER BY m.id_matricula;


-- FULL OUTER JOIN: Todo de ambos lados: LEFT JOIN + RIGHT JOIN CON DONDE HAYAN NULL Y SE UNEN (UNION)
SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        LEFT JOIN
    matriculas m ON m.id_alumno = a.id_alumno 
UNION SELECT 
    a.id_alumno, a.nombre, m.id_matricula, m.id_curso
FROM
    alumnos a
        RIGHT JOIN
    matriculas m ON m.id_alumno = a.id_alumno
WHERE
    a.id_alumno IS NULL
ORDER BY 1 IS NULL;

-- EJERCICIOS DE LA GUIA

SELECT 
    *
FROM
    alumnos;
SELECT 
    *
FROM
    matriculas;
SELECT 
    *
FROM
    cursos;

-- 1): Listado de alumnos con sus id_curso (sólo emparejados).

SELECT 
    a.id_alumno, a.nombre, m.id_curso
FROM
    alumnos a
        INNER JOIN
    matriculas m ON a.id_alumno = m.id_alumno
ORDER BY a.id_alumno , m.id_curso;

-- 2): Alumnos sin ninguna matrícula (anti-join).

SELECT 
    a.id_alumno, a.nombre
FROM
    alumnos a
        LEFT JOIN
    matriculas m ON a.id_alumno = m.id_alumno
WHERE
    m.id_alumno IS NULL
ORDER BY a.id_alumno

-- 3)No: Matrículas sin alumno (huérfanas).

SELECT m.id_matricula, m.id_alumno, m.id_curso
FROM matriculas m
LEFT JOIN alumnos a
ON m.id_alumno = a.id_alumno
WHERE a.nombre IS NULL
ORDER BY m.id_matricula;

-- 4): Cursos del catálogo sin ninguna matrícula.

SELECT c.id_curso, c.nombre_curso
FROM cursos c
LEFT JOIN matriculas m
ON c.id_curso = m.id_curso
WHERE m.id_matricula IS NULL
ORDER BY c.id_curso;

-- 5): Número de matrículas por alumno (incluye 0).

SELECT a.id_alumno, a.nombre, count(m.id_matricula) AS n_matriculas
FROM matriculas m
RIGHT JOIN alumnos a
ON a.id_alumno = m.id_alumno
GROUP BY a.id_alumno
ORDER BY a.id_alumno;

-- 6): Alumnos con más de un curso.

SELECT a.id_alumno, a.nombre, count(m.id_matricula) AS n
FROM matriculas m
RIGHT JOIN alumnos a
ON a.id_alumno = m.id_alumno
GROUP BY a.id_alumno
ORDER BY n DESC
LIMIT 1;

-- 7): FULL OUTER JOIN emulado (alumnos y sus matrículas, incluyendo huérfanas).

SELECT a.id_alumno, a.nombre, m.id_matricula
FROM alumnos a
LEFT JOIN matriculas m
ON a.id_alumno = m.id_alumno
UNION
SELECT a.id_alumno, a.nombre, m.id_matricula
FROM alumnos a
RIGHT JOIN matriculas m
ON a.id_alumno = m.id_alumno;

-- 8): Para cada curso del catálogo, número de alumnos con matrícula válida (alumno y curso existen).

SELECT c.id_curso, c.nombre_curso, count(a.id_alumno) as n_alumnos
FROM cursos c
LEFT JOIN matriculas m
ON c.id_curso = m.id_curso
LEFT JOIN alumnos a
ON m.id_alumno = a.id_alumno
GROUP BY c.id_curso
ORDER BY c.id_curso;

/* 
1. B
2. B 
3. B
4. C
5. B
6. B
7. B  
8. B
9. B 
10. B
 */
 
 USE tienda_online;
 
 -- 18) Productos NUNCA vendidos.
 
SELECT DISTINCT
  pr.nombre AS producto
FROM productos pr
LEFT JOIN detalle_pedido AS dp ON dp.id_producto = pr.id_producto
WHERE dp.id_producto IS NULL
ORDER BY producto ASC;

-- 20) Pedidos sin pagos, con cliente y coste_total.

SELECT
  p.id_pedido AS pedido,
  pa.id_pago,
  c.nombre    AS cliente,
  p.coste_total AS coste_total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
LEFT JOIN pagos pa ON pa.id_pedido = p.id_pedido
WHERE pa.id_pedido IS NULL
ORDER BY coste_total DESC;

-- 28) Pedidos con pagos parciales (suma pagos < coste_total y ≥ 1 pago).
SELECT
  p.id_pedido AS pedido,
  c.nombre    AS cliente,
  SUM(pa.total_pagado) AS total_pagado,
  p.coste_total AS coste_total
FROM pedidos AS p
JOIN clientes AS c ON c.id_cliente = p.id_cliente
LEFT JOIN pagos AS pa ON pa.id_pedido = p.id_pedido
GROUP BY p.id_pedido, c.nombre, p.coste_total
HAVING SUM(pa.total_pagado) IS NOT NULL
   AND SUM(pa.total_pagado) < p.coste_total
ORDER BY total_pagado ASC, pedido ASC;


-- 29) Nº de productos distintos comprados por cliente.
SELECT
  c.nombre AS cliente,
  COUNT(DISTINCT dp.id_producto) AS productos_distintos
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.id_cliente = c.id_cliente
LEFT JOIN detalle_pedido AS dp ON dp.id_pedido = p.id_pedido
GROUP BY c.id_cliente, c.nombre
ORDER BY productos_distintos DESC, cliente ASC;



-- 35) Clientes 2025 SIN pedidos aún.
SELECT
  c.nombre AS cliente,
  c.fecha_registro AS fecha_registro
FROM clientes AS c
LEFT JOIN pedidos AS p ON p.id_cliente = c.id_cliente
WHERE c.fecha_registro >= '2025-01-01' AND c.fecha_registro < '2026-01-01'
  AND p.id_pedido IS NULL
ORDER BY fecha_registro ASC, cliente ASC;
 