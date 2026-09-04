# SQL-Task-2: SQL funksiyaları

## Məqsəd

PostgreSQL-də `satislar` cədvəli üzərində skalyar, aqreqat və pəncərə funksiyalarından istifadə edərək 40 SQL sorğusu yazmaq.

## Qaydalar

- Bütün sorğular yalnız `satislar` cədvəli üzərində yazılmalıdır. **JOIN qadağandır.**
- Hazırlıq bölməsində verilən cədvəl və 18 qeyd olduğu kimi istifadə edilməlidir. Mətnlərdəki boşluqları, hərf registrini, `NULL` və `0` qiymətlərini ilkin məlumatlarda dəyişmək olmaz.
- Hər cavab işlək SQL sorğusu olmalı, nəticə sütunlarına mənalı `AS` ləqəbləri verilməlidir.
- Bütün cavablar bir `.sql` faylında, nömrə ardıcıllığı ilə təqdim edilməlidir.
- Hər sorğunun üstündə `-- 1-ci tapşırıq`, `-- 2-ci tapşırıq` kimi nömrəli şərh olmalıdır.
- Sorğularda tələb olunan sıralama, format, dəqiqlik və xüsusi məhdudiyyətlər qorunmalıdır.
- Sintaktik xəta olan sorğu 0 bal alır.
- Maksimal bal: **100**. Tövsiyə olunan müddət: **120 dəqiqə**; bu, son təhvil tarixi deyil.

## A. Mətn funksiyaları

1. Hər satışın `satis_id`-sini, məhsul adının kənar boşluqlardan təmizlənmiş böyük hərfli formasını, təmizlənmiş adın hərf sayını və ilk 3 hərfini göstər. `satis_id` üzrə sırala.
2. Məhsul adlarını təmizlə, hərf registrini eyniləşdir və təkrarsız siyahını əlifba sırası ilə göstər.
3. Hər satış üçün `MƏHSUL / Şəhər` formatında etiket yarat. Şəhər `NULL` olduqda `NAMELUM` yaz.
4. Təkrarsız satıcı siyahısını göstər, `satici` sütununu ad və soyad sütunlarına böl.
5. Məhsulun ilk 3 böyük hərfi, satışın iki rəqəmli ayı və üç rəqəmli ID-si ilə anbar kodu yarat: `NOU-01-001`.

## B. Ədədi funksiyalar

6. Hər satışın ümumi məbləğini (`qiymet * miqdar`), onun 18% ƏDV-sini (2 onluq rəqəm), qiymətin yuxarı və aşağı yuvarlaqlaşdırılmış formalarını hesabla. Məbləğ üzrə azalan sırala.
7. Miqdarın 2-yə bölünməsindən qalığı, miqdarın 5-dən fərqinin modulunu və qiymətin kvadrat kökünü (2 onluq rəqəm) göstər.
8. Endirim tətbiq edilmiş ödəniləcək məbləği hesabla. `NULL` endirimi 0 qəbul et, nəticəni azalan sırala.
9. Məbləği bütün satışların orta məbləğindən böyük olan satışları tap. Orta məbləği sorğu daxilində hesabla, hazır rəqəm yazma.

## C. Tarix və zaman funksiyaları

10. Hər satış tarixinin il, ay və gün hissələrini ayrı sütunlarda göstər.
11. Yalnız iyun və iyul satışları üçün keçən gün sayını və satışdan 30 gün sonrakı zəmanət tarixini göstər.
12. Hər ayın satış sayını və ümumi dövriyyəsini göstər. Ay formatı `MM-YYYY` (məsələn, `03-2024`), sıralama xronoloji olsun.
13. Həftənin günü üzrə gün nömrəsini, satış sayını və dövriyyəni göstər. `EXTRACT(DOW ...)` üçün bazar günü 0-dır.
14. Bir sətirdə ilk və son satış tarixini, aralarındakı gün fərqini, ümumi satış sayını və bir aya düşən orta dövriyyəni göstər. Ay sayı üçün satış olan fərqli ayları nəzərə al.

## D. Tip çevirmə və NULL

15. Bir sorğuda xam endirimi, `NULL` əvəzinə 0 olan formasını, 0 əvəzinə `NULL` olan formasını və şəhərin `NULL`-suz formasını göstər.
16. Qiyməti mətnə çevir, `satis_id-MƏHSUL` kodu yarat və satışdan `2024-12-31` tarixinə qədər gün sayını hesabla.
17. Hər satıcı üçün ümumi satış sayını, endirimi `NULL` olmayan satış sayını, endirimi 0-dan böyük satış sayını və sonuncunun ümumi satışlardakı faizini göstər. Faiz üzrə azalan sırala.

## E. CASE

18. Qiymətə görə kateqoriya yarat: 1000 və yuxarı `Bahali`, 300-999 `Orta`, qalanı `Ucuz`. Qiymət üzrə azalan sırala.
19. Endirim statusu yarat: `NULL` və ya 0 üçün `Endirim yoxdur`, 15 və yuxarı üçün `Boyuk endirim`, qalanı üçün `Kicik endirim`.
20. Bir sorğuda və bir sətirdə ümumi satış sayını, `Texnika` və `Aksesuar` satışlarının sayını göstər. **WHERE qadağandır.**

## F. Aqreqatlar, GROUP BY və HAVING

21. Bir sətirdə satış sayını, şəhəri `NULL` olmayan satış sayını, fərqli satıcı sayını, dövriyyəni, orta, minimum və maksimum qiyməti göstər.
22. Şəhər üzrə satış sayı və dövriyyə hesabatı yarat. `NULL` şəhər `Namelum` kimi görünsün. Dövriyyə üzrə azalan sırala.
23. Yalnız qiyməti 50-dən böyük satışları nəzərə al. Satıcı üzrə qruplaşdır, dövriyyəsi 5000-dən böyük olan qrupları saxla.
24. Təmizlənmiş məhsul adı üzrə satış sayını, minimum və maksimum qiyməti, onların fərqini göstər. Yalnız birdən çox dəfə satılmış məhsullar qalsın. Fərq üzrə azalan sırala.
25. Hər şəhər üçün satılan məhsulların təkrarsız, böyük hərfli, vergüllə ayrılmış siyahısını bir sətirdə göstər (`STRING_AGG`).

## G. Pəncərə funksiyaları

26. Satışları qiymət üzrə azalan sırala və `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` sütunlarını əlavə et. Bərabər qiymətləri nəzərə al.
27. Hər şəhərin daxilində satışları məbləğ üzrə sırala. `NULL` şəhər `Namelum` qrupunda olsun (`PARTITION BY`).
28. Hər satışın ümumi dövriyyədəki faiz payını hesabla. Ümumi cəmi `SUM(...) OVER ()` ilə al. **GROUP BY qadağandır; nəticə 18 sətir olmalıdır.**
29. Tarix sırası ilə satış məbləğini, əvvəlki və sonrakı satış məbləğini, fərqi və yığılan cəmi göstər.
30. Satışları məbləğ üzrə `NTILE(4)` ilə dörd mümkün qədər bərabər qrupa böl, hər satışın qrupunu göstər.

## H. Qarışıq tapşırıqlar

31. İkinci ən bahalı satışı tap, bərabər qiymətləri nəzərə al. **LIMIT və OFFSET qadağandır.** PDF ipucu: pəncərə funksiyasını alt-sorğuda hesabla, sonra süz.
32. Hər satıcının ən böyük məbləğli satışını tap. Hər satıcı üçün yalnız 1 sətir qaytar, məbləğ üzrə azalan sırala.
33. Xronoloji ardıcıl satışlar arasında ən böyük məbləğ düşüşünü tap. Tarix, məbləğ, əvvəlki məbləğ və fərq göstərilsin; yalnız 1 sətir qaytar.
34. Aylıq dövriyyəni, əvvəlki ayın dövriyyəsini və artım faizini (1 onluq rəqəm) göstər. İlk ayda faiz `NULL` olsun.
35. Hər ayın ilk satışını tap: ay, `satis_id`, tarix və məhsul adı göstərilsin. Nəticə 7 sətir olsun.
36. Satışları məbləğ üzrə azalan sırala və ümumi dövriyyənin 50%-ni doldurmağa kifayət edən ən böyük satışları seç. Yığılan cəm və onun faizi də göstərilsin.
37. Hər şəhərin ümumi dövriyyədəki faiz payını hesabla. **Eyni sorğuda GROUP BY və pəncərə funksiyası işlənməlidir; alt-sorğu qadağandır.**
38. Satıcıların ardıcıl satışları arasındakı ən uzun 3 fasiləni tap. Satıcı, əvvəlki və sonrakı tarix, gün fərqi göstərilsin.
39. Qiyməti öz şəhərinin orta qiymətindən yüksək olan satışları tap. Şəhər, `satis_id`, qiymət və şəhərin orta qiymətini göstər; orta qiyməti alt-sorğuda pəncərə funksiyası ilə hesabla.
40. Satıcı üzrə yekun hesabat yarat: böyük hərfli ad, satış sayı, endirimdən sonrakı xalis dövriyyə (2 onluq rəqəm), orta qiymət (1 onluq rəqəm). Status **brut dövriyyəyə** görə olsun: 6000+ `Ulduz`, 5000+ `Yaxsi`, qalanı `Zeif`. Yalnız ən azı 3 satışı olan satıcılar qalsın; **xalis dövriyyə** üzrə azalan sırala.