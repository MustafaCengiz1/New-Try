*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_153
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_153_yedek.

*Alıştırma – 3: Yeni bir rapor oluşturun. Select-Options komutu kullanarak kullanıcıdan “AGENCYNUM”
*alın. (Bu kolonu STRAVELAG database tablosu içinde bulabilirsiniz). Gelen veriye göre ilk alıştırmada
*oluşturduğunuz ve içinde kayıt oluşturduğunuz database tablosundan ilgili satırları okuyun ve oluşan
*internal tablonun ALV’sini alın. (İkinci fonksiyon kombinasyonunu kullanarak). Programınızı Perform
*komutu kullanarak yazın.

DATA: gs_str TYPE zmc_sap04_strav.

DATA: gt_table    TYPE TABLE OF zmc_sap04_strav,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_layout   TYPE lvc_s_layo.

SELECT-OPTIONS: so_agnum FOR gs_str-agencynum.


START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO TABLE gt_table
    WHERE agencynum IN so_agnum.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_STRAV'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.
