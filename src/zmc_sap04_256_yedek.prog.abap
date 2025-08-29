*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_256
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_256_yedek.

*Alıştırma – 8: Yeni bir rapor oluşturun. Raporda 1 adet tip tanımlaması yapın ve tip içerisinde
*STRAVELAG tablosundaki bütün kolonlar bulunsun. Bu tip tanımlamasını kullanarak bir table type
*tanımlayın. Öncelikle STRAVELAG tablosundaki tüm satırları okuyun ve bir internal tabloya kaydedin.
*Daha sonra rapor içinde inline declaration kullanarak yeni bir internal tablo tanımlayın ve VALUE-FOR
*IN komutları yardımıyla yeni internal tabloyu tanımlandığı yerde doldurun.

START-OF-SELECTION.

  SELECT * FROM stravelag
    INTO TABLE @DATA(gt_table).

  DATA(gt_table_2) = VALUE zmc_tt_sap04_8( FOR gs_line IN gt_table ( gs_line ) ).

  DATA(gt_table_3) = VALUE zmc_tt_sap04_7( FOR gs_line IN gt_table ( agencynum = gs_line-agencynum
                                                                     name      = gs_line-name
                                                                     postbox   = gs_line-postbox
                                                                     postcode  = gs_line-postcode
                                                                     street    = gs_line-street ) ).

  BREAK-POINT.
