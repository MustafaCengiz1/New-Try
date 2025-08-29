class ZMC_CL_SAP04_NEW_ENTRY_YEDEK definition
  public
  final
  create public .

public section.

  methods NEW_ENTRY
    importing
      !IV_AGENCYNUM type S_AGNCYNUM
      !IV_NAME type S_AGNCYNAM
      !IV_STREET type S_STREET
      !IV_POSTBOX type S_POSTBOX
      !IV_POSTCODE type POSTCODE
      !IV_CITY type CITY
      !IV_COUNTRY type S_COUNTRY
      !IV_REGION type S_REGION
      !IV_TELEPHONE type S_PHONENO
      !IV_LANGU type SPRAS
      !IV_CURRENCY type S_CURR_AG .
  methods PREP_FCAT
    exporting
      !ET_FCAT type SLIS_T_FIELDCAT_ALV .
  methods PREP_LAYOUT
    importing
      !IV_ZEBRA type CHAR1
      !IV_COLWIDTH_OPTIMIZE type CHAR1
    exporting
      !ES_LAYOUT type SLIS_LAYOUT_ALV .
  methods PREP_DATA
    exporting
      !ET_STRAVELAG type ZMC_TT_STRAVELAG_2 .
  methods DISPLAY_DATA
    importing
      !IS_LAYOUT type SLIS_LAYOUT_ALV
      !IT_FCAT type SLIS_T_FIELDCAT_ALV
      value(IT_STRAVELAG) type ZMC_TT_STRAVELAG_2 .
protected section.

  methods MAKE_URL
    importing
      !IV_NAME type S_AGNCYNAM
    returning
      value(RV_URL) type S_URL .
private section.
ENDCLASS.



CLASS ZMC_CL_SAP04_NEW_ENTRY_YEDEK IMPLEMENTATION.


  METHOD DISPLAY_DATA.

*    DATA: lt_stravelag TYPE zmc_tt_stravelag_2.
*
*    lt_stravelag = it_stravelag.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = is_layout
        it_fieldcat        = it_fcat
      TABLES
        t_outtab           = it_stravelag
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.


  method MAKE_URL.

    DATA: lv_name TYPE s_agncynam.

    lv_name = iv_name.

    CONDENSE lv_name NO-GAPS.

    CONCATENATE 'www.' lv_name '.com' INTO rv_url.

    TRANSLATE rv_url TO LOWER CASE.

  endmethod.


  METHOD NEW_ENTRY.

    DATA: ls_stravelag TYPE zmc_sap04_strav.

    ls_stravelag-agencynum = iv_agencynum.
    ls_stravelag-name      = iv_name.
    ls_stravelag-street    = iv_street.
    ls_stravelag-postbox   = iv_postbox.
    ls_stravelag-postcode  = iv_postcode.
    ls_stravelag-city      = iv_city.
    ls_stravelag-country   = iv_country.
    ls_stravelag-region    = iv_region.
    ls_stravelag-telephone = iv_telephone.
    ls_stravelag-langu     = iv_langu.
    ls_stravelag-currency  = iv_currency.

*    CONDENSE ls_stravelag-name NO-GAPS.
*
*    CONCATENATE 'wwww.' ls_stravelag-name '.com' INTO ls_stravelag-url.
*
*    TRANSLATE ls_stravelag-url TO LOWER CASE.

*     make_url( EXPORTING iv_name = ls_stravelag-name
*               RECEIVING rv_url  = ls_stravelag-url ).

    ls_stravelag-url = make_url( iv_name = ls_stravelag-name ).

    MODIFY zmc_sap04_strav FROM ls_stravelag.

  ENDMETHOD.


  METHOD PREP_DATA.

    SELECT * FROM zmc_sap04_strav
      INTO CORRESPONDING FIELDS OF TABLE et_stravelag.

  ENDMETHOD.


  METHOD PREP_FCAT.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZMC_SAP04_STRAV'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = et_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.


  METHOD PREP_LAYOUT.

    es_layout-zebra             = iv_zebra.
    es_layout-colwidth_optimize = iv_colwidth_optimize.
    es_layout-box_fieldname     = 'BOX'.

  ENDMETHOD.
ENDCLASS.
