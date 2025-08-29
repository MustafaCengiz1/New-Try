*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_181
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_181_yedek.

DATA: gv_id        TYPE zmc_de_sap04_id,
      gv_name      TYPE zmc_de_sap04_name,
      gv_surname   TYPE zmc_de_sap04_sname,
      gv_job       TYPE zmc_de_sap04_job,
      gv_salary    TYPE zmc_de_sap04_sal,
      gv_curr      TYPE zmc_de_sap04_crr,
      gv_gsm       TYPE zmc_de_sap04_gsm,
      gv_e_mail    TYPE zmc_de_sap04_email,
      gs_str       TYPE zmc_sap04_tbl_1,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alv       TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      gt_table     TYPE TABLE OF zmc_sap04_tbl_1.

START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_181'.
  SET TITLEBAR 'TITILE_181'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'CREATE'.

      IF gv_id IS NOT INITIAL.
        gs_str-id      = gv_id.
        gs_str-name    = gv_name.
        gs_str-surname = gv_surname.
        gs_str-job     = gv_job.
        gs_str-salary  = gv_salary.
        gs_str-curr    = gv_curr.
        gs_str-gsm     = gv_gsm.
        gs_str-e_mail  = gv_e_mail.

        MODIFY zmc_sap04_tbl_1 FROM gs_str.

        IF sy-subrc IS INITIAL.
          MESSAGE 'Yeni kayit eklendi.' TYPE 'S'.
        ENDIF.
      ENDIF.

    WHEN 'READ'.

      IF gv_id IS NOT INITIAL.
        SELECT SINGLE *
          FROM zmc_sap04_tbl_1
          INTO gs_str
          WHERE id = gv_id.

        IF sy-subrc IS INITIAL.

*          gv_id      = gs_str-id.
          gv_name    = gs_str-name.
          gv_surname = gs_str-surname.
          gv_job     = gs_str-job.
          gv_salary  = gs_str-salary.
          gv_curr    = gs_str-curr.
          gv_gsm     = gs_str-gsm.
          gv_e_mail  = gs_str-e_mail.
        ENDIF.
      ENDIF.

    WHEN 'UPDATE'.

      DATA: lv_update.

      IF gv_id IS NOT INITIAL.
        SELECT SINGLE *
          FROM zmc_sap04_tbl_1
          INTO gs_str
          WHERE id = gv_id.

        IF sy-subrc IS INITIAL.

          IF gv_name IS NOT INITIAL.
            gs_str-name = gv_name.
            lv_update = abap_true.
          ENDIF.

          IF gv_surname IS NOT INITIAL.
            gs_str-surname = gv_surname.
            lv_update = abap_true.
          ENDIF.

          IF gv_job IS NOT INITIAL.
            gs_str-job = gv_job.
            lv_update = abap_true.
          ENDIF.

          IF gv_salary IS NOT INITIAL.
            gs_str-salary = gv_salary.
            lv_update = abap_true.
          ENDIF.

          IF gv_curr IS NOT INITIAL.
            gs_str-curr = gv_curr.
            lv_update = abap_true.
          ENDIF.

          IF gv_gsm IS NOT INITIAL.
            gs_str-gsm = gv_gsm.
            lv_update = abap_true.
          ENDIF.

          IF gv_e_mail IS NOT INITIAL.
            gs_str-e_mail = gv_e_mail.
            lv_update = abap_true.
          ENDIF.

          IF lv_update = abap_true.
            MODIFY zmc_sap04_tbl_1 FROM gs_str.

            IF sy-subrc IS INITIAL.
              MESSAGE 'Kayit güncellendi.' TYPE 'S'.

*              PERFORM alv_display.

              IF go_alv IS BOUND."IS NOT INITIAL

                go_alv->check_changed_data( ).

                go_alv->refresh_table_display(
                  EXCEPTIONS
                    finished       = 1
                  OTHERS         = 2 ).

                IF sy-subrc <> 0.
                  BREAK-POINT.
                ENDIF.
              ENDIF.

            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

    WHEN 'DELETE'.

      IF gv_id IS NOT INITIAL.
        DELETE FROM zmc_sap04_tbl_1 WHERE id = gv_id.

        IF sy-subrc IS INITIAL.
          MESSAGE 'Kayit silindi' TYPE 'S'.
        ENDIF.
      ENDIF.

    WHEN 'ALV'.

      PERFORM alv_display.

    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

FORM alv_display .
  SELECT * FROM zmc_sap04_tbl_1 INTO TABLE gt_table.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_TBL_1'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    MESSAGE 'Fieldcatalog olusturulamadi' TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  IF go_alv IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'C_ALV'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    go_alv->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.
  ENDIF.

ENDFORM.
