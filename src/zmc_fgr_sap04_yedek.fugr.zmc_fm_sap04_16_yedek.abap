FUNCTION ZMC_FM_SAP04_16_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EV_COLOR) TYPE  CHAR4
*"     REFERENCE(EV_ANSWER) TYPE  CHAR1
*"--------------------------------------------------------------------

  CALL SELECTION-SCREEN 2029 STARTING AT 5 5 ENDING AT 45 5.

  IF sy-subrc IS INITIAL.
    ev_color = p_color.

  else.

    ev_answer = sy-subrc.
  ENDIF.





ENDFUNCTION.
