DROP TABLE IF EXISTS satislar;

CREATE TABLE satislar
(
    satis_id INT PRIMARY KEY,
    mehsul VARCHAR(50),
    kateqoriya VARCHAR(30),
    seher VARCHAR(30),
    satici VARCHAR(50),
    miqdar INT,
    qiymet NUMERIC(10, 2),
    endirim_faiz NUMERIC(5, 2),
    tarix DATE
);

INSERT INTO satislar (satis_id, mehsul, kateqoriya, seher, satici, miqdar, qiymet, endirim_faiz, tarix)
VALUES
    (1, ' noutbuk ', 'Texnika', 'Bakı', 'aysel memmedova', 2, 1250.00, 10.00, DATE '2024-01-15'),
    (2, 'MONITOR', 'Texnika', 'Bakı', 'aysel memmedova', 3, 320.50, NULL, DATE '2024-01-28'),
    (3, 'klaviatura', 'Aksesuar', 'Gəncə', 'RAUF ELIYEV', 5, 45.90, 0.00, DATE '2024-02-05'),
    (4, 'Printer', 'Texnika', 'Sumqayıt', 'nigar huseynova', 1, 480.00, 5.00, DATE '2024-02-17'),
    (5, 'telefon ', 'Texnika', 'Bakı', 'Elvin Qasimov', 4, 899.99, 15.00, DATE '2024-03-03'),
    (6, 'tablet', 'Texnika', 'Gəncə', 'RAUF ELIYEV', 2, 640.00, NULL, DATE '2024-03-11'),
    (7, 'kamera', 'Texnika', 'Bakı', 'aysel memmedova', 1, 1250.00, NULL, DATE '2024-03-22'),
    (8, ' kabel', 'Aksesuar', 'Sumqayıt', 'nigar huseynova', 10, 12.50, 0.00, DATE '2024-04-02'),
    (9, 'MONITOR', 'Texnika', 'Şəki', 'Elvin Qasimov', 2, 320.50, NULL, DATE '2024-04-14'),
    (10, 'noutbuk', 'Texnika', 'Gəncə', 'RAUF ELIYEV', 1, 1799.00, 20.00, DATE '2024-04-25'),
    (11, 'klaviatura', 'Aksesuar', 'Bakı', 'Elvin Qasimov', 6, 45.90, NULL, DATE '2024-05-06'),
    (12, 'Telefon', 'Texnika', 'Sumqayıt', 'nigar huseynova', 3, 899.99, NULL, DATE '2024-05-19'),
    (13, 'kabel', 'Aksesuar', 'Bakı', 'aysel memmedova', 8, 12.50, 0.00, DATE '2024-06-01'),
    (14, 'printer', 'Texnika', NULL, 'Elvin Qasimov', 2, 480.00, 10.00, DATE '2024-06-12'),
    (15, 'kamera', 'Texnika', 'Gəncə', 'RAUF ELIYEV', 1, 1150.00, NULL, DATE '2024-06-23'),
    (16, 'tablet ', 'Texnika', 'Bakı', 'nigar huseynova', 4, 640.00, 25.00, DATE '2024-07-04'),
    (17, 'MONITOR ', 'Texnika', 'Sumqayıt', 'aysel memmedova', 5, 299.00, NULL, DATE '2024-07-15'),
    (18, 'qulaqliq', 'Aksesuar', 'Bakı', 'Elvin Qasimov', 7, 89.90, 5.00, DATE '2024-07-27');

SELECT COUNT(*) AS satis_sayi
FROM satislar;

-- Tapşırıq 1
SELECT satis_id,
       UPPER(TRIM(mehsul)) AS temizlenmis_mehsul,
       LENGTH(UPPER(TRIM(mehsul))) AS mehsul_uzunlugu,
       LEFT(UPPER(TRIM(mehsul)), 3) AS mehsul_ilk_3_simvol
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 2
SELECT DISTINCT UPPER(TRIM(mehsul)) AS mehsul_adi
FROM satislar
ORDER BY mehsul_adi;

-- Tapşırıq 3
SELECT satis_id,
       UPPER(TRIM(mehsul)) || ' / ' || COALESCE(seher, 'NAMELUM') AS mehsul_seher
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 4
SELECT DISTINCT SPLIT_PART(TRIM(INITCAP(satici)), ' ', 1) AS satici_ad,
                SPLIT_PART(TRIM(INITCAP(satici)), ' ', 2) AS satici_soyad
FROM satislar
ORDER BY satici_ad, satici_soyad;

-- Tapşırıq 5

SELECT satis_id,
    LEFT(UPPER(TRIM(mehsul)), 3) || '-' ||
    TO_CHAR(tarix, 'MM') || '-' ||
    LPAD(satis_id::TEXT, 3, '0') AS anbar_kodu
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 6
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg,
       ROUND((qiymet * miqdar) * 0.18, 2) AS vergi_meblegi,
       CEIL(qiymet) AS yuxari_yuvarlaq_qiymet,
       FLOOR(qiymet) AS asagi_yuvarlaq_qiymet
FROM satislar
ORDER BY umumi_mebleg DESC;

-- Tapşırıq 7
SELECT satis_id,
       MOD(miqdar, 2) AS miqdar_mod_2,
       ABS(miqdar - 5) AS miqdar_ferqi_5,
       ROUND(SQRT(qiymet), 2) AS qiymet_kvadrat_kok
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 8
SELECT satis_id,
       COALESCE(endirim_faiz, 0) AS endirim_faizi,
       ROUND((qiymet * miqdar) - ((qiymet * miqdar) * COALESCE(endirim_faiz, 0) / 100), 2) AS endirimli_mebleg
FROM satislar
ORDER BY endirimli_mebleg DESC;

-- Tapşırıq 9
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg
FROM satislar
WHERE qiymet * miqdar > (SELECT AVG(qiymet * miqdar) FROM satislar)
ORDER BY umumi_mebleg DESC;

-- Tapşırıq 10
SELECT satis_id,
       tarix,
       EXTRACT(YEAR FROM tarix) AS satis_ili,
       EXTRACT(MONTH FROM tarix) AS satis_ayi,
       EXTRACT(DAY FROM tarix) AS satis_gunu
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 11
SELECT satis_id,
       tarix,
       CURRENT_DATE - tarix AS satisdan_sonra_gun_sayi,
       tarix + 30 AS zemanet_bitme_tarixi
FROM satislar
WHERE EXTRACT(MONTH FROM tarix) IN (6, 7)
ORDER BY tarix;

-- Tapşırıq 12
SELECT TO_CHAR(DATE_TRUNC('month', tarix), 'MM-YYYY') AS satis_ayi,
       COUNT(*) AS satis_sayi,
       SUM(qiymet * miqdar) AS ayliq_umumi_mebleg
FROM satislar
GROUP BY DATE_TRUNC('month', tarix)
ORDER BY DATE_TRUNC('month', tarix);

-- Tapşırıq 13
SELECT EXTRACT(DOW FROM tarix) AS hefte_gunu,
       COUNT(*) AS satis_sayi,
       SUM(qiymet * miqdar) AS umumi_mebleg
FROM satislar
GROUP BY EXTRACT(DOW FROM tarix)
ORDER BY EXTRACT(DOW FROM tarix);

-- Tapşırıq 14
SELECT
    MIN(tarix) AS ilk_satis_tarixi,
    MAX(tarix) AS son_satis_tarixi,
    MAX(tarix) - MIN(tarix) AS satislar_arasi_gun_sayi,
    COUNT(*) AS satis_sayi,
    ROUND(SUM(qiymet * miqdar) / COUNT(DISTINCT DATE_TRUNC('month', tarix)), 2) AS ayliq_ortalama_mebleg
FROM satislar;

-- Tapşırıq 15
SELECT satis_id,
       endirim_faiz AS endirim_faizi,
       COALESCE(endirim_faiz, 0) AS null_sifir_endirim,
       NULLIF(endirim_faiz, 0) AS sifir_null_endirim,
       COALESCE(seher, 'NAMELUM') AS nullsuz_seher
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 16
SELECT satis_id,
       CAST(qiymet AS TEXT) AS qiymet_metin,
       CAST(satis_id AS TEXT) || '-' || TRIM(UPPER(mehsul)) AS satis_kodu,
       DATE '2024-12-31' - tarix AS satisdan_sonra_gun_sayi
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 17
SELECT
    INITCAP(TRIM(satici)) AS satici_adi,
    COUNT(*) AS satis_sayi,
    COUNT(endirim_faiz) AS null_olmayan_endirim_sayi,
    COUNT(*) FILTER (WHERE endirim_faiz > 0) AS musbet_endirimli_satis_sayi,
    ROUND(COUNT(*) FILTER (WHERE endirim_faiz > 0) * 100.0 / COUNT(*), 2) AS endirimli_satis_faizi
FROM satislar
GROUP BY INITCAP(TRIM(satici))
ORDER BY endirimli_satis_faizi DESC;

-- Tapşırıq 18
SELECT satis_id,
       qiymet,
       CASE
            WHEN qiymet >= 1000 THEN 'Bahali'
            WHEN qiymet >= 300 THEN 'Orta'
            ELSE 'Ucuz'
       END AS qiymet_kateqoriyasi
FROM satislar
ORDER BY qiymet DESC;

-- Tapşırıq 19
SELECT satis_id,
       endirim_faiz,
       CASE
            WHEN endirim_faiz IS NULL OR endirim_faiz = 0 THEN 'Endirim yoxdur'
            WHEN endirim_faiz >= 15 THEN 'Boyuk endirim'
            ELSE 'Kicik endirim'
       END AS endirim_kateqoriyasi
FROM satislar
ORDER BY satis_id;

-- Tapşırıq 20
SELECT
    COUNT(*) AS satis_sayi,
    SUM(
        CASE
            WHEN kateqoriya = 'Texnika' THEN 1
            ELSE 0
        END
    ) AS texnika_satis_sayi,
    SUM(
        CASE
            WHEN kateqoriya = 'Aksesuar' THEN 1
            ELSE 0
        END
    ) AS aksesuar_satis_sayi
FROM satislar;
