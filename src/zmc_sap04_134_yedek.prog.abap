*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_134
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_134_YEDEK.

*Alıştırma – 9: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet parametre alin. (isim ve soy isim). Rapor
*içerisinde 2 yeni perform oluşturun, ilk perform içerisinde isim ve soy ismi birleştirin. İkinci perform
*içerisinde elde ettiğiniz texti ekrana yazdırın.

PARAMETERS: p_name TYPE string,
            p_sname TYPE string.

DATA: gv_text TYPE string.

START-OF-SELECTION.

PERFORM merge.
PERFORM display_text.

FORM merge.
  CONCATENATE p_name p_sname INTO gv_text SEPARATED BY space.
ENDFORM.


FORM display_text .
  MESSAGE gv_text TYPE 'I'.
ENDFORM.
