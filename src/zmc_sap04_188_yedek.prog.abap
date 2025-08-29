*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_188
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_188_yedek.

*Alıştırma – 7: SPFLI ve SFLIGHT tablolarının Alev’leri yan yana olacak şekilde bir Container ALV
*oluşturun. İki ALV’nin ortasında 1 adet hücre (CARRID tipinde veri girilebilen input field) olsun.
*Hücrenin hemen altında bir buton olsun. Kullanıcı herhangi bir CARRID girip alttaki butona basarsa her
*iki ALV’de de sadece bu CARRID’ye karşılık gelen satırlar kalsın. Diğer satırlar silinsin. Butonuna altına
*yeni bir buton oluşturun. Bu butona basıldığında ALV’ler önceki hallerine geri dönsün.

DATA: go_cont_1       TYPE REF TO cl_gui_custom_container,
      go_grid_1       TYPE REF TO cl_gui_alv_grid,
      go_cont_2       TYPE REF TO cl_gui_custom_container,
      go_grid_2       TYPE REF TO cl_gui_alv_grid,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_layout       TYPE lvc_s_layo,
      gv_carrid       TYPE s_carr_id,
      gt_spfli        TYPE TABLE OF spfli,
      gt_sflight      TYPE TABLE OF sflight.

START-OF-SELECTION.

  CALL SCREEN 0500.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0500  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0500 OUTPUT.
  SET PF-STATUS 'PF_STATUS_188'.
*  SET TITLEBAR 'xxx'.

  PERFORM spfli_alv.
  PERFORM sflight_alv.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0500  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0500 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'FILTER'.

      DELETE gt_spfli WHERE carrid = gv_carrid.
      DELETE gt_sflight WHERE carrid = gv_carrid.

    WHEN 'RESET'.

      CLEAR: gt_spfli, gt_sflight.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  SPFLI_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM spfli_alv .

  IF gt_spfli IS INITIAL.
    SELECT * FROM spfli INTO TABLE gt_spfli.
  ENDIF.

  IF gt_fcat_spfli IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SPFLI'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat_spfli
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.
  ENDIF.

  IF gs_layout IS INITIAL.
    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = 'A'.
  ENDIF.

  IF go_grid_1 IS INITIAL.

    CREATE OBJECT go_cont_1
      EXPORTING
        container_name              = 'CONT_1'
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
        it_outtab                     = gt_spfli
        it_fieldcatalog               = gt_fcat_spfli
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
*&      Form  SFLIGHT_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM sflight_alv .

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE gt_sflight.
  ENDIF.

  IF gt_fcat_sflight IS INITIAL.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SFLIGHT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = gt_fcat_sflight
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.
  ENDIF.

  IF gs_layout IS INITIAL.
    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = 'A'.
  ENDIF.

  IF go_grid_2 IS INITIAL.

    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'CONT_2'
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
        it_outtab                     = gt_sflight
        it_fieldcatalog               = gt_fcat_sflight
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
