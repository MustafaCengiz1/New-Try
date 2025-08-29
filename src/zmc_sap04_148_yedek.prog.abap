*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_148
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_148_yedek.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

TYPES: BEGIN OF gty_str,
         box.
    INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli  TYPE TABLE OF gty_str,
      gs_spfli  TYPE gty_str,
      gv_answer.


START-OF-SELECTION.

  "1. Asama: Databaseden veri cek.
  SELECT * FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli.

  "2. Asama: Field Catalog Internal Tablosunu olustur.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "3. Asama: Layout hazirla.
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.

  "4. Asama: ALV'yi ekranda göster.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
      i_callback_pf_status_set = 'PF_STATUS_148'
      i_callback_user_command  = 'UC_148'
    TABLES
      t_outtab                 = gt_spfli
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

FORM pf_status_148 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_148'.
ENDFORM.

FORM uc_148 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'REMOVE'.

      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question  = 'Secilen satir database tablosundan da silinsin mi?'
        IMPORTING
          answer         = gv_answer
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.

      IF sy-subrc IS NOT INITIAL.
        BREAK-POINT.
      ENDIF.

      IF gv_answer = 1.
        READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.

        DELETE FROM spfli WHERE carrid = gs_spfli-carrid AND connid = gs_spfli-connid.
      ENDIF.

      DELETE gt_spfli INDEX ls_selfield-tabindex.

      "4. Asama: ALV'yi ekranda göster.
      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program       = sy-repid
          is_layout                = gs_layout
          it_fieldcat              = gt_fieldcat
          i_callback_pf_status_set = 'PF_STATUS_148'
          i_callback_user_command  = 'UC_148'
        TABLES
          t_outtab                 = gt_spfli
        EXCEPTIONS
          program_error            = 1
          OTHERS                   = 2.

      IF sy-subrc IS NOT INITIAL.
        BREAK-POINT.
      ENDIF.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
*  	WHEN OTHERS.
  ENDCASE.

ENDFORM.
