*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_161
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_161_yedek.

PARAMETERS: p_1   TYPE i,
            p_2   TYPE i,
            p_sym TYPE c LENGTH 1.

DATA: go_calculator TYPE REF TO zmc_cl_sap04_calculator,
      gv_no         TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_calculator.

  IF p_sym = '+'.

    go_calculator->topla(
      EXPORTING
        iv_no_1 = p_1
        iv_no_2 = p_2
      IMPORTING
        ev_no   = gv_no ).

*    CALL METHOD go_calculator->topla
*      EXPORTING
*        iv_no_1 = p_1
*        iv_no_2 = p_2
*      IMPORTING
*        ev_no   = gv_no.

  ELSEIF p_sym = '-'.

    go_calculator->cikar(
      EXPORTING
        iv_no_cikar_1 = p_1
        iv_no_cikar_2 = p_2
      IMPORTING
        ev_no_cikar   = gv_no ).

  ELSEIF p_sym = '/'.

    go_calculator->bol(
      EXPORTING
        iv_no_bol_1         = p_1
        iv_no_bol_2         = p_2
      IMPORTING
        ev_no_bolum         = gv_no
      EXCEPTIONS
        sifira_bolme_islemi = 1
        others              = 2 ).

    IF sy-subrc = 1.
      MESSAGE 'Sifira bölme islemi' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ELSEIF p_sym = '*'.

    go_calculator->carp(
      EXPORTING
        iv_no_carp_1 = p_1
        iv_no_carp_2 = p_2
      IMPORTING
        ev_no_carpim = gv_no ).

  ENDIF.
