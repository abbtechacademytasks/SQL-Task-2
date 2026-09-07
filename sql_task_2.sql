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

-- 1-ci tapşırıq
SELECT satis_id,
       UPPER(TRIM(mehsul)) AS temizlenmis_mehsul,
       LENGTH(UPPER(TRIM(mehsul))) AS mehsul_uzunlugu,
       LEFT(UPPER(TRIM(mehsul)), 3) AS mehsul_ilk_3_simvol
FROM satislar
ORDER BY satis_id;

-- 2-ci tapşırıq
SELECT DISTINCT UPPER(TRIM(mehsul)) AS mehsul_adi
FROM satislar
ORDER BY mehsul_adi;

-- 3-ci tapşırıq
SELECT satis_id,
       UPPER(TRIM(mehsul)) || ' / ' || COALESCE(seher, 'NAMELUM') AS mehsul_seher
FROM satislar
ORDER BY satis_id;

-- 4-ci tapşırıq
SELECT DISTINCT SPLIT_PART(TRIM(INITCAP(satici)), ' ', 1) AS satici_ad,
                SPLIT_PART(TRIM(INITCAP(satici)), ' ', 2) AS satici_soyad
FROM satislar
ORDER BY satici_ad, satici_soyad;

-- 5-ci tapşırıq
SELECT satis_id,
       LEFT(UPPER(TRIM(mehsul)), 3) || '-' ||
       TO_CHAR(tarix, 'MM') || '-' ||
       LPAD(satis_id::TEXT, 3, '0') AS anbar_kodu
FROM satislar
ORDER BY satis_id;

-- 6-ci tapşırıq
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg,
       ROUND((qiymet * miqdar) * 0.18, 2) AS vergi_meblegi,
       CEIL(qiymet) AS yuxari_yuvarlaq_qiymet,
       FLOOR(qiymet) AS asagi_yuvarlaq_qiymet
FROM satislar
ORDER BY umumi_mebleg DESC;

-- 7-ci tapşırıq
SELECT satis_id,
       MOD(miqdar, 2) AS miqdar_mod_2,
       ABS(miqdar - 5) AS miqdar_ferqi_5,
       ROUND(SQRT(qiymet), 2) AS qiymet_kvadrat_kok
FROM satislar
ORDER BY satis_id;

-- 8-ci tapşırıq
SELECT satis_id,
       COALESCE(endirim_faiz, 0) AS endirim_faizi,
       ROUND((qiymet * miqdar) - ((qiymet * miqdar) * COALESCE(endirim_faiz, 0) / 100.0), 2) AS endirimli_mebleg
FROM satislar
ORDER BY endirimli_mebleg DESC;

-- 9-cu tapşırıq
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg
FROM satislar
WHERE qiymet * miqdar > (SELECT AVG(qiymet * miqdar) FROM satislar)
ORDER BY umumi_mebleg DESC;

-- 10-cu tapşırıq
SELECT satis_id,
       tarix,
       EXTRACT(YEAR FROM tarix) AS satis_ili,
       EXTRACT(MONTH FROM tarix) AS satis_ayi,
       EXTRACT(DAY FROM tarix) AS satis_gunu
FROM satislar
ORDER BY satis_id;

-- 11-ci tapşırıq
SELECT satis_id,
       tarix,
       CURRENT_DATE - tarix AS satisdan_sonra_gun_sayi,
       (tarix + INTERVAL '30 days')::DATE AS zemanet_bitme_tarixi
FROM satislar
WHERE EXTRACT(MONTH FROM tarix) IN (6, 7)
ORDER BY tarix;

-- 12-ci tapşırıq
SELECT TO_CHAR(DATE_TRUNC('month', tarix), 'MM-YYYY') AS satis_ayi,
       COUNT(*) AS satis_sayi,
       SUM(qiymet * miqdar) AS ayliq_umumi_mebleg
FROM satislar
GROUP BY DATE_TRUNC('month', tarix)
ORDER BY DATE_TRUNC('month', tarix);

-- 13-cü tapşırıq
SELECT EXTRACT(DOW FROM tarix) AS hefte_gunu,
       COUNT(*) AS satis_sayi,
       SUM(qiymet * miqdar) AS umumi_mebleg
FROM satislar
GROUP BY EXTRACT(DOW FROM tarix)
ORDER BY EXTRACT(DOW FROM tarix);

-- 14-cü tapşırıq
SELECT MIN(tarix) AS ilk_satis_tarixi,
       MAX(tarix) AS son_satis_tarixi,
       MAX(tarix) - MIN(tarix) AS satislar_arasi_gun_sayi,
       COUNT(*) AS satis_sayi,
       ROUND(SUM(qiymet * miqdar) / COUNT(DISTINCT DATE_TRUNC('month', tarix)), 2) AS ayliq_ortalama_mebleg
FROM satislar;

-- 15-ci tapşırıq
SELECT satis_id,
       endirim_faiz AS endirim_faizi,
       COALESCE(endirim_faiz, 0) AS null_sifir_endirim,
       NULLIF(endirim_faiz, 0) AS sifir_null_endirim,
       COALESCE(seher, 'NAMELUM') AS nullsuz_seher
FROM satislar
ORDER BY satis_id;

-- 16-cı tapşırıq
SELECT satis_id,
       CAST(qiymet AS TEXT) AS qiymet_metni,
       CAST(satis_id AS TEXT) || '-' || TRIM(UPPER(mehsul)) AS satis_kodu,
       DATE '2024-12-31' - tarix AS ilin_sonuna_qalan_gun_sayi
FROM satislar
ORDER BY satis_id;

-- 17-ci tapşırıq
SELECT INITCAP(TRIM(satici)) AS satici_adi,
       COUNT(*) AS satis_sayi,
       COUNT(endirim_faiz) AS null_olmayan_endirim_sayi,
       COUNT(*) FILTER (WHERE endirim_faiz > 0) AS musbet_endirimli_satis_sayi,
       ROUND(COUNT(*) FILTER (WHERE endirim_faiz > 0) * 100.0 / COUNT(*), 2) AS endirimli_satis_faizi
FROM satislar
GROUP BY INITCAP(TRIM(satici))
ORDER BY endirimli_satis_faizi DESC;

-- 18-ci tapşırıq
SELECT satis_id,
       qiymet,
       CASE
           WHEN qiymet >= 1000 THEN 'Bahali'
           WHEN qiymet >= 300 THEN 'Orta'
           ELSE 'Ucuz'
       END AS qiymet_kateqoriyasi
FROM satislar
ORDER BY qiymet DESC;

-- 19-cu tapşırıq
SELECT satis_id,
       endirim_faiz,
       CASE
           WHEN endirim_faiz IS NULL OR endirim_faiz = 0 THEN 'Endirim yoxdur'
           WHEN endirim_faiz >= 15 THEN 'Boyuk endirim'
           ELSE 'Kicik endirim'
       END AS endirim_kateqoriyasi
FROM satislar
ORDER BY satis_id;

-- 20-ci tapşırıq
SELECT COUNT(*) AS satis_sayi,
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

-- 21-ci tapşırıq
SELECT COUNT(*) AS satis_sayi,
       COUNT(seher) AS seher_satis_sayi,
       COUNT(DISTINCT INITCAP(TRIM(satici))) AS unikal_satici_sayi,
       SUM(qiymet * miqdar) AS umumi_mebleg,
       ROUND(AVG(qiymet), 2) AS ortalama_qiymet,
       MIN(qiymet) AS minimum_qiymet,
       MAX(qiymet) AS maksimum_qiymet
FROM satislar;

-- 22-ci tapşırıq
SELECT COALESCE(seher, 'Namelum') AS seher_adi,
       COUNT(*) AS satis_sayi,
       SUM(qiymet * miqdar) AS umumi_mebleg
FROM satislar
GROUP BY COALESCE(seher, 'Namelum')
ORDER BY umumi_mebleg DESC;

-- 23-cü tapşırıq
SELECT INITCAP(TRIM(satici)) AS satici_adi,
       SUM(qiymet * miqdar) AS dovriyye
FROM satislar
WHERE qiymet > 50
GROUP BY INITCAP(TRIM(satici))
HAVING SUM(qiymet * miqdar) > 5000
ORDER BY dovriyye DESC;

-- 24-cü tapşırıq
SELECT UPPER(TRIM(mehsul)) AS mehsul_adi,
       COUNT(*) AS mehsul_sayi,
       MIN(qiymet) AS qiymet_minimal,
       MAX(qiymet) AS qiymet_maximal,
       MAX(qiymet) - MIN(qiymet) AS qiymet_ferqi
FROM satislar
GROUP BY UPPER(TRIM(mehsul))
HAVING COUNT(*) > 1
ORDER BY qiymet_ferqi DESC, mehsul_adi;

-- 25-ci tapşırıq
SELECT COALESCE(seher, 'Namelum') AS seher_adi,
       STRING_AGG(
               DISTINCT UPPER(TRIM(mehsul)),
               ', ' ORDER BY UPPER(TRIM(mehsul))
       ) AS mehsullar
FROM satislar
GROUP BY COALESCE(seher, 'Namelum')
ORDER BY seher_adi;

-- 26-cı tapşırıq
SELECT satis_id,
       UPPER(TRIM(mehsul)) AS mehsul_adi,
       qiymet,
       ROW_NUMBER() OVER (ORDER BY qiymet DESC, satis_id) AS setir_nomresi,
       RANK() OVER (ORDER BY qiymet DESC) AS qiymet_ranki,
       DENSE_RANK() OVER (ORDER BY qiymet DESC) AS six_qiymet_ranki
FROM satislar
ORDER BY qiymet DESC, satis_id;

-- 27-ci tapşırıq
SELECT satis_id,
       COALESCE(seher, 'Namelum') AS seher_adi,
       qiymet * miqdar AS umumi_mebleg,
       DENSE_RANK() OVER (
           PARTITION BY COALESCE(seher, 'Namelum')
           ORDER BY qiymet * miqdar DESC
       ) AS seher_daxili_rank
FROM satislar
ORDER BY seher_adi, seher_daxili_rank, satis_id;

-- 28-ci tapşırıq
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg,
       SUM(qiymet * miqdar) OVER () AS butun_satislarin_meblegi,
       ROUND(
           (qiymet * miqdar) * 100.0
               / SUM(qiymet * miqdar) OVER (),
           2
       ) AS dovriyye_faizi
FROM satislar
ORDER BY satis_id;

-- 29-cu tapşırıq
SELECT satis_id,
       tarix,
       qiymet * miqdar AS umumi_mebleg,
       LAG(qiymet * miqdar) OVER (
           ORDER BY tarix, satis_id
       ) AS evvelki_satis_meblegi,
       LEAD(qiymet * miqdar) OVER (
           ORDER BY tarix, satis_id
       ) AS sonraki_satis_meblegi,
       (qiymet * miqdar)
           - LAG(qiymet * miqdar) OVER (
               ORDER BY tarix, satis_id
           ) AS evvelki_satisla_ferq,
       SUM(qiymet * miqdar) OVER (
           ORDER BY tarix, satis_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS yigilan_mebleg
FROM satislar
ORDER BY tarix, satis_id;

-- 30-cu tapşırıq
SELECT satis_id,
       qiymet * miqdar AS umumi_mebleg,
       NTILE(4) OVER (
           ORDER BY qiymet * miqdar DESC, satis_id
       ) AS mebleg_qrupu
FROM satislar
ORDER BY mebleg_qrupu, umumi_mebleg DESC, satis_id;

-- 31-ci tapşırıq
SELECT satis_id,
       mehsul_adi,
       qiymet
FROM (
    SELECT satis_id,
           UPPER(TRIM(mehsul)) AS mehsul_adi,
           qiymet,
           DENSE_RANK() OVER (
               ORDER BY qiymet DESC
           ) AS qiymet_ranki
    FROM satislar
) AS qiymet_siralari
WHERE qiymet_ranki = 2
ORDER BY satis_id;

-- 32-ci tapşırıq
SELECT satis_id,
       satici_adi,
       mehsul_adi,
       umumi_mebleg
FROM (
    SELECT satis_id,
           INITCAP(TRIM(satici)) AS satici_adi,
           UPPER(TRIM(mehsul)) AS mehsul_adi,
           qiymet * miqdar AS umumi_mebleg,
           ROW_NUMBER() OVER (
               PARTITION BY INITCAP(TRIM(satici))
               ORDER BY qiymet * miqdar DESC, satis_id
           ) AS sira
    FROM satislar
) AS satis_siralari
WHERE sira = 1
ORDER BY umumi_mebleg DESC, satis_id;

-- 33-cü tapşırıq
SELECT satis_id,
       tarix,
       umumi_mebleg,
       evvelki_mebleg,
       umumi_mebleg - evvelki_mebleg AS ferq
FROM (
    SELECT satis_id,
           tarix,
           qiymet * miqdar AS umumi_mebleg,
           LAG(qiymet * miqdar) OVER (
               ORDER BY tarix, satis_id
           ) AS evvelki_mebleg
    FROM satislar
) AS satis_ferqleri
WHERE evvelki_mebleg IS NOT NULL
ORDER BY ferq ASC, tarix, satis_id
LIMIT 1;

-- 34-cü tapşırıq
WITH ayliq_hesabat AS (
    SELECT DATE_TRUNC('month', tarix) AS ay,
           SUM(qiymet * miqdar) AS ayliq_dovriyye
    FROM satislar
    GROUP BY DATE_TRUNC('month', tarix)
),
ayliq_muqayise AS (
    SELECT ay,
           ayliq_dovriyye,
           LAG(ayliq_dovriyye) OVER (
               ORDER BY ay
           ) AS evvelki_ay_dovriyyesi
    FROM ayliq_hesabat
)
SELECT TO_CHAR(ay, 'MM-YYYY') AS ay_adi,
       ayliq_dovriyye,
       evvelki_ay_dovriyyesi,
       ROUND(
           (ayliq_dovriyye - evvelki_ay_dovriyyesi) * 100.0
               / NULLIF(evvelki_ay_dovriyyesi, 0),
           1
       ) AS artim_faizi
FROM ayliq_muqayise
ORDER BY ay;

-- 35-ci tapşırıq
SELECT TO_CHAR(ay, 'MM-YYYY') AS ay_adi,
       satis_id,
       tarix,
       mehsul_adi
FROM (
    SELECT DATE_TRUNC('month', tarix) AS ay,
           satis_id,
           tarix,
           UPPER(TRIM(mehsul)) AS mehsul_adi,
           ROW_NUMBER() OVER (
               PARTITION BY DATE_TRUNC('month', tarix)
               ORDER BY tarix, satis_id
           ) AS sira
    FROM satislar
) AS ayliq_satislar
WHERE sira = 1
ORDER BY ay;

-- 36-cı tapşırıq
WITH satis_pareto AS (
    SELECT satis_id,
           UPPER(TRIM(mehsul)) AS mehsul_adi,
           qiymet * miqdar AS umumi_mebleg,
           SUM(qiymet * miqdar) OVER (
               ORDER BY qiymet * miqdar DESC, satis_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS yigilan_mebleg,
           SUM(qiymet * miqdar) OVER () AS umumi_dovriyye
    FROM satislar
)
SELECT satis_id,
       mehsul_adi,
       umumi_mebleg,
       yigilan_mebleg,
       ROUND(
           yigilan_mebleg * 100.0 / NULLIF(umumi_dovriyye, 0),
           2
       ) AS yigilan_faiz
FROM satis_pareto
WHERE yigilan_mebleg - umumi_mebleg < umumi_dovriyye * 0.5
ORDER BY umumi_mebleg DESC, satis_id;

-- 37-ci tapşırıq
SELECT COALESCE(seher, 'Namelum') AS seher_adi,
       SUM(qiymet * miqdar) AS seher_dovriyyesi,
       ROUND(
           SUM(qiymet * miqdar) * 100.0
               / NULLIF(SUM(SUM(qiymet * miqdar)) OVER (), 0),
           2
       ) AS umumi_dovriyyede_faiz
FROM satislar
GROUP BY COALESCE(seher, 'Namelum')
ORDER BY seher_dovriyyesi DESC, seher_adi;

-- 38-ci tapşırıq
WITH satis_fasileleri AS (
    SELECT satis_id,
           INITCAP(TRIM(satici)) AS satici_adi,
           LAG(tarix) OVER (
               PARTITION BY INITCAP(TRIM(satici))
               ORDER BY tarix, satis_id
           ) AS evvelki_tarix,
           tarix AS sonraki_tarix
    FROM satislar
)
SELECT satici_adi,
       evvelki_tarix,
       sonraki_tarix,
       sonraki_tarix - evvelki_tarix AS fasile_gunleri
FROM satis_fasileleri
WHERE evvelki_tarix IS NOT NULL
ORDER BY fasile_gunleri DESC,
         satici_adi,
         sonraki_tarix,
         satis_id
LIMIT 3;

-- 39-cu tapşırıq
SELECT seher_adi,
       satis_id,
       qiymet,
       ROUND(seher_orta_qiymeti, 2) AS seher_orta_qiymeti
FROM (
    SELECT COALESCE(seher, 'Namelum') AS seher_adi,
           satis_id,
           qiymet,
           AVG(qiymet) OVER (
               PARTITION BY COALESCE(seher, 'Namelum')
           ) AS seher_orta_qiymeti
    FROM satislar
) AS seher_qiymetleri
WHERE qiymet > seher_orta_qiymeti
ORDER BY seher_adi, qiymet DESC, satis_id;

-- 40-cı tapşırıq
SELECT UPPER(TRIM(satici)) AS satici_adi,
       COUNT(*) AS satis_sayi,
       ROUND(
           SUM(
               (qiymet * miqdar)
                   * (1 - COALESCE(endirim_faiz, 0) / 100.0)
           ),
           2
       ) AS xalis_dovriyye,
       ROUND(AVG(qiymet), 1) AS orta_qiymet,
       CASE
           WHEN SUM(qiymet * miqdar) >= 6000 THEN 'Ulduz'
           WHEN SUM(qiymet * miqdar) >= 5000 THEN 'Yaxsi'
           ELSE 'Zeif'
       END AS status
FROM satislar
GROUP BY UPPER(TRIM(satici))
HAVING COUNT(*) >= 3
ORDER BY xalis_dovriyye DESC, satici_adi;
