FUNCTION ZMC_FM_SAP04_06_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NO) TYPE  NUMC1
*"  EXPORTING
*"     REFERENCE(EV_DAY) TYPE  CHAR15
*"  EXCEPTIONS
*"      WRONG_NUMBER
*"--------------------------------------------------------------------

  CASE iv_no.
    WHEN 1.
      ev_day = 'Pazartesi'.
    WHEN 2.
      ev_day = 'Sali'.
    WHEN 3.
      ev_day = 'Carsamba'.
    WHEN 4.
      ev_day = 'Persembe'.
    WHEN 5.
      ev_day = 'Cuma'.
    WHEN 6.
      ev_day = 'Cumartesi'.
    WHEN 7.
      ev_day = 'Pazar'.

    WHEN OTHERS.
      RAISE wrong_number.
  ENDCASE.


ENDFUNCTION.
