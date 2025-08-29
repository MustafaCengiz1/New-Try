FUNCTION ZMC_FM_SAP04_08_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRNAME) TYPE  S_CARRNAME
*"  EXPORTING
*"     REFERENCE(ES_SCARR) TYPE  SCARR
*"     REFERENCE(ET_SPFLI) TYPE  ZMC_SAP04_TT_2
*"     REFERENCE(ET_SFLIGHT) TYPE  ZMC_SAP04_TT_3
*"--------------------------------------------------------------------

  SELECT SINGLE * FROM scarr
    INTO es_scarr
    WHERE carrname = iv_carrname.

  IF sy-subrc IS INITIAL.

    SELECT * FROM spfli
      INTO TABLE et_spfli
      WHERE carrid = es_scarr-carrid.

    SELECT * FROM sflight
      INTO TABLE et_sflight
      WHERE carrid = es_scarr-carrid.

  ENDIF.


ENDFUNCTION.
