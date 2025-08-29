*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_123
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_123_yedek.

PARAMETERS: p_text_1 TYPE c LENGTH 40 LOWER CASE,
            p_text_2 TYPE c LENGTH 40 LOWER CASE,
            p_upper AS CHECKBOX.

DATA: gv_text TYPE c LENGTH 80.

START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_02'
    EXPORTING
      iv_text_1    = p_text_1
      iv_text_2    = p_text_2
      iv_uppercase = p_upper
    importing
      ev_text      = gv_text.

  WRITE: gv_text.
