*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_227
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_227_yedek.

*Alıştırma – 8: Yeni bir rapor oluşturun. Raporda 2 adet radiobutton olsun. Kullanıcı ilk radiobuttonu
*seçerse ZCM_TABLO_1, ikinci radiobuttonu seçerse ZCM_TABLO_2 tablosundaki bütün satırların
*okuyup internal tablo içine kaydedin. Select komutunu sadece 1 kere kullanılan. TYPE ANY TABLE
*komutu yardımıyla bir field sembol tanımlayın ve internal tabloyu bu field sembole assign edin. Field
*sembol üzerinde loop ederek tüm kolonları ekrana yazdırın.

PARAMETERS: p_1 RADIOBUTTON GROUP mng,
            p_2 RADIOBUTTON GROUP mng.

DATA: gt_emp        TYPE TABLE OF zmc_sap04_emp,
      gt_hld        TYPE TABLE OF zmc_sap04_hld,
      gv_table_name TYPE tabname.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  IF p_1 = abap_true.
    ASSIGN gt_emp TO <fs_table>.
    gv_table_name = 'ZMC_SAP04_EMP'.
  ELSE.
    ASSIGN gt_hld TO <fs_table>.
    gv_table_name = 'ZMC_SAP04_HLD'.
  ENDIF.

  SELECT * FROM (gv_table_name) INTO TABLE <fs_table>.

  BREAK-POINT.
