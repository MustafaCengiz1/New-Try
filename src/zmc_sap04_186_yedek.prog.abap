*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_186
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_186_yedek.

*Alıştırma – 5: SFLIGHT tablosu için Container ALV hazırlayın. Kullanıcının kolon ismi girebileceği 1 hücre
*(input field) oluşturun. 3 adet buton (3 ayri renk isminde) oluşturun. Kullanıcı herhangi bir kolon ismi
*girip butonlardan birine bastığında o kolon renklendirilsin.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      gt_sflight   TYPE TABLE OF sflight,
      gv_field     TYPE string.

START-OF-SELECTION.

  CALL SCREEN 0300.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'STATUS_300'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'RED'.
      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.
    WHEN 'BLUE'.
      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C111'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C111'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C111'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.
    WHEN 'GREEN'.
      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.
      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname = gs_fcat-fieldname.
      ENDIF.
*	WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv .

  SELECT * FROM sflight INTO TABLE gt_sflight.

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

  IF go_alvgrid IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CONT_SFLIGHT'
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

    go_alvgrid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.
