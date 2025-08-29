*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_144
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_144_yedek.

*Alıştırma – 19: Yeni bir fonksiyon yazın. Kullanıcıdan 1 adet işlem sembolü adet de sayı alsın. Gelen
*sembole göre uygun matematiksel işlemi yapıp sonucunu kullanıcıya versin. İşlem sembolü bos olursa
*bir exception bildirsin. Geçersiz bir işlem sembolü girilirse ayrı bir exception bildirsin. Fonksiyon
*içerisindeki tüm işlemleri ayrı performlar halinde yapın. Fonksiyonu yeni yazacağınız bir raporda
*kullanın. Sonucu ekrana yazdırın.

PARAMETERS: p_no_1   TYPE i,
            p_no_2   TYPE i,
            p_symbol TYPE c LENGTH 1.

DATA: gv_result TYPE i.

START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_10'
    EXPORTING
      iv_symbol            = p_symbol
      iv_number_1          = p_no_1
      iv_number_2          = p_no_2
    IMPORTING
      ev_result            = gv_result
    EXCEPTIONS
      sifira_bolme_islemi  = 1
      bos_islem_sembolu    = 2
      yanlis_islem_sembolu = 3
      OTHERS               = 4.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
