*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_124
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_124_yedek.

PARAMETERS: p_carrid TYPE s_carr_id,
            p_connid TYPE s_conn_id,
            p_time_d TYPE sy-uzeit,
            p_time_a TYPE sy-uzeit.

DATA: gs_spfli          TYPE spfli,
      gv_fltime         TYPE s_fltime,
      gv_fltime_changed TYPE xfeld.

START-OF-SELECTION.

  SELECT SINGLE * FROM spfli
    INTO gs_spfli
    WHERE carrid = p_carrid
    AND   connid = p_connid.

  CALL FUNCTION 'ZMC_FM_SAP04_03'
    EXPORTING
      iv_dep_time       = p_time_d
      iv_arr_time       = p_time_a
    IMPORTING
      ev_fltime         = gv_fltime
      ev_fltime_changed = gv_fltime_changed
    changing
      cs_spfli          = gs_spfli.

  IF gv_fltime_changed = abap_true.
    MODIFY spfli FROM gs_spfli.
  ENDIF.

*  BREAK-POINT.
