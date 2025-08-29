*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_195
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_195_yedek.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(5) TEXT-003.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_saat TYPE i.

SELECTION-SCREEN COMMENT 21(7) TEXT-004.
SELECTION-SCREEN POSITION 28.
PARAMETERS: p_dk TYPE i.

SELECTION-SCREEN COMMENT 43(7) TEXT-005.
SELECTION-SCREEN POSITION 50.
PARAMETERS: p_sny TYPE i.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_sonuc TYPE i.
SELECTION-SCREEN END OF BLOCK a2.


AT SELECTION-SCREEN. "Selection Screen üzerinde islem yapma ve ayrilmama.

  p_sonuc = ( p_saat * 3600 ) + ( p_dk * 60 ) + p_sny.

AT SELECTION-SCREEN OUTPUT. "Selection Screen elementleri üzerinde islem yapilan alan.

  LOOP AT SCREEN.

    IF p_sonuc IS INITIAL.

      IF screen-name = 'P_SONUC' OR screen-name = '%_P_SONUC_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.

      IF screen-name = 'P_SONUC'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.
