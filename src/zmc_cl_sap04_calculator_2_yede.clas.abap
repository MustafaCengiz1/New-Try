class ZMC_CL_SAP04_CALCULATOR_2_YEDE definition
  public
  final
  create public .

public section.

  methods HESAPLA
    importing
      !IV_SAYI_1 type INT4
      !IV_SAYI_2 type INT4
      !IV_SEMBOL type CHAR1
    exporting
      !EV_SONUC type INT4
      !EV_HATA type CHAR1 .
protected section.

  methods TOPLA
    importing
      !IV_NO_1 type INT4
      !IV_NO_2 type INT4
    exporting
      !EV_NO type INT4 .
  methods CIKAR
    importing
      !IV_NO_CIKAR_1 type INT4
      !IV_NO_CIKAR_2 type INT4
    exporting
      !EV_NO_CIKAR type INT4 .
  methods CARP
    importing
      !IV_NO_CARP_1 type INT4
      !IV_NO_CARP_2 type INT4
    exporting
      !EV_NO_CARPIM type INT4 .
  methods BOL
    importing
      !IV_NO_BOL_1 type INT4
      !IV_NO_BOL_2 type INT4
    exporting
      !EV_NO_BOLUM type INT4
    exceptions
      SIFIRA_BOLME_ISLEMI .
private section.
ENDCLASS.



CLASS ZMC_CL_SAP04_CALCULATOR_2_YEDE IMPLEMENTATION.


  METHOD BOL.

    IF iv_no_bol_2 = 0.
      RAISE sifira_bolme_islemi.
    ENDIF.

    ev_no_bolum = iv_no_bol_1 / iv_no_bol_2.

  ENDMETHOD.


  METHOD CARP.

    ev_no_carpim = iv_no_carp_1 * iv_no_carp_2.

  ENDMETHOD.


  METHOD CIKAR.

    ev_no_cikar = iv_no_cikar_1 - iv_no_cikar_2.

  ENDMETHOD.


  METHOD HESAPLA.

    IF iv_sembol = '+'.

      topla( EXPORTING iv_no_1 = iv_sayi_1
                       iv_no_2 = iv_sayi_2
             IMPORTING ev_no   = ev_sonuc ).

*      call method topla EXPORTING iv_no_1 = iv_sayi_1
*                                  iv_no_2 = iv_sayi_2
*                        IMPORTING ev_no   = ev_sonuc .

    ELSEIF iv_sembol = '-'.

      cikar(
        EXPORTING
          iv_no_cikar_1 = iv_sayi_1
          iv_no_cikar_2 = iv_sayi_2
        IMPORTING
          ev_no_cikar   = ev_sonuc ).

    ELSEIF iv_sembol = '/'.

      bol( EXPORTING  iv_no_bol_1         = iv_sayi_1
                      iv_no_bol_2         = iv_sayi_2
           IMPORTING  ev_no_bolum         = ev_sonuc
           EXCEPTIONS sifira_bolme_islemi = 1
           OTHERS                         = 2 ).

      IF sy-subrc = 1.
        MESSAGE 'Sifira bölme islemi' TYPE 'S' DISPLAY LIKE 'E'.
        ev_hata = abap_true.

        RETURN.
      ENDIF.

    ELSEIF iv_sembol = '*'.

      carp( EXPORTING iv_no_carp_1 = iv_sayi_1
                      iv_no_carp_2 = iv_sayi_2
            IMPORTING ev_no_carpim = ev_sonuc ).



    ENDIF.

  ENDMETHOD.


  METHOD TOPLA.

    ev_no = iv_no_1 + iv_no_2.

  ENDMETHOD.
ENDCLASS.
