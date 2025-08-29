*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_145
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_145_yedek.

*Alıştırma – 20: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet gün ismi, 1 adet de sayı alin. Kullanıcının
*girdiği sayı kadar gün sonra günlerden hangi gün olacağını hesaplayın ve kullanıcıya geri bildirin.
*Fonksiyonu yeni yazacağınız bir raporda kullanın. Sonucu ekrana yazdırın.

PARAMETERS: p_day    TYPE c LENGTH 15 LOWER CASE,
            p_number TYPE i.

DATA: gv_day TYPE c LENGTH 15.

START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_11'
    EXPORTING
      iv_day     = p_day
      iv_number  = p_number
    IMPORTING
      ev_day     = gv_day
    EXCEPTIONS
      yanlis_gun = 1
      OTHERS     = 2.

  IF sy-subrc = 1.
*    MESSAGE
  ENDIF.
