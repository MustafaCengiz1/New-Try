class ZMC_STRAVELAG_UPDATE_YEDEK definition
  public
  final
  create public .

public section.

  data GS_LOG_INFO type BAL_S_LOG .
  data GV_TIMESTAMP type TZNTSTMPS .
  data GV_TIMESTAMP_STR type STRING .
  data GV_LOG_HANDLE type BALLOGHNDL .
  data GS_LOG_MSG type BAL_S_MSG .

  methods CONSTRUCTOR .
  methods ILK_LOG
    importing
      !IV_AGNUM type S_AGNCYNUM
      !IV_NAME type STRING .
  methods IKINCI_LOG
    importing
      !IV_UNAME type SYST_UNAME .
  methods ID_KONTROL
    importing
      !IV_AGNUM type S_AGNCYNUM
    exceptions
      YANLIS_FIRMA_NO .
  methods ISIM_KONTROL
    importing
      !IV_NAME type STRING
    exceptions
      BOS_ISIM
      FAZLA_KARAKTER .
  methods GUNCELLE
    importing
      !IV_AGNUM type S_AGNCYNUM
      !IV_NAME type STRING
    exceptions
      GUNCELLEME_BASARISIZ .
  methods MESAJLARI_DATABASE_KAYDET .
protected section.

  methods EKLE .
private section.
ENDCLASS.



CLASS ZMC_STRAVELAG_UPDATE_YEDEK IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    "Log olusturma hazirlik kismi.
    CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP gv_timestamp TIME ZONE sy-zonlo.
    gv_timestamp_str = gv_timestamp.
    CONDENSE gv_timestamp_str.

    gs_log_info-object     = 'ZMC_SAP04'.
    gs_log_info-subobject  = 'ZMC_SUB_SAP04'.
    gs_log_info-extnumber  = gv_timestamp_str.
    gs_log_info-aldate_del = sy-datum + 14.

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = gs_log_info
      IMPORTING
        e_log_handle            = gv_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1
        OTHERS                  = 2.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.
  ENDMETHOD.


  METHOD EKLE.

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle     = gv_log_handle
        i_s_msg          = gs_log_msg
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        log_is_full      = 3
        OTHERS           = 4.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.


  method GUNCELLE.

  UPDATE zmc_stravelag SET name = iv_name
                       WHERE agencynum = iv_agnum.

  IF sy-subrc IS NOT INITIAL.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'E'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 009.

    ekle( ).

    RAISE guncelleme_basarisiz.
  ELSE.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 010.
    gs_log_msg-msgv1 = iv_agnum.

    ekle( ).
  ENDIF.

  endmethod.


  METHOD ID_KONTROL.

    DATA: ls_stravelag TYPE zmc_stravelag.

    SELECT SINGLE * FROM zmc_stravelag
      INTO ls_stravelag
      WHERE agencynum = iv_agnum.

  IF ls_stravelag IS INITIAL.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'E'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 005.

    ekle( ).

    RAISE yanlis_firma_no.
  ELSE.
    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 006.

    ekle( ).
  ENDIF.

  ENDMETHOD.


  METHOD IKINCI_LOG.

    CLEAR: gs_log_msg.
    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 004.
    gs_log_msg-msgv1 = iv_uname.

    ekle( ).

  ENDMETHOD.


  METHOD ILK_LOG.

    gs_log_msg-msgty = 'S'.
    gs_log_msg-msgid = 'ZMC_SAP04_1'.
    gs_log_msg-msgno = 003.
    gs_log_msg-msgv1 = iv_agnum.
    gs_log_msg-msgv2 = iv_name.

    ekle( ).

  ENDMETHOD.


  METHOD ISIM_KONTROL.

    IF iv_name IS INITIAL.
      CLEAR: gs_log_msg.
      gs_log_msg-msgty = 'E'.
      gs_log_msg-msgid = 'ZMC_SAP04_1'.
      gs_log_msg-msgno = 007.

      ekle( ).

      RAISE bos_isim.

    ELSE.
      IF strlen( iv_name ) > 25.
        CLEAR: gs_log_msg.
        gs_log_msg-msgty = 'E'.
        gs_log_msg-msgid = 'ZMC_SAP04_1'.
        gs_log_msg-msgno = 008.

        ekle( ).

        RAISE fazla_karakter.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD MESAJLARI_DATABASE_KAYDET.
    "Olusturulan log kaydini databse'e kaydetme.
    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_save_all       = abap_true
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
