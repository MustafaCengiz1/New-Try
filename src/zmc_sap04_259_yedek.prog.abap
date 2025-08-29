*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_259
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_259_yedek.

*Alıştırma – 11: Yeni bir rapor oluşturun ve içerisinde 3 kolonlu yeni bir internal tablo tanımlayın.
*Tablonun kolonları DERS_ADI, DERS_NOTU ve BASARI_DURUMU olsun. Internal tabloya 3 adet yeni
*satir ekleyin. Tabloda loop edin ve BASARI_DURUMU hücresini CON WHEN THEN ELSE komutu
*kullanarak doldurun.

TYPES: BEGIN OF gty_str,
         ders_adi      TYPE c LENGTH 12,
         ders_notu     TYPE n LENGTH 2,
         basari_durumu TYPE c LENGTH 10,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str.

START-OF-SELECTION.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).
  <gs_str>-ders_adi = 'Matematik'.
  <gs_str>-ders_notu = '100'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-ders_adi = 'Resim'.
  <gs_str>-ders_notu = '40'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-ders_adi = 'Edebiyat'.
  <gs_str>-ders_notu = '70'.

  LOOP AT gt_table ASSIGNING <gs_str>.

    <gs_str>-basari_durumu = COND #( WHEN <gs_str>-ders_notu < 45 THEN 'Basarisiz' ELSE 'Basarili' ).

  ENDLOOP.

  BREAK-POINT.
