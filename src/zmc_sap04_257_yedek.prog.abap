*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_257
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_257_yedek.

*Alıştırma – 9: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet CARRID alın. Rapor içinde 2 kere SPFLI
*tablosundan ilgili satırları okuyun ve iki ayrı internal tablo içine kaydedin. Her okumada secim
*ekranından gelen bir CARRID bilgisini koşul olarak belirleyin. Inline declaration ile SPFLI tablosunun
*satir yapısı ile ayni satır yapısında bir internal tablo tanımlayın. Öncelikle FOR IN döngüsü kullanarak
*birinci internal tablodaki verileri, daha sonra BASE FOR IN komutlarını kullanarak ikinci internal
*tablodaki verileri üçüncü internal tablonun içine aktarın.

PARAMETERS: p_carr1 TYPE s_carr_id,
            p_carr2 TYPE s_carr_id.

START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE @DATA(gt_table_1)
    WHERE carrid = @p_carr1.

  SELECT * FROM spfli
    INTO TABLE @DATA(gt_table_2)
    WHERE carrid = @p_carr2.

  DATA(gt_table_3) = VALUE zmc_tt_spfli( FOR gs_line IN gt_table_1 ( gs_line ) ).

  gt_table_3 = VALUE #( BASE gt_table_3 FOR gs_line IN gt_table_2 ( gs_line ) ).

  BREAK-POINT.
