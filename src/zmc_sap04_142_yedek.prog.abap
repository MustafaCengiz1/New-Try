*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_142
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_142_yedek.

*Alıştırma – 17: Yeni bir fonksiyon yazın. Bir adet CARRNAME alsın. Gelen CARRNAME bilgisine göre
*SCARR tablosunu okusun ve kullanıcıya bir internal tablo versin. Ayrıca elde edilen internal tablodaki
*CARRID değerlerini kullanarak SPFLI ve SFLIGHT tablolarını da okuyup kullanıcıya versin. Fonksiyonu
*yeni yazacağınız bir raporda kullanın. Gelen satırları ekrana yazdırın.


PARAMETERS: p_carrn TYPE s_carrname.

DATA: gs_scarr   TYPE scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.


START-OF-SELECTION.


  CALL FUNCTION 'ZMC_FM_SAP04_08'
    EXPORTING
      iv_carrname = p_carrn
    IMPORTING
      es_scarr    = gs_scarr
      et_spfli    = gt_spfli
      et_sflight  = gt_sflight.

  BREAK-POINT.
