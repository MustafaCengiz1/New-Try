*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_152
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_152_yedek.

*Alıştırma – 2: Yeni bir rapor oluşturun. Select-Options komutu kullanarak kullanıcıdan “AGENCYNUM”
*alın. (Bu kolonu STRAVELAG database tablosu içinde bulabilirsiniz). Gelen veriye göre ilk alıştırmada
*oluşturduğunuz ve içinde kayıt oluşturduğunuz database tablosundan ilgili satırları okuyun ve oluşan
*internal tablonun ALV’sini alın. (Birinci fonksiyon kombinasyonunu kullanarak). Programınızı Perform
*komutu kullanarak yazın.

TYPES: BEGIN OF gty_str,
        box TYPE c LENGTH 1.
        INCLUDE STRUCTURE zmc_sap04_strav.
TYPES: END OF gty_str.

DATA: gv_agnum    TYPE s_agncynum,
      gt_table    TYPE TABLE OF gty_str,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

SELECT-OPTIONS: so_agnum FOR gv_agnum.


START-OF-SELECTION.

  "1. Asama: Databaseden veri cek.
  SELECT * FROM zmc_sap04_strav
    INTO CORRESPONDING FIELDS OF TABLE gt_table
    WHERE agencynum IN so_agnum.

  "2. Asama: Field Catalog Internal Tablosunu olustur.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_STRAV'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "3. Asama: Layout hazirla.
  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.

  "4. Asama: ALV'yi ekranda göster.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
