*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_180
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_180_yedek.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: line_color TYPE c LENGTH 4.
TYPES: cell_color TYPE lvc_t_scol.
*TYPES: traffic_light TYPE c LENGTH 1.
TYPES: traffic_light TYPE icon_d.
TYPES: END OF gty_str.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo.

DATA: gt_sflight TYPE TABLE OF gty_str,
      gs_sflight TYPE gty_str.

START-OF-SELECTION.

  CALL SCREEN 0100.

MODULE status_0100 OUTPUT. "PBO
  SET PF-STATUS 'PF_STATUS_180'.
  SET TITLEBAR 'TITLE_180'.

  PERFORM select_data.
  PERFORM open_traffic_lights.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

ENDMODULE.

MODULE user_command_0100 INPUT. "PAI

  DATA: lt_row_no        TYPE lvc_t_roid,
        ls_row_no        TYPE lvc_s_roid,
        lt_list          TYPE TABLE OF gty_str,
        ls_list          TYPE gty_str,
        lt_index_columns TYPE lvc_t_col,
        ls_index_columns TYPE lvc_s_col,
        lv_color         TYPE c LENGTH 4,
        lv_answer        TYPE c LENGTH 1,
        lt_cell          TYPE lvc_t_cell,
        ls_cell          TYPE lvc_s_cell,
        ls_cell_color    TYPE lvc_s_scol,
        lv_color_number,
        lv_intensified,
        lv_inverse,
        lt_filter        TYPE lvc_t_filt,
        ls_filter        TYPE lvc_s_filt,
        lt_sort          TYPE lvc_t_sort,
        ls_sort          TYPE lvc_s_sort.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'STRSIL'.

      go_alvgrid->get_selected_rows(
        IMPORTING
          et_row_no = lt_row_no ).

      lt_list = gt_sflight.

      LOOP AT lt_row_no INTO ls_row_no.
*        DELETE gt_sflight INDEX ls_row_no-row_id.

        READ TABLE lt_list INTO ls_list INDEX ls_row_no-row_id.
        IF sy-subrc IS INITIAL.
          DELETE gt_sflight WHERE carrid = ls_list-carrid AND
                                  connid = ls_list-connid AND
                                  fldate = ls_list-fldate.
        ENDIF.
      ENDLOOP.

    WHEN 'RESET'.
      CLEAR: gt_sflight, lt_filter, lt_sort.

    WHEN 'COLUMN'.

      go_alvgrid->get_selected_columns(
        IMPORTING
          et_index_columns = lt_index_columns ).

      IF lt_index_columns IS NOT INITIAL.

        CALL FUNCTION 'ZMC_FM_SAP04_16'
          IMPORTING
            ev_color  = lv_color
            ev_answer = lv_answer.

        IF lv_answer IS INITIAL AND lv_color IS NOT INITIAL.

          LOOP AT lt_index_columns INTO ls_index_columns.

            READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = ls_index_columns-fieldname.

            IF sy-subrc IS INITIAL.
              gs_fcat-emphasize = lv_color.

              MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.
            ENDIF.

          ENDLOOP.
        ENDIF.
      ENDIF.

    WHEN 'LINE'.

      go_alvgrid->get_selected_rows(
        IMPORTING
          et_row_no = lt_row_no ).

      IF lt_row_no IS NOT INITIAL.
        CALL FUNCTION 'ZMC_FM_SAP04_16'
          IMPORTING
            ev_color  = lv_color
            ev_answer = lv_answer.

        IF lv_answer IS INITIAL AND lv_color IS NOT INITIAL.

          LOOP AT lt_row_no INTO ls_row_no.

            READ TABLE gt_sflight INTO gs_sflight INDEX ls_row_no-row_id.

            IF sy-subrc IS INITIAL.
              gs_sflight-line_color = lv_color.

              MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.
            ENDIF.

          ENDLOOP.

        ENDIF.
      ENDIF.

    WHEN 'CELL'.

      go_alvgrid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lt_cell IS NOT INITIAL.

        CALL FUNCTION 'ZMC_FM_SAP04_17'
          IMPORTING
            ev_color_number = lv_color_number
            ev_intensified  = lv_intensified
            ev_inverse      = lv_inverse
            ev_answer       = lv_answer.


        IF lv_answer IS INITIAL AND lv_color_number IS NOT INITIAL
                                AND lv_intensified  IS NOT INITIAL
                                AND lv_inverse      IS NOT INITIAL.

          LOOP AT lt_cell INTO ls_cell.

            ls_cell_color-fname     = ls_cell-col_id.
            ls_cell_color-color-col = lv_color_number.
            ls_cell_color-color-int = lv_intensified.
            ls_cell_color-color-inv = lv_inverse.

            READ TABLE gt_sflight INTO gs_sflight INDEX ls_cell-row_id.

            IF sy-subrc IS INITIAL.

              APPEND ls_cell_color TO gs_sflight-cell_color.

              MODIFY gt_sflight FROM gs_sflight INDEX ls_cell-row_id.

            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

    WHEN 'PLNTYPE'.

      go_alvgrid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.
        IF sy-subrc IS INITIAL.

          IF ls_cell-col_id = 'PLANETYPE'.

            READ TABLE gt_sflight INTO gs_sflight INDEX ls_cell-row_id.

            IF sy-subrc IS INITIAL.

              ls_filter-fieldname = ls_cell-col_id.
              ls_filter-sign      = 'I'.
              ls_filter-option    = 'EQ'.
              ls_filter-low       = gs_sflight-planetype.

              APPEND ls_filter TO lt_filter.
              CLEAR: ls_filter.

            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

    WHEN 'A_Z'.

      go_alvgrid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.

        IF sy-subrc IS INITIAL.
          CLEAR: lt_sort.

          ls_sort-spos      = 1.
          ls_sort-fieldname = ls_cell-col_id.
          ls_sort-up        = abap_true. "Ascending
          ls_sort-down      = abap_false."Descending

          APPEND ls_sort TO lt_sort.
          CLEAR: ls_sort.

        ENDIF.
      ENDIF.


    WHEN 'Z_A'.

      CLEAR: lt_cell.

      go_alvgrid->get_selected_cells(
        IMPORTING
          et_cell = lt_cell ).

      IF lines( lt_cell ) = 1.

        READ TABLE lt_cell INTO ls_cell INDEX 1.

        IF sy-subrc IS INITIAL.
          CLEAR: lt_sort.


          ls_sort-spos      = 1.
          ls_sort-fieldname = ls_cell-col_id.
          ls_sort-up        = abap_false. "Ascending
          ls_sort-down      = abap_true."Descending

          APPEND ls_sort TO lt_sort.
          CLEAR: ls_sort.

        ENDIF.
      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.

FORM select_data.
  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
  ENDIF.
ENDFORM.

FORM fcat.

  IF gt_fcat IS INITIAL.

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

    gs_fcat-fieldname = 'TRAFFIC_LIGHT'.
    gs_fcat-col_pos   = 7.
    gs_fcat-scrtext_m = 'Bilet Durumu'.

    APPEND gs_fcat to gt_fcat.
    CLEAR: gs_fcat.

  ENDIF.

ENDFORM.

FORM layout.

  IF gs_layout IS INITIAL.

    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = 'A'.
    gs_layout-info_fname = 'LINE_COLOR'.
    gs_layout-ctab_fname = 'CELL_COLOR'.
*    gs_layout-excp_fname = 'TRAFFIC_LIGHT'.

  ENDIF.

ENDFORM.

FORM show_alv.

  IF go_alvgrid IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CC_ALV'
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
        it_outtab                     = gt_sflight
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

    go_alvgrid->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).

    go_alvgrid->set_frontend_layout( is_layout = gs_layout ).

    go_alvgrid->set_filter_criteria(
      EXPORTING
        it_filter                 = lt_filter
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2 ).

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_alvgrid->set_sort_criteria(
      EXPORTING
        it_sort                   = lt_sort
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2 ).

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_alvgrid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.

FORM open_traffic_lights.

  DATA: lv_decimal TYPE p DECIMALS 1.

  LOOP AT gt_sflight INTO gs_sflight.

    lv_decimal = gs_sflight-seatsocc / gs_sflight-seatsmax.

    IF lv_decimal >= ( 80 / 100 ).

*      gs_sflight-traffic_light = 1.
      gs_sflight-traffic_light = '@0A@'.

    ELSEIF lv_decimal < ( 80 / 100 ) AND lv_decimal >= ( 40 / 100 ).

*      gs_sflight-traffic_light = 2.
      gs_sflight-traffic_light = '@09@'.

    ELSEIF lv_decimal < ( 40 / 100 ).

*      gs_sflight-traffic_light = 3.
      gs_sflight-traffic_light = '@08@'.

    ENDIF.

    MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

  ENDLOOP.

ENDFORM.
