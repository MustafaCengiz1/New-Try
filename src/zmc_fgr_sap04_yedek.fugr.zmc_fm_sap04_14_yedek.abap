FUNCTION ZMC_FM_SAP04_14_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_STRAVELAG) TYPE  ZMC_SAP04_STRAV
*"  EXPORTING
*"     REFERENCE(EV_ANSWER) TYPE  CHAR1
*"--------------------------------------------------------------------
DATA: ls_stravelag TYPE zmc_sap04_strav.

ls_stravelag = is_stravelag.


  p_url_2 = ls_stravelag-url.

  CALL SELECTION-SCREEN 2027 STARTING AT 5 5 ENDING AT 105 7.

  IF p_url_2 IS NOT INITIAL.

    IF sy-subrc IS INITIAL.

      ls_stravelag-eski_url = ls_stravelag-url.

      ls_stravelag-url = p_url_2.

      MODIFY zmc_sap04_strav FROM ls_stravelag.

    ENDIF.
  ENDIF.





ENDFUNCTION.
