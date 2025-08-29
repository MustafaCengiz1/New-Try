*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_191
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_191_yedek.

*Alıştırma – 10: Kendinize ait olan ve SCARR ile ayni satir yapısına sahip olan database tablosunun (Ör:
*ZCM_SCARR) bütün hücrelerinin gösterildiği bir Dialog Screen hazırlayın. Tablo üzerinde CRUD
*işlemlerinin yapılabilmesi için 4 adet yeni buton tanımlayın. Yapılan değişiklikleri görebilmek ekranın
*hemen sağ tarafında ayni tablonun ALV’sini gösterin.

DATA: gv_carrid    TYPE s_carr_id,
      gv_carrname  TYPE s_carrname,
      gv_curr      TYPE s_currcode,
      gv_url       TYPE s_carrurl,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alvgrid   TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,
      gt_scarr     TYPE TABLE OF zmc_scarr_sap04,
      gs_scarr     TYPE zmc_scarr_sap04.

START-OF-SELECTION.

  CALL SCREEN 0300.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'STATUS_191'.
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
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'CREATE'.

      IF gv_carrid IS NOT INITIAL.

        gs_scarr-carrid   = gv_carrid.
        gs_scarr-carrname = gv_carrname.
        gs_scarr-currcode = gv_curr.
        gs_scarr-url      = gv_url.

        MODIFY zmc_scarr_sap04 FROM gs_scarr.
        CLEAR: gs_scarr.

      ENDIF.

    WHEN 'READ'.

      IF gv_carrid IS NOT INITIAL.

        READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gv_carrid.
        IF sy-subrc IS INITIAL.

          gv_carrid   = gs_scarr-carrid.
          gv_carrname = gs_scarr-carrname.
          gv_curr     = gs_scarr-currcode.
          gv_url      = gs_scarr-url.

        ENDIF.
      ENDIF.

    WHEN 'UPDATE'.

      IF gv_carrid IS NOT INITIAL.

        READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gv_carrid.
        IF sy-subrc IS INITIAL.

          gs_scarr-carrid = gv_carrid.

          IF gv_carrname IS NOT INITIAL.
            gs_scarr-carrname = gv_carrname.
          ENDIF.

          IF gv_curr IS NOT INITIAL.
            gs_scarr-currcode = gv_curr.
          ENDIF.

          IF gv_url IS NOT INITIAL.
            gs_scarr-url = gv_url.
          ENDIF.

          MODIFY zmc_scarr_sap04 FROM gs_scarr.
          CLEAR: gs_scarr.

        ENDIF.
      ENDIF.

    WHEN 'DELETE'.

      IF gv_carrid IS NOT INITIAL.
        DELETE FROM zmc_scarr_sap04 WHERE carrid = gv_carrid.
      ENDIF.

    WHEN OTHERS.
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

  SELECT * FROM zmc_scarr_sap04 INTO TABLE gt_scarr.

  IF gt_fcat IS INITIAL.

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
  ENDIF.

  IF gs_layout IS INITIAL.
    gs_layout-zebra      = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-sel_mode   = 'A'.
  ENDIF.

  IF go_alvgrid IS INITIAL.

    CREATE OBJECT go_container
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
