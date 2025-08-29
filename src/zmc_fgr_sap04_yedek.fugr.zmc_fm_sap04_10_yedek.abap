FUNCTION ZMC_FM_SAP04_10_YEDEK.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_SYMBOL) TYPE  CHAR1
*"     REFERENCE(IV_NUMBER_1) TYPE  INT4
*"     REFERENCE(IV_NUMBER_2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  INT4
*"  EXCEPTIONS
*"      SIFIRA_BOLME_ISLEMI
*"      BOS_ISLEM_SEMBOLU
*"      YANLIS_ISLEM_SEMBOLU
*"--------------------------------------------------------------------

  IF iv_symbol = '/' AND iv_number_2 = 0.

    RAISE sifira_bolme_islemi.

  ENDIF.

  IF iv_symbol IS INITIAL.
    RAISE bos_islem_sembolu.
  ENDIF.

  IF iv_symbol = '+'.

    ev_result = iv_number_1 + iv_number_2.

  ELSEIF iv_symbol = '-'.

    ev_result = iv_number_1 - iv_number_2.

  ELSEIF iv_symbol = '*'.

    ev_result = iv_number_1 * iv_number_2.

  ELSEIF iv_symbol = '/'.

    ev_result = iv_number_1 / iv_number_2.

  ELSE.

    RAISE yanlis_islem_sembolu.

  ENDIF.



ENDFUNCTION.
