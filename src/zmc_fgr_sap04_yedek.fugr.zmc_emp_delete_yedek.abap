FUNCTION ZMC_EMP_DELETE_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EMPID) TYPE  ZMC_EMPID OPTIONAL
*"  EXPORTING
*"     VALUE(EV_SUCCESS) TYPE  BOOLEAN
*"--------------------------------------------------------------------

  DELETE FROM zmc_emp WHERE empid = iv_empid.

  IF sy-subrc IS INITIAL.
    ev_success = abap_true.
  ENDIF.

ENDFUNCTION.
