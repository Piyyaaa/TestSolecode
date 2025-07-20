DROP DATABASE IF EXISTS siperpus;
CREATE DATABASE siperpus;
USE siperpus;

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat TEXT NOT NULL,
    no_ktp VARCHAR(20) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    tanggal_terdaftar DATE NOT NULL DEFAULT (CURDATE())
);

CREATE TABLE Kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(50) NOT NULL
);

CREATE TABLE Buku (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    pengarang VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    tahun_terbit YEAR NOT NULL,
    jumlah_tersedia INT NOT NULL,
    kategori_id INT,
    FOREIGN KEY (kategori_id) REFERENCES Kategori(id)
);

CREATE TABLE Peminjaman (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anggota_id INT,
    buku_id INT,
    tanggal_pinjam DATE NOT NULL,
    tanggal_batas_kembali DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0,
    FOREIGN KEY (anggota_id) REFERENCES User(id),
    FOREIGN KEY (buku_id) REFERENCES Buku(id)
);

-- a. INITIAL DATA

INSERT INTO Kategori (nama) VALUES
('Fiksi'), ('Non-Fiksi'), ('Teknologi'), ('Bisnis'), ('Sains'), ('Education');

INSERT INTO User (nama, alamat, no_ktp, no_hp, email) VALUES
('User 1', 'Alamat A', '123456', '0811111111', 'user1@email.com'),
('User 2', 'Alamat B', '234567', '0822222222', 'user2@email.com'),
('User 3', 'Alamat C', '345678', '0833333333', 'user3@email.com');

INSERT INTO Buku (judul, pengarang, penerbit, isbn, tahun_terbit, jumlah_tersedia, kategori_id) VALUES
('Buku 1', 'Pengarang A', 'Penerbit A', '1111', 2020, 10, 1),
('Buku 2', 'Pengarang B', 'Penerbit A', '2222', 2020, 5, 1),
('Buku 3', 'Pengarang C', 'Penerbit B', '3333', 2020, 3, 2),
('Buku 4', 'Pengarang D', 'Penerbit C', '4444', 2021, 4, 2),
('Buku 5', 'Pengarang E', 'Penerbit D', '5555', 2022, 6, 3),
('Buku 6', 'Pengarang F', 'Penerbit D', '6666', 2022, 7, 3),
('Buku 7', 'Pengarang G', 'Penerbit E', '7777', 2021, 2, 4),
('Buku 8', 'Pengarang H', 'Penerbit F', '8888', 2023, 8, 4),
('Buku 9', 'Pengarang I', 'Penerbit G', '9999', 2023, 5, 5),
('Buku 10', 'Pengarang J', 'Penerbit H', '1010', 2024, 9, 5);

INSERT INTO Peminjaman (anggota_id, buku_id, tanggal_pinjam, tanggal_batas_kembali, tanggal_kembali, denda) VALUES
(1, 1, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(1, 2, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(1, 3, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(2, 4, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(2, 5, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(2, 6, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(3, 7, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(3, 8, '2025-07-01', '2025-07-06', '2025-07-06', 0),
(3, 9, '2025-07-01', '2025-07-06', '2025-07-11', 5000);

-- b. MANIPULASI DATA

-- 1. Buku yang tidak pernah dipinjam
SELECT judul 
FROM Buku
WHERE id NOT IN (SELECT buku_id FROM Peminjaman);

-- 2. User yang terlambat kembalikan buku + denda
SELECT u.nama AS User, SUM(p.denda) AS Denda
FROM Peminjaman p
JOIN User u ON u.id = p.anggota_id
WHERE p.denda > 0
GROUP BY u.id;

-- 3. Daftar user dan buku yang dipinjam
SELECT u.id AS No, u.nama AS User,
GROUP_CONCAT(b.judul ORDER BY b.id SEPARATOR ', ') AS Buku
FROM Peminjaman p
JOIN User u ON u.id = p.anggota_id
JOIN Buku b ON b.id = p.buku_id
GROUP BY u.id;
