FUNCTION ZMC_EMP_GET_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EMPID) TYPE  ZMC_EMPID OPTIONAL
*"  EXPORTING
*"     VALUE(ET_EMP) TYPE  ZMC_TT_EMP
*"--------------------------------------------------------------------
  IF iv_empid IS NOT INITIAL.
    SELECT * FROM zmc_emp
      INTO TABLE et_emp
      WHERE empid = iv_empid.

  ELSE.
    SELECT * FROM zmc_emp
      INTO TABLE et_emp
       WHERE empid = iv_empid.

  ENDIF.




ENDFUNCTION.
