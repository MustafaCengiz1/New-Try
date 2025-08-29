*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_184
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_184_yedek.

*Alıştırma – 3: SCARR tablosu için Container ALV hazırlayın. 2 adet buton oluşturun. İlk butona
*basıldığında tek satırları, ikinci butona basıldığında çift numaralı satırları istediğiniz bir renk ile
*renklendirin.
TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE scarr.
TYPES: satir_renk TYPE c LENGTH 4. "C711
TYPES: END OF gty_str.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      gt_scarr     TYPE TABLE OF gty_str,
      gs_scarr     TYPE gty_str.

START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT."PBO
  SET PF-STATUS 'PF_STATUS_184'.
  SET TITLEBAR 'TITLE_184'.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM alv.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT."PAI
  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'TEK'.

      LOOP AT gt_scarr INTO gs_scarr.

        CLEAR: gs_scarr-satir_renk.

        IF sy-tabix MOD 2 = 1.

          gs_scarr-satir_renk = 'C711'.

        ENDIF.

        MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.
      ENDLOOP.

    WHEN 'CIFT'.

      LOOP AT gt_scarr INTO gs_scarr.

        CLEAR: gs_scarr-satir_renk.

        IF sy-tabix MOD 2 = 0.

          gs_scarr-satir_renk = 'C610'.

        ENDIF.

        MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.
      ENDLOOP.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

FORM select_data .
  IF gt_scarr IS INITIAL.
    SELECT * FROM scarr INTO TABLE gt_scarr.
  ENDIF.
ENDFORM.

FORM fcat .
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

ENDFORM.

FORM layout .
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.
  gs_layout-info_fname = 'SATIR_RENK'.
ENDFORM.

FORM alv .

  IF go_container IS NOT BOUND. "IF go_container is initial.
    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CONTAINER'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_alvgrid
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_alvgrid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_scarr
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ELSE.

*    go_alvgrid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).
*
*    go_alvgrid->set_frontend_layout( is_layout = gs_layout ).

    go_alvgrid->refresh_table_display( ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.
  ENDIF.

ENDFORM.
