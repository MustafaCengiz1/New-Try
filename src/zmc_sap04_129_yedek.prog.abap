*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_129
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_129_yedek.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (1 adet CARRID, 2 adet
*tarih). Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options
*yapılarına aktarın. Elde ettiğiniz Select-Options yapılarını kullanarak SFLIGHT tablosundan uygun
*satırları okuyun ve ekrana yazdırın.


PARAMETERS: p_carrid TYPE s_carr_id,
            p_date_1 TYPE sy-datum,
            p_date_2 TYPE sy-datum.

TYPES: BEGIN OF gty_str_carrid,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_carr_id,
         high   TYPE s_carr_id,
       END OF gty_str_carrid.

TYPES: BEGIN OF gty_str_date,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE sy-datum,
         high   TYPE sy-datum,
       END OF gty_str_date.

DATA: gs_str_carrid   TYPE gty_str_carrid,
      gt_table_carrid TYPE RANGE OF s_carr_id,
      gs_str_date     TYPE gty_str_date,
      gt_table_date   TYPE RANGE OF sy-datum,
      gt_sflight      TYPE TABLE OF sflight.

START-OF-SELECTION.

  gs_str_carrid-sign   = 'I'.
  gs_str_carrid-option = 'EQ'.
  gs_str_carrid-low    = p_carrid.

  APPEND gs_str_carrid TO gt_table_carrid.
  CLEAR: gs_str_carrid.

  gs_str_date-sign   = 'I'.
  gs_str_date-option = 'BT'.
  gs_str_date-low    = p_date_1.
  gs_str_date-high   = p_date_2.

  APPEND gs_str_date TO gt_table_date.
  CLEAR: gs_str_date.

  SELECT * FROM sflight
  INTO TABLE gt_sflight
    WHERE carrid IN gt_table_carrid
    AND   fldate IN gt_table_date.

  SORT gt_sflight BY fldate.

  BREAK-POINT.
