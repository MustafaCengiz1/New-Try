*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_126
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_126_yedek.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 1 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.

DATA: gv_carrid  TYPE s_carr_id,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_car FOR gv_carrid.



START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrid IN so_car.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE carrid IN so_car.

  SELECT * FROM sflight
    INTO TABLE gt_sflight
    WHERE carrid IN so_car.

  BREAK-POINT.
