*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_185
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_185_yedek.

*Alıştırma – 4: SPFLI ve kendinize ait SPFLI ile ayni satır yapısına sahip olan database tablosu (Ör:
*ZCM_SPFLI) yan yana iki ayrı ALV olacak şekilde bir Container ALV hazırlayın. (Sağdaki ALV tamamen
*bos olacak.) İki ALV arasında 2 adet buton olsun. İlk buton solda seçili satırları soldaki ALV’den silsin ve
*sağdaki ALV’ye kaydetsin. Aynı zamanda database tablosuna da kaydetsin. İkinci buton sağdaki tabloda
*seçili satırları database tablosundan ve ALV’den silsin ve soldaki ALV’ye kaydetsin.


DATA: go_cont_1  TYPE REF TO cl_gui_custom_container,
      go_grid_1  TYPE REF TO cl_gui_alv_grid,
      go_cont_2  TYPE REF TO cl_gui_custom_container,
      go_grid_2  TYPE REF TO cl_gui_alv_grid,
      gt_table_1 TYPE TABLE OF zmc_spfli_1,
      gs_str_1   TYPE zmc_spfli_1,
      gt_table_2 TYPE TABLE OF zmc_spfli_2,
      gs_str_2   TYPE zmc_spfli_2,
      gt_fcat    TYPE lvc_t_fcat,
      gs_layout  TYPE lvc_s_layo.

START-OF-SELECTION.

  CALL SCREEN 0400.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0400  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0400 OUTPUT.
  SET PF-STATUS 'PF_STATUS_185'.
  SET TITLEBAR 'TITLE185'.

  PERFORM select_data_1.
  PERFORM select_data_2.
  PERFORM fcat.
  PERFORM layout.

  PERFORM alv_1.
  PERFORM alv_2.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0400 INPUT."PAI

  DATA: lt_row_no TYPE lvc_t_roid,
        ls_row_no TYPE lvc_s_roid.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'RIGHT'.

      CLEAR: lt_row_no.

      go_grid_1->get_selected_rows(
        IMPORTING
          et_row_no = lt_row_no ).

      LOOP AT lt_row_no INTO ls_row_no.

        READ TABLE gt_table_1 INTO gs_str_1 INDEX ls_row_no-row_id.
        IF sy-subrc IS INITIAL.

          DELETE FROM zmc_spfli_1 WHERE carrid = gs_str_1-carrid AND connid = gs_str_1-connid.

          MODIFY zmc_spfli_2 FROM gs_str_1.

        ENDIF.

      ENDLOOP.

      SELECT * FROM zmc_spfli_1 INTO TABLE gt_table_1.
      SELECT * FROM zmc_spfli_2 INTO TABLE gt_table_2.

    WHEN 'LEFT'.

      CLEAR: lt_row_no.

      go_grid_2->get_selected_rows(
        IMPORTING
          et_row_no = lt_row_no ).

      LOOP AT lt_row_no INTO ls_row_no.

        READ TABLE gt_table_2 INTO gs_str_2 INDEX ls_row_no-row_id.
        IF sy-subrc IS INITIAL.

          DELETE FROM zmc_spfli_2 WHERE carrid = gs_str_2-carrid AND connid = gs_str_2-connid.

          MODIFY zmc_spfli_1 FROM gs_str_2.

        ENDIF.

      ENDLOOP.

      SELECT * FROM zmc_spfli_1 INTO TABLE gt_table_1.
      SELECT * FROM zmc_spfli_2 INTO TABLE gt_table_2.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data_1 .
  IF gt_table_1 IS INITIAL.
    SELECT * FROM zmc_spfli_1 INTO TABLE gt_table_1.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data_2 .
  IF gt_table_2 IS INITIAL.
    SELECT * FROM zmc_spfli_2 INTO TABLE gt_table_2.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fcat .

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SPFLI_1'
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
*&---------------------------------------------------------------------*
*&      Form  LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM layout .
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_1.

  IF go_grid_1 IS NOT BOUND.


    CREATE OBJECT go_cont_1
      EXPORTING
        container_name              = 'CONTAINER_1'
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

    CREATE OBJECT go_grid_1
      EXPORTING
        i_parent          = go_cont_1
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_grid_1->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table_1
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

    go_grid_1->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_2 .

  IF go_grid_2 IS NOT BOUND.
    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'CONTAINER_2'
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

    CREATE OBJECT go_grid_2
      EXPORTING
        i_parent          = go_cont_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_grid_2->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table_2
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

    go_grid_2->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.
ENDFORM.
