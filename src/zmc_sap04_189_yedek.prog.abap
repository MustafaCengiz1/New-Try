*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_189
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_189_yedek.

*Alıştırma – 8: SFLIGHT tablosu için Container ALV hazırlayın. 2 adet buton tanımlayın. İlk butona
*basıldığında “PRICE” kolonu, ikinci butona basıldığında “SEATSMAX” kolonu için trafik ışıkları
*oluşturun.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: trf TYPE icon_d.
TYPES: END OF gty_str.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gt_sflight   TYPE TABLE OF gty_str,
      gs_sflight   TYPE gty_str,
      gs_layout    TYPE lvc_s_layo.

START-OF-SELECTION.

  CALL SCREEN 0200.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '189'.
*  SET TITLEBAR 'xxx'.
  PERFORM alv.
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
    WHEN 'PRICE'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-price <= 550.

          gs_sflight-trf = '@08@'.

        ELSEIF gs_sflight-price > 550 AND gs_sflight-price <= 700.

          gs_sflight-trf = '@09@'.

        ELSEIF gs_sflight-price > 700.

          gs_sflight-trf = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.

      IF sy-subrc IS INITIAL.
        gs_fcat-col_pos = 5.
        gs_fcat-scrtext_m = 'Price Tr Isiklari'.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.
      ELSE.
        gs_fcat-fieldname = 'TRF'.
        gs_fcat-col_pos   = 5.
        gs_fcat-scrtext_m = 'Price Tr Isiklari'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.
      ENDIF.

    WHEN 'MAX'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-seatsmax <= 250.

          gs_sflight-trf = '@08@'.

        ELSEIF gs_sflight-seatsmax > 250 AND gs_sflight-seatsmax <= 350.

          gs_sflight-trf = '@09@'.

        ELSEIF gs_sflight-seatsmax > 350.

          gs_sflight-trf = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.
      IF sy-subrc IS INITIAL.
        gs_fcat-col_pos = 8.
        gs_fcat-scrtext_m = 'Seatsmax Tr Isiklari'.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.
*        MODIFY gt_fcat FROM gs_fcat TRANSPORTING col_pos scrtext_m WHERE fieldname = 'TRF'.
      ELSE.
        gs_fcat-fieldname = 'TRF'.
        gs_fcat-col_pos   = 8.
        gs_fcat-scrtext_m = 'Seatsmax Tr Isiklari'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.
      ENDIF.

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

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE gt_sflight.
  ENDIF.

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
  ENDIF.

  IF gs_layout IS INITIAL.
    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = 'A'.
  ENDIF.

  IF go_alvgrid IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'CC_SFLIGHT'
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
