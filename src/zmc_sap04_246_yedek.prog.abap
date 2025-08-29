*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_246
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_246_yedek.

PARAMETERS: p_id    TYPE zmc_de_empid,
            p_name  TYPE zmc_de_name,
            p_sname TYPE zmc_de_sname,
            p_hldy  TYPE zmc_de_hld.

PARAMETERS: p_create RADIOBUTTON GROUP wsd,
            p_delete RADIOBUTTON GROUP wsd,
            p_update RADIOBUTTON GROUP wsd.

DATA: gv_process,
      gt_sap04_emp_yeni TYPE TABLE OF zzmc_sap04_emp,
      gt_sap04_emp_eski TYPE TABLE OF zzmc_sap04_emp,
      gt_cdpos          TYPE cdpos_tab,
      gt_test           TYPE TABLE OF cdtxt.

START-OF-SELECTION.

  IF p_id IS INITIAL.
    MESSAGE 'ID alani bos olamaz' TYPE 'S' DISPLAY LIKE'E'.
    EXIT.
  ENDIF.

  IF p_create = abap_true.

    DATA(gs_sap04_emp_yeni) = VALUE zmc_sap04_emp( mandt   = sy-mandt
                                                   id      = p_id
                                                   name    = p_name
                                                   sname   = p_sname
                                                   holiday = p_hldy ).
    MODIFY zmc_sap04_emp FROM gs_sap04_emp_yeni.

    gv_process = 'I'.

    APPEND gs_sap04_emp_yeni TO gt_sap04_emp_yeni.

  ELSEIF p_delete = abap_true.

    SELECT * FROM zmc_sap04_emp INTO TABLE gt_sap04_emp_eski WHERE id = p_id.

    DELETE FROM zmc_sap04_emp WHERE id = p_id.

    gv_process = 'D'.

  ELSEIF p_update = abap_true.

    SELECT SINGLE * FROM zmc_sap04_emp INTO @DATA(gs_structure) WHERE id = @p_id.

    IF gs_structure IS INITIAL.
      EXIT.
    ENDIF.

    APPEND gs_structure TO gt_sap04_emp_eski.

    IF p_name IS NOT INITIAL.
      gs_structure-name = p_name.
    ENDIF.

    IF p_sname IS NOT INITIAL.
      gs_structure-sname = p_sname.
    ENDIF.

    IF p_hldy IS NOT INITIAL.
      gs_structure-holiday = p_hldy.
      DATA(gv_hld_change) = abap_true.
    ENDIF.

    APPEND gs_structure TO gt_sap04_emp_yeni.

    MODIFY zmc_sap04_emp FROM gs_structure.

    gv_process = 'U'.

  ENDIF.

  CHECK gv_hld_change = abap_true.

  CALL FUNCTION 'ZMC_SAP04_WRITE_DOCUMENT'
    EXPORTING
      objectid          = 'ZMC_SAP04'
      tcode             = sy-tcode
      utime             = sy-uzeit
      udate             = sy-datum
      username          = sy-uname
      upd_zmc_sap04_emp = gv_process
    TABLES
      icdtxt_zmc_sap04  = gt_test
      xzmc_sap04_emp    = gt_sap04_emp_yeni
      yzmc_sap04_emp    = gt_sap04_emp_eski.

  CALL FUNCTION 'CHANGEDOCUMENT_READ_ALL'
    EXPORTING
      i_objectclass              = 'ZMC_SAP04'
      i_tablename                = 'ZMC_SAP04_EMP'
    IMPORTING
      et_cdpos                   = gt_cdpos
    EXCEPTIONS
      missing_input_objectclass  = 1
      missing_input_header       = 2
      no_position_found          = 3
      wrong_access_to_archive    = 4
      time_zone_conversion_error = 5
      read_too_many_entries      = 6
      OTHERS                     = 7.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
