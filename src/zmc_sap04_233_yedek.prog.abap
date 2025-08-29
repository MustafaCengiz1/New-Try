*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_233
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_233_yedek.

START-OF-SELECTION.

  DATA: gs_str          TYPE zmc_sap04_strav,
        gv_satir_sayisi TYPE i,
        gv_index        TYPE i  VALUE 10,
        gs_yeni_2       TYPE zmc_sap04_strav.

  SELECT * FROM zmc_sap04_strav INTO TABLE @DATA(gt_table).

  "7.40 öncesi
  READ TABLE gt_table INTO DATA(gs_table) INDEX 500.
  IF sy-subrc IS INITIAL.
    "WRITE
  ENDIF.

  "7.40 sonrasi
  TRY.
      gs_str = gt_table[ 50 ].

    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Aranan satir bulunamadi' TYPE 'E'.
  ENDTRY.

  gv_satir_sayisi = lines( gt_table ).

*  IF gv_index <= gv_satir_sayisi.
  IF gv_index <= lines( gt_table ).
    gs_str = gt_table[ gv_index ].
  ENDIF.

  "7.40 öncesi
  READ TABLE gt_table INTO DATA(gs_yeni) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    "WRITE
  ENDIF.

  "7.40 sonrasi
  TRY .
      gs_yeni_2 = gt_table[ agencynum = '00000061' name = 'Fly High' ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Aranan satir bulunamadi' TYPE 'E'.
  ENDTRY.

  TRY.
      DATA(gs_yeni_3) = gt_table[ agencynum = '00000061' name = 'Fly High' ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Aranan satir bulunamadi' TYPE 'E'.
  ENDTRY.




  BREAK-POINT.
