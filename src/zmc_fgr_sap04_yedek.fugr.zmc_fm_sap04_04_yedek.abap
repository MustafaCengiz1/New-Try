FUNCTION ZMC_FM_SAP04_04_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUMBER_1) TYPE  INT4
*"     REFERENCE(IV_NUMBER_2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  INT4
*"  EXCEPTIONS
*"      ZERO_DIVISION
*"--------------------------------------------------------------------

  IF iv_number_2 = 0.

    RAISE zero_division.

  ELSE.

    ev_result = iv_number_1 / iv_number_2.

  ENDIF.



ENDFUNCTION.
