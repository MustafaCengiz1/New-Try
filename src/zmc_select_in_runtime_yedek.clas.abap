class ZMC_SELECT_IN_RUNTIME_YEDEK definition
  public
  final
  create public .

public section.

  methods GET_TABLE
    importing
      !IV_SCARR type CHAR1
      !IV_SPFLI type CHAR1
      !IV_SFLIGHT type CHAR1
    exporting
      !ET_DATA type STANDARD TABLE .
protected section.
private section.
ENDCLASS.



CLASS ZMC_SELECT_IN_RUNTIME_YEDEK IMPLEMENTATION.


  METHOD GET_TABLE.

    DATA: lv_tabname TYPE tabname.

    IF iv_scarr = abap_true.

      lv_tabname = 'SCARR'.

    ELSEIF iv_spfli = abap_true.

      lv_tabname = 'SPFLI'.

    ELSEIF iv_sflight = abap_true.

      lv_tabname = 'SFLIGHT'.

    ENDIF.

    SELECT * FROM (lv_tabname) INTO TABLE et_data.


  ENDMETHOD.
ENDCLASS.
