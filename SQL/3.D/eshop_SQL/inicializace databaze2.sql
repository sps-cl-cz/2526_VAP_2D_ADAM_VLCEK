IF DB_ID('EshopDB') IS NOT NULL
BEGIN
    ALTER DATABASE EshopDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EshopDB;
END
GO

CREATE DATABASE EshopDB COLLATE Czech_CI_AS;
GO

USE EshopDB;
GO

CREATE TABLE Kategorie (
    id_kategorie INT PRIMARY KEY IDENTITY(1,1),
    nazev VARCHAR(100) NOT NULL,
    popis VARCHAR(255),
    id_nadrazena_kategorie INT NULL FOREIGN KEY REFERENCES Kategorie(id_kategorie)
);

CREATE TABLE Dodavatele (
    id_dodavatel INT PRIMARY KEY IDENTITY(1,1),
    nazev_firmy VARCHAR(100) NOT NULL,
    ico VARCHAR(20) NOT NULL UNIQUE,
    zeme VARCHAR(50) NOT NULL,
    kontakt_email VARCHAR(100),
    aktivni BIT NOT NULL DEFAULT 1
);

CREATE TABLE Produkty (
    id_produkt INT PRIMARY KEY IDENTITY(1,1),
    nazev VARCHAR(150) NOT NULL,
    id_kategorie INT NULL FOREIGN KEY REFERENCES Kategorie(id_kategorie),
    id_dodavatel INT NULL FOREIGN KEY REFERENCES Dodavatele(id_dodavatel),
    cena DECIMAL(10,2) NOT NULL,
    skladem INT NOT NULL DEFAULT 0,
    zaruka_mesice INT NOT NULL DEFAULT 24,
    aktivni BIT NOT NULL DEFAULT 1
);

CREATE TABLE Zakaznici (
    id_zakaznik INT PRIMARY KEY IDENTITY(1,1),
    jmeno VARCHAR(50) NOT NULL,
    prijmeni VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefon VARCHAR(20),
    mesto VARCHAR(50) NOT NULL,
    datum_registrace DATE NOT NULL DEFAULT GETDATE(),
    vip BIT NOT NULL DEFAULT 0
);

CREATE TABLE Dopravci (
    id_dopravce INT PRIMARY KEY IDENTITY(1,1),
    nazev VARCHAR(100) NOT NULL,
    cena_dopravy DECIMAL(10,2) NOT NULL,
    doba_doruceni_dny INT NOT NULL
);

CREATE TABLE Objednavky (
    id_objednavka INT PRIMARY KEY IDENTITY(1,1),
    id_zakaznik INT NULL FOREIGN KEY REFERENCES Zakaznici(id_zakaznik),
    id_dopravce INT NULL FOREIGN KEY REFERENCES Dopravci(id_dopravce),
    datum_objednavky DATETIME NOT NULL DEFAULT GETDATE(),
    stav VARCHAR(30) NOT NULL DEFAULT 'Nová',
    zpusob_platby VARCHAR(30) NOT NULL,
    celkova_cena DECIMAL(10,2) NOT NULL
);

CREATE TABLE PolozkyObjednavky (
    id_polozka INT PRIMARY KEY IDENTITY(1,1),
    id_objednavka INT NOT NULL FOREIGN KEY REFERENCES Objednavky(id_objednavka),
    id_produkt INT NOT NULL FOREIGN KEY REFERENCES Produkty(id_produkt),
    pocet_kusu INT NOT NULL DEFAULT 1,
    cena_za_kus DECIMAL(10,2) NOT NULL,
    sleva_procenta INT NOT NULL DEFAULT 0
);

CREATE TABLE Recenze (
    id_recenze INT PRIMARY KEY IDENTITY(1,1),
    id_produkt INT NOT NULL FOREIGN KEY REFERENCES Produkty(id_produkt),
    id_zakaznik INT NULL FOREIGN KEY REFERENCES Zakaznici(id_zakaznik),
    hodnoceni INT NOT NULL CHECK (hodnoceni BETWEEN 1 AND 5),
    text_recenze VARCHAR(500),
    datum_recenze DATE NOT NULL DEFAULT GETDATE()
);
GO

INSERT INTO Kategorie (nazev, popis, id_nadrazena_kategorie) VALUES
('Elektronika', 'Spotøební elektronika a výpoèetní technika', NULL),
('Notebooky', 'Pøenosné poèítaèe pro práci, studium i hraní', 1),
('Mobilní telefony', 'Chytré telefony a pøíslušenství', 1),
('Monitory', 'Kanceláøské, grafické a herní monitory', 1),
('Audio', 'Sluchátka, reproduktory a mikrofony', 1),
('Pøíslušenství', 'Klávesnice, myši, kabely a brašny', 1),
('Chytrá domácnost', 'Chytré osvìtlení, zásuvky a senzory', NULL),
('Herní konzole', 'Konzole a herní ovladaèe', 1);

INSERT INTO Dodavatele (nazev_firmy, ico, zeme, kontakt_email, aktivni) VALUES
('AlzaTech Distribution s.r.o.', '27082440', 'Èeská republika', 'obchod@alzatech.cz', 1),
('EuroElectro GmbH', '45123698', 'Nìmecko', 'sales@euroelectro.de', 1),
('CzechPeripherals a.s.', '60193521', 'Èeská republika', 'info@czechperipherals.cz', 1),
('SmartHome Slovakia s.r.o.', '36842105', 'Slovensko', 'kontakt@smarthome.sk', 1),
('GlobalDisplay Corp.', '88412039', 'Nizozemsko', 'orders@globaldisplay.nl', 1),
('TechImport Polska Sp. z o.o.', '52104879', 'Polsko', 'biuro@techimport.pl', 1),
('Nordic Audio AB', '91023488', 'Švédsko', 'hello@nordicaudio.se', 0);

INSERT INTO Produkty (nazev, id_kategorie, id_dodavatel, cena, skladem, zaruka_mesice, aktivni) VALUES
('Notebook Lenovo ThinkPad E16', 2, 1, 24990.00, 8, 24, 1),
('Notebook ASUS ZenBook 14', 2, 2, 28500.00, 5, 24, 1),
('Herní notebook Acer Nitro 5', 2, 1, 32990.00, 3, 24, 1),
('Smartphone Samsung Galaxy S24', 3, 2, 21990.00, 15, 24, 1),
('Smartphone iPhone 15 128GB', 3, 1, 23490.00, 10, 24, 1),
('Smartphone Xiaomi Redmi Note 13', 3, 2, 5490.00, 25, 24, 1),
('Monitor Dell UltraSharp 27"', 4, 5, 11490.00, 12, 36, 1),
('Herní monitor AOC 24" 165Hz', 4, 5, 4290.00, 18, 36, 1),
('Bezdrátová sluchátka Sony WH-1000XM5', 5, 2, 8490.00, 9, 24, 1),
('Bluetooth reproduktor JBL Flip 6', 5, 1, 2990.00, 22, 24, 1),
('Mechanická klávesnice Keychron K8', 6, 3, 2590.00, 14, 24, 1),
('Bezdrátová myš Logitech MX Master 3S', 6, 3, 2490.00, 30, 24, 1),
('Chytrá žárovka Philips Hue White', 7, 4, 690.00, 40, 24, 1),
('Chytrá zásuvka Tapo P110', 7, 4, 390.00, 0, 24, 1),
('Dárkový poukaz Eshop 1000 Kè', NULL, NULL, 1000.00, 100, 12, 1);

INSERT INTO Zakaznici (jmeno, prijmeni, email, telefon, mesto, datum_registrace, vip) VALUES
('Petr', 'Novák', 'petr.novak@email.cz', '+420602111222', 'Praha', '2023-01-10', 1),
('Jana', 'Svobodová', 'jana.svobodova@seznam.cz', '+420777222333', 'Brno', '2023-02-14', 1),
('Martin', 'Dvoøák', 'martin.dvorak@gmail.com', '+420608333444', 'Ostrava', '2023-03-05', 0),
('Eva', 'Èerná', 'eva.cerna@email.cz', '+420724444555', 'Praha', '2023-04-20', 1),
('Tomáš', 'Procházka', 'tomas.prochazka@seznam.cz', '+420603555666', 'Plzeò', '2023-06-12', 0),
('Lucie', 'Kuèerová', 'lucie.kucerova@gmail.com', '+420731666777', 'Brno', '2023-07-08', 1),
('Jakub', 'Veselý', 'jakub.vesely@post.cz', '+420604777888', 'Olomouc', '2023-09-19', 0),
('Kateøina', 'Horáková', 'katerina.horakova@seznam.cz', '+420775888999', 'Praha', '2023-11-02', 0),
('Filip', 'Nìmec', 'filip.nemec@gmail.com', NULL, 'Liberec', '2024-01-15', 0),
('Veronika', 'Malá', 'veronika.mala@email.cz', '+420605999000', 'Èeské Budìjovice', '2024-02-01', 1);

INSERT INTO Dopravci (nazev, cena_dopravy, doba_doruceni_dny) VALUES
('Zásilkovna - Výdejní místo', 79.00, 2),
('PPL - Kurýr na adresu', 119.00, 1),
('Balíkovna', 65.00, 2),
('DPD Private', 129.00, 1),
('Èeská pošta - Balík Do ruky', 149.00, 3);

INSERT INTO Objednavky (id_zakaznik, id_dopravce, datum_objednavky, stav, zpusob_platby, celkova_cena) VALUES
(1, 2, '2024-01-10 09:15:00', 'Dokonèená', 'Karta', 27480.00),
(2, 1, '2024-01-12 14:30:00', 'Dokonèená', 'Karta', 24580.00),
(1, 1, '2024-01-20 11:00:00', 'Dokonèená', 'Pøevod', 8490.00),
(3, 3, '2024-01-25 16:45:00', 'Odeslaná', 'Dobírka', 9780.00),
(4, 2, '2024-02-02 10:20:00', 'Dokonèená', 'Karta', 39990.00),
(5, 4, '2024-02-05 18:10:00', 'Stornována', 'Dobírka', 32990.00),
(2, 2, '2024-02-10 08:50:00', 'Odeslaná', 'Karta', 16470.00),
(6, 1, '2024-02-14 12:00:00', 'Dokonèená', 'Karta', 26480.00),
(7, 3, '2024-02-18 15:25:00', 'Zaplacená', 'Pøevod', 2760.00),
(8, NULL, '2024-02-22 17:40:00', 'Nová', 'Karta', 2000.00),
(1, 4, '2024-02-25 13:10:00', 'Nová', 'Karta', 22980.00),
(NULL, 1, '2024-02-28 19:05:00', 'Dokonèená', 'Dobírka', 5490.00);

INSERT INTO PolozkyObjednavky (id_objednavka, id_produkt, pocet_kusu, cena_za_kus, sleva_procenta) VALUES
(1, 1, 1, 24990.00, 0),
(1, 12, 1, 2490.00, 0),
(2, 4, 1, 21990.00, 0),
(2, 11, 1, 2590.00, 0),
(3, 9, 1, 8490.00, 10),
(4, 6, 1, 5490.00, 0),
(4, 8, 1, 4290.00, 5),
(5, 2, 1, 28500.00, 0),
(5, 7, 1, 11490.00, 0),
(6, 3, 1, 32990.00, 0),
(7, 7, 1, 11490.00, 0),
(7, 12, 2, 2490.00, 5),
(8, 5, 1, 23490.00, 0),
(8, 10, 1, 2990.00, 0),
(9, 13, 4, 690.00, 10),
(10, 15, 2, 1000.00, 0),
(11, 7, 2, 11490.00, 15),
(12, 6, 1, 5490.00, 0);

INSERT INTO Recenze (id_produkt, id_zakaznik, hodnoceni, text_recenze, datum_recenze) VALUES
(1, 1, 5, 'Skvìlý pracovní notebook, tichý chod a výborná klávesnice.', '2024-01-18'),
(12, 1, 5, 'Nejlepší kanceláøská myš, koleèko MagSpeed nemá konkurenci.', '2024-01-19'),
(4, 2, 4, 'Výborný fotoaparát i displej, jen baterie by mohla vydržet déle.', '2024-01-22'),
(11, 2, 5, 'Mechanická klávesnice má super odezvu, doporuèuji.', '2024-01-23'),
(9, 1, 5, 'Potlaèení okolního hluku (ANC) funguje naprosto dokonale.', '2024-01-28'),
(6, 3, 3, 'Za tu cenu slušný telefon, ale systém obsahuje zbyteèné aplikace.', '2024-02-01'),
(2, 4, 5, 'Lehký, rychlý a s nádherným OLED displejem.', '2024-02-09'),
(7, 4, 4, 'Kvalitní obraz a USB-C hub pøímo v monitoru.', '2024-02-10'),
(5, 6, 5, 'Pøechod na iPhone 15 s USB-C se vyplatil, maximální spokojenost.', '2024-02-20'),
(10, NULL, 4, 'Hraje hlasitì a èistì, ideální k vodì.', '2024-02-21');
GO