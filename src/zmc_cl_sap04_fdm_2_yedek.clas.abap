class ZMC_CL_SAP04_FDM_2_YEDEK definition
  public
  final
  create public .

public section.

  class-methods GET_DATA
    importing
      !IV_TABLE_NAME type STRING
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SCARR type ZMC_TT_SCARR
      !ET_SPFLI type ZMC_TT_SPFLI .
protected section.

  class-methods GET_SCARR
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SCARR type ZMC_TT_SCARR .
  class-methods GET_SPFLI
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SPFLI type ZMC_TT_SPFLI .
private section.
ENDCLASS.



CLASS ZMC_CL_SAP04_FDM_2_YEDEK IMPLEMENTATION.


  METHOD GET_DATA.

    IF iv_table_name = 'SCARR'.

      get_scarr(
        EXPORTING
          iv_carrid = iv_carrid
        IMPORTING
          et_scarr  = et_scarr ).

    ELSEIF iv_table_name = 'SPFLI'.

      get_spfli(
        EXPORTING
          iv_carrid = iv_carrid
        IMPORTING
          et_spfli  = et_spfli ).

    ENDIF.


  ENDMETHOD.


  METHOD GET_SCARR.

    SELECT * FROM scarr
      INTO TABLE et_scarr
      WHERE carrid = iv_carrid.

  ENDMETHOD.


  METHOD GET_SPFLI.

    SELECT * FROM spfli
      INTO TABLE et_spfli
      WHERE carrid = iv_carrid.

  ENDMETHOD.
ENDCLASS.
