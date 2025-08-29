FUNCTION ZMC_FM_SAP04_13_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EV_URL) TYPE  S_URL
*"     REFERENCE(EV_ANSWER) TYPE  CHAR1
*"--------------------------------------------------------------------


  CALL SELECTION-SCREEN 2026 STARTING AT 5 5 ENDING AT 105 7.

  ev_url = p_url.
  ev_answer = sy-subrc.


ENDFUNCTION.
