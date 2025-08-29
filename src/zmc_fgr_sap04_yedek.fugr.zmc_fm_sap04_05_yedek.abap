FUNCTION ZMC_FM_SAP04_05_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_TEXT_1) TYPE  CHAR20
*"     REFERENCE(IV_TEXT_2) TYPE  CHAR20
*"     REFERENCE(IV_TEXT_3) TYPE  CHAR20
*"  EXPORTING
*"     REFERENCE(EV_TEXT) TYPE  STRING
*"     REFERENCE(EV_NO_CHAR) TYPE  NUMC2
*"--------------------------------------------------------------------

  CONCATENATE iv_text_1
              iv_text_2
              iv_text_3 INTO ev_text SEPARATED BY space.

  ev_no_char = strlen( ev_text ).

ENDFUNCTION.
