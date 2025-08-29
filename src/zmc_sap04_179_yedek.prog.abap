*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_179
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_179_yedek.

DATA: gt_table TYPE TABLE OF zmc_sap04_deep_1,
      gs_str   TYPE zmc_sap04_deep_1.

PARAMETERS: p_carrid TYPE s_carr_id.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_table
    WHERE carrid = p_carrid.

  IF sy-subrc IS INITIAL.
    READ TABLE gt_table INTO gs_str INDEX 1.

    SELECT * FROM spfli
      INTO TABLE gs_str-deep_spfli
      WHERE carrid = p_carrid.

    CLEAR gt_table.

    APPEND gs_str TO gt_table.

  ENDIF.

  BREAK-POINT.
