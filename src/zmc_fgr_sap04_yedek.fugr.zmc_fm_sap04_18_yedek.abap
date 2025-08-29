FUNCTION ZMC_FM_SAP04_18_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_SUCCESS) TYPE  CHAR1
*"     REFERENCE(IV_ERROR) TYPE  CHAR1
*"     REFERENCE(IV_WARNING) TYPE  CHAR1
*"     REFERENCE(IV_INFO) TYPE  CHAR1
*"--------------------------------------------------------------------

    IF iv_success = abap_true.

*      MESSAGE s000(zmc_sap04_1).
*    MESSAGE s001(zmc_sap04_1) WITH '1' 'basari'.
      MESSAGE s001 WITH '1' 'basari'.

    ELSEIF iv_error = abap_true.

*      MESSAGE e000(zmc_sap04_1).
*    MESSAGE e001(zmc_sap04_1) WITH '2' 'hata'.
      MESSAGE e001 WITH '2' 'hata'.

    ELSEIF iv_warning = abap_true.

*      MESSAGE w000(zmc_sap04_1).
*    MESSAGE w001(zmc_sap04_1) WITH '3' 'uyari'.
      MESSAGE w001 WITH '3' 'uyari'.

    ELSEIF iv_info = abap_true.

*      MESSAGE i000(zmc_sap04_1).
      MESSAGE i001 WITH '4' 'bilgi'.

    ENDIF.



ENDFUNCTION.
