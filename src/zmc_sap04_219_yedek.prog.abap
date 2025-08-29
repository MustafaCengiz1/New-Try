*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_219
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_219_yedek.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflig RADIOBUTTON GROUP abc.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight,
      go_obj     TYPE REF TO zmc_select_in_runtime,
      gv_number  TYPE i VALUE 1.

FIELD-SYMBOLS: <gt_table> TYPE ANY TABLE,
               <gs_str>   TYPE any,
               <gv_field> TYPE any.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  IF p_scarr = abap_true.

    ASSIGN gt_scarr TO <gt_table>.

  ELSEIF p_spfli = abap_true.

    ASSIGN gt_spfli TO <gt_table>.

  ELSEIF p_sflig = abap_true.

    ASSIGN gt_sflight TO <gt_table>.

  ENDIF.

  go_obj->get_table(
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflig
    IMPORTING
      et_data    = <gt_table> ).

  LOOP AT <gt_table> ASSIGNING <gs_str>.

    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <gs_str> TO <gv_field>.
      IF <gv_field> IS ASSIGNED.
        WRITE: <gv_field>.
        UNASSIGN <gv_field>.
      ELSE.
        EXIT.
      ENDIF.

      ADD 1 TO gv_number.
    ENDDO.

    gv_number = 1.

    SKIP.
  ENDLOOP.

*  BREAK-POINT.
