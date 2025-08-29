*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_203
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_203_yedek.

*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet tarih alın. Bu iki tarih hücresi yan yana
*olsun. Gelen iki tarih arasındaki gün sayısını hesaplayın ve secim ekranından çıkmadan, secim
*ekranındaki üçüncü hücre içerisinde gösterin. Secim ekranındaki dördüncü hücre içerisinde ise
*kullanıcının girdiği iki tarihin ortasındaki tarihi yazın. Üçüncü ve dördüncü hücreler yan yana olsunlar
*ve bos olduklarında görünmez olsunlar.

SELECTION-SCREEN BEGIN OF BLOCK x1 WITH FRAME TITLE TEXT-001.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(17) TEXT-003.
SELECTION-SCREEN POSITION 18.
PARAMETERS: p_trh1 TYPE datum.

SELECTION-SCREEN COMMENT 29(13) TEXT-004.
SELECTION-SCREEN POSITION 43.
PARAMETERS: p_trh2 TYPE datum.


SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK x1.


SELECTION-SCREEN BEGIN OF BLOCK y1 WITH FRAME TITLE TEXT-002.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(17) TEXT-005.
SELECTION-SCREEN POSITION 18.
PARAMETERS: p_gun TYPE i.

SELECTION-SCREEN COMMENT 36(15) TEXT-006.
SELECTION-SCREEN POSITION 52.
PARAMETERS: p_trh3 TYPE datum.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK y1.

AT SELECTION-SCREEN.

  p_gun = p_trh2 - p_trh1.

  p_trh3 = p_trh1 + ( p_gun / 2 ).

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_gun IS INITIAL.

      IF screen-name = 'P_GUN' or screen-name = '%C005012_1000'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

    IF p_trh3 IS INITIAL.

      IF screen-name = 'P_TRH3' or screen-name = '%C006015_1000'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.
