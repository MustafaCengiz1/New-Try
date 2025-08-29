*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_125
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_125_yedek.

DATA: gv_number_1 TYPE i VALUE 10,
      gv_number_2 TYPE i,
      gv_result   TYPE i.



START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_04'
    EXPORTING
      iv_number_1   = gv_number_1
      iv_number_2   = gv_number_2
    IMPORTING
      ev_result     = gv_result
    EXCEPTIONS
      zero_division = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.

  ENDIF.
