*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_171
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_171_yedek.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet sayı alin. Ayrıca 3 adet radiobutton olsun.
*Radiobuttonların isimleri sırasıyla “Üzeri 2”, “Üzeri 3” ve “Üzeri 4” olsun. Yeni bir Class oluşturun. Class
*içerisinde 3 adet metot olsun. (Tamamı Instance-Public). Kullanıcının seçtiği radiobutton
*doğrultusunda gelen sayıyı kullanarak sonucu hesaplayın ve ekrana yazdırın. (Örnek: Eğer “Üzeri 2”
*radiobutonu seçildiyse, 1. metot kullanılacak ve sonuç hesaplanacak.)

PARAMETERS: p_1    TYPE i,
            p_kare RADIOBUTTON GROUP abc,
            p_kup  RADIOBUTTON GROUP abc,
            p_dort RADIOBUTTON GROUP abc.

DATA: go_obj   TYPE REF TO zmc_cl_alistirma_2,
      gv_sonuc TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  go_obj->mv_sayi = p_1.

  IF p_kare = abap_true.

    go_obj->uzeri_2(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ELSEIF p_kup = abap_true.

    go_obj->uzeri_3(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ELSEIF p_dort = abap_true.

    go_obj->uzeri_4(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ENDIF.

  WRITE: gv_sonuc.
