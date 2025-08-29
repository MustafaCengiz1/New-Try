*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_133
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_133_yedek.

*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (SPFLI tablosundaki
*COUNTRYFR tipinde). Parametrelerden alınan COUNTRYFR bilgisini kullanarak SPFLI tablosundan
*satırları okuyun. Daha sonra For All Entries komutu yardımıyla SFLIGHT tablosundan, SPFLI’den okunan
*tüm satırların CARRID’si ile ayni CARRID’ye sahip olan satırları okuyun ve ekrana yazdırın.

PARAMETERS: p_1 TYPE ZFT_DE_SH_COUNTRYFR,
            p_2 TYPE ZFT_DE_SH_COUNTRYFR,
            p_3 TYPE ZFT_DE_SH_COUNTRYFR.

DATA: gs_spfli       TYPE spfli,
      gt_spfli       TYPE TABLE OF spfli,
      gt_spfli_final TYPE TABLE OF spfli,
      gt_sflight     TYPE TABLE OF sflight.

START-OF-SELECTION.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE countryfr = p_1.

  LOOP AT gt_spfli INTO gs_spfli.
    APPEND gs_spfli TO gt_spfli_final.
    CLEAR: gs_spfli.
  ENDLOOP.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE countryfr = p_2.

  LOOP AT gt_spfli INTO gs_spfli.
    APPEND gs_spfli TO gt_spfli_final.
    CLEAR: gs_spfli.
  ENDLOOP.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE countryfr = p_3.

  LOOP AT gt_spfli INTO gs_spfli.
    APPEND gs_spfli TO gt_spfli_final.
    CLEAR: gs_spfli.
  ENDLOOP.

  SELECT * FROM sflight
    INTO TABLE gt_sflight
    FOR ALL ENTRIES IN gt_spfli_final
    WHERE carrid = gt_spfli_final-carrid.

    BREAK-POINT.
