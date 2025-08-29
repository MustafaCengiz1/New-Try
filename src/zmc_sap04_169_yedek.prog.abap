*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_169
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_169_YEDEK.

CLASS lcl_calculator DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS: topla IMPORTING iv_no_1 TYPE i
                                   iv_no_2 TYPE i
                         EXPORTING ev_no   TYPE i.

    CLASS-METHODS: cikar IMPORTING iv_no_cikar_1 TYPE i
                                   iv_no_cikar_2 TYPE i
                         EXPORTING ev_no_cikar   TYPE i.

    CLASS-METHODS: carp IMPORTING iv_no_carp_1 TYPE i
                                  iv_no_carp_2 TYPE i
                        EXPORTING ev_no_carpim TYPE i.

    CLASS-METHODS: bol IMPORTING iv_no_bol_1 TYPE i
                                 iv_no_bol_2 TYPE i
                       EXPORTING ev_no_bolum TYPE i.

ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.

  METHOD topla.
    ev_no = iv_no_1 + iv_no_2.
  ENDMETHOD.

  METHOD cikar.
    ev_no_cikar = iv_no_cikar_1 - iv_no_cikar_2.
  ENDMETHOD.

  METHOD carp.
    ev_no_carpim = iv_no_carp_1 * iv_no_carp_2.
  ENDMETHOD.

  METHOD bol.
    ev_no_bolum = iv_no_bol_1 / iv_no_bol_2.
  ENDMETHOD.

ENDCLASS.

PARAMETERS: p_sayi_1 TYPE i,
            p_sayi_2 TYPE i,
            p_sembol TYPE c LENGTH 1.

DATA: gv_res TYPE i.

START-OF-SELECTION.

  IF p_sembol = '+'.

    lcl_calculator=>topla(
      EXPORTING
        iv_no_1 = p_sayi_1
        iv_no_2 = p_sayi_2
      IMPORTING
        ev_no   = gv_res ).

  ELSEIF p_sembol = '-'.

    lcl_calculator=>cikar(
      EXPORTING
        iv_no_cikar_1 = p_sayi_1
        iv_no_cikar_2 = p_sayi_2
      IMPORTING
        ev_no_cikar   = gv_res ).

  ELSEIF p_sembol = '*'.

    lcl_calculator=>carp(
      EXPORTING
        iv_no_carp_1 = p_sayi_1
        iv_no_carp_2 = p_sayi_2
      IMPORTING
        ev_no_carpim = gv_res ).

  ELSEIF p_sembol = '/'.

    IF p_sayi_2 = 0.
      MESSAGE 'Bölen sifir olamaz!' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    lcl_calculator=>bol(
      EXPORTING
        iv_no_bol_1 = p_sayi_1
        iv_no_bol_2 = p_sayi_2
      IMPORTING
        ev_no_bolum = gv_res ).

  ENDIF.

  WRITE: gv_res.
