*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_172
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_172_YEDEK.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet sayı alın. Ayrıca 3 adet radiobutton olsun.
*Radiobuttonların isimleri sırasıyla “Üzeri 2”, “Üzeri 3” ve “Üzeri 4” olsun. Yeni bir Class oluşturun. Class
*içerisinde 3 adet metot olsun. (Tamamı Static-Public). Kullanıcının seçtiği radiobutton doğrultusunda
*gelen sayıyı kullanarak sonucu hesaplayın ve ekrana yazdırın. (Örnek: Eğer “Üzeri 2” radiobutonu
*seçildiyse, 1. metot kullanılacak ve sonuç hesaplanacak.)

PARAMETERS: p_1    TYPE i,
            p_kare RADIOBUTTON GROUP abc,
            p_kup  RADIOBUTTON GROUP abc,
            p_dort RADIOBUTTON GROUP abc.

DATA: gv_sonuc TYPE i.

START-OF-SELECTION.

  ZMC_CL_ALISTIRMA_3=>mv_sayi = p_1.

  IF p_kare = abap_true.

    ZMC_CL_ALISTIRMA_3=>uzeri_2(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ELSEIF p_kup = abap_true.

    ZMC_CL_ALISTIRMA_3=>uzeri_3(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ELSEIF p_dort = abap_true.

    ZMC_CL_ALISTIRMA_3=>uzeri_4(
      EXPORTING
        iv_sayi = p_1
      IMPORTING
        ev_sayi = gv_sonuc ).

  ENDIF.

  WRITE: gv_sonuc.
