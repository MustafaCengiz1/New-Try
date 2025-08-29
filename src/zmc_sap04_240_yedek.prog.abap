*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_240
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_240_yedek.

DATA: gt_table TYPE zmc_tt_sap04,
      gs_str   TYPE zmc_s_sap04.

START-OF-SELECTION.

  SELECT * FROM zmc_stravelag INTO TABLE @DATA(gt_stravelag).


  LOOP AT gt_stravelag INTO DATA(gs_stravelag).

    MOVE-CORRESPONDING gs_stravelag TO gs_str.

  ENDLOOP.

  LOOP AT gt_stravelag INTO gs_stravelag.

    gs_str = CORRESPONDING #( gs_stravelag ).

  ENDLOOP.

  MOVE-CORRESPONDING gt_stravelag TO gt_table.

  gt_table = CORRESPONDING #( gt_stravelag ).


  MOVE-CORRESPONDING gt_stravelag TO gt_table KEEPING TARGET LINES.

  gt_table = CORRESPONDING #( BASE ( gt_table ) gt_stravelag ).

  BREAK-POINT.
