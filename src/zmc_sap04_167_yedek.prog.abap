*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_167
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_167_yedek.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.

DATA: go_obj TYPE REF TO zmc_cl_sap04_constructor.


START-OF-SELECTION.

CREATE OBJECT go_obj
  EXPORTING
    iv_scarr   = p_scarr
    iv_spfli   = p_spfli
    iv_sflight = p_sflgt.

IF p_scarr = abap_true.

  go_obj->alv_scarr( ).

ELSEIF p_spfli = abap_true.

  go_obj->alv_spfli( ).

ELSEIF p_sflgt = abap_true.

  go_obj->alv_sflight( ).

ENDIF.
