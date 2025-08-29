*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_118
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_118_yedek.

PARAMETERS: p_1   TYPE i,
            p_2   TYPE i,
            p_sum RADIOBUTTON GROUP abc,
            p_sub RADIOBUTTON GROUP abc,
            p_div RADIOBUTTON GROUP abc,
            p_mul RADIOBUTTON GROUP abc.

DATA: gv_result TYPE p DECIMALS 2,
      gv_ok     TYPE c LENGTH 1.

START-OF-SELECTION.

  PERFORM control.

  IF gv_ok IS INITIAL.
    MESSAGE 'Yanlis islem' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_sum = abap_true.
    PERFORM sum.

  ELSEIF p_sub = abap_true.
    PERFORM sub.

  ELSEIF p_div = abap_true.
    PERFORM div.

  ELSEIF p_mul = abap_true.
    PERFORM mul.
  ENDIF.

  PERFORM display.


FORM sum .
  gv_result = p_1 + p_2.
ENDFORM.


FORM sub .
  gv_result = p_1 - p_2.
ENDFORM.


FORM div .
  gv_result = p_1 / p_2.
ENDFORM.


FORM mul .
  gv_result = p_1 * p_2.
ENDFORM.


FORM control .

  "Kullanici bölme islemi sectiyse, bölenin sifir olup olmadigini kontrol et.
  IF p_div = abap_true.
    IF p_2 NE 0.
      "Bölen sifir degil. Isleme devam edilebilir.
      gv_ok = abap_true.
    ELSE.
      "Bölen sifir old icin isleme devam edilmemeli.
      gv_ok = abap_false.
    ENDIF.
  ELSE.
    "Yapilan islem bölme olmadigi icin devam edilebilir.
    gv_ok = abap_true.
  ENDIF.

ENDFORM.


FORM display .
  WRITE: gv_result.
ENDFORM.
