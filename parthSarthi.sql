DROP USER 'userNew'@'%';
DROP DATABASE IF EXISTS ParthSarthi;
CREATE DATABASE ParthSarthi;
USE ParthSarthi;

CREATE USER userNew IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON ParthSarthi.* TO 'userNew'@'%';

CREATE TABLE user (
	userID VARCHAR(30) ,
    userName VARCHAR(30) ,
    -- userEmail VARCHAR(50) ,
    userPass VARCHAR(30) ,
    userPhone VARCHAR(10),
    -- sanitize entry with react    
    PRIMARY KEY(userID)
    -- FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

CREATE TABLE driver (
	driverID INT ,
    driverName VARCHAR(30) ,
    driverPass VARCHAR(30) ,
    driverPhone VARCHAR(30) ,
    PRIMARY KEY(driverID)
    -- FOREIGN KEY (cabID) REFERENCES cab(cabID),
    -- FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

CREATE TABLE cab (
	cabID INT,
    cabNum VARCHAR(17) ,
    cabService VARCHAR(10) ,
    cabCapacity INT ,
    PRIMARY KEY(cabID)
    -- FOREIGN KEY (driverID) REFERENCES driver(driverID),
    -- FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

CREATE TABLE app (
	firstName VARCHAR(30) ,
    lastName VARCHAR(30) ,
    -- CONCAT name (firstName,lastName),
    username VARCHAR(30) ,
    password VARCHAR(30) ,
    PRIMARY KEY(username)
    -- FOREIGN KEY (userID) REFERENCES user(userID),
    -- FOREIGN KEY (driverID) REFERENCES driver(driverID),
    -- FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

CREATE TABLE receipt (
	distanceTravelled INT ,
    fare INT 
	-- discount INT ,
	-- penalty INT ,
	-- moment DATETIME 
    -- datetime: DDMMYYhhhh
    -- PRIMARY KEY(userID,driverID,moment)
    -- FOREIGN KEY(userID) REFERENCES user(userID),
    -- FOREIGN KEY(driverID) REFERENCES driver(driverID)
);

CREATE TABLE booking (
	bookID INT ,
    pickupLocation VARCHAR(100) ,
    pickupTime TIME,
    dropLocation VARCHAR(100) ,
    -- dropTime TIME ,
    -- currentStatus VARCHAR(10) ,
    -- services VARCHAR(10) ,
    capacity INT ,
    PRIMARY KEY(bookID)
    -- FOREIGN KEY (userID) REFERENCES user(userID),
    -- FOREIGN KEY (cabID) REFERENCES cab(cabID)
);

ALTER TABLE user ADD (bookID INT, FOREIGN KEY (bookID) REFERENCES booking(bookID));
ALTER TABLE driver ADD(cabID INT, FOREIGN KEY (cabID) REFERENCES cab(cabID));
ALTER TABLE driver ADD(bookID INT, FOREIGN KEY (bookID) REFERENCES booking(bookID));
ALTER TABLE cab ADD(driverID INT, FOREIGN KEY (driverID) REFERENCES driver(driverID));
ALTER TABLE cab ADD(bookID INT, FOREIGN KEY (bookID) REFERENCES booking(bookID));
ALTER TABLE app ADD(userID VARCHAR(30), FOREIGN KEY (userID) REFERENCES user(userID));
ALTER TABLE app ADD(driverID INT, FOREIGN KEY (driverID) REFERENCES driver(driverID));
ALTER TABLE app ADD(bookID INT, FOREIGN KEY (bookID) REFERENCES booking(bookID));
ALTER TABLE receipt ADD(userID VARCHAR(30), FOREIGN KEY(userID) REFERENCES user(userID));
-- ALTER TABLE receipt ADD(cabID INT , FOREIGN KEY(cabID) REFERENCES cab(cabID));
ALTER TABLE booking ADD(userID VARCHAR(30), FOREIGN KEY (userID) REFERENCES user(userID));
ALTER TABLE booking ADD(cabID INT, FOREIGN KEY (cabID) REFERENCES cab(cabID));
ALTER TABLE receipt ADD PRIMARY KEY (userID);

CREATE TABLE hosts (
    userID VARCHAR(30),
    driverID INT,
    username VARCHAR(30),
    FOREIGN KEY (userID) REFERENCES user(userID),
    FOREIGN KEY (driverID) REFERENCES driver(driverID),
    FOREIGN KEY (username) REFERENCES app(username)
);

CREATE TABLE finds (
	availability bool,
    cabID INT ,
    bookID INT ,
    FOREIGN KEY (cabID) REFERENCES cab(cabID),
    FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

CREATE TABLE reviews (
    userReview VARCHAR(100) DEFAULT NULL,
    driverReview VARCHAR(100) DEFAULT NULL,
    tripCompletion bool,
    userID VARCHAR(30) ,
    driverID INT ,
    FOREIGN KEY (userID) REFERENCES user(userID),
    FOREIGN KEY (driverID) REFERENCES driver(driverID)
);

CREATE TABLE cancels (
    driverStatus VARCHAR(10) ,
    driverID INT ,
    bookID INT ,
    FOREIGN KEY (driverID) REFERENCES driver(driverID),
    FOREIGN KEY (bookID) REFERENCES booking(bookID)
);

DELIMITER //
CREATE TRIGGER trg_receipt_distance_travelled
BEFORE INSERT ON receipt
FOR EACH ROW
BEGIN
    IF NEW.distanceTravelled <= 0 THEN
        SET NEW.distanceTravelled = 1;
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE TRIGGER set_pickupTime_trigger
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
    SET NEW.pickupTime = NOW();
END;
//DELIMITER ;

insert into app (firstName, lastName, username, password) values ('parth', 'banjoo', 'parthsarthi', 'password');

insert into driver (driverID, driverName, driverPass, driverPhone) values (1,'Guss Pim', 'cQWGpW5', '3451327089');
insert into driver (driverID, driverName, driverPass, driverPhone) values (2,'Evey Dullard', 'JWuHzJmKuj', '2815248805');
insert into driver (driverID, driverName, driverPass, driverPhone) values (3,'Annie Elflain', '6hGdPHSS', '1485475535');
insert into driver (driverID, driverName, driverPass, driverPhone) values (4,'Fee Damsell', 'BpBGFKXMWmA', '3134080520');
insert into driver (driverID, driverName, driverPass, driverPhone) values (5,'Kiley Feronet', 'FIa8c0me', '5667420208');
insert into driver (driverID, driverName, driverPass, driverPhone) values (6,'Aguste Capelen', 'w0K1SfETXCpY', '2411341655');
insert into driver (driverID, driverName, driverPass, driverPhone) values (7,'Gunner Brand', 'CAjmREyhbD8g', '2448287906');
insert into driver (driverID, driverName, driverPass, driverPhone) values (8,'Gerladina Blakebrough', 'MuUxEHke1G', '7026601018');
insert into driver (driverID, driverName, driverPass, driverPhone) values (9,'Devon McNirlan', 'DvBW7sUswxo', '1735179516');
insert into driver (driverID, driverName, driverPass, driverPhone) values (10,'Netty Mason', 'S1sKBnUja5aA', '7046404290');
insert into driver (driverID, driverName, driverPass, driverPhone) values (11,'Margarita Reynalds', 'Nhbcub', '5355308584');
insert into driver (driverID, driverName, driverPass, driverPhone) values (12,'Penelope Ughelli', 'IyBQRuDzbk', '6853166739');
insert into driver (driverID, driverName, driverPass, driverPhone) values (13,'Francine Ledes', 'Jw3B54xdr', '7431056959');
insert into driver (driverID, driverName, driverPass, driverPhone) values (14,'Joana Manhare', 'mWFklscY', '4537651850');
insert into driver (driverID, driverName, driverPass, driverPhone) values (15,'Lemmie Glusby', 'EggUrV6zIlf', '1765869683');
insert into driver (driverID, driverName, driverPass, driverPhone) values (16,'Toiboid Oats', 'fNlsaOczHsK', '5966564241');
insert into driver (driverID, driverName, driverPass, driverPhone) values (17,'Rois Pitrollo', 'ozsi3d', '5472668679');
insert into driver (driverID, driverName, driverPass, driverPhone) values (18,'Lavinie Kilgallen', 'r0s0sR', '7395856210');
insert into driver (driverID, driverName, driverPass, driverPhone) values (19,'Ed Farmiloe', 'zldb1T4z', '5937110227');
insert into driver (driverID, driverName, driverPass, driverPhone) values (20,'Wade Breslin', 'e0tvli', '5921235369');
insert into driver (driverID, driverName, driverPass, driverPhone) values (21,'Fraze Birth', 'Gt4ZQnbQqWo', '6672076225');
insert into driver (driverID, driverName, driverPass, driverPhone) values (22,'Georgetta Denekamp', 'PRzl3iJjOJwX', '4293852407');
insert into driver (driverID, driverName, driverPass, driverPhone) values (23,'Minny Patrono', '1B2vfJ', '3304388601');
insert into driver (driverID, driverName, driverPass, driverPhone) values (24,'Laird Swansborough', 'N4iXcvMdC9K', '2864015465');
insert into driver (driverID, driverName, driverPass, driverPhone) values (25,'Bev Troker', 'NrL5QjCMi', '1151210947');
insert into driver (driverID, driverName, driverPass, driverPhone) values (26,'Hewet Densell', '7ILnb4nYc6a', '9128307949');
insert into driver (driverID, driverName, driverPass, driverPhone) values (27,'Gualterio Lawtey', 'urfj0s', '8976806687');
insert into driver (driverID, driverName, driverPass, driverPhone) values (28,'Remus Mc Ilory', 'nzD6wvVBJS', '5429710984');
insert into driver (driverID, driverName, driverPass, driverPhone) values (29,'Margot Cavozzi', 'SuWh6GJ', '2081838910');
insert into driver (driverID, driverName, driverPass, driverPhone) values (30,'Vilhelmina Zannutti', 'MAaCqf', '6869043182');
insert into driver (driverID, driverName, driverPass, driverPhone) values (31,'Jeffrey Darycott', 'psCIvDT', '6165285191');
insert into driver (driverID, driverName, driverPass, driverPhone) values (32,'Laverne Allcorn', 'zfaa9JqoF', '4209620732');
insert into driver (driverID, driverName, driverPass, driverPhone) values (33,'Amara O''Quin', 'eIyPKKdE3M', '7679711068');
insert into driver (driverID, driverName, driverPass, driverPhone) values (34,'Pavla Whillock', 'Zu30zuHA', '6513389407');
insert into driver (driverID, driverName, driverPass, driverPhone) values (35,'Darryl Morales', 'e5mcA9fXJ5', '4567629203');
insert into driver (driverID, driverName, driverPass, driverPhone) values (36,'Karlotta Gadie', 'bT2fUO3bvVj', '3157312491');
insert into driver (driverID, driverName, driverPass, driverPhone) values (37,'Thoma Marklow', '1bqYdPy', '3031843285');
insert into driver (driverID, driverName, driverPass, driverPhone) values (38,'Suki Cavendish', 'R2JJro', '3044201133');
insert into driver (driverID, driverName, driverPass, driverPhone) values (39,'Daren Lunck', '9gKYSU3G1Cd', '1959858158');
insert into driver (driverID, driverName, driverPass, driverPhone) values (40,'Gardy Cottom', 'aKOu3hD1n', '7703980009');
insert into driver (driverID, driverName, driverPass, driverPhone) values (41,'Stacie Rabbitt', 'EDNbjpBAO0XI', '5547202346');
insert into driver (driverID, driverName, driverPass, driverPhone) values (42,'Damian Waadenburg', 'ZLrDwEs', '8206510815');
insert into driver (driverID, driverName, driverPass, driverPhone) values (43,'Mack Brugemann', 'bQPa6oB9w', '4305305751');
insert into driver (driverID, driverName, driverPass, driverPhone) values (44,'Lauren Cockrem', '308A5v', '6571814598');
insert into driver (driverID, driverName, driverPass, driverPhone) values (45,'Gunther Waddoups', 'VAlYTa1VD1', '3871689626');
insert into driver (driverID, driverName, driverPass, driverPhone) values (46,'Kellina Plaister', 'uiB1a3Ep', '9636506213');
insert into driver (driverID, driverName, driverPass, driverPhone) values (47,'Rica Hasnip', '4iZSU2', '5287755379');
insert into driver (driverID, driverName, driverPass, driverPhone) values (48,'Seka Shayler', 'N5HgXl', '7119985694');
insert into driver (driverID, driverName, driverPass, driverPhone) values (49,'Deanne Vagg', 'FjqTQl', '1213138441');
insert into driver (driverID, driverName, driverPass, driverPhone) values (50,'Matteo Lampel', 'pqRbMGuSrNe', '1186015451');
insert into driver (driverID, driverName, driverPass, driverPhone) values (51,'Christiano Sultana', 'VBjg8smOWF', '3616928341');
insert into driver (driverID, driverName, driverPass, driverPhone) values (52,'Tamarra Hattersley', 'i0YV9sxu5A', '2028370366');
insert into driver (driverID, driverName, driverPass, driverPhone) values (53,'Prudence Tommis', '5cN7m3arePI', '9399971512');
insert into driver (driverID, driverName, driverPass, driverPhone) values (54,'Abie Phette', '5UDSXS1Ove5j', '3494791474');
insert into driver (driverID, driverName, driverPass, driverPhone) values (55,'Fallon Bhatia', 'BShZswf2', '4294483508');
insert into driver (driverID, driverName, driverPass, driverPhone) values (56,'Kasper Serraillier', 'kBVPcnRhCU', '9599930714');
insert into driver (driverID, driverName, driverPass, driverPhone) values (57,'Iormina Wigg', 'ARbfzkGf1DR', '6082654902');
insert into driver (driverID, driverName, driverPass, driverPhone) values (58,'Abner Cockrill', 'sHmpI2u33e', '2535708091');
insert into driver (driverID, driverName, driverPass, driverPhone) values (59,'Stevie Scrafton', 'rVByJeKbha', '9024143941');
insert into driver (driverID, driverName, driverPass, driverPhone) values (60,'Haily MacLese', 'uMeJ4GzLYN', '2074189155');
insert into driver (driverID, driverName, driverPass, driverPhone) values (61,'Jayne Pillans', 'g1uo2G9m', '2565196735');
insert into driver (driverID, driverName, driverPass, driverPhone) values (62,'Elysee Schnitter', 'ez35Rc', '2312614759');
insert into driver (driverID, driverName, driverPass, driverPhone) values (63,'Rosie Challes', 'BIvxt7UGDZ', '4457696008');
insert into driver (driverID, driverName, driverPass, driverPhone) values (64,'Letta Clayworth', 'FLCiaE', '9052904350');
insert into driver (driverID, driverName, driverPass, driverPhone) values (65,'Dru Carslaw', 'KVYh6Iop', '3917904945');
insert into driver (driverID, driverName, driverPass, driverPhone) values (66,'Alanah Janu', 'SH8m42Gq5', '6752087457');
insert into driver (driverID, driverName, driverPass, driverPhone) values (67,'Gus Moakson', 'jiR9uPx3cAk', '9575264470');
insert into driver (driverID, driverName, driverPass, driverPhone) values (68,'Isahella Mattielli', 'KRD593bWz', '7799523837');
insert into driver (driverID, driverName, driverPass, driverPhone) values (69,'Ella Allnatt', '0ztL5ctt', '4033402713');
insert into driver (driverID, driverName, driverPass, driverPhone) values (70,'Audry Charnley', 't1ry2duXY', '7391290116');
insert into driver (driverID, driverName, driverPass, driverPhone) values (71,'Mireille Ragot', '14VsoLZF5', '9984060201');
insert into driver (driverID, driverName, driverPass, driverPhone) values (72,'Gael Helix', 'oYmlU0Bm', '2636593767');
insert into driver (driverID, driverName, driverPass, driverPhone) values (73,'Jacynth Lorkins', '2vO5zv', '1441742241');
insert into driver (driverID, driverName, driverPass, driverPhone) values (74,'Orv Fairbeard', 'CDtEiVIG1rd', '2367608275');
insert into driver (driverID, driverName, driverPass, driverPhone) values (75,'Norbert Girardot', 'UO0cp3ZjXwwu', '7453850413');
insert into driver (driverID, driverName, driverPass, driverPhone) values (76,'Walt Fancourt', '0ThGrTy', '2448975422');
insert into driver (driverID, driverName, driverPass, driverPhone) values (77,'Bordy Favela', 'Yn9CPhd5NAi', '9795460551');
insert into driver (driverID, driverName, driverPass, driverPhone) values (78,'Powell Perrone', 'ftGN2iyf', '7582193571');
insert into driver (driverID, driverName, driverPass, driverPhone) values (79,'Celestine Cattroll', 'mq9mvH3tc', '1212124557');
insert into driver (driverID, driverName, driverPass, driverPhone) values (80,'Janina Louth', 'Pl4tX2ikHGP', '1087260004');
insert into driver (driverID, driverName, driverPass, driverPhone) values (81,'Leena Durden', 'QZLqzhP', '6146661920');
insert into driver (driverID, driverName, driverPass, driverPhone) values (82,'Adolf Borsi', 'ScgMeAY', '8943491788');
insert into driver (driverID, driverName, driverPass, driverPhone) values (83,'Hadrian Pevsner', 'iR5VmAa2h', '4266420665');
insert into driver (driverID, driverName, driverPass, driverPhone) values (84,'Rafe Kenningham', 'bHhdp5IZra9p', '5516899361');
insert into driver (driverID, driverName, driverPass, driverPhone) values (85,'Sena Tucsell', 'rqlR5s', '2255708925');
insert into driver (driverID, driverName, driverPass, driverPhone) values (86,'Tabby Tearle', 'MxKV2Muxba60', '4958168854');
insert into driver (driverID, driverName, driverPass, driverPhone) values (87,'Layla Cater', 'gDU9DijrZu', '9817983937');
insert into driver (driverID, driverName, driverPass, driverPhone) values (88,'Crichton O''Rowane', 'MJXKGJK', '1782097782');
insert into driver (driverID, driverName, driverPass, driverPhone) values (89,'Liz Ivel', 'J8Le0Yoe6', '8839208850');
insert into driver (driverID, driverName, driverPass, driverPhone) values (90,'Reyna Jakubovski', 'QkL39vT', '9293530253');
insert into driver (driverID, driverName, driverPass, driverPhone) values (91,'Myles Fyall', 'JumNORGD', '9808099145');
insert into driver (driverID, driverName, driverPass, driverPhone) values (92,'Candi Marusyak', 'SgY1LdbKWh7K', '7164222080');
insert into driver (driverID, driverName, driverPass, driverPhone) values (93,'Greg Toulson', 'S5e2hGtYZSmQ', '7011213668');
insert into driver (driverID, driverName, driverPass, driverPhone) values (94,'Ingrim Eldin', 'UUsSxA6urR', '4604553126');
insert into driver (driverID, driverName, driverPass, driverPhone) values (95,'Monro Norcock', 'gTZZWeh87rj', '1762965670');
insert into driver (driverID, driverName, driverPass, driverPhone) values (96,'Nevin Antonopoulos', 'BHYx1R9rs', '2845181880');
insert into driver (driverID, driverName, driverPass, driverPhone) values (97,'Xerxes Gonin', '4INSNZMMrlKe', '4656893134');
insert into driver (driverID, driverName, driverPass, driverPhone) values (98,'Alexine Gulleford', '1OIc4H1iIDXW', '4391540181');
insert into driver (driverID, driverName, driverPass, driverPhone) values (99,'Benny Waldrum', 'kmPgxR7Lg', '8211249431');
insert into driver (driverID, driverName, driverPass, driverPhone) values (100,'Jacquelin Rosengren', 'TxdQVs', '2812306455');

CREATE INDEX driverIDIndex ON driver(driverID);

insert into cab (cabID, cabNum, cabService, cabCapacity) values (1, '1GYFK63898R464866', "active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (2, 'WBAXH5C55DD678413', "active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (3, '2C3CCARG9DH416354', "active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (4, '1C3BCBGGXEN851140', "active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (5, 'WVGEF9BP3ED768750', "active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (6, 'JH4KC1F70EC201105', "active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (7, '1G6DV1EP2D0497849', "active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (8, '1FTEW1CWXAF323705', "active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (9, 'WAUMF78P86A325862', "active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (10, 'WAUSF98E87A052554',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (11, 'WBANF33506B860617',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (12, 'WA1WKBFP9BA979545',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (13, '1GYS4BEF2DR500193',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (14, '1G4HC5EM6AU565071',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (15, '4T1BF1FK6FU320300',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (16, 'WBAUP7C59AV102508',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (17, 'WAUAH74F08N771168',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (18, '1N6AA0CA7DN878679',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (19, '2C3CDXEJ5DH705717',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (20, 'JTHBE1D23E5010963',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (21, 'JTJBC1BA9E2894858',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (22, 'WP0AB2A90AS379918',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (23, '2HNYD28557H285247',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (24, 'SCBZB25E62C422182',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (25, 'JH4CU2F40CC741905',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (26, '4JGDA2EB5CA676748',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (27, 'WA1YL54B64N366213',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (28, '1GTN1UEH3EZ203802',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (29, 'SCFAD02A86G470650',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (30, '1G6DS5E31D0613880',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (31, 'WBAEK13476C160420',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (32, 'WUADUAFG5AN578117',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (33, '3D4PG3FG6BT227959',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (34, '4USBU53557L862019',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (35, '1D7RB1CP5BS069814',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (36, 'KL4CJGSB7DB975715',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (37, 'JN1CV6AP8BM172613',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (38, 'WAUNE78PX8A237485',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (39, 'WBAAV53431J896806',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (40, 'JH4CW2H51BC548810',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (41, 'WBA3A9G54DN131325',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (42, 'SCBFC7ZA2DC613606',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (43, '1FMJK1H51BE703013',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (44, 'WUAAU34259N326787',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (45, 'WBADR63471G174744',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (46, '3C3CFFAR8CT587605',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (47, 'WAUVC58EX3A950632',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (48, 'WAUNF98P66A427922',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (49, '5N1AR2MM4FC337132',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (50, '5UXXW3C58F0208933',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (51, 'WAUHGAFC7DN565079',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (52, 'WBADW7C51BE400393',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (53, '2C4RDGBG0DR755241',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (54, 'WAUGL78E15A488145',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (55, '3FAHP0DC8BR284635',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (56, 'WBA3A5C53EP412312',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (57, 'WAUGL78E05A729502',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (58, '5NPET4ACXAH217203',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (59, '19UUA76528A323757',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (60, '2G61T5S30F9918509',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (61, 'WAUYGAFC6CN452870',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (62, 'WBANU5C53AC781852',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (63, 'JTHBB1BA7B2115876',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (64, 'WUARL48H99K638655',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (65, 'WA1VMBFE0ED769150',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (66, '1G6DU6EA5A0470023',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (67, 'WBSDE93451B810907',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (68, 'YV4902DZ0D2918480',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (69, '5YMGZ0C58CL830439',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (70, '1N6AD0CU6BC827779',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (71, 'WAULD54B22N455381',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (72, '1GYFK438X8R083791',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (73, 'WA1CV74L87D310986',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (74, 'SCBBR93W59C712943',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (75, '1G4GA5GR7CF535305',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (76, '1N4AA5AP1DC442970',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (77, '1D7RE3BK0AS918965',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (78, '1GYEE437290168379',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (79, 'JH4CW2H57DC714265',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (80, 'SCBLE47K49C398678',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (81, '5J6TF1H34CL854938',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (82, 'JN1AZ4EH0CM848119',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (83, '1N6BF0KX4FN659970',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (84, 'JA32U1FU5BU550334',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (85, '5UXWX7C59CL851737',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (86, 'WBAXG5C50CD878200',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (87, 'JN1AJ0HP3CM829552',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (88, '5TDBKRFH8FS596727',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (89, 'WUAGNAFG3BN446565',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (90, '5J6TF2H5XDL718595',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (91, 'WA1CFBFP7BA157317',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (92, 'JH4CU2F65DC962158',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (93, 'WAUJGBFC2DN060980',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (94, 'WAUAH74F76N086159',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (95, '5TFBY5F1XBX452868',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (96, 'KM8NU4CCXAU039353',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (97, 'WBA3D5C5XFK079399',"active", 2);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (98, 'WAU4FAFR4CA976502',"active", 6);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (99, 'SCBCC41NX9C903812',"active", 3);
insert into cab (cabID, cabNum, cabService, cabCapacity) values (100, '1GD422CG6EF054712', "active", 3);

CREATE VIEW familycabs AS
SELECT *
FROM cab
WHERE cabCapacity > 5;