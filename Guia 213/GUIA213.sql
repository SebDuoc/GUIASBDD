-- CASO 1
SELECT 
    carreraid "IDENTIFICACION DE LA CARRERA",
    COUNT(carreraid) "TOTAL ALUMNOS MATRICULADOS",
    'Le corresponden' || TO_CHAR(COUNT(carreraid) * '&Monto', '$99g999g999') || ' del presupuesto total asignado para publicidad.' "MONTO POR PUBLICIDAD"
FROM alumno
GROUP BY carreraid
ORDER BY "TOTAL ALUMNOS MATRICULADOS" DESC, carreraid;

-- CASO 2
SELECT 
    carreraid "CARRERA",
    COUNT(carreraid) "TOTAL DE ALUMNOS"
FROM alumno
GROUP BY carreraid
HAVING COUNT(carreraid) > 4
ORDER BY carreraid;

-- CASO 3   
SELECT 
    TO_CHAR(run_jefe, '09G999G999') "RUN JEFE SIN DV",
    COUNT(run_jefe) "TOTAL DE EMPLEADOS A SU CARGO",
    LPAD(TO_CHAR(MAX(SALARIO), '$99g999g999'), 14, ' ') "SALARIO MAXIMO",
    LPAD(COUNT(run_jefe) * 10 || '% del Salario Máximo', 25, ' ' ) "PORCENTAJE DE BONIFICACION",
    LPAD(TO_CHAR(((COUNT(run_jefe) * 10) / 100) * MAX(SALARIO), '$99G999G999'), 13, ' ') "BONIFICACION"
FROM empleado
GROUP BY run_jefe
HAVING COUNT(run_jefe) > 0
ORDER BY COUNT(run_jefe);

-- CASO 4
SELECT 
    p.id_escolaridad "ESCOLARIDAD",
    e.desc_escolaridad "DESCRIPCION ESCOLARIDAD",
    COUNT(p.id_escolaridad) "TOTAL DE EMPLEADOS",
    TO_CHAR(MAX(SALARIO), '$99G999G999') "SALARIO MAXIMO",
    TO_CHAR(MIN(SALARIO), '$99G999G999') "SALARIO MINIMO",
    TO_CHAR(SUM(SALARIO), '$99G999G999')  "SALARIO TOTAL",
    TO_CHAR(ROUND(AVG(SALARIO)), '$99G999G999') "SALARIO PROMEDIO"
FROM empleado p JOIN escolaridad_emp e
ON p.id_escolaridad = e.id_escolaridad
GROUP BY p.id_escolaridad, e.desc_escolaridad
ORDER BY COUNT(p.id_escolaridad) DESC;

-- CASO 5
SELECT 
    tituloid "CODIGO DEL LIBRO",
    COUNT(tituloid) "TOTAL DE VECES SOLICITADO",
    CASE
        WHEN COUNT(TITULOID) = 1 THEN 'No se requiere nuevos ejemplares'
        WHEN COUNT(TITULOID) = 2 OR COUNT(TITULOID) = 3 THEN 'Se requiere comprar 1 nuevos ejemplares'
        WHEN COUNT(TITULOID) = 4 OR COUNT(TITULOID) = 5 THEN 'Se requiere comprar 2 nuevos ejemplares'
        WHEN COUNT(TITULOID) > 5 THEN 'Se requiere comprar 4 nuevos ejemplares'
    END "SUGERENGIA"
FROM prestamo
WHERE TO_CHAR(FECHA_INI_PRESTAMO, 'YYYY') = TO_CHAR(TO_DATE(ADD_MONTHS(SYSDATE, -12)), 'YYYY')
GROUP BY tituloid
ORDER BY "TOTAL DE VECES SOLICITADO" DESC;

-- CASO 6 
SELECT 
    TO_CHAR(e.run_emp, '09g999g999') "RUN EMPLEADO",
    TO_CHAR(p.fecha_ini_prestamo, 'MM/YYYY') "MES PRESTAMOS LIBROS",
    COUNT(p.run_emp)
FROM empleado e JOIN prestamo p 
ON e.run_emp = p.run_emp 
GROUP BY p.fecha_ini_prestamo, e.run_emp;




