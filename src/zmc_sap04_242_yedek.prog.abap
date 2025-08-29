*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_242
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_242_yedek.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

  LOOP AT gt_sflight INTO DATA(gs_sflight) GROUP BY ( carrid = gs_sflight-carrid ) INTO DATA(gt_group).

    LOOP AT GROUP gt_group INTO DATA(gs_line).
      BREAK-POINT.
    ENDLOOP.

  ENDLOOP.

  BREAK-POINT.
