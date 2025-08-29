*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_143
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_143_yedek.

*Alıştırma – 18: Yeni bir fonksiyon yazın. Bir adet CARRID alsın. Gelen CARRID bossa kullanıcıya SCARR
*tablosunun tüm satırlarını versin. Doluysa tek bir satir versin. Doluysa ve buna rağmen SCARR
*içerisinde uygun bir satir bulunamadıysa “SATIR_BULUNMAMADI” seklinde bir exception versin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonuç ne olursa olsun ekrana yazdırın.

PARAMETERS: p_carrid TYPE s_carr_id.

DATA: gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_09'
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_scarr  = gt_scarr
    EXCEPTIONS
      no_data   = 1
      OTHERS    = 2.

  BREAK-POINT.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
