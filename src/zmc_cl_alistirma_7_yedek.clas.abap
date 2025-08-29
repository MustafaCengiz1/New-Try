class ZMC_CL_ALISTIRMA_7_YEDEK definition
  public
  final
  create public .

public section.

  data MT_SCARR type ZMC_TT_SCARR .
  data MT_SPFLI type ZMC_TT_SPFLI .
  data MT_SFLIGHT type ZMC_TT_SFLIGHT .

  methods CONSTRUCTOR
    importing
      !IV_SCARR type CHAR1
      !IV_SPFLI type CHAR1
      !IV_SFLIGHT type CHAR1 .
  methods ALV_SCARR .
  methods ALV_SPFLI .
  methods ALV_SFLIGHT .
protected section.
private section.
ENDCLASS.



CLASS ZMC_CL_ALISTIRMA_7_YEDEK IMPLEMENTATION.


  METHOD ALV_SCARR.

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


  METHOD ALV_SFLIGHT.

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


  METHOD ALV_SPFLI.

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


  METHOD CONSTRUCTOR.

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
ENDCLASS.
