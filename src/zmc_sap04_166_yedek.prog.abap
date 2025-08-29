*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_166
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_166_yedek.

PARAMETERS: p_carrid TYPE s_carr_id,
            p_tname  TYPE string.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF spfli.

START-OF-SELECTION.

  zmc_cl_sap04_fdm_2=>get_data(
    EXPORTING
      iv_table_name = p_tname
      iv_carrid     = p_carrid
    IMPORTING
      et_scarr      = gt_scarr
      et_spfli      = gt_spfli ).

  BREAK-POINT.
