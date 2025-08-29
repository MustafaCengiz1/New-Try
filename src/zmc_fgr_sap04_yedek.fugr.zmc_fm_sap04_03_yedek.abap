FUNCTION ZMC_FM_SAP04_03_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_DEP_TIME) TYPE  TIMS
*"     REFERENCE(IV_ARR_TIME) TYPE  TIMS
*"  EXPORTING
*"     REFERENCE(EV_FLTIME) TYPE  S_FLTIME
*"     REFERENCE(EV_FLTIME_CHANGED) TYPE  XFELD
*"  CHANGING
*"     REFERENCE(CS_SPFLI) TYPE  SPFLI
*"--------------------------------------------------------------------

  DATA: lv_seconds TYPE i.

  cs_spfli-deptime = iv_dep_time.
  cs_spfli-arrtime = iv_arr_time.

  lv_seconds = iv_arr_time - iv_dep_time.

  ev_fltime = lv_seconds / 60.

  IF ev_fltime NE cs_spfli-fltime.

    cs_spfli-fltime = ev_fltime.

    ev_fltime_changed = abap_true.

  ENDIF.







ENDFUNCTION.
