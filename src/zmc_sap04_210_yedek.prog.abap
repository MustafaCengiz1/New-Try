*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_210
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_210_yedek.

PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
            p_name  TYPE string LOWER CASE.

DATA: gs_log_info      TYPE bal_s_log,
      gv_timestamp     TYPE tzntstmps,
      gv_timestamp_str TYPE string,
      gv_log_handle    TYPE balloghndl,
      gs_log_msg       TYPE bal_s_msg.


DATA: gs_stravelag        TYPE zmc_stravelag,
      go_stravelag_update TYPE REF TO zmc_stravelag_update.

START-OF-SELECTION.

  CREATE OBJECT go_stravelag_update.

  go_stravelag_update->ilk_log(
    EXPORTING
      iv_agnum = p_agnum
      iv_name  = p_name ).

  go_stravelag_update->ikinci_log(
    EXPORTING
      iv_uname = sy-uname ).

  go_stravelag_update->id_kontrol(
    EXPORTING
      iv_agnum        = p_agnum
    EXCEPTIONS
      yanlis_firma_no = 1
      OTHERS          = 2 ).

  IF sy-subrc IS NOT INITIAL.
    go_stravelag_update->mesajlari_database_kaydet( ).
    LEAVE PROGRAM.
  ENDIF.

  go_stravelag_update->isim_kontrol(
    EXPORTING
      iv_name        = p_name
    EXCEPTIONS
      bos_isim       = 1
      fazla_karakter = 2
      OTHERS         = 3 ).

  IF sy-subrc IS NOT INITIAL.
    go_stravelag_update->mesajlari_database_kaydet( ).
    LEAVE PROGRAM.
  ENDIF.

  go_stravelag_update->guncelle(
    EXPORTING
      iv_agnum             = p_agnum
      iv_name              = p_name
    EXCEPTIONS
      guncelleme_basarisiz = 1
      OTHERS               = 2 ).

  go_stravelag_update->mesajlari_database_kaydet( ).

  IF sy-subrc IS INITIAL.
    MESSAGE s010(zmc_sap04_1) WITH p_agnum.
  ENDIF.

  "Log olusturma hazirlik kismi.
*  CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP gv_timestamp TIME ZONE sy-zonlo.
*  gv_timestamp_str = gv_timestamp.
*  CONDENSE gv_timestamp_str.
*
*  gs_log_info-object     = 'ZMC_SAP04'.
*  gs_log_info-subobject  = 'ZMC_SUB_SAP04'.
*  gs_log_info-extnumber  = gv_timestamp_str.
*  gs_log_info-aldate_del = sy-datum + 14.
*
*  CALL FUNCTION 'BAL_LOG_CREATE'
*    EXPORTING
*      i_s_log                 = gs_log_info
*    IMPORTING
*      e_log_handle            = gv_log_handle
*    EXCEPTIONS
*      log_header_inconsistent = 1
*      OTHERS                  = 2.
*
*  IF sy-subrc IS NOT INITIAL.
*    BREAK-POINT.
*  ENDIF.


  "Ilk log kaydi.
*  gs_log_msg-msgty = 'S'.
*  gs_log_msg-msgid = 'ZMC_SAP04_1'.
*  gs_log_msg-msgno = 003.
*  gs_log_msg-msgv1 = p_agnum.
*  gs_log_msg-msgv2 = p_name.
*
*  PERFORM add.
*
*  "Ikinci log kaydi.
*  CLEAR: gs_log_msg.
*  gs_log_msg-msgty = 'S'.
*  gs_log_msg-msgid = 'ZMC_SAP04_1'.
*  gs_log_msg-msgno = 004.
*  gs_log_msg-msgv1 = sy-uname.
*
*  PERFORM add.
*
*  PERFORM check_id.
*  PERFORM check_name.
*  PERFORM update.
*
*
*
**&---------------------------------------------------------------------*
**&      Form  CHECK_ID
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM check_id .
*
*  SELECT SINGLE * FROM zmc_stravelag
*    INTO gs_stravelag
*    WHERE agencynum = p_agnum.
*
*  IF gs_stravelag IS INITIAL.
*    CLEAR: gs_log_msg.
*    gs_log_msg-msgty = 'E'.
*    gs_log_msg-msgid = 'ZMC_SAP04_1'.
*    gs_log_msg-msgno = 005.
*
*    PERFORM add.
*    PERFORM save.
*
*    LEAVE PROGRAM.
*  ELSE.
*    CLEAR: gs_log_msg.
*    gs_log_msg-msgty = 'S'.
*    gs_log_msg-msgid = 'ZMC_SAP04_1'.
*    gs_log_msg-msgno = 006.
*
*    PERFORM add.
*  ENDIF.
*
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  CHECK_NAME
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM check_name .
*
*  IF p_name IS INITIAL.
*    CLEAR: gs_log_msg.
*    gs_log_msg-msgty = 'E'.
*    gs_log_msg-msgid = 'ZMC_SAP04_1'.
*    gs_log_msg-msgno = 007.
*
*    PERFORM add.
*    PERFORM save.
*
*    LEAVE PROGRAM.
*  ELSE.
*    IF strlen( p_name ) > 25.
*      CLEAR: gs_log_msg.
*      gs_log_msg-msgty = 'E'.
*      gs_log_msg-msgid = 'ZMC_SAP04_1'.
*      gs_log_msg-msgno = 008.
*
*      PERFORM add.
*      PERFORM save.
*
*      LEAVE PROGRAM.
*    ENDIF.
*  ENDIF.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  UPDATE
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM update.
*  UPDATE zmc_stravelag SET name = p_name
*                       WHERE agencynum = p_agnum.
*
*  IF sy-subrc IS NOT INITIAL.
*    CLEAR: gs_log_msg.
*    gs_log_msg-msgty = 'E'.
*    gs_log_msg-msgid = 'ZMC_SAP04_1'.
*    gs_log_msg-msgno = 009.
*
*    PERFORM add.
*    PERFORM save.
*
*    LEAVE PROGRAM.
*  ELSE.
*    CLEAR: gs_log_msg.
*    gs_log_msg-msgty = 'S'.
*    gs_log_msg-msgid = 'ZMC_SAP04_1'.
*    gs_log_msg-msgno = 010.
*    gs_log_msg-msgv1 = p_agnum.
*
*    PERFORM add.
*    PERFORM save.
*
*    MESSAGE s010(zmc_sap04_1) WITH p_agnum.
*  ENDIF.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  ADD
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM add .
*  CALL FUNCTION 'BAL_LOG_MSG_ADD'
*    EXPORTING
*      i_log_handle     = gv_log_handle
*      i_s_msg          = gs_log_msg
*    EXCEPTIONS
*      log_not_found    = 1
*      msg_inconsistent = 2
*      log_is_full      = 3
*      OTHERS           = 4.
*
*  IF sy-subrc IS NOT INITIAL.
*    BREAK-POINT.
*  ENDIF.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  SAVE
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM save .
*  "Olusturulan log kaydini databse'e kaydetme.
*  CALL FUNCTION 'BAL_DB_SAVE'
*    EXPORTING
*      i_save_all       = abap_true
*    EXCEPTIONS
*      log_not_found    = 1
*      save_not_allowed = 2
*      numbering_error  = 3
*      OTHERS           = 4.
*
*  IF sy-subrc IS NOT INITIAL.
*    BREAK-POINT.
*  ENDIF.
*ENDFORM.
