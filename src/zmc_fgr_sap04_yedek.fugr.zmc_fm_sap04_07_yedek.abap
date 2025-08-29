FUNCTION ZMC_FM_SAP04_07_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"  EXPORTING
*"     REFERENCE(ET_SPFLI) TYPE  ZMC_SAP04_TT_2
*"--------------------------------------------------------------------


  SELECT * FROM spfli
    INTO TABLE et_spfli
    WHERE carrid = iv_carrid.


ENDFUNCTION.
