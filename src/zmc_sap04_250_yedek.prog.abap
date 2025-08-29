*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_250
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_250_yedek.

*Alıştırma – 2: Yeni bir rapor oluşturun ve ZCM_TABLO_1 ile ZCM_TABLO_2 database tablolarından
*bütün verileri çekin. Daha sonra ikinci tablodan gelen veri ile loop ederek izinlerin bitiş tarihlerini 1’er
*gün arttırın. Bunu yaparken birinci tablodaki izin hakkini da kontrol edin. Yani bu işlemi sadece yeni
*değerin birinci tablodaki izin hakkini geçmediği durumlarda gerçekleştirin. Raporda inline declaration
*ile tanımlanmış değişkenler kullanın.

PARAMETERS: p_id  TYPE zmc_de_empid,
            p_yil TYPE c LENGTH 4.

DATA: gv_start TYPE datum,
      gv_end   TYPE datum.

START-OF-SELECTION.

  CONCATENATE p_yil '0101' INTO gv_start.
  CONCATENATE p_yil '1231' INTO gv_end.

  SELECT * FROM zmc_sap04_hld INTO TABLE @DATA(gt_hld) WHERE id = @p_id AND
                                                             start_date >= @gv_start AND
                                                             end_date   <= @gv_end.

  SELECT SINGLE holiday FROM zmc_sap04_emp INTO @DATA(gv_hld_total) WHERE id = @p_id.


  DATA(gv_hld_total_kullanilan) = REDUCE i( INIT x = 0
                                            FOR gs_line
                                            IN gt_hld
                                            NEXT x = x + gs_line-saved_holidays ).

  IF gv_hld_total_kullanilan < gv_hld_total.
    LOOP AT gt_hld ASSIGNING FIELD-SYMBOL(<gs_hld>).

      ADD 1 TO <gs_hld>-end_date.

      ADD 1 TO gv_hld_total_kullanilan.

      IF gv_hld_total_kullanilan = gv_hld_total.
        EXIT.
      ENDIF.

    ENDLOOP.
  ENDIF.

  MODIFY zmc_sap04_hld FROM TABLE gt_hld.


*  BREAK-POINT.
