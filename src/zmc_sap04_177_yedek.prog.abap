*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_177
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_177_yedek.

*Alıştırma – 8: Besinci, altıncı ve yedinci alıştırmaları lokal Class tanımlayarak yapın.

CLASS lcl_alistirma_8 DEFINITION.

  PUBLIC SECTION.

    DATA: mt_scarr   TYPE zmc_tt_scarr,
          mt_spfli   TYPE zmc_tt_spfli,
          mt_sflight TYPE zmc_tt_sflight.

    METHODS: constructor IMPORTING iv_scarr   TYPE char1
                                   iv_spfli   TYPE char1
                                   iv_sflight TYPE char1.

    METHODS: alv_scarr.
    METHODS: alv_spfli.
    METHODS: alv_sflight.




ENDCLASS.

CLASS lcl_alistirma_8 IMPLEMENTATION.

  METHOD constructor.
    IF iv_scarr = abap_true.

      SELECT * FROM scarr
        INTO TABLE mt_scarr.

    ELSEIF iv_spfli = abap_true.

      SELECT * FROM spfli
        INTO TABLE mt_spfli.

    ELSEIF iv_sflight = abap_true.

      SELECT * FROM sflight
        INTO TABLE mt_sflight.

    ENDIF.
  ENDMETHOD.

  METHOD alv_scarr.
    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SCARR'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = mt_scarr
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.
  ENDMETHOD.

  METHOD alv_spfli.
    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SPFLI'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = mt_spfli
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.
  ENDMETHOD.

  METHOD alv_sflight.
    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SFLIGHT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = mt_sflight
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgh RADIOBUTTON GROUP abc.

DATA: go_object TYPE REF TO lcl_alistirma_8.

START-OF-SELECTION.

  CREATE OBJECT go_object
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflgh.

  IF p_scarr = abap_true.

    go_object->alv_scarr( ).

  ELSEIF p_spfli = abap_true.

    go_object->alv_spfli( ).

  ELSEIF p_sflgh = abap_true.

    go_object->alv_sflight( ).

  ENDIF.
