class ZMC_MSG_DISPLAY_YEDEK definition
  public
  final
  create public .

public section.

  methods SHOW_MSG
    importing
      !IV_SUCCESS type CHAR1
      !IV_ERROR type CHAR1
      !IV_WARNING type CHAR1
      !IV_INFO type CHAR1 .
protected section.
private section.
ENDCLASS.



CLASS ZMC_MSG_DISPLAY_YEDEK IMPLEMENTATION.


  METHOD SHOW_MSG.

    IF iv_success = abap_true.

*      MESSAGE s000(zmc_sap04_1).
*    MESSAGE s001(zmc_sap04_1) WITH '1' 'basari'.
      MESSAGE s001 WITH '1' 'basari'.

    ELSEIF iv_error = abap_true.

*      MESSAGE e000(zmc_sap04_1).
*    MESSAGE e001(zmc_sap04_1) WITH '2' 'hata'.
      MESSAGE e001 WITH '2' 'hata'.

    ELSEIF iv_warning = abap_true.

*      MESSAGE w000(zmc_sap04_1).
*    MESSAGE w001(zmc_sap04_1) WITH '3' 'uyari'.
      MESSAGE w001 WITH '3' 'uyari'.

    ELSEIF iv_info = abap_true.

*      MESSAGE i000(zmc_sap04_1).
      MESSAGE i001 WITH '4' 'bilgi'.

    ENDIF.




  ENDMETHOD.
ENDCLASS.
