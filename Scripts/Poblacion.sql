/* Polideportivo */


INSERT INTO Polideportivo 
VALUES (1,'Juan Carlos I','Avenida Juan Carlos','{"348726601","777830021","983770921"}',2000);

INSERT INTO Pista VALUES(1,1,'baloncesto','disponible',3.5,CURRENT_DATE);
INSERT INTO Pista VALUES(2,1,'tenis','disponible',5.0,CURRENT_DATE);

INSERT INTO usuario VALUES ('38490321D','Juan','Carlos','pipo@gmail.com','378922201','2002-01-22',NULL,3);

INSERT INTO reserva VALUES (1,CURRENT_DATE,CURRENT_DATE,10,NULL,2,1);