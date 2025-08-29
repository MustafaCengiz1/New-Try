*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_215
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_215_yedek.

DATA: gv_number TYPE i VALUE 10,
      gt_scarr  TYPE TABLE OF scarr,
      gs_scarr  TYPE scarr.

FIELD-SYMBOLS: <gv_fs_number> TYPE i,
               <gs_scarr>     TYPE scarr.

START-OF-SELECTION.

  ADD 10 TO gv_number.
  ASSIGN gv_number TO <gv_fs_number>.
  ADD 10 TO <gv_fs_number>.
  ADD 10 TO gv_number.

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

*  LOOP AT gt_scarr INTO gs_scarr.
*    IF gs_scarr-currcode = 'EUR'.
*      gs_scarr-currcode = 'USD'.
*    ELSEIF gs_scarr-currcode = 'USD'.
*      gs_scarr-currcode = 'EUR'.
*    ENDIF.
*    MODIFY gt_scarr FROM gs_scarr TRANSPORTING currcode WHERE carrid = gs_scarr-carrid.
*  ENDLOOP.

  LOOP AT gt_scarr ASSIGNING <gs_scarr>.

    IF <gs_scarr>-currcode = 'EUR'.

      <gs_scarr>-currcode = 'USD'.

    ELSEIF <gs_scarr>-currcode = 'USD'.

      <gs_scarr>-currcode = 'EUR'.

    ENDIF.

  ENDLOOP.

  BREAK-POINT.
