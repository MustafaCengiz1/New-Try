FUNCTION ZMC_FM_SAP04_01_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUMBER_1) TYPE  INT4
*"     REFERENCE(IV_NUMBER_2) TYPE  INT4
*"  EXPORTING
*"     VALUE(EV_RESULT) TYPE  INT4
*"--------------------------------------------------------------------

*  ADD 10 TO iv_number_1.

  CLEAR: ev_result.


  ev_result = iv_number_1 + iv_number_2.


ENDFUNCTION.
