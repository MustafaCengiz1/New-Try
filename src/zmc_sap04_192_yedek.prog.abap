*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_192
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_192_yedek.

PARAMETERS: p_ad    TYPE zmc_de_name,
            p_sad   TYPE zmc_de_sname,
            p_tarih TYPE datum.

DATA: gt_table  TYPE TABLE OF zmc_sap04_date,
      gs_str    TYPE zmc_sap04_date,
      gv_yil    TYPE c LENGTH 4,
      gv_ay     TYPE c LENGTH 10,
      gv_gun_no TYPE c LENGTH 1.
*      gv_gun   TYPE c LENGTH 10.

START-OF-SELECTION.

*  SELECT * FROM zmc_sap04_date
*    INTO TABLE gt_table.
*
*  gs_str-id       = lines( gt_table ) + 1.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '01'
      object                  = 'ZMC_SAP04'
    IMPORTING
      number                  = gs_str-id
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  gs_str-ad       = p_ad.
  gs_str-soyad    = p_sad.
  gs_str-d_tarihi = p_tarih.                                "20250710

  gv_yil = p_tarih+0(4).
  gv_ay  = p_tarih+4(2).
*  gv_gun = p_tarih+6(2).

*  gs_str-d_yil = p_tarih+0(4).
  gs_str-d_yil = gv_yil.

  CASE gv_ay.
    WHEN '01'.
      gs_str-d_ay = 'Ocak'.
    WHEN '02'.
      gs_str-d_ay = 'Subat'.
    WHEN '03'.
      gs_str-d_ay = 'Mart'.
    WHEN '04'.
      gs_str-d_ay = 'Nisan'.
    WHEN '05'.
      gs_str-d_ay = 'Mayis'.
    WHEN '06'.
      gs_str-d_ay = 'Haziran'.
    WHEN '07'.
      gs_str-d_ay = 'Temmuz'.
    WHEN '08'.
      gs_str-d_ay = 'Agustos'.
    WHEN '09'.
      gs_str-d_ay = 'Eylül'.
    WHEN '10'.
      gs_str-d_ay = 'Ekim'.
    WHEN '11'.
      gs_str-d_ay = 'Kasim'.
    WHEN '12'.
      gs_str-d_ay = 'Aralik'.
    WHEN OTHERS.
  ENDCASE.

  CALL FUNCTION 'DATE_COMPUTE_DAY'
    EXPORTING
      date = p_tarih
    IMPORTING
      day  = gv_gun_no.

  CASE gv_gun_no.
    WHEN '1'.
      gs_str-d_gun = 'Pazartesi'.
    WHEN '2'.
      gs_str-d_gun = 'Sali'.
    WHEN '3'.
      gs_str-d_gun = 'Carsamba'.
    WHEN '4'.
      gs_str-d_gun = 'Persembe'.
    WHEN '5'.
      gs_str-d_gun = 'Cuma'.
    WHEN '6'.
      gs_str-d_gun = 'Cumartesi'.
    WHEN '7'.
      gs_str-d_gun = 'Pazar'.
    WHEN OTHERS.
  ENDCASE.

  MODIFY zmc_sap04_date FROM gs_str.
