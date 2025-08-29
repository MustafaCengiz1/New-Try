*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_252
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_252_yedek.

*Alıştırma – 4: Bir önceki alıştırmada manuel olarak hazırlanmış internal tablo için manuel olarak field
*Catalog oluşturun ve Container ALV hazırlayın. Field Catalog tablosunu hazırlarken inline declaration
*ile tanımlanmış field sembol kullanın.


TYPES: BEGIN OF gty_str,
         proje_id        TYPE n LENGTH 4,
         proje_ad        TYPE c LENGTH 20,
         proje_sorumlusu TYPE c LENGTH 20,
         proje_plan_gun  TYPE n LENGTH 3,
         proje_departman TYPE c LENGTH 20,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid.

START-OF-SELECTION.

  CALL SCREEN 0200.


*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'SAP04_200'.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).
  <gs_str>-proje_id        = 1000.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 5.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1001.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 10.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1002.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 15.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1003.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 20.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1004.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 25.
  <gs_str>-proje_departman = 'Departman A'.

  DATA(gt_fcat) = VALUE lvc_t_fcat( ( fieldname = 'PROJE_ID'        scrtext_m = 'Proje ID' )
                                    ( fieldname = 'PROJE_AD'        scrtext_m = 'Proje Ad' )
                                    ( fieldname = 'PROJE_SORUMLUSU' scrtext_m = 'Proje Sorumlusu' )
                                    ( fieldname = 'PROJE_PLAN_GUN'  scrtext_m = 'Proje Plan Gün' )
                                    ( fieldname = 'PROJE_DEPARTMAN' scrtext_m = 'Proje Departman' ) ).

  DATA(gs_layout) = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).

  IF go_alvgrid IS INITIAL.

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
        it_outtab                     = gt_table
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

    go_alvgrid->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
*	WHEN .
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.
