*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_239
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_239_yedek.

PARAMETERS: p_scarr RADIOBUTTON GROUP xyz,
            p_spfli RADIOBUTTON GROUP xyz,
            p_sflgt RADIOBUTTON GROUP xyz.

DATA: go_object TYPE REF TO ZMC_SELECT_IN_RUNTIME_2,
      gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

CREATE OBJECT go_object.

IF p_scarr = abap_true.

  ASSIGN gt_scarr TO <fs_table>.

ELSEIF p_spfli = abap_true.

  ASSIGN gt_spfli TO <fs_table>.

ELSEIF p_sflgt = abap_true.

  ASSIGN gt_sflight TO <fs_table>.

ENDIF.

go_object->get_table(
  EXPORTING
    iv_tabname = COND #( WHEN p_scarr = abap_true THEN 'SCARR'
                         WHEN p_spfli = abap_true THEN 'SPFLI'
                         WHEN p_sflgt = abap_true THEN 'SFLIGHT' )
  IMPORTING
    et_data    = <fs_table> ).

BREAK-POINT.
