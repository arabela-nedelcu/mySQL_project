		#2. CREAREA BAZEI DE DATE

CREATE DATABASE arabela_nedelcu;
USE arabela_nedelcu;

/*Crearea tabelelor si modificarea structurii tabelelor*/

CREATE TABLE client (
	id INT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR (50) NOT NULL,
    adresa VARCHAR (50),
    oras CHAR (10),
    tara CHAR (10)
);

ALTER TABLE client
CHANGE COLUMN id IDclient TINYINT (6);


CREATE TABLE angajat(
	IDangajat TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume varchar (50),
    prenume VARCHAR (10),
    data_nastere DATE
);

CREATE TABLE expeditor(
	IDexpeditor TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR (50) NOT NULL
);

ALTER TABLE expeditor
ADD COLUMN telefon varchar(15) ;

CREATE TABLE furnizor(
	IDfurnizor TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR (50) NOT NULL,
    adresa VARCHAR (50),
    oras VARCHAR (10),
    cod_postal INT (10),
    telefon VARCHAR (15) NOT NULL
);

ALTER TABLE furnizor
DROP COLUMN cod_postal;

CREATE TABLE categorie(
	IDcategorie TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR (20) NOT NULL
);

CREATE TABLE produs (
	IDprodus TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR (50) NOT NULL,
    IDfurnizor TINYINT (6) NOT NULL,
    IDcategorie TINYINT (6),
    bucati INT (5) NOT NULL,
    pret INT (20)
);

ALTER TABLE produs
ADD FOREIGN KEY (IDfurnizor) REFERENCES furnizor(IDfurnizor), 
ADD FOREIGN KEY (IDcategorie) REFERENCES categorie(IDcategorie);

CREATE TABLE comanda (
	IDcomanda TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDclient TINYINT (6) NOT NULL,
    IDangajat TINYINT (6),
    data_comanda TINYINT (6) NOT NULL,
    IDexpeditor TINYINT (6)NOT NULL,
    FOREIGN KEY (IDexpeditor) REFERENCES expeditor(IDexpeditor),
    FOREIGN KEY (IDangajat) REFERENCES angajat(IDangajat)
);

ALTER TABLE comanda
MODIFY data_comanda DATE;

ALTER TABLE comanda
ADD FOREIGN KEY (IDclient) REFERENCES client(IDclient);

CREATE TABLE detalii_comanda(
	IDdetaliicomanda TINYINT (6) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IDcomanda TINYINT (6) NOT NULL,
    IDprodus TINYINT (6) NOT NULL,
    cantitate TINYINT (6) NOT NULL,
    FOREIGN KEY (IDcomanda) REFERENCES comanda(IDcomanda),
    FOREIGN KEY (IDprodus) REFERENCES produs(IDprodus)
);

ALTER TABLE comanda
	DROP FOREIGN KEY comanda_ibfk_2;
DROP TABLE angajat;

ALTER TABLE comanda
DROP COLUMN IDangajat;

ALTER TABLE expeditor
ADD COLUMN firma_curierat VARCHAR (20) AFTER IDexpeditor;

ALTER TABLE comanda
ADD COLUMN data_livrare DATE AFTER data_comanda;

ALTER TABLE comanda
ADD COLUMN status ENUM('comanda_plasata', 'comanda_pregatita', 'comanda_predata_curierului', 'comanda_livrata') NOT NULL;

ALTER TABLE produs
MODIFY COLUMN pret DOUBLE (9,2);

		#3.ACTUALIZAREA DATELOR
/*inserare date in BD*/

INSERT INTO client
VALUES 
(1, 'Ernesto Gonzales', 'C/ Romero, 33', 'Sevilla', 'Spania'),
(2, 'John Wane', 'South House 300 Queensbridge', 'Londra', 'UK'),
(3, 'Vasile Mihai', 'Rasaritului nr.4', 'Bucuresti', 'Romania'),
(4, 'Catherine Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', 'Belgia'),
(5, 'Andreea Marin', 'Camil Ressu, nr. 8', 'Bucuresti', 'Romania'),
(6, 'Tomas Red', '90 Wadhurst Rd.', 'Londra', 'Uk'),
(7, 'Simon Crowther', 'Heerstr. 22', 'Bruxelles', 'Belgia'),
(8, 'Jean Pierre', '2, rue du Commerce', 'Lyon ', 'Franta'),
(9, 'Ionut Toma', 'Independentei, nr.45', 'Bucuresti', 'Romania'),
(10, 'William Terry', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'SUA'),
(11, 'Stefania Zamfirache', 'Dreptatii, nr. 22', 'Cluj ', 'Romania'),
(12, 'Catherine Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', 'Belgia');

select * from client;

/*AM CONSTATAT CA AM INTRODUS UN CLIENT DE 2 ORI, ASA CA VOM STERGE DUPLICATUL*/

DELETE FROM client
WHERE IDclient = 12;


INSERT INTO expeditor
VALUES
(1, 'Cargus', 'Ion Gheorghe', '+40756273637'),
(2, 'DHL', 'Marian Istrate', '+40723546474'),
(3, 'GLS', 'Alin Males', '+40723834847'),
(4, 'Posta Romana', 'George Ion', '+40254183645'),
(5, 'FanCurier', 'Ionel Toma', '+40756478399'),
(6, 'Speedy Express', 'Thomas Edison', '503 555 9831'),
(7, 'Federal Shipping', 'Allan Martin', ' 503 589 9931');

INSERT INTO furnizor
VALUES
(1, 'Emag', 'Sos. Bucuresti Nord, nr. 15-23', 'Bucuresti','07120054001'),
(2, 'Cell', 'Str. Iuliu Maniu 7 Corp A parter', 'Bucuresti','0733949500'),
(3, 'Altex', 'Str. Cascadelor, nr.34', 'Ploiesti','0715474834'),
(4, 'Flanco', 'Str. Intrarea Mare, nr.34', 'Cluj','0734526381'),
(5, 'Domo', 'Str. Ionel Ferning, nr.4323', 'Bucuresti','0715374945'),
(6, 'Gigel SRL', 'Str. Furnalistilor, nr. 34', 'Galati','0767465745'),
(7, 'Cit Group', 'Sos. Barcuta, nr, 24', 'Arad','0726484645'),
(8, 'Leka Trading', '471 Serangoon Loop, Suite #402', 'Singapore','0756435465'),
(9, 'Lyngbysild', 'Lyngbysild Fiskebakken 10', 'Lyngby','0738441081'),
(10, 'Refrescos Americanas LTDA', 'Av. das Americanas 12.890', 'São Paulo','0756434345'),
(11, 'Pc Garage', 'Str. Logofat Tautu 68A, Sector 3', 'Bucuresti','0785674647'),
(12, 'Dabstore', 'Str. Lucretiu Patrascanu, nr 14', 'Bucuresti',' 0755177999'),
(13, 'IT Arena', 'Strada Zefirului Nr. 25', 'Ploiesti','0712978345');

INSERT INTO categorie
VALUES
(1, 'laptop'),
(2, 'telefon'),
(3, 'televizor'),
(4, 'tableta'),
(5, 'casti'),
(6, 'foto'),
(7, 'masina de spalat'),
(8, 'frigider'),
(9, 'aer conditionat'),
(10, 'centrala termica'),
(11, 'boxe'),
(12, 'monitoare');

INSERT INTO produs
VALUES
(1, 'Samsung', '2', '7','14','1345.99'),
(2, 'Beko', '3', '7','34','643'),
(3, 'Whirpool', '2', '1','65','4532.76'),
(4, 'Acer', '3', '1','46','2345'),
(5, 'Asus', '2', '4','76','2356'),
(6, 'Toshiba', '3', '8','44','1246'),
(7, 'Boch', '4', '12','13','2345'),
(8, 'LG', '7', '10','54','3456.67'),
(9, 'Vortex', '6', '9','89','3242'),
(10, 'Arctic', '8', '5','65','4355.56'),
(11, 'Myria', '10', '6','4','3325.45'),
(12, 'Leica', '11', '11','45','2335'),
(13, 'Sony', '12', '3','67','6433.45'),
(14, 'Philips', '13', '8','6','34'),
(15, 'Goregnie', '7', '11','5','456.43');

/*AM GRESIT LA INTRODUCEREA PRETULUI PRODUSULUI CU ID-UL 14*/
START TRANSACTION;
UPDATE produs
SET pret=3456
WHERE IDprodus=14;
COMMIT;

INSERT INTO comanda
VALUES
(1, 5, 20190304, 20190328,6,'comanda_livrata'),
(2, 6, 20200304, 20200403,5,'comanda_plasata'),
(3, 4, 20180405, 20180607,4,'comanda_livrata'),
(4, 7, 20200304, 20200316,6,'comanda_pregatita'),
(5, 5, 20190506, 20190604,7,'comanda_livrata'),
(6, 9, 20191112, 20191224,4,'comanda_livrata'),
(7, 10, 20190203, 20190411,2,'comanda_livrata'),
(8, 11, 20190606, 20190703,1,'comanda_plasata'),
(9, 4, 20200103, 20200211,2,'comanda_livrata'),
(10, 5, 20191202, 20200105,3,'comanda_livrata'),
(11, 3, 20200202, 20200324,3,'comanda_predata_curierului'),
(12, 2, 20200226, 20200314,4,'comanda_pregatita'),
(13, 3, 20190807, 20190811,1,'comanda_livrata');

/*S-A MODIFICAT STATUSUL COMENZII CU ID-UL 9*/
UPDATE comanda
SET status='comanda_predata_curierului'
WHERE IDcomanda = 9;

SELECT * FROM COMANDA;

INSERT INTO detalii_comanda
VALUES
(1, 4, 1, 1),
(2, 4, 3, 1),
(3, 1, 5, 3),
(4, 3, 9, 4),
(5, 6, 12, 5),
(6, 6, 4, 6),
(7, 8, 1, 3),
(8, 13, 2, 2),
(9, 13, 4, 4),
(10, 12, 9, 1),
(11, 11, 11, 2),
(12, 9, 13, 1),
(13, 5, 13, 9),
(14, 10, 4, 1),
(15, 7, 8, 4);


INSERT INTO detalii_comanda
VALUES
(16, 2, 1, 2),
(17, 6, 10, 1),
(18, 1, 5, 0);

SELECT * FROM detalii_comanda;

/*UNA DINTRE COMENZI CONTINE UN PRODUS CU CANTITATE 0, CE NU NECESITA PROCESARE*/

SET sql_safe_updates = 0;
DELETE FROM detalii_comanda
WHERE cantitate = 0;
SET sql_safe_updates = 1;

/*join*/

/*CLIENTUL CU NUMELE Tomas Red DORESTE SCHIMBAREA MASINII DE SPALAT BEKO CU UNA SAMSUNG. AFLAREA ID-ULUI PRODUSULUI FOLOSIND JOIN*/


SELECT detalii_comanda.IDprodus 
FROM detalii_comanda
JOIN comanda ON detalii_comanda.IDcomanda=comanda.IDcomanda
JOIN client ON client.idclient=comanda.IDclient
JOIN produs ON produs.idprodus=detalii_comanda.IDprodus
WHERE client.nume= 'Tomas Red';

UPDATE detalii_comanda
SET IDprodus=2
WHERE IDdetaliicomanda = 10;

/*CLIENTUL CU ID-UL 9 NU MAI DORESTE CUMPARAREA PRODUSULUI CU ID-UL 10*/

DELETE FROM detalii_comanda
WHERE IDdetaliicomanda = 11;

		#4.INTEROGARI VARIATE CU SELECT
/*subinterogari*/

/**afiseaza id-ul si numele produselor care au fost comandate**/

SELECT IDprodus, nume
FROM produs
WHERE IDprodus IN (SELECT IDprodus FROM detalii_comanda);

/**afiseaza id-ul si data comenzilor expediate in anul 2019 de DHL **/

SELECT IDcomanda, data_comanda
FROM comanda
WHERE IDexpeditor = (SELECT IDexpeditor 
					FROM expeditor
                    WHERE firma_curierat = 'DHL')
AND YEAR(data_comanda)=2019;

/**afiseaza nr de produse livrate in orasul Bruxelles in 2018**/

SELECT COUNT(*)
FROM client
WHERE oras = 'Bruxelles'
AND IDclient = (SELECT IDclient 
				FROM comanda
                WHERE YEAR(data_comanda) = 2018);

/*join*/

/**afiseaza numele clientului, data comenzii si numele produslui**/

SELECT cl.nume, co.data_comanda, p.nume
FROM client cl
JOIN comanda co ON cl.IDclient = co.IDclient
JOIN detalii_comanda dc ON co.IDcomanda=dc.IDcomanda
JOIN produs p ON dc.IDprodus=p.IDprodus;

/**afiseaza toate produsele impreuna cu datele comandarii lor, chiar daca acestea nu au fost comandate**/

SELECT p.nume, c.data_comanda
FROM produs p
LEFT JOIN detalii_comanda dc ON p.IDprodus=dc.IDprodus
LEFT JOIN comanda c ON dc.IDcomanda=c.IDcomanda;

/*functii de grup/having*/

/**afiseaza numele clientilor, orasul si tara, grupate dupa anul comenzii si orasul de livrare**/

SELECT GROUP_CONCAT(cl.nume SEPARATOR ',') AS nume_clienti, cl.oras , cl.tara, YEAR(data_comanda)
FROM client cl
JOIN comanda co ON cl.IDclient=co.IDclient
GROUP BY cl.oras, YEAR(data_comanda);

/**afiseaza categoriile ce au un singur produs**/

SELECT ca.nume AS categorie 
FROM categorie ca
LEFT JOIN produs p ON ca.IDcategorie=p.IDcategorie
GROUP BY ca.nume
HAVING COUNT(p.nume) = 1;


/**afiseaza categoriile a caror suma de produse din stoc depaseste 400000**/

SELECT ca.nume, SUM(p.pret*p.bucati) AS suma
FROM categorie ca
LEFT JOIN produs p ON ca.IDcategorie=p.IDcategorie
GROUP BY ca.nume
HAVING SUM(p.pret*p.bucati) > 400000;

/*functii predefinite MySQL*/

/**afiseaza numele si pretul produsului cel mai scump**/

SELECT nume, MAX(pret)
FROM produs;

/**afiseaza cate comenzi au fost plasate in fiecare an**/

SELECT COUNT(*) AS nr_comenzi, YEAR(data_comanda) AS an_comanda
FROM comanda
GROUP BY YEAR(data_comanda);

/**afiseaza detaliile comenzilor din anul 2020 care au statusul comenzii = 'comanda plasata'**/

SELECT *
FROM comanda
WHERE YEAR(data_comanda) = 2020
AND status = 'comanda_plasata';

/**afiseaza doar primele 10 caractere ale adreselor de livrare ale clientilor**/

SELECT SUBSTRING(adresa,1,10) AS adresa10
FROM client;

/**afiseaza numarul de zile dintre plasarea comenzii si livrarea acesteia**/

SELECT IDcomanda, data_comanda, data_livrare, DATEDIFF(data_livrare,data_comanda) AS NumberOfDays
FROM comanda;


		#5. VIEW

 /*crearea unui view cu datele ce apar pe factura, ordonate dupa numele clientului*/
 
CREATE VIEW Factura
AS
SELECT cl.IDclient,
	cl.nume AS NumeClient, 
    cl.adresa, 
    cl.oras, 
    cl.tara, 
    co.IDcomanda,
    co.data_comanda, 
    co.data_livrare,
    e.firma_curierat,
    e.nume AS Expeditor,
    e.telefon AS telefon_expeditor,
    ca.nume AS Categorie,
    p.nume AS Produs,
    dc.cantitate,
    p.pret
    
        
FROM client cl
JOIN comanda co ON cl.IDclient=co.IDclient
JOIN expeditor e ON co.IDexpeditor=e.IDexpeditor
JOIN detalii_comanda dc ON co.IDcomanda=dc.IDcomanda
JOIN produs p ON dc.IDprodus=p.IDprodus
JOIN categorie ca ON p.IDcategorie=ca.IDcategorie
ORDER BY cl.nume;

SELECT * FROM Factura;

/*afisarea ID-ului categoriilor, numelui si totalului incasarilor ale primelor 5 categorii care au adus cele mai mari incasari in 2019, ordonate descrescator dupa totalul vanzarilor*/

 CREATE VIEW Incasari2019
 AS
 SELECT c.IDcategorie, c.nume, dc.cantitate*p.pret AS incasari
 FROM categorie C
 JOIN produs p ON c.IDcategorie=p.IDcategorie
 JOIN detalii_comanda dc ON p.IDprodus= dc.IDprodus
 JOIN comanda co ON dc.IDcomanda=co.IDcomanda
 WHERE YEAR(data_comanda) = 2019
 GROUP BY c.IDcategorie
 ORDER BY incasari DESC
 LIMIT 5;

SELECT * FROM Incasari2019;

		#6. FUNCTII

/*functie care primeste id-ul de client ca parametru de intrare, si intoarce valoarea totala a comenzilor date de acest client*/

DELIMITER //
CREATE FUNCTION total_comenzi_id (id INT)
RETURNS INT
BEGIN
	DECLARE suma INT;
	SELECT SUM(p.pret*dc.cantitate) INTO suma
    FROM produs p
    JOIN detalii_comanda dc ON p.IDprodus=dc.IDprodus
    JOIN comanda c ON dc.IDcomanda=c.IDcomanda
    WHERE IDclient = id
    GROUP BY IDclient;
RETURN suma;
END;
//
DELIMITER ;

SELECT total_comenzi_id(4);

/*functie ce primeste ca parametru de intrare un an, care afla furnizorul de la care s-au comandat cele mai multe produse in respectivul an*/

DELIMITER //
CREATE FUNCTION furnizor_max (an int)
RETURNS VARCHAR(20)
BEGIN
	DECLARE fnume VARCHAR(20);
    SELECT f.nume INTO fnume
    FROM furnizor f
    JOIN produs p ON f.IDfurnizor=p.IDfurnizor
    JOIN detalii_comanda dc ON p.IDprodus=dc.IDprodus
    JOIN comanda c ON dc.IDcomanda=c.IDcomanda
    WHERE YEAR(data_comanda) = an
    GROUP BY f.IDfurnizor
    ORDER BY  SUM(cantitate) DESC
    LIMIT 1;
RETURN fnume;
END;
//
DELIMITER ;

SELECT furnizor_max (2020);

/*functie care sa intoarca telefonul furnizorului in urmatorul format “(####) ###.###.”, in fucntie de id-ul acestuia */

DELIMITER //
CREATE FUNCTION Telefon_furnizor (id_t INT)
RETURNS VARCHAR(25)
BEGIN

	DECLARE telefon_nou VARCHAR(20);   
    
    DECLARE telefon_vechi VARCHAR(15);
    
			SELECT TRIM(telefon) INTO  telefon_vechi 
            FROM furnizor
            WHERE IDfurnizor=id_t;  
            
		SET telefon_nou = CONCAT('(',  LEFT(telefon_vechi, 4),  ') ', SUBSTRING(telefon_vechi, 5, 3) , ' . ' , RIGHT(telefon_vechi, 3));
    
    
RETURN telefon_nou;
    
END;
//
DELIMITER ;

SELECT Telefon_furnizor (4);

		#7.PROCEDURI STOCATE

/*procedura stocata ce intoarce totalul vanzarilor in functie de categoria si anul date ca parametri de intrare*/

DELIMITER //
CREATE PROCEDURE Vanzari_Categorie (IN nume_categorie VARCHAR(15), IN an_comanda VARCHAR(4))
BEGIN
   SELECT CONCAT(ROUND(SUM(dc.cantitate * p.pret)), ' lei') AS TotalVanzari
   FROM detalii_comanda dc
       JOIN comanda co ON dc.IDcomanda=co.IDcomanda
       JOIN produs p ON dc.IDprodus=p.IDprodus
       JOIN Categorie ca  ON p.IDcategorie=ca.IDcategorie
	WHERE Ca.nume = nume_categorie
	AND YEAR(co.data_comanda) = an_comanda
	GROUP BY p.nume
	ORDER BY p.nume;
END; 
//
DELIMITER ;

CALL Vanzari_Categorie('laptop', 2019);

/*procedura stocata care accepta id-ul produsului ca parametru de intrare si intoarce numarul de bucati vandute. 
Daca sunt mai putin de 5 bucati vandute, se afiseaza alaturi de nr de bucati mesajul: 'slab vandut', daca sunt mai mult de 10,
se afiseaza mesajul 'bine vandut', iar daca sunt mai mult de 10 'foarte bine vandut'.*/


DELIMITER //
CREATE PROCEDURE Produse_vandute (IN id_produs INT, OUT Total_vanzari Decimal(9,2), OUT mesaj VARCHAR(25))
BEGIN
	SELECT SUM(cantitate) INTO Total_vanzari
	FROM detalii_comanda
	WHERE id_produs= idprodus; 
	
    IF Total_vanzari < 5 THEN
		SET mesaj= 'Produs slab vandut';
	ELSE 
		IF TOTAL_vanzari >= 5 AND Total_vanzari < 10 THEN
        SET mesaj= 'Produs bine vandut';
        ELSE
			IF Total_vanzari >= 10 THEN
            SET mesaj= 'Produs foarte bine vandut';
            END IF;
        END IF;
	END IF;
    

END;
 //
DELIMITER ;

CALL Produse_vandute (4, @v, @m);
SELECT @v, @m;

/*procedura stocata ce insereaza intr-o tabela temporara numele, bucatile din stoc si pretul produselor ce au pretul mai mare decat media.*/

DELIMITER //

CREATE PROCEDURE Tabela_pret_mediu()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS pret_mediu;
	CREATE TEMPORARY TABLE pret_mediu AS  
     
		SELECT DISTINCT nume, bucati, pret 
		FROM produs
		WHERE pret> (SELECT AVG(pret) FROM produs)
		ORDER BY pret;

SELECT * FROM pret_mediu;
 
END //
DELIMITER ;


CALL Tabela_pret_mediu;

		#8. CURSORI

/*procedura ce primeste ca marametru de intrare o valoare totala de comanda.
Contine un cursor care determina toate comenzile mai mari decat aceasta valoare si intoarce numele clientului, data_comanda, statusul comenzii si valoarea totala a acesteia.*/

DELIMITER //
CREATE PROCEDURE Comenzi_mari(IN valoare INT)
BEGIN
                                    
    DECLARE nume_client VARCHAR(50);
    DECLARE data_co DATE;
    DECLARE status_comanda VARCHAR(50);
    DECLARE valoare_comanda INT;
    DECLARE ok TINYINT DEFAULT 1; 

    DECLARE c CURSOR FOR
        SELECT cl.nume, co.data_comanda, co.status, SUM(dc.cantitate * p.pret)
        FROM client cl
        JOIN comanda co ON cl.IDclient=co.IDclient
        JOIN detalii_comanda dc ON co.IDcomanda=dc.IDcomanda
        JOIN produs p ON dc.IDprodus=p.IDprodus
        GROUP BY cl.nume
        HAVING SUM(dc.cantitate * p.pret) > valoare;
      
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET ok = 0; 
    
    CREATE OR REPLACE TEMPORARY TABLE tabela (nume_client VARCHAR(50), 
									data_plasare_comanda DATE, 
                                    status_comanda VARCHAR(30), 
                                    valoare_totala_comanda INT); 
    OPEN c;
    
       
    valoare: LOOP
		FETCH c INTO nume_client, data_co, status_comanda, valoare;
        IF ok = 0 THEN
	LEAVE valoare;
        ELSE
			INSERT INTO tabela
            VALUES (nume_client, data_co, status_comanda, valoare);
		END IF;
	END LOOP valoare;
    
    SELECT * FROM tabela;
END;
//
DELIMITER ;

CALL Comenzi_mari(20000);

/*procedura care primeste 2 parametri: anul, tara.
Procedura foloseste un cursor pentru a afisa categoria cea mai comandata in tara si in anul date, furnizorul si cantitatea acesteia.*/

DELIMITER //
CREATE PROCEDURE furnizori_tara_an(IN tara_c varchar(50), IN an YEAR )
BEGIN
    DECLARE categorie VARCHAR(50);
    DECLARE furnizor VARCHAR(50);
    DECLARE comanda INT;
    DECLARE ok TINYINT DEFAULT 1;
        
    DECLARE c CURSOR FOR 
		SELECT f.nume, ca.nume, SUM(dc.cantitate)
		FROM furnizor f
        JOIN produs p ON f.IDfurnizor=p.IDfurnizor
        JOIN categorie ca ON p.IDcategorie=ca.IDcategorie
        JOIN detalii_comanda dc ON p.IDProdus = dc.Idprodus
        JOIN comanda co ON dc.IDcomanda=co.IDcomanda
        JOIN client cl ON co.IDclient=cl.IDclient
        
			WHERE YEAR(data_comanda) = an AND cl.tara=tara_c
            GROUP BY f.nume, ca.nume
            ORDER BY SUM(dc.cantitate) DESC
            LIMIT 1;
            
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET ok = 0; 
    
    
    CREATE OR REPLACE TEMPORARY TABLE tabela_detalii (furnizor VARCHAR(50), 
                                    categorie VARCHAR(30), 
                                    cantitate_vanduta INT); 
    OPEN c;
    bucla: LOOP
        FETCH c INTO furnizor, categorie, comanda;
        IF ok = 0 THEN
            LEAVE bucla;
        ELSE 
            INSERT INTO tabela_detalii
            VALUES (furnizor, categorie, comanda);
		END IF;
	END LOOP bucla;
    CLOSE c;    
  
   SELECT * FROM tabela_detalii;
END;
//
DELIMITER ; 

CALL furnizori_tara_an('Romania', 2019);

/*functie cu un cursor ce determina toate firmele de curierat, concatenate intr-o lista, 
ce au livrat comenzi mai tarziu de 30 zile de la data comenzii (parametru de intrare pentru functie)*/

DELIMITER //
CREATE FUNCTION expeditori_zile (zile INT)
RETURNS VARCHAR(500)
BEGIN
	DECLARE firma VARCHAR(50);
    DECLARE lista_firme VARCHAR(500);
    DECLARE ok TINYINT DEFAULT 1;
    
    DECLARE c CURSOR FOR
		SELECT DISTINCT firma_curierat
		FROM expeditor, comanda
		WHERE DATEDIFF(data_livrare, data_comanda)>30;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET ok = 0;
    OPEN c;
    firme: LOOP
		 FETCH c INTO firma;
         IF ok = 0 THEN
         LEAVE firme;
         ELSE 
			
         SET lista_firme = CONCAT_WS(', ', lista_firme, firma);
		
         END IF;
    END LOOP firme;
	CLOSE c;

RETURN lista_firme;

END;
//
DELIMITER ;

SELECT EXPEDITORI_ZILE(30);

		#9.Triggeri

/*trigger la plasarea unei noi comenzi, daca se introduce data comenzii < data curenta, se insereaza automat
data curenta, si data_livrare = getdate + 5 zile*/

DELIMITER //
CREATE TRIGGER bi_comanda BEFORE INSERT 
ON comanda FOR EACH ROW
BEGIN 
	IF NEW.data_comanda <CURDATE() THEN
    SET NEW.data_comanda = CURDATE();
    END IF;
    IF NEW.data_livrare IS NULL THEN 
    SET NEW.data_livrare = DATE_ADD(CURDATE(), INTERVAL 5 DAY);
    END IF;
END;
//
DELIMITER ;

INSERT INTO comanda
VALUES
(NULL, 1, 20190304, NULL, 3,'comanda_plasata');

SELECT * FROM comanda;

/*trigger la plasarea unei noi comenzi: verificare daca cantitate < bucati produs pe stoc,
daca nu, arunca eroare.*/

DELIMITER //

CREATE TRIGGER bi_detalii_comanda
     BEFORE INSERT ON detalii_comanda FOR EACH ROW
     BEGIN
          IF NEW.cantitate > (SELECT bucati 
						FROM produs p
						JOIN detalii_comanda dc ON 	p.IDprodus=dc.IDprodus
                        WHERE NEW.IDprodus = p.IDprodus)
          THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'NU AVEM ATATEA BUCATI IN STOC';
          END IF;
     END;
//


INSERT INTO detalii_comanda
VALUES
(NULL, 4, 15, 500);

SELECT * FROM detalii_comanda;

/*trigger la modificarea adresei unui client, daca acesta are o comanda in curs de procesare (nu exte comanda_livrata), arunca o eroare*/

DELIMITER //

CREATE TRIGGER bu_client
     BEFORE UPDATE ON client FOR EACH ROW
     BEGIN
          IF NEW.IDclient IN (SELECT c.IDclient
							FROM client c
                            JOIN comanda co ON c.IDclient=co.IDclient
					        AND status != 'comanda_livrata')
          THEN
               SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'NU SE POATE MODIFICA ADRESA DE LIVRARE. COMANDA IN CURS';
          END IF;
     END;
//

UPDATE client SET adresa = 'Str. Verzilor nr. 4' WHERE idclient=5; #update-ul se produce

SELECT * FROM client;

UPDATE client SET adresa = 'Str. Verzilor nr. 4' WHERE idclient=7; #update-ul nu se produce

									# Multumesc mult pentru rabdare! :)
