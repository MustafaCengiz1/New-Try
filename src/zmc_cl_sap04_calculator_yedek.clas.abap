class ZMC_CL_SAP04_CALCULATOR_YEDEK definition
  public
  final
  create public .

public section.

  methods TOPLA
    importing
      !IV_NO_1 type INT4
      !IV_NO_2 type INT4
    exporting
      !EV_NO type INT4 .
  methods CIKAR
    importing
      !IV_NO_CIKAR_1 type INT4
      !IV_NO_CIKAR_2 type INT4
    exporting
      !EV_NO_CIKAR type INT4 .
  methods CARP
    importing
      !IV_NO_CARP_1 type INT4
      !IV_NO_CARP_2 type INT4
    exporting
      !EV_NO_CARPIM type INT4 .
  methods BOL
    importing
      !IV_NO_BOL_1 type INT4
      !IV_NO_BOL_2 type INT4
    exporting
      !EV_NO_BOLUM type INT4
    exceptions
      SIFIRA_BOLME_ISLEMI .
protected section.
private section.
ENDCLASS.



CLASS ZMC_CL_SAP04_CALCULATOR_YEDEK IMPLEMENTATION.


  METHOD BOL.

    IF iv_no_bol_2 = 0.
      RAISE sifira_bolme_islemi.
    ENDIF.

    ev_no_bolum = iv_no_bol_1 / iv_no_bol_2.

  ENDMETHOD.


  METHOD CARP.

    ev_no_carpim = iv_no_carp_1 * iv_no_carp_2.

  ENDMETHOD.


  METHOD CIKAR.

    ev_no_cikar = iv_no_cikar_1 - iv_no_cikar_2.

  ENDMETHOD.


  METHOD TOPLA.

    ev_no = iv_no_1 + iv_no_2.

  ENDMETHOD.
ENDCLASS.
