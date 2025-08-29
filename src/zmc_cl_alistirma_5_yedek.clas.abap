class ZMC_CL_ALISTIRMA_5_YEDEK definition
  public
  final
  create public .

public section.

  data MT_SCARR type ZMC_TT_SCARR .
  data MT_SPFLI type ZMC_TT_SPFLI .
  data MT_SFLIGHT type ZMC_TT_SFLIGHT .

  methods GET_DATA
    importing
      !IT_CARRID_RANGE type ZMC_TT_CARRID
      !IV_SCARR type CHAR1
      !IV_SPFLI type CHAR1
      !IV_SFLIGHT type CHAR1 .
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



CLASS ZMC_CL_ALISTIRMA_5_YEDEK IMPLEMENTATION.


  METHOD GET_DATA.

    IF iv_scarr = abap_true.

      get_scarr(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_scarr        = mt_scarr ).

    ENDIF.

    IF iv_spfli = abap_true.

      get_spfli(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_spfli        = mt_spfli ).

    ENDIF.

    IF iv_sflight = abap_true.

      get_sflight(
        EXPORTING
          it_carrid_range = it_carrid_range
        IMPORTING
          et_sflight      = mt_sflight ).

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
