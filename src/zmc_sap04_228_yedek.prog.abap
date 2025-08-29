*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_228
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_228_yedek.

*DATA: gv_text_1 TYPE c LENGTH 20 VALUE 'Text Text 001',
*      gv_text_2 TYPE c LENGTH 20 VALUE 'Text Text 001',
*      gv_number TYPE i VALUE 10,
*      gv_date TYPE datum VALUE '20250818',
*      gv_time TYPE uzeit VALUE '190600'.
*
START-OF-SELECTION.
*
*DATA(gv_son) = gv_text_1.
*DATA(gv_son_2) = gv_text_2.
*
*DATA(gv_toplam) = gv_number + 10.
*
*DATA(gv_date_2) = sy-datum.
*
*DATA(gv_time_2) = sy-uzeit.

SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

  READ TABLE gt_sflight INTO DATA(gs_sflight) INDEX 1.

  IF sy-subrc IS INITIAL.

    DATA(gt_sflight_2) = gt_sflight.

    DATA(gs_sflight_2) = gs_sflight.

  ENDIF.

BREAK-POINT.
