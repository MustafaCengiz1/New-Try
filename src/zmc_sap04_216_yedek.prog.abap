*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_216
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_216_yedek.

TYPES: BEGIN OF gty_str,
         carrid     TYPE s_carr_id,
         connid     TYPE s_conn_id,
         fldate     TYPE s_date,
         bos_koltuk TYPE i,
       END OF gty_str.

DATA: gt_table   TYPE TABLE OF gty_str,
      gs_str     TYPE gty_str,
      gt_sfligt  TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <gs_str> TYPE gty_str.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sfligt.

*  LOOP AT gt_sfligt INTO gs_sflight.
*
*    gs_str-carrid     = gs_sflight-carrid.
*    gs_str-connid     = gs_sflight-connid.
*    gs_str-fldate     = gs_sflight-fldate.
*    gs_str-bos_koltuk = gs_sflight-seatsmax - gs_sflight-seatsocc.
*    APPEND gs_str TO gt_table.
*    CLEAR: gs_str.
*
*  ENDLOOP.

  LOOP AT gt_sfligt INTO gs_sflight.

    APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.

    <gs_str>-carrid     = gs_sflight-carrid.
    <gs_str>-connid     = gs_sflight-connid.
    <gs_str>-fldate     = gs_sflight-fldate.
    <gs_str>-bos_koltuk = gs_sflight-seatsmax - gs_sflight-seatsocc.

  ENDLOOP.

  BREAK-POINT.
