*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_214
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_214_YEDEK.

PARAMETERS: p_carr3 TYPE s_carr_id.

DATA: gt_sflight TYPE TABLE OF sflight,
      gt_fcat   TYPE lvc_t_fcat,
      gs_layout TYPE lvc_s_layo.

START-OF-SELECTION.

SELECT * FROM sflight INTO TABLE gt_sflight WHERE carrid = p_carr3.

CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
    i_structure_name       = 'SFLIGHT'
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
    t_outtab           = gt_sflight
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.

IF sy-subrc IS NOT INITIAL.
  BREAK-POINT.
ENDIF.
