## Base de dades "Universidad"
USE universidad;
# 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
	# Uso la clasificación que tiene en persona entre alumno o profesor, ordeno de forma ascendente.
SELECT apellido1 'Primer apellido', apellido2 'Segundo apellido', nombre 'Nombre' FROM persona WHERE tipo = 'alumno' ORDER BY Apellido1, Apellido2, Nombre; 

# 2. Esbriba el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
	# Lo mismo pero sin ordenar, buscando el campo nulo para teléfono.
SELECT apellido1 'Primer apellido', apellido2 'Segundo apellido', nombre 'Nombre' FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

# 3. Retorna el llistat dels/les alumnes que van néixer en 1999.
	# Usando BETWEEN
SELECT apellido1 'Primer apellido', apellido2 'Segundo apellido', nombre 'Nombre' FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999/01/01' AND '1999/12/31';
	# Usando la funcion YEAR, también hay para MONTH y DAY.
SELECT apellido1 'Primer apellido', apellido2 'Segundo apellido', nombre 'Nombre' FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

# 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
	# El LIKE no es sensible a mayúsculas, puede ir con % (cero, uno, muchos caracteres) o con _ (un caracter)
SELECT apellido1 'Primer apellido', apellido2 'Segundo apellido', nombre 'Nombre' FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

# 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre 'Asignatura' FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

# 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
	# Un triple INNER JOIN entre profesor, persona y departamento.
SELECT pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', pe.nombre 'Nombre', dp.nombre 'Departamento' FROM profesor JOIN persona pe ON pe.id = id_profesor JOIN departamento dp ON dp.id = id_departamento ORDER BY pe.apellido1, pe.apellido2, pe.nombre;

# 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asi.nombre 'Asignatura', ce.anyo_inicio 'Año inicio' , ce.anyo_fin 'Año fin' FROM alumno_se_matricula_asignatura asma JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar JOIN persona pe ON pe.id = asma.id_alumno JOIN asignatura asi ON asi.id = asma.id_asignatura WHERE pe.nif ='26902806M';

# 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
	# También se podría hacer con GROUP BY al igual que la #9
SELECT DISTINCT dp.nombre 'Departamento' FROM departamento dp JOIN profesor pf ON dp.id = pf.id_departamento JOIN asignatura asi ON pf.id_profesor = asi.id_profesor JOIN grado gr ON asi.id_grado = gr.id WHERE gr.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

# 9. Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT CONCAT(pe.apellido1, ' ', pe.apellido2, ', ', pe.nombre) AS 'Alumnos matriculados 2018/2019' FROM persona pe JOIN alumno_se_matricula_asignatura asma ON pe.id = asma.id_alumno JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id WHERE ce.anyo_inicio BETWEEN 2018 AND 2019;
###
### Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
###
# 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a.El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
	# No hay profesores sin departamento asignado, por lo que creo una nueva "persona" que a la que desde la tabla "profesor" su ID no haya sido usado.
SELECT dp.nombre 'Departamento', pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', pe.nombre 'Nombre' FROM persona pe LEFT JOIN profesor pf ON pf.id_profesor = pe.id LEFT JOIN departamento dp ON pf.id_departamento = dp.id WHERE pe.tipo = 'profesor' ORDER BY dp.nombre , pe.apellido1 , pe.apellido2 , pe.nombre;

# 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', pe.nombre 'Nombre' FROM persona pe LEFT JOIN profesor pf ON pe.id = pf.id_profesor WHERE pe.tipo = 'profesor' AND pf.id_profesor IS NULL;
    
# 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT dp.nombre 'Departamento' FROM departamento dp LEFT JOIN profesor pf ON dp.id = pf.id_departamento WHERE pf.id_departamento IS NULL;

# 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', pe.nombre 'Nombre' FROM persona pe LEFT JOIN profesor pf ON pe.id = pf.id_profesor LEFT JOIN asignatura asi ON pf.id_profesor = asi.id_profesor WHERE pe.tipo = 'profesor' AND asi.id_profesor IS NULL;

# 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT asi.nombre 'Asignatura' FROM asignatura asi WHERE asi.id_profesor IS NULL;

# 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT dp.nombre AS 'Departamento' FROM departamento dp LEFT JOIN profesor pf ON dp.id = pf.id_departamento WHERE pf.id_departamento IS NULL; 
###
### Consultes resum:
###
# 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(id) FROM persona WHERE tipo = 'alumno';

# 2. Calcula quants/es alumnes van néixer en 1999.
SELECT COUNT(id) 'Alumnos nacidos en 1999' FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999/01/01' AND '1999/12/31';
	#Usando YEAR
SELECT COUNT(id) FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

# 3. Calcula quants/es professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT COUNT(pf.id_departamento) AS 'Cantidad profesores', dp.nombre AS 'Departamento' FROM departamento dp JOIN profesor pf ON pf.id_departamento = dp.id GROUP BY dp.nombre ORDER BY COUNT(pf.id_departamento) DESC;

# 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.
SELECT COUNT(pf.id_departamento) AS 'Cantidad profesores', dp.nombre AS 'Departamento' FROM departamento dp LEFT JOIN profesor pf ON pf.id_departamento = dp.id GROUP BY dp.nombre;

# 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT gr.nombre 'Grado', COUNT(asi.id) 'Cantidad de asignaturas' FROM grado gr LEFT JOIN asignatura asi ON gr.id = asi.id_grado GROUP BY gr.nombre ORDER BY COUNT(asi.id) DESC; 

# 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT gr.nombre ' Grado', COUNT(*) 'Cantidad asignaturas' FROM grado gr JOIN asignatura asi ON gr.id = asi.id_grado GROUP BY gr.nombre HAVING COUNT(*) > 40;

# 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT gr.nombre 'Grado', asi.tipo 'Tipo asignatura', SUM(asi.creditos) 'Créditos' FROM grado gr LEFT JOIN asignatura asi ON gr.id = asi.id_grado GROUP BY gr.nombre, asi.tipo;

# 8. Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.
SELECT ce.anyo_inicio 'Año inicio', COUNT(*) 'Alumnos matriculados' FROM alumno_se_matricula_asignatura asma JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id GROUP BY ce.anyo_inicio;

# 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT pe.id 'id', pe.nombre 'Nombre', pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', COUNT(asi.id) 'Cantidad de asignaturas' FROM persona pe LEFT JOIN profesor pf ON pf.id_profesor = pe.id LEFT JOIN asignatura asi ON asi.id_profesor = pf.id_profesor WHERE pe.tipo = 'profesor' GROUP BY pe.id ORDER BY asi.id DESC;

# 10. Retorna totes les dades de l'alumne més jove.
SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;

# 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT pe.apellido1 'Primer apellido', pe.apellido2 'Segundo apellido', pe.nombre 'Nombre' FROM persona pe LEFT JOIN profesor pf ON pe.id = pf.id_profesor LEFT JOIN asignatura asi ON asi.id_profesor = pf.id_profesor WHERE pe.tipo = 'profesor' AND asi.id_profesor IS NULL;