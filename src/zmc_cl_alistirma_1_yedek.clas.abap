class ZMC_CL_ALISTIRMA_1_YEDEK definition
  public
  final
  create public .

public section.

  methods ISLEM
    importing
      !IV_1 type I
      !IV_2 type I
    exporting
      !EV_RES type I .
protected section.
private section.
ENDCLASS.



CLASS ZMC_CL_ALISTIRMA_1_YEDEK IMPLEMENTATION.


  METHOD ISLEM.

    ev_res = iv_1.

    DO iv_2 TIMES.

      ev_res = ev_res * iv_1.

    ENDDO.

  ENDMETHOD.
ENDCLASS.
