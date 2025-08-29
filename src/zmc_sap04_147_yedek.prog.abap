*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_147
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_147_yedek.

DATA: gt_fieldcat     TYPE slis_t_fieldcat_alv,
      gs_fieldcat     TYPE slis_fieldcat_alv,
      gt_fieldcat_sel TYPE slis_t_fieldcat_alv,
      gs_fieldcat_sel TYPE slis_fieldcat_alv,
      gs_layout       TYPE slis_layout_alv,
      gv_answer, "TYPE cLENGTH 1.
      gv_answer_dist,
      gv_seconds      TYPE i,
      gv_distance     TYPE s_distance.

TYPES: BEGIN OF gty_str,
         box.
    INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli               TYPE TABLE OF gty_str,
      gt_spfli_selected_line TYPE TABLE OF gty_str,
      gs_spfli               TYPE gty_str,
      gt_spfli_org           TYPE TABLE OF spfli,
      gs_spfli_org           TYPE spfli.


START-OF-SELECTION.

  "1. Asama: Databaseden veri cek.
  PERFORM select_data.

  "2. Asama: Field Catalog Internal Tablosunu olustur.
  PERFORM fieldcat.

  "3. Asama: Layout hazirla.
  PERFORM layout.

  "4. Asama: ALV'yi ekranda göster.
  PERFORM display_data.


FORM pf_147 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_147'.
ENDFORM.

FORM uc_147 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.
  CASE lv_ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'SORT'.
      SORT gt_spfli BY cityfrom.

      PERFORM display_data.

    WHEN '&IC1'.

      READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.

        IF ls_selfield-fieldname NE 'DISTANCE'.

          CLEAR: gt_spfli_selected_line.
          APPEND gs_spfli TO gt_spfli_selected_line.

          gt_fieldcat_sel = gt_fieldcat.

          LOOP AT gt_fieldcat_sel INTO gs_fieldcat_sel WHERE fieldname = 'FLTIME'.
            gs_fieldcat_sel-edit = abap_true.
            gs_fieldcat_sel-input = abap_true.

            MODIFY gt_fieldcat_sel FROM gs_fieldcat_sel INDEX sy-tabix.
          ENDLOOP.

          CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
            EXPORTING
              i_title               = 'FLTIME hücresini güncelleyebilirsiniz'
              i_screen_start_column = 5
              i_screen_start_line   = 5
              i_screen_end_column   = 165
              i_screen_end_line     = 8
              i_tabname             = 'GT_SPFLI_SELECTED_LINE'
*             I_STRUCTURE_NAME      =
              it_fieldcat           = gt_fieldcat_sel
              i_callback_program    = sy-repid
            IMPORTING
              e_exit                = gv_answer
            TABLES
              t_outtab              = gt_spfli_selected_line
            EXCEPTIONS
              program_error         = 1
              OTHERS                = 2.

          IF sy-subrc IS NOT INITIAL.
            BREAK-POINT.
          ENDIF.

          "Kullanici eger YESIL OK tusuna bastiysa.
          IF gv_answer IS INITIAL.

            MOVE-CORRESPONDING gt_spfli_selected_line TO gt_spfli_org.

            READ TABLE gt_spfli_org INTO gs_spfli_org INDEX 1.

            IF sy-subrc IS INITIAL.
              gv_seconds = gs_spfli_org-fltime * 60.

              gs_spfli_org-arrtime = gs_spfli_org-deptime + gv_seconds.

              MODIFY gt_spfli_org FROM gs_spfli_org TRANSPORTING arrtime WHERE carrid = gs_spfli_org-carrid AND connid = gs_spfli_org-connid.
            ENDIF.

            MODIFY spfli FROM TABLE gt_spfli_org.

            CLEAR: gt_spfli.

            PERFORM select_data.

            PERFORM display_data.
          ENDIF.

        ELSE. "Yani tiklana kolon DISTANCE kolonu ise

          CLEAR: gv_distance.

          CALL FUNCTION 'ZMC_FM_SAP04_12'
            IMPORTING
              ev_distance = gv_distance
              ev_answer   = gv_answer_dist.

          IF gv_answer_dist = 0.

            READ TABLE gt_spfli INTO gs_spfli INDEX ls_selfield-tabindex.
            IF sy-subrc IS INITIAL.

              MOVE-CORRESPONDING gs_spfli to gs_spfli_org.

              gs_spfli_org-distance = gv_distance.

*              MODIFY gt_spfli FROM gs_spfli TRANSPORTING distance WHERE carrid = gs_spfli-carrid AND connid = gs_spfli-connid.

              MODIFY spfli FROM  gs_spfli_org.

              PERFORM select_data.
              PERFORM display_data.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data .
  SELECT * FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fieldcat .
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

  LOOP AT gt_fieldcat INTO gs_fieldcat WHERE fieldname = 'DISTANCE'.
    gs_fieldcat-hotspot = abap_true.

    MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM layout .
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_data .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
      i_callback_pf_status_set = 'PF_147'
      i_callback_user_command  = 'UC_147'
    TABLES
      t_outtab                 = gt_spfli
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
ENDFORM.
