*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_120
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_120_yedek.

DATA: gv_carrname TYPE s_carrname,
      gt_scarr    TYPE TABLE OF scarr,
      gt_spfli    TYPE TABLE OF spfli,
      gt_sflight  TYPE TABLE OF sflight.

SELECT-OPTIONS: so_cname FOR gv_carrname.

START-OF-SELECTION.

  PERFORM select_all.

FORM select_all .
  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrname IN so_cname.

  IF gt_scarr IS NOT INITIAL.
    PERFORM select_spfli.
    PERFORM select_sflight.
  ENDIF.
ENDFORM.


FORM select_spfli .
  SELECT * FROM spfli
    INTO TABLE gt_spfli
    FOR ALL ENTRIES IN gt_scarr
    WHERE carrid = gt_scarr-carrid.
ENDFORM.


FORM select_sflight .
  SELECT * FROM sflight
    INTO TABLE gt_sflight
    FOR ALL ENTRIES IN gt_scarr
    WHERE carrid = gt_scarr-carrid.
ENDFORM.
