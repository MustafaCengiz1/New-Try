*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_198
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_198_yedek.

TYPES: BEGIN OF gty_1,
         carrid    TYPE s_carr_id,
         carrname  TYPE s_carrname,
         currcode	 TYPE s_currcode,
         connid    TYPE s_conn_id,
         countryfr TYPE land1,
       END OF gty_1.

DATA: gt_table TYPE TABLE OF gty_1,
      gs_str   TYPE gty_1,
      gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr,
      gt_spfli TYPE TABLE OF spfli,
      gs_spfli TYPE spfli,
      gt_table_2 TYPE TABLE OF gty_1,
      gt_table_3 TYPE TABLE OF gty_1.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.
  SELECT * FROM spfli INTO TABLE gt_spfli.

  LOOP AT gt_scarr INTO gs_scarr.

    gs_str-carrid = gs_scarr-carrid.
    gs_str-carrname = gs_scarr-carrname.
    gs_str-currcode = gs_scarr-currcode.

    LOOP AT gt_spfli INTO gs_spfli WHERE carrid = gs_scarr-carrid.

      gs_str-connid = gs_spfli-connid.
      gs_str-countryfr = gs_spfli-countryfr.

      APPEND gs_str TO gt_table.

    ENDLOOP.

  ENDLOOP.

  SELECT scarr~carrid, scarr~carrname, scarr~currcode,
         spfli~connid, spfli~countryfr
    INTO TABLE @gt_table_2
    FROM scarr
    INNER JOIN spfli
    on scarr~carrid = spfli~carrid.

  SELECT scarr~carrid, scarr~carrname, scarr~currcode,
         spfli~connid, spfli~countryfr
    INTO TABLE @gt_table_3
    FROM scarr
    LEFT OUTER JOIN spfli
    on scarr~carrid = spfli~carrid.


  BREAK-POINT.
