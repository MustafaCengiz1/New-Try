*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_212
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_212_yedek.

PARAMETERS: p_carr1 TYPE s_carr_id.

DATA: gt_scarr  TYPE TABLE OF scarr,
      gt_fcat   TYPE lvc_t_fcat,
      gs_layout TYPE lvc_s_layo.

START-OF-SELECTION.

SELECT * FROM scarr INTO TABLE gt_scarr WHERE carrid = p_carr1.

CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
    i_structure_name       = 'SCARR'
    i_bypassing_buffer     = abap_true
  CHANGING
    ct_fieldcat            = gt_fcat
  EXCEPTIONS
    inconsistent_interface = 1
    program_error          = 2
    OTHERS                 = 3.

IF sy-subrc IS NOT INITIAL.
  BREAK-POINT.
ENDIF.

gs_layout-zebra      = abap_true.
gs_layout-cwidth_opt = abap_true.
gs_layout-sel_mode   = 'A'.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
  EXPORTING
    i_callback_program = sy-repid
    is_layout_lvc      = gs_layout
    it_fieldcat_lvc    = gt_fcat
  TABLES
    t_outtab           = gt_scarr
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.

IF sy-subrc IS NOT INITIAL.
  BREAK-POINT.
ENDIF.
