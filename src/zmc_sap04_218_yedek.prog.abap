*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_218
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_218_yedek.

DATA: gv_text      TYPE string VALUE 'Örnek field sembol kullanmak icin yazilan rapor',
      gs_scarr     TYPE scarr,
      gt_spfli     TYPE TABLE OF spfli,
      gt_sflight   TYPE TABLE OF sflight,
      gt_stravelag TYPE TABLE OF stravelag.

FIELD-SYMBOLS: <fs_general> TYPE any,
               <fs_field>   TYPE any,
               <fs_str>     TYPE any,
               <fs_any_table> TYPE any,
               <fs_table>   TYPE ANY TABLE.

START-OF-SELECTION.

*ASSIGN gv_text to <fs_general>.
*WRITE: <fs_general>.

  SELECT SINGLE * FROM scarr
    INTO gs_scarr
    WHERE carrid = 'JL'.

  ASSIGN gs_scarr TO <fs_general>.

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_general> TO <fs_field>.
*IF sy-subrc IS INITIAL.
  IF <fs_field> IS ASSIGNED.

    WRITE: / <fs_field>.

  ENDIF.

  ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_general> TO <fs_field>.
  IF <fs_field> IS ASSIGNED.

    WRITE: / <fs_field>.

  ENDIF.

  SELECT * FROM spfli INTO TABLE gt_spfli.

  ASSIGN gt_spfli TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    ASSIGN COMPONENT 'AIRPFROM' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: / <fs_field>.
    ENDIF.

  ENDLOOP.



  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: / <fs_field>.
    ENDIF.

  ENDLOOP.


  SELECT * FROM stravelag INTO TABLE gt_stravelag.

  ASSIGN gt_stravelag TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    ASSIGN COMPONENT 'AGENCYNUM' OF STRUCTURE <fs_str> TO <fs_field>.
    IF <fs_field> IS ASSIGNED.
      WRITE: / <fs_field>.
    ENDIF.

  ENDLOOP.

*  ASSIGN gv_text TO <fs_table>.

  ASSIGN gt_stravelag to <fs_any_table>.

  BREAK-POINT.
*
*  LOOP AT <fs_any_table> ASSIGNING <fs_str>.
*
*  ENDLOOP.
