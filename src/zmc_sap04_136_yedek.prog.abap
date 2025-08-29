*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_136
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_136_yedek.

*Alıştırma – 11: Yeni bir rapor oluşturun ve kullanıcıdan 3 adet parametre alin. (Tamami radiobutton
*olsun. İsimlendirilmeleri “SCARR”, “SPFLI” ve “SFLIGHT” olsun. Kullanıcı hangi radiobuttonu seçerse
*satırlarını okuyup ekrana yazdırın. İşlemleri ayrı ayrı performlar içerisinde gerçekleştirin.)

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    PERFORM select_scarr.

  ELSEIF p_spfli = abap_true.

    PERFORM select_spfli.

  ELSEIF p_sflght = abap_true.

    PERFORM select_sflight.

  ENDIF.

  BREAK-POINT.


FORM select_scarr .

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

ENDFORM.


FORM select_spfli .
  SELECT * FROM spfli
    INTO TABLE gt_spfli.
ENDFORM.


FORM select_sflight .
  SELECT * FROM sflight
    INTO TABLE gt_sflight.
ENDFORM.
