*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_140
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_140_yedek.

*Alıştırma – 15: Yeni bir fonksiyon yazın. Kullanıcıdan 1 ile 7 arasında bir sayı alsın. Kullanıcıya girdiği
*sayıya karşılık gelen günü bildirsin. Fonksiyonu yeni yazacağınız bir raporda kullanın. Kullanıcının elde
*ettiği günü ekrana yazdırın.

PARAMETERS: p_day TYPE n  LENGTH 1.

DATA: gv_day            TYPE c LENGTH 15,
      gv_exception_text TYPE swc_shtext,
      gv_funcname       TYPE rs38l_fnam VALUE 'ZMC_FM_SAP04_06',
      gv_exception      TYPE parameter VALUE '1'.

START-OF-SELECTION.

  TRY .
      CALL FUNCTION 'ZMC_FM_SAP04_06'
        EXPORTING
          iv_no        = p_day
        IMPORTING
          ev_day       = gv_day
        EXCEPTIONS
          wrong_number = 1
          OTHERS       = 2.
    CATCH cx_root INTO DATA(go_root).
      WRITE: go_root->get_text( ).
  ENDTRY.


  IF sy-subrc = 1.


    CALL FUNCTION 'SWO_TEXT_FUNCTION_EXCEPTION'
      EXPORTING
        language  = sy-langu
        function  = gv_funcname
        exception = gv_exception
      IMPORTING
        shorttext = gv_exception_text.

    MESSAGE 'Yanlis input' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.

  ENDIF.

  MESSAGE gv_day TYPE 'I'.
