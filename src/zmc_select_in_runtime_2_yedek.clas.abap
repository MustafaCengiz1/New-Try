class ZMC_SELECT_IN_RUNTIME_2_YEDEK definition
  public
  final
  create public .

public section.

  methods GET_TABLE
    importing
      !IV_TABNAME type TABNAME
    exporting
      !ET_DATA type STANDARD TABLE .
protected section.
private section.
ENDCLASS.



CLASS ZMC_SELECT_IN_RUNTIME_2_YEDEK IMPLEMENTATION.


  METHOD GET_TABLE.


    SELECT * FROM (iv_tabname) INTO TABLE et_data.


  ENDMETHOD.
ENDCLASS.
