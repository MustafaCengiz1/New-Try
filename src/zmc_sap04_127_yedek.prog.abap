*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_127
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_127_yedek.

*Alıştırma – 2: Yeni bir rapor oluşturun ve kullanıcıdan Select-Options yardımıyla 3 adet “CARRID” alın.
*Alınan veriyi kullanarak SCARR, SPFLI ve SFLIGHT tablolarından tüm satırları okuyun ve ekrana yazdırın.
*Ancak ekrana yazdırırken önce SCARR tablosundan 1 satir yazdırın, daha sonra SPFLI tablosunda bu
*satir ile ayni CARRID bilgisine sahip olan satırları yazdırmaya başlayın. Her SPFLI satırından sonra
*SFLIGHT tablosundan bu satir ile ayni CARRID bilgisine sahip olan satırları yazdırın.

DATA: gs_scarr   TYPE scarr,
      gs_spfli   TYPE spfli,
      gs_sflight TYPE sflight,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_car FOR gs_scarr-carrid.

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

  LOOP AT gt_scarr INTO gs_scarr.

    WRITE: gs_scarr-carrid,
           gs_scarr-carrname,
           gs_scarr-currcode,
           gs_scarr-url.

    ULINE.
    SKIP.

    LOOP AT gt_spfli INTO gs_spfli WHERE carrid = gs_scarr-carrid.

      WRITE: / gs_spfli-carrid,
               gs_spfli-connid,
               gs_spfli-cityfrom,
               gs_spfli-cityto.



      LOOP AT gt_sflight INTO gs_sflight WHERE carrid = gs_spfli-carrid AND connid = gs_spfli-connid.

        WRITE: / gs_sflight-carrid,
                 gs_sflight-connid,
                 gs_sflight-planetype,
                 gs_sflight-price.
        ULINE.
      ENDLOOP.

    ENDLOOP.

    ULINE.

  ENDLOOP.
