*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_230
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_230_yedek.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc,
            p_kln   TYPE i.

DATA: gv_number TYPE i VALUE 1.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    LOOP AT gt_scarr ASSIGNING FIELD-SYMBOL(<gs_scarr>).

      DO.

        ASSIGN COMPONENT gv_number OF STRUCTURE <gs_scarr> TO FIELD-SYMBOL(<gv_field>).
        IF sy-subrc IS INITIAL AND <gv_field> IS ASSIGNED.

          WRITE: <gv_field>.

        ENDIF.

        ADD 1 TO gv_number.

        IF gv_number > p_kln.
          EXIT.
        ENDIF.

      ENDDO.

      SKIP.
      gv_number = 1.

    ENDLOOP.



  ELSEIF p_spfli = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    LOOP AT gt_spfli ASSIGNING FIELD-SYMBOL(<gs_spfli>).

      DO.

        ASSIGN COMPONENT gv_number OF STRUCTURE <gs_spfli> TO <gv_field>.
        IF sy-subrc IS INITIAL AND <gv_field> IS ASSIGNED.

          WRITE: <gv_field>.

        ENDIF.

        ADD 1 TO gv_number.

        IF gv_number > p_kln.
          EXIT.
        ENDIF.

      ENDDO.

      SKIP.
      gv_number = 1.

    ENDLOOP.

  ELSEIF p_sflgt = abap_true.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    LOOP AT gt_sflight ASSIGNING FIELD-SYMBOL(<gs_sflight>).

      DO.

        ASSIGN COMPONENT gv_number OF STRUCTURE <gs_sflight> TO <gv_field>.
        IF sy-subrc IS INITIAL AND <gv_field> IS ASSIGNED.

          WRITE: <gv_field>.

        ENDIF.

        ADD 1 TO gv_number.

        IF gv_number > p_kln.
          EXIT.
        ENDIF.

      ENDDO.

      SKIP.
      gv_number = 1.

    ENDLOOP.

  ENDIF.
