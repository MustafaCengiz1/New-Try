*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_199
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_199_YEDEK.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde adını ve soy adını alın.
*Ayrıca 2 adet parametre oluşturun. Parametreler “Yukarıdan Aşağıya” ve “Sağdan Sola” olsun. Rapor
*içerisinde kullanıcının adını ve soy adını alt alta veya sağdan sola olacak şekilde yazdırın.

PARAMETERS: p_string TYPE string,
            p_sagdan RADIOBUTTON GROUP abc,
            p_ykrdn  RADIOBUTTON GROUP abc.

DATA: gv_no TYPE i,
      gv_text TYPE string,
      gv_atla TYPE i,
      gv_harf TYPE c LENGTH 1.

START-OF-SELECTION.

gv_no = strlen( p_string ).

IF p_sagdan = abap_true.

  DO gv_no TIMES.

    gv_atla = gv_no - sy-index.

    CONCATENATE gv_text p_string+gv_atla(1) INTO gv_text.

  ENDDO.

  WRITE: gv_text.

ELSE.

  DO gv_no TIMES.

    gv_atla = sy-index - 1.

    gv_harf = p_string+gv_atla(1).

    IF gv_harf IS INITIAL.
*    IF p_string+gv_atla(1) IS INITIAL.
      SKIP.
    ELSE.
      WRITE: / gv_harf.
*      WRITE: / p_string+gv_atla(1).
    ENDIF.

  ENDDO.

ENDIF.
