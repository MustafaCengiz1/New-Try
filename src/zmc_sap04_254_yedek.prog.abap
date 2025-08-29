*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_254
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_254_yedek.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet CARRID ve 1 adet CONNID alın. Rapor
*içinde SPFLI tablosunun tamamını okuyup bir internal tablo içine kaydedin. LINE_INDEX komutunu
*kullanarak secim ekranından gelen veriler yardımıyla internal tablodaki ilgili satirin kaçıncı satir
*olduğunu bulun.

PARAMETERS: p_carrid TYPE s_carr_id,
            p_connid TYPE s_conn_id.

START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

  "7.40 öncesi
  READ TABLE gt_spfli INTO DATA(gs_spfli) WITH KEY carrid = p_carrid connid = p_connid.
  IF sy-subrc IS INITIAL.
    DATA(gv_index_1) = sy-tabix.
  ENDIF.

  "7.40 sonrasi
  DATA(gv_index_2) = line_index( gt_spfli[ carrid = p_carrid connid = p_connid ] ).

  IF gv_index_1 = gv_index_2.
    MESSAGE 'Islem basarili' TYPE 'S'.
  ENDIF.
