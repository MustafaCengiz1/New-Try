*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_195
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_196_yedek.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(5) TEXT-003.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_saat TYPE n LENGTH 3.

SELECTION-SCREEN COMMENT 10(7) TEXT-004.
SELECTION-SCREEN POSITION 17.
PARAMETERS: p_dk TYPE n LENGTH 3.

SELECTION-SCREEN COMMENT 21(7) TEXT-005.
SELECTION-SCREEN POSITION 29.
PARAMETERS: p_sny TYPE n LENGTH 3.
*
SELECTION-SCREEN PUSHBUTTON 34(50) bt1 USER-COMMAND hsp.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_sonuc TYPE i.
SELECTION-SCREEN END OF BLOCK a2.

INITIALIZATION.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_calculation
     TEXT                  = 'HESAPLA'
     INFO                  = 'Girilen süreleri saniyeye cevirir.'
*     ADD_STDINF            = 'X'
    IMPORTING
      result                = bt1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.




AT SELECTION-SCREEN. "Selection Screen üzerinde islem yapma ve ayrilmama.

  CASE sy-ucomm.
    WHEN 'HSP'.
      p_sonuc = ( p_saat * 3600 ) + ( p_dk * 60 ) + p_sny.
*  	WHEN .
*  	WHEN OTHERS.
  ENDCASE.

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
