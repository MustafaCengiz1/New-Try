*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_157
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_157_yedek.

*Alıştırma – 7: Yeni bir rapor oluşturun ve STRAVELAG tablosunun sadece AGENCYNUM, NAME, CITY,
*COUNTRY, TELEPHONE ve URL kolonlarını çekerek bir internal tablo içine kaydedin. Internal tablonun
*ALV’si görüntüleyebilmek için manuel olarak Field Catalog internal tablosu oluşturun ve ALV’yi ekranda
*gösterin.

TYPES: BEGIN OF gty_str,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         city      TYPE city,
         country   TYPE s_country,
         telephone TYPE s_phoneno,
         url       TYPE s_url,
       END OF gty_str.

DATA: gt_table    TYPE TABLE OF gty_str,
      gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_layo     TYPE lvc_s_layo.

START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

  gs_fieldcat-fieldname = 'AGENCYNUM'.
  gs_fieldcat-reptext   = 'Firma Kodu'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'NAME'.
  gs_fieldcat-reptext   = 'Firma Ismi'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'CITY'.
  gs_fieldcat-reptext   = 'Sehir'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'COUNTRY'.
  gs_fieldcat-reptext   = 'Ülke'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'TELEPHONE'.
  gs_fieldcat-reptext   = 'Telefon'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'URL'.
  gs_fieldcat-reptext   = 'Web Adresi'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_layo-zebra      = abap_true.
  gs_layo-cwidth_opt = abap_true.
  gs_layo-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layo
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.
