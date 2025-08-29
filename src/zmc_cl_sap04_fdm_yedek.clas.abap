class ZMC_CL_SAP04_FDM_YEDEK definition
  public
  final
  create public .

public section.

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
protected section.
private section.
ENDCLASS.



CLASS ZMC_CL_SAP04_FDM_YEDEK IMPLEMENTATION.


  METHOD GET_SCARR.

    select * FROM scarr
      into TABLE et_scarr
      WHERE carrid = iv_carrid.


  ENDMETHOD.


  METHOD GET_SPFLI.

    select * FROM spfli
      INTO TABLE et_spfli
      WHERE carrid = iv_carrid.

  ENDMETHOD.
ENDCLASS.
