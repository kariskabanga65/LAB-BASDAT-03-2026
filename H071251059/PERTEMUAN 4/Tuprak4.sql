SET search_path TO classicmodels;

--- 1
SELECT customernumber AS "Nomor Pelanggan", 
	SUM(amount) AS "Total Akumulasi Dana",
	COUNT(checknumber) AS "Jumlah Transaksi",
	MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customernumber
HAVING --COUNT(DISTINCT checknumber) > 4
AVG(amount) > 20000;

--- 2
SELECT customernumber AS "Nomor Pelanggan", 
	SUM(amount) AS "Total Akumulasi Setoran"
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY "Total Akumulasi Setoran" DESC;

--- 3
SELECT productline AS "Nama Kategori", 
COUNT(productcode) AS "Jumlah Variasi Produk",
	ROUND(AVG(msrp), 2) AS "Rata-Rata Harga",
	STRING_AGG(productname, ', ' ORDER BY productname) AS "Daftar Nama Produk"
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

--- 4
SELECT reportsto AS "ID Pegawai"
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT employeenumber
FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

--- 5
SELECT productcode AS "Kode Produk",
	SUM(quantityordered) AS "Total Unit Terjual",
	ROUND(AVG(priceeach), 2) AS "Rata-Rata Harga"
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode 
HAVING SUM(quantityordered) > 50
ORDER BY "Total Unit Terjual" DESC;

--- 6
SELECT productcode,
SUM(quantityordered) AS "Total Unit dipesan",
SUM(quantityordered * priceeach) "pendapatan kotor",
ROUND(AVG(priceeach), 2) AS "Rata-rata harga",
MAX (priceeach) - MIN (priceeach) AS "Selisi tertinggi terendah"
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY "pendapatan kotor" DESC;

--- 7
SELECT customernumber
FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT DISTINCT customernumber
FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold'
EXCEPT
SELECT customernumber
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000;