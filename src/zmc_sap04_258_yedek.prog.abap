*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_258
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_258_yedek.

*Alıştırma – 10: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CURRENCY alın. Rapor içinde SFLIGHT
*tablosundaki tüm satırları okuyun ve REDUCE komutu kullanarak, elde edilen tablodaki tüm fiyatların
*toplamını tek bir değişken içine kaydedin.

PARAMETERS: p_curr TYPE s_currcode.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO TABLE @DATA(gt_sflight)
    WHERE currency = @p_curr.


DATA(gv_toplam) = REDUCE i( INIT x = 0 FOR gs_line IN gt_sflight NEXT x = x + gs_line-price ).

BREAK-POINT.
