*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_235
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_235_yedek.

TYPES: BEGIN OF gty_str,
         id        TYPE zmc_de_f_id,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         url       TYPE s_url,
       END OF gty_str.

DATA: gt_table   TYPE TABLE OF gty_str,
      gt_table_2 TYPE TABLE OF gty_str,
      gs_str     TYPE gty_str.

START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO TABLE @DATA(gt_stravelag).

  LOOP AT gt_stravelag INTO DATA(gs_stravelag) WHERE id > 30.
    gs_str-id        = gs_stravelag-id.
    gs_str-agencynum = gs_stravelag-agencynum.
    gs_str-name      = gs_stravelag-name.
    gs_str-street    = gs_stravelag-street.
    gs_str-url       = gs_stravelag-url.

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.
  ENDLOOP.

  gt_table_2 = VALUE #( FOR gs_strav IN gt_stravelag WHERE ( id > 30 ) ( id        = gs_strav-id
                                                                         agencynum = gs_strav-agencynum
                                                                         name      = gs_strav-name
                                                                         street    = gs_strav-street
                                                                         url       = gs_strav-url ) ).

*  DATA(gt_table_3) = VALUE zmc_tt_sap04( FOR gs_strav IN gt_stravelag WHERE ( id > 30 ) ( id        = gs_strav-id
*                                                                                          agencynum = gs_strav-agencynum
*                                                                                          name      = gs_strav-name
*                                                                                          street    = gs_strav-street
*                                                                                          url       = gs_strav-url ) ).
*


  BREAK-POINT.
