*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_237
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_237_yedek.

DATA: gv_no_1 TYPE i.
DATA: gv_no_2 TYPE i.

START-OF-SELECTION.

  SELECT * FROM zmc_stravelag INTO TABLE @DATA(gt_table).


  LOOP AT gt_table INTO DATA(gs_str) WHERE country = 'DE'.

    ADD 1 TO gv_no_1.

  ENDLOOP.


  gv_no_2 = REDUCE #( INIT x = 0 FOR gs_str_2 IN gt_table WHERE ( country = 'DE' ) NEXT x = x + 1 ).

  BREAK-POINT.

  SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

  DATA(gv_no_3) = REDUCE i( INIT x = 0 FOR gs_sflight IN gt_sflight NEXT x = x + gs_sflight-seatsocc ).

  BREAK-POINT.
