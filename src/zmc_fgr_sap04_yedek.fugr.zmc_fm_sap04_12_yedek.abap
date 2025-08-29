FUNCTION ZMC_FM_SAP04_12_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EV_DISTANCE) TYPE  S_DISTANCE
*"     REFERENCE(EV_ANSWER) TYPE  CHAR1
*"--------------------------------------------------------------------


  CALL SELECTION-SCREEN 2025 STARTING AT 5 5 ENDING AT 105 7.

  ev_distance = p_dist.
  ev_answer   = sy-subrc.


ENDFUNCTION.
