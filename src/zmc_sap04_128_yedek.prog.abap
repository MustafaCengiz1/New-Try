*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_128
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_128_yedek.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet parametre alin. Her ikisi de CARRID tipinde
*olsun. Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options
*yapılarına aktarın ve SPFLI tablosunda satırları okuyup ekrana yazdırın.

PARAMETERS: p_carr_1 TYPE s_carr_id,
            p_carr_2 TYPE s_carr_id.

TYPES: BEGIN OF gty_str,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_carr_id,
         high   TYPE s_carr_id,
       END OF gty_str.

DATA: gs_str_so   TYPE gty_str,
      gt_table_so TYPE RANGE OF s_carr_id,
      gt_spfli    TYPE TABLE OF spfli.

START-OF-SELECTION.

  gs_str_so-sign   = 'I'.
  gs_str_so-option = 'BT'.
  gs_str_so-low    = p_carr_1.
  gs_str_so-high   = p_carr_2.

  APPEND gs_str_so TO gt_table_so.
  CLEAR: gs_str_so.


*  gs_str_so-sign   = 'I'.
*  gs_str_so-option = 'EQ'.
*  gs_str_so-low    = p_carr_2.
**gs_str_so-high   = 'I'.
*
*  APPEND gs_str_so TO gt_table_so.
*  CLEAR: gs_str_so.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE carrid IN gt_table_so.

  BREAK-POINT.
