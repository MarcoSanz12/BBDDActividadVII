/* 1. Aumentar precio porcentaje a X deporte */


CREATE OR REPLACE FUNCTION aumentarPrecioPista(porcentaje FLOAT, pDeporte deporte)
RETURNS INT AS $$
DECLARE
	cambios INT;
BEGIN

	UPDATE pista
	SET precio = precio * (1 + (porcentaje/100))
	WHERE deporte = pDeporte;
	
	SELECT count(*) INTO cambios FROM pista WHERE deporte = pDeporte;
	
	RETURN cambios;

END;

$$ LANGUAGE plpgsql;

/* 2. Trigger calcular edad alumno */

CREATE OR REPLACE FUNCTION calcularEdadFunc() RETURNS TRIGGER AS $$
DECLARE
    anyoActual INT;
    anyo INT;
BEGIN

    SELECT extract( year from new.fechaNacimiento) INTO anyo;
    SELECT extract (year from CURRENT_DATE) INTO anyoActual;

    new.edad := anyoActual - anyo;
	
	RETURN NEW;
    
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER calcularEdadTr BEFORE INSERT ON usuario
FOR EACH ROW
EXECUTE PROCEDURE calcularEdadFunc();

/* 3. Trigger asignar precio automaticamente reserva */
CREATE OR REPLACE FUNCTION calcularPrecioFunc() RETURNS TRIGGER AS $$
DECLARE

BEGIN

    new.precio := ((SELECT precio FROM Pista WHERE idPista = new.idPista AND idPolideportivo = new.idPolideportivo) * new.duracion);

    RETURN NEW;

END

$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER calcularPrecioTr BEFORE INSERT ON reserva
FOR EACH ROW
EXECUTE PROCEDURE calcularPrecioFunc();

/* 4. Aumentar antiguedad */

CREATE OR REPLACE FUNCTION aumentarAntiguedad()
RETURNS INT AS $$
DECLARE
    cambios INT;
BEGIN

    cambios := 0;

    IF (extract(day from CURRENT_DATE) = 1) THEN

        UPDATE usuario SET antiguedad = antiguedad + 1;
        SELECT count(*) FROM usuario INTO cambios;

    END IF;

    RETURN cambios;

END

$$ LANGUAGE plpgsql;