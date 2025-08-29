*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_158
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_158_yedek.

*Alıştırma – 8: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alın. Alınan CARRID ile SCARR
*tablosunu okuyun ve oluşan internal tablonun ALV’sini gösterin. ALV’deki CARRID kolonu HOTSPOT
*olsun. Tıklandığında mevcut ALV’den çıkmadan SPFLI tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin. (Küçük pencere şeklinde.) Bu ALV’nin de CARRID kolonu HOTSPOT olsun.
*Tıklandığında mevcut ALV’den çıkmadan SFLIGHT tablosunda ayni CARRID verisine sahip satırların
*ALV’si gösterilsin.

*SCARR
*SPFLI
*SFLIGHT

DATA: gt_scarr            TYPE TABLE OF scarr,
      gt_fieldcat_scarr   TYPE lvc_t_fcat,
      gs_fieldcat_scarr   TYPE lvc_s_fcat,
      gs_layout_scarr     TYPE lvc_s_layo,
      gt_spfli            TYPE TABLE OF spfli,
      gs_spfli            TYPE spfli,
      gt_fieldcat_spfli   TYPE lvc_t_fcat,
      gs_fieldcat_spfli   TYPE lvc_s_fcat,
      gs_layout_spfli     TYPE lvc_s_layo,
      gt_sflight          TYPE TABLE OF sflight,
      gt_fieldcat_sflight TYPE lvc_t_fcat,
      gs_fieldcat_sflight TYPE lvc_s_fcat,
      gs_layout_sflight   TYPE lvc_s_layo.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat_scarr
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  READ TABLE gt_fieldcat_scarr INTO gs_fieldcat_scarr WITH KEY fieldname = 'CARRID'.

  IF sy-subrc IS INITIAL.
    gs_fieldcat_scarr-hotspot = abap_true.

    MODIFY gt_fieldcat_scarr FROM gs_fieldcat_scarr INDEX sy-tabix.
  ENDIF.

  gs_layout_scarr-zebra      = abap_true.
  gs_layout_scarr-cwidth_opt = abap_true.
  gs_layout_scarr-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program      = sy-repid
      is_layout_lvc           = gs_layout_scarr
      it_fieldcat_lvc         = gt_fieldcat_scarr
      i_callback_user_command = 'UC_158'
    TABLES
      t_outtab                = gt_scarr
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

FORM uc_158 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.

      IF ls_selfield-fieldname = 'CARRID'.

        SELECT * FROM spfli
          INTO TABLE gt_spfli
          WHERE carrid = ls_selfield-value.

        CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'SPFLI'
            i_bypassing_buffer     = abap_true
          CHANGING
            ct_fieldcat            = gt_fieldcat_spfli
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.

        IF sy-subrc IS NOT INITIAL.
          BREAK-POINT.
        ENDIF.

        READ TABLE gt_fieldcat_spfli INTO gs_fieldcat_spfli WITH KEY fieldname = 'CARRID'.

        IF sy-subrc IS INITIAL.
          gs_fieldcat_spfli-hotspot = abap_true.

          MODIFY gt_fieldcat_spfli FROM gs_fieldcat_spfli INDEX sy-tabix.
        ENDIF.

        gs_layout_spfli-zebra      = abap_true.
        gs_layout_spfli-cwidth_opt = abap_true.
        gs_layout_spfli-sel_mode   = 'A'.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program      = sy-repid
            is_layout_lvc           = gs_layout_spfli
            it_fieldcat_lvc         = gt_fieldcat_spfli
            i_callback_user_command = 'UC_158_SPFLI'
          TABLES
            t_outtab                = gt_spfli
          EXCEPTIONS
            program_error           = 1
            OTHERS                  = 2.

        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.
      ENDIF.

*  	WHEN .
    WHEN OTHERS.
  ENDCASE.

ENDFORM.

FORM uc_158_spfli USING lv_ucomm    TYPE sy-ucomm
                        ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.

      IF ls_selfield-fieldname = 'CARRID'.

        READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
        IF sy-subrc = 0.
          SELECT * FROM sflight
            INTO TABLE gt_sflight
            WHERE carrid = gs_spfli-carrid
            AND   connid = gs_spfli-connid.
        ENDIF.

        CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'SFLIGHT'
            i_bypassing_buffer     = abap_true
          CHANGING
            ct_fieldcat            = gt_fieldcat_sflight
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.

        IF sy-subrc IS NOT INITIAL.
          BREAK-POINT.
        ENDIF.

        gs_layout_sflight-zebra      = abap_true.
        gs_layout_sflight-cwidth_opt = abap_true.
        gs_layout_sflight-sel_mode   = 'A'.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
          EXPORTING
            i_callback_program = sy-repid
            is_layout_lvc      = gs_layout_sflight
            it_fieldcat_lvc    = gt_fieldcat_sflight
*           i_callback_user_command = 'UC_158_SPFLI'
          TABLES
            t_outtab           = gt_sflight
          EXCEPTIONS
            program_error      = 1
            OTHERS             = 2.

        IF sy-subrc <> 0.
          BREAK-POINT.
        ENDIF.
      ENDIF.

  ENDCASE.

ENDFORM.
