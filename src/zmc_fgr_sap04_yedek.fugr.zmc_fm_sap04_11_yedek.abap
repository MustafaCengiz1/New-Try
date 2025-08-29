FUNCTION ZMC_FM_SAP04_11_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_DAY) TYPE  CHAR15
*"     REFERENCE(IV_NUMBER) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_DAY) TYPE  CHAR15
*"  EXCEPTIONS
*"      YANLIS_GUN
*"--------------------------------------------------------------------

  DATA: lv_number   TYPE i,
        lv_number_2 TYPE i,
        lv_number_3 TYPE i.

  CASE iv_day.
    WHEN 'Pazartesi'.
      lv_number = 1.
    WHEN 'Sali'.
      lv_number = 2.
    WHEN 'Carsamba'.
      lv_number = 3.
    WHEN 'Persembe'.
      lv_number = 4.
    WHEN 'Cuma'.
      lv_number = 5.
    WHEN 'Cumartesi'.
      lv_number = 6.
    WHEN 'Pazar'.
      lv_number = 7.
    WHEN OTHERS.

      RAISE yanlis_gun.
  ENDCASE.

  lv_number_2 = iv_number MOD 7.

  ADD  lv_number_2 TO lv_number.

  lv_number_3 = lv_number MOD 7.

  CASE lv_number_3.
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
  ENDCASE.



ENDFUNCTION.
