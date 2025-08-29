*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_165
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_165_yedek.

PARAMETERS: p_carrid TYPE s_carr_id.

DATA: gt_scarr TYPE zmc_tt_scarr,
      gt_spfli TYPE zmc_tt_spfli.

START-OF-SELECTION.

  zmc_cl_sap04_fdm=>get_scarr(
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_scarr  = gt_scarr ).

  zmc_cl_sap04_fdm=>get_spfli(
    EXPORTING
      iv_carrid = p_carrid
    IMPORTING
      et_spfli  = gt_spfli ).

  BREAK-POINT.
