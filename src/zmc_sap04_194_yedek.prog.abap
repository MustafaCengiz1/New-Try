*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_194
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_194_yedek.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_saat TYPE i,
            p_dk   TYPE i,
            p_sny  TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_sonuc TYPE i.
SELECTION-SCREEN END OF BLOCK a2.


AT SELECTION-SCREEN. "Selection Screen üzerinde islem yapma ve ayrilmama.

  p_sonuc = ( p_saat * 3600 ) + ( p_dk * 60 ) + p_sny.

AT SELECTION-SCREEN OUTPUT.

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
