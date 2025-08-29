FUNCTION ZMC_FM_SAP04_02_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_TEXT_1) TYPE  CHAR40
*"     REFERENCE(IV_TEXT_2) TYPE  CHAR40
*"     REFERENCE(IV_UPPERCASE) TYPE  XFELD OPTIONAL
*"     REFERENCE(IV_TEST) TYPE  CHAR10 OPTIONAL
*"  EXPORTING
*"     REFERENCE(EV_TEXT) TYPE  CHAR80
*"--------------------------------------------------------------------

CONCATENATE iv_text_1 iv_text_2 INTO ev_text SEPARATED BY space.

IF iv_uppercase = abap_true.
  TRANSLATE ev_text TO UPPER CASE.
ENDIF.

ENDFUNCTION.
