*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_132
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_132_yedek.

*Alıştırma – 7: Bir önceki alıştırmadaki parametreyi tekrar tanımlayın ve gelen veriyi kullanarak SCARR
*tablosunu okuyun. For All Entries komutu yardımıyla SPFLI tablosundan, SCARR’dan okunan tüm
*satırların CARRID’si ile ayni CARRID’ye sahip olan satırları okuyun. Daha sonra yine For All Entries
*komutu yardımıyla SFLIGHT tablosundan, SPFLI’den okunan tüm satırların CONNID’si ile ayni
*CONNID’ye sahip olan satırları okuyun ve ekrana yazdırın.

PARAMETERS: p_carrn TYPE zmc_sap04_de_cn LOWER CASE.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrname = p_carrn.

  IF gt_scarr IS NOT INITIAL.
    SELECT * FROM spfli
    INTO TABLE gt_spfli
    FOR ALL ENTRIES IN gt_scarr
    WHERE carrid = gt_scarr-carrid.
  ENDIF.

  IF gt_spfli IS NOT INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight
      FOR ALL ENTRIES IN gt_spfli
      WHERE connid = gt_spfli-connid.
  ENDIF.

  BREAK-POINT.
