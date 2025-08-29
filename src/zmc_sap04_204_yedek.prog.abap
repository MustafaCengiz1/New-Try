*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_204
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_204_yedek.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID, 1 adet CONNID alin. Rapor
*içerisinde bu parametrelerin dropdown olarak gösterilebilmesini sağlayın. Ayrıca ekranda SPFLI
*tablosunun her bir hücresi için bir parametre tanımlayın. Bu parametreler yan yana, kullanıcının veri
*girişi yapmasına kapalı olacak şekilde ve içerisinde veri yoksa görünmez olacak şekilde düzenlensin.
*Gelen veriye göre SPFLI tablosundan ilgili satiri okuyun ve gelen satirin hücrelerini secim ekranındaki
*hücrelerin içine kaydederek görünür hale getirin.

SELECTION-SCREEN BEGIN OF BLOCK q1 WITH FRAME TITLE TEXT-001.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(7) TEXT-002.
SELECTION-SCREEN POSITION 8.
PARAMETERS: p_carrid TYPE c LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 14(7) TEXT-003.
SELECTION-SCREEN POSITION 21.
PARAMETERS: p_connid TYPE n LENGTH 4 AS LISTBOX VISIBLE LENGTH 7.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK q1.

SELECTION-SCREEN BEGIN OF BLOCK q2 WITH FRAME TITLE TEXT-004.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(14) TEXT-005.
SELECTION-SCREEN POSITION 15.
PARAMETERS: p_cntrfr TYPE land1 VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 21(12) TEXT-006.
SELECTION-SCREEN POSITION 34.
PARAMETERS: p_cityfr TYPE land1 VISIBLE LENGTH 20.

SELECTION-SCREEN COMMENT 55(7) TEXT-007.
SELECTION-SCREEN POSITION 63.
PARAMETERS: p_airfr TYPE land1 VISIBLE LENGTH 7.


SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK q2.

DATA: gt_carrid TYPE TABLE OF s_carr_id,
      gs_carrid TYPE s_carr_id,
      gt_connid TYPE TABLE OF s_conn_id,
      gs_connid TYPE s_conn_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gs_spfli TYPE spfli.

INITIALIZATION.

  SELECT carrid FROM spfli INTO TABLE gt_carrid.

  SORT gt_carrid.
  DELETE ADJACENT DUPLICATES FROM gt_carrid.

  LOOP AT gt_carrid INTO gs_carrid.

    gs_value-key  = gs_carrid.
    gs_value-text = gs_carrid.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_CARRID'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  CLEAR: gt_values.

  SELECT connid FROM spfli INTO TABLE gt_connid.

  SORT gt_connid.
  DELETE ADJACENT DUPLICATES FROM gt_connid.

  LOOP AT gt_connid INTO gs_connid.

    gs_value-key  = gs_connid.
    gs_value-text = gs_connid.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.

  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_CONNID'
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  CLEAR: gt_values.

AT SELECTION-SCREEN.

  SELECT SINGLE * FROM spfli
    INTO gs_spfli
    WHERE carrid = p_carrid
    AND   connid = p_connid.

    p_cntrfr = gs_spfli-countryfr.
    p_cityfr = gs_spfli-cityfrom.
    p_airfr  = gs_spfli-airpfrom.








*BREAK-POINT.
