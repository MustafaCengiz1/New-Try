*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_156
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_156_yedek.

*Alıştırma – 6: İlk alıştırmada oluşturduğunuz db tablosuna “ESKI_URL” isminde yeni bir kolon ekleyin.
*Yine STRAVELAG database tablosunu kullanarak ALV’yi ekranda gösterin. Beşinci alıştırmada
*oluşturulan buton yardımıyla URL hücresi güncellendiğinde, eski URL verisini db tablosunun
*“ESKI_URL” hücresine kaydedin ve ALV’yi yeniden oluşturun.

DATA: gs_str TYPE zmc_sap04_strav.

DATA: gt_table    TYPE TABLE OF zmc_sap04_strav,
      gs_table    TYPE zmc_sap04_strav,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_layout   TYPE lvc_s_layo,
      gv_url      TYPE s_url,
      gv_answer.

SELECT-OPTIONS: so_agnum FOR gs_str-agencynum.


START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO TABLE gt_table
    WHERE agencynum IN so_agnum.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_STRAV'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  READ TABLE gt_fieldcat INTO gs_fieldcat WITH KEY fieldname = 'URL'.
  IF sy-subrc IS INITIAL.
    gs_fieldcat-hotspot = abap_true.

    MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
  ENDIF.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program      = sy-repid
      is_layout_lvc           = gs_layout
      it_fieldcat_lvc         = gt_fieldcat
*     i_callback_pf_status_set = 'PF_156'
      i_callback_user_command = 'UC_156'
    TABLES
      t_outtab                = gt_table
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

*FORM pf_156 USING lt_extab TYPE slis_t_extab.
*  SET PF-STATUS 'PF_STATUS_156'.
*ENDFORM.

FORM uc_156 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.

    WHEN '&IC1'.

      IF ls_selfield-fieldname = 'URL'.

        READ TABLE gt_table INTO gs_table INDEX ls_selfield-tabindex.

        IF sy-subrc IS INITIAL.
          CALL FUNCTION 'ZMC_FM_SAP04_14'
            EXPORTING
              is_stravelag = gs_table
            IMPORTING
              ev_answer    = gv_answer.
        ENDIF.

        IF gv_answer = 0.

          SELECT * FROM zmc_sap04_strav
            INTO TABLE gt_table.

          ls_selfield-refresh = abap_true.

        ENDIF.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.

ENDFORM.
