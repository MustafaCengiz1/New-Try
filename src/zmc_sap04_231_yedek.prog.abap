*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_231
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_231_yedek.

TYPES: BEGIN OF gty_str,
         id           TYPE zmc_de_f_id,
         agencynum    TYPE s_agncynum,
         name         TYPE s_agncynam,
         country      TYPE s_country,
         country_text TYPE c LENGTH 15,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str.

START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

  LOOP AT gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).

    CALL FUNCTION 'IGN_COUNTRYNAME_GET'
      EXPORTING
        i_country         = <gs_str>-country
      IMPORTING
        e_countryname     = <gs_str>-country_text
      EXCEPTIONS
        country_not_found = 1
        OTHERS            = 2.

    IF sy-subrc IS NOT INITIAL.
      MESSAGE 'Yanlis ülke kodu' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDLOOP.

  READ TABLE gt_table ASSIGNING FIELD-SYMBOL(<gs_str_2>) INDEX 5.
  IF sy-subrc IS INITIAL AND <gs_str_2> IS ASSIGNED.
    <gs_str_2>-country = 'TR'.
    <gs_str_2>-country_text = 'Türkiye'.
  ENDIF.

  READ TABLE gt_table INTO DATA(gs_str) INDEX 10.
  IF sy-subrc IS INITIAL.
    gs_str-country = 'TR'.
    gs_str-country_text = 'Türkiye'.
  ENDIF.

  BREAK-POINT.
