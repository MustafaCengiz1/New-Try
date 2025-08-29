FUNCTION ZMC_FM_SAP04_17_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EV_COLOR_NUMBER) TYPE  CHAR1
*"     REFERENCE(EV_INTENSIFIED) TYPE  CHAR1
*"     REFERENCE(EV_INVERSE) TYPE  CHAR1
*"     REFERENCE(EV_ANSWER) TYPE  CHAR1
*"--------------------------------------------------------------------

  CALL SELECTION-SCREEN 2030 STARTING AT 5 5 ENDING AT 45 5.

  IF sy-subrc IS INITIAL.

    ev_color_number = p_1.
    ev_intensified  = p_2.
    ev_inverse      = p_3.

  ELSE.

    ev_answer = sy-subrc.

  ENDIF.

ENDFUNCTION.
