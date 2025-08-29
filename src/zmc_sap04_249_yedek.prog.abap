*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_249
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_249_yedek.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet çalışan ID bilgisi alin. Yeni bir class
*oluşturun. Birinci metot çalışanın genel bilgilerini (ZCM_TABLO_1 tablosundan) tek bir satir olarak
*hazırlayıp export etsin. İkinci metot bir tablo export etsin ve bu tablonun 2 adet kolonu olsun. (YIL ve
*KULLANILAN_IZIN). İlk metottan gelen satır ve ikinci metottan gelen tabloyu kullanarak anlamlı bir
*mesaj oluşturup kullanıcıya verin. (1001 ID’sine sahip Mehmet Öztürk 2024 yılında 27 gün ve 2025
*yılında 20 gün izin kaydı yapmıştır.) Raporda inline declaration ile tanımlanmış değişkenler kullanın.

TYPES: BEGIN OF gty_yil,
         yil TYPE c LENGTH 4,
       END OF gty_yil.

PARAMETERS: p_id TYPE zmc_de_empid.

DATA: gv_msg    TYPE string,
      gt_yil    TYPE TABLE OF gty_yil,
      gs_yil    TYPE gty_yil,
      gv_start  TYPE datum,
      gv_end    TYPE datum,
      gv_hld_no TYPE n LENGTH 2.

START-OF-SELECTION.

  SELECT * FROM zmc_sap04_hld INTO TABLE @DATA(gt_hld) WHERE id = @p_id.

  READ TABLE gt_hld INTO DATA(gs_hld) INDEX 1.

  IF sy-subrc IS INITIAL.

    CONCATENATE gs_hld-id 'ID''sine sahip' gs_hld-name gs_hld-sname INTO gv_msg SEPARATED BY space.
  ELSE.
    MESSAGE 'Yanlis id' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  LOOP AT gt_hld INTO gs_hld.                               "20250828

    gs_yil-yil = gs_hld-start_date+0(4).

    APPEND gs_yil TO gt_yil.

*    APPEND gs_hld-start_date+0(4) TO gt_yil.

  ENDLOOP.

  SORT gt_yil.

  DELETE ADJACENT DUPLICATES FROM gt_yil.

  LOOP AT gt_yil INTO gs_yil.

    DATA(gv_index) = sy-tabix.

    CONCATENATE gs_yil '0101' INTO gv_start.
    CONCATENATE gs_yil '1231' INTO gv_end.

    LOOP AT gt_hld INTO gs_hld WHERE start_date >= gv_start AND end_date <= gv_end.
      ADD gs_hld-saved_holidays TO gv_hld_no.
    ENDLOOP.

*    CONCATENATE gv_msg gs_yil-yil 'yilinda' gv_hld_no 'gün ve' INTO gv_msg SEPARATED BY space.

    IF gv_index = 1.

      IF lines( gt_yil ) = 1.

        CONCATENATE gv_msg gs_yil-yil 'yilinda' gv_hld_no 'gün' INTO gv_msg SEPARATED BY space.

      ELSE.

        CONCATENATE gv_msg gs_yil-yil 'yilinda' gv_hld_no 'gün ve' INTO gv_msg SEPARATED BY space.

      ENDIF.

    ENDIF.

    IF gv_index > 1.

      IF gv_index < lines( gt_yil ).

        CONCATENATE gv_msg gs_yil-yil 'yilinda' gv_hld_no 'gün ve' INTO gv_msg SEPARATED BY space.

      ELSE.

        CONCATENATE gv_msg gs_yil-yil 'yilinda' gv_hld_no 'gün ' INTO gv_msg SEPARATED BY space.

      ENDIF.

    ENDIF.

    CLEAR: gv_hld_no.

  ENDLOOP.

  CONCATENATE gv_msg 'izin kullanmistir.' INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.
