class ZMC_CL_ALISTIRMA_4_YEDEK definition
  public
  final
  create public .

public section.

  methods GET_DATA
    importing
      !IT_CARRID_RANGE type ZMC_TT_CARRID
      !IV_SCARR type CHAR1
      !IV_SPFLI type CHAR1
      !IV_SFLIGHT type CHAR1
    exporting
      !ET_SCARR type ZMC_TT_SCARR
      !ET_SPFLI type ZMC_TT_SPFLI
      !ET_SFLIGHT type ZMC_TT_SFLIGHT .
protected section.

  methods GET_SCARR
    importing
      !IT_CARRID_RANGE type ZMC_TT_CARRID
    exporting
      !ET_SCARR type ZMC_TT_SCARR .
  methods GET_SPFLI
    importing
      !IT_CARRID_RANGE type ZMC_TT_CARRID
    exporting
      !ET_SPFLI type ZMC_TT_SPFLI .
  methods GET_SFLIGHT
    importing
      !IT_CARRID_RANGE type ZMC_TT_CARRID
    exporting
      !ET_SFLIGHT type ZMC_TT_SFLIGHT .
private section.
ENDCLASS.



CLASS ZMC_CL_ALISTIRMA_4_YEDEK IMPLEMENTATION.


  METHOD GET_DATA.

    IF iv_scarr = abap_true.

      get_scarr(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_scarr        = et_scarr ).

    ENDIF.

    IF iv_spfli = abap_true.

      get_spfli(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_spfli        = et_spfli ).

    ENDIF.

    IF iv_sflight = abap_true.

      get_sflight(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_sflight      = et_sflight ).

    ENDIF.

  ENDMETHOD.


  METHOD GET_SCARR.

    SELECT * FROM scarr
      INTO TABLE et_scarr
      WHERE carrid IN IT_CARRID_RANGE.

  ENDMETHOD.


  METHOD GET_SFLIGHT.

    SELECT * FROM sflight
      INTO TABLE et_sflight
      WHERE carrid IN it_carrid_range.
  ENDMETHOD.


  METHOD GET_SPFLI.

     SELECT * FROM spfli
      INTO TABLE ET_SPFLI
      WHERE carrid IN IT_CARRID_RANGE.

  ENDMETHOD.
ENDCLASS.
