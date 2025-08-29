*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_244
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_244_YEDEK.

PARAMETERS: p_table TYPE tabname.

DATA: gr_data TYPE REF TO data.

*FIELD-SYMBOLS: <fs_tablo> TYPE ANY TABLE.

START-OF-SELECTION.

DATA(go_obj) = NEW zmc_dynamic_table_sel( ).

CREATE OBJECT go_obj.

go_obj->get_table(
  EXPORTING
    iv_tabname = p_table
  IMPORTING
    et_data    = gr_data ).

ASSIGN gr_data->* TO FIELD-SYMBOL(<fs_tablo>).

BREAK-POINT.
