*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_248
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_248_yedek.

TYPES: BEGIN OF gty_header,
         header TYPE c LENGTH 20,
       END OF gty_header.

DATA: gt_header TYPE TABLE OF gty_header,
      gs_header TYPE gty_header.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  gs_header-header = 'MANDT'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'ID'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'AGENCYNUM'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'NAME'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'STREET'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'POSTBOX'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'POSTCODE'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'CITY'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'COUNTRY'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'REGION'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'TELEPHONE'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'URL'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'LANGU'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  gs_header-header = 'CURRENCY'.
  APPEND gs_header TO gt_header.
  CLEAR: gs_header.

  cl_gui_frontend_services=>gui_download(
    EXPORTING
      filename                  = 'C:\Users\musta\OneDrive\Desktop\yeni4.XLS'
      write_field_separator     = 'X'
      fieldnames                = gt_header
    CHANGING
      data_tab                  = gt_table
    EXCEPTIONS
      file_write_error          = 1
      no_batch                  = 2
      gui_refuse_filetransfer   = 3
      invalid_type              = 4
      no_authority              = 5
      unknown_error             = 6
      header_not_allowed        = 7
      separator_not_allowed     = 8
      filesize_not_allowed      = 9
      header_too_long           = 10
      dp_error_create           = 11
      dp_error_send             = 12
      dp_error_write            = 13
      unknown_dp_error          = 14
      access_denied             = 15
      dp_out_of_memory          = 16
      disk_full                 = 17
      dp_timeout                = 18
      file_not_found            = 19
      dataprovider_exception    = 20
      control_flush_error       = 21
      not_supported_by_gui      = 22
      error_no_gui              = 23
      OTHERS                    = 24
  ).
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
