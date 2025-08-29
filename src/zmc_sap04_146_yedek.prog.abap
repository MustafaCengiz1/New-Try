*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_146
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_146_yedek.

"4 tane fonksiyon

"Ilk ikisi birinci kombinasyon
"Son ikisi ikinci kombinasyon

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

TYPES: BEGIN OF gty_str,
         box.
       INCLUDE STRUCTURE spfli.
TYPES: END OF gty_str.

DATA: gt_spfli TYPE TABLE OF gty_str.


START-OF-SELECTION.

  "1. Asama: Databaseden veri cek.
  SELECT * FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli.

  "2. Asama: Field Catalog Internal Tablosunu olustur.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
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
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.

  "4. Asama: ALV'yi ekranda göster.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_spfli
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.


*  BREAK-POINT.
