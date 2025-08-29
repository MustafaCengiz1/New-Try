*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_205
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_205_yedek.

*Alıştırma – 7: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID alin. Rapor içerisinde bu
*parametrelerin dropdown olarak gösterilebilmesini sağlayın. Ayrıca ekranda kendinize ait SCARR
*tablosunun (Ör: ZCM_SCARR) her bir hücresi için bir parametre tanımlayın. Kullanıcı CARRID seçtikten
*sonra çalıştır butonuna basarsa altta bulunan hücreler doldurulsun. Kullanıcı altta bulunan hücreleri
*doldurup çalıştır butonuna basarsa, kendinize ait SCARR tablosunda yeni bir kayıt oluşturun ve
*CARRID parametresinin dropdown listesine, yeni girilen satirin CARRID değerini de ekleyin.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(7) TEXT-002.
SELECTION-SCREEN POSITION 8.
PARAMETERS: p_carrid TYPE c LENGTH 3 AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.



SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(7) TEXT-002.
SELECTION-SCREEN POSITION 8.
PARAMETERS: p_crrid2 TYPE c LENGTH 3 VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 15(13) TEXT-003.
SELECTION-SCREEN POSITION 28.
PARAMETERS: p_carrnm TYPE s_carrname VISIBLE LENGTH 20.

SELECTION-SCREEN COMMENT 50(9) TEXT-004.
SELECTION-SCREEN POSITION 59.
PARAMETERS: p_curr TYPE s_currcode VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 65(12) TEXT-005.
SELECTION-SCREEN POSITION 78.
PARAMETERS: p_url TYPE s_carrurl VISIBLE LENGTH 7.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a2.

DATA: gt_carrid      TYPE TABLE OF s_carr_id,
      gs_carrid      TYPE s_carr_id,
      gt_values      TYPE vrm_values,
      gs_value       TYPE vrm_value,
      gs_scarr_sap04 TYPE zmc_scarr_sap04.


INITIALIZATION.

  SELECT carrid FROM zmc_scarr_sap04 INTO TABLE gt_carrid.

  LOOP AT gt_carrid INTO gs_carrid.

    gs_value-key = gs_carrid.
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

AT SELECTION-SCREEN.

  IF p_crrid2 IS INITIAL.

    SELECT SINGLE * FROM zmc_scarr_sap04
      INTO gs_scarr_sap04
      WHERE carrid = p_carrid.

    p_crrid2 = gs_scarr_sap04-carrid.
    p_carrnm = gs_scarr_sap04-carrname.
    p_curr   = gs_scarr_sap04-currcode.
    p_url    = gs_scarr_sap04-url.

  ELSE.

    IF p_carrid IS INITIAL.

      gs_scarr_sap04-carrid   = p_crrid2.
      gs_scarr_sap04-carrname = p_carrnm.
      gs_scarr_sap04-currcode = p_curr.
      gs_scarr_sap04-url      = p_url.

      MODIFY zmc_scarr_sap04 FROM gs_scarr_sap04.
      CLEAR: gs_scarr_sap04.

    ELSE.

      SELECT SINGLE * FROM zmc_scarr_sap04
        INTO gs_scarr_sap04
        WHERE carrid = p_carrid.

      p_crrid2 = gs_scarr_sap04-carrid.
      p_carrnm = gs_scarr_sap04-carrname.
      p_curr   = gs_scarr_sap04-currcode.
      p_url    = gs_scarr_sap04-url.

    ENDIF.

  ENDIF.
