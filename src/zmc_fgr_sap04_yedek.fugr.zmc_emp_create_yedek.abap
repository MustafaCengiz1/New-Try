FUNCTION ZMC_EMP_CREATE_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EMPID) TYPE  ZMC_EMPID OPTIONAL
*"     VALUE(IV_EMPNAME) TYPE  ZMC_EMPNAM OPTIONAL
*"     VALUE(IV_EMPADD) TYPE  ZMC_EMPADD OPTIONAL
*"     VALUE(IV_EMPDES) TYPE  ZMC_EMPDES OPTIONAL
*"  EXPORTING
*"     VALUE(EV_SUCCESS) TYPE  BOOLEAN
*"--------------------------------------------------------------------

  DATA: ls_emp TYPE zmc_emp.

  ls_emp-empid  = iv_empid.
  ls_emp-empname = iv_empname.
  ls_emp-empadd = iv_empadd.
  ls_emp-empdes = iv_empdes.

  MODIFY zmc_emp FROM ls_emp.

  IF sy-subrc IS INITIAL.
    ev_success = abap_true.
  ENDIF.

ENDFUNCTION.
