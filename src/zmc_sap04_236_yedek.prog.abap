*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_236
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_236_YEDEK.

*TYPES: BEGIN OF gty_str,
*         id        TYPE zmc_de_f_id,
*         agencynum TYPE s_agncynum,
*         name      TYPE s_agncynam,
*         street    TYPE s_street,
*         url       TYPE s_url,
*       END OF gty_str.
*
*DATA: gt_table   TYPE zmc_tt_sap04,
*      gs_str     TYPE zmc_s_sap04.


START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO TABLE @DATA(gt_stravelag).

*  LOOP AT gt_stravelag INTO DATA(gs_stravelag).
*    gs_str-id        = gs_stravelag-id.
*    gs_str-agencynum = gs_stravelag-agencynum.
*    gs_str-name      = gs_stravelag-name.
*    gs_str-street    = gs_stravelag-street.
*    gs_str-url       = gs_stravelag-url.
*
*    APPEND gs_str TO gt_table.
*    CLEAR: gs_str.
*  ENDLOOP.





*  DATA(gt_table) = VALUE zmc_tt_sap04( FOR gs_strav IN gt_stravelag  ( id        = gs_strav-id
*                                                                                        agencynum = gs_strav-agencynum
*                                                                                        name      = gs_strav-name
*                                                                                        street    = gs_strav-street
*                                                                                        url       = gs_strav-url ) ).
*
*  gt_table = VALUE #( BASE gt_table FOR gs_strav IN gt_stravelag WHERE ( id < 10 ) ( id        = gs_strav-id
*                                                                                     agencynum = gs_strav-agencynum
*                                                                                     name      = gs_strav-name
*                                                                                     street    = gs_strav-street
*                                                                                     url       = gs_strav-url ) ).
*
  BREAK-POINT.
