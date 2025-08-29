*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_229
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_229_yedek.

PARAMETERS: p_scarr RADIOBUTTON GROUP was,
            p_spfli RADIOBUTTON GROUP was,
            p_sflgt RADIOBUTTON GROUP was,
            p_index TYPE i.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    READ TABLE gt_scarr INTO DATA(gs_scarr) INDEX p_index.
    IF sy-subrc  IS INITIAL.
      "WRITE
    ENDIF.

  ELSEIF p_spfli = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    READ TABLE gt_spfli INTO DATA(gs_spfli) INDEX p_index.
    IF sy-subrc  IS INITIAL.
      "WRITE
    ENDIF.

  ELSE.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    READ TABLE gt_sflight INTO DATA(gs_sflight) INDEX p_index.
    IF sy-subrc  IS INITIAL.
      "WRITE
    ENDIF.

  ENDIF.

  BREAK-POINT.
