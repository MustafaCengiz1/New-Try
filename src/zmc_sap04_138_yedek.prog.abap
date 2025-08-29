*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_138
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_138_yedek.

*Alıştırma – 13: İlk 5 alıştırmayı tekrar yazın ve işlemleri ayrı ayrı performlar içerisinde gerçekleştirin.

DATA: gv_carrid  TYPE s_carr_id,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_car FOR gv_carrid.

START-OF-SELECTION.

  PERFORM select_data.

FORM select_data.
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
ENDFORM.
