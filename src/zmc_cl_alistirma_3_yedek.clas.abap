class ZMC_CL_ALISTIRMA_3_YEDEK definition
  public
  final
  create public .

public section.

  class-data MV_SAYI type I .

  class-methods UZERI_2
    importing
      !IV_SAYI type I
    exporting
      !EV_SAYI type I .
  class-methods UZERI_3
    importing
      !IV_SAYI type I
    exporting
      !EV_SAYI type I .
  class-methods UZERI_4
    importing
      !IV_SAYI type I
    exporting
      !EV_SAYI type I .
protected section.

  class-data MV_SAYI_2 type I .
private section.
ENDCLASS.



CLASS ZMC_CL_ALISTIRMA_3_YEDEK IMPLEMENTATION.


  METHOD UZERI_2.

    ev_sayi = iv_sayi * iv_sayi.

  ENDMETHOD.


  method UZERI_3.

    ev_sayi = iv_sayi * iv_sayi * iv_sayi.

  endmethod.


  METHOD UZERI_4.

    ev_sayi = iv_sayi * iv_sayi * iv_sayi * iv_sayi.

  ENDMETHOD.
ENDCLASS.
