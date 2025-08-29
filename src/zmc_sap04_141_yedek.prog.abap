*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_141
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_141_yedek.

*Alıştırma – 16: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bilgisine göre SCARR
*tablosunu okusun ve kullanıcıya bir internal tablo versin. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Gelen satırları ekrana yazdırın.


PARAMETERS: p_carrid TYPE s_carr_id.

DATA: gt_spfli TYPE TABLE OF spfli. "Structure

START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_07'
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_spfli  = gt_spfli.

  BREAK-POINT.
