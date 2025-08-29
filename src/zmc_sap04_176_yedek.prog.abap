*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_176
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_176_yedek.

*Alıştırma – 7: Yeni bir rapor oluşturun. İçerisinde 3 adet radiobutton olsun. Radibuttonlarin her birinin
*ismi bir db tablosu olsun. Radiobutonlar yardımıyla kullanıcıdan 1 adet db tablosu ismi alın. Yeni bir
*Class oluşturun ve 4 adet metot tanımlayın. (Tamamı Instance-Public) Gelen db tablosu ismini
*kullanarak sırasıyla veri çekin, fieldcatalog hazırlayın, Layout hazırlayın ve kullanıcı hangi tabloyu
*seçtiyse ekranda o tablonun ALV’sini gösterin.

PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgh RADIOBUTTON GROUP abc.

DATA: go_object TYPE REF TO zmc_cl_alistirma_7.

START-OF-SELECTION.

  CREATE OBJECT go_object
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflgh.

  IF p_scarr = abap_true.

    go_object->alv_scarr( ).

  ELSEIF p_spfli = abap_true.

    go_object->alv_spfli( ).

  ELSEIF p_sflgh = abap_true.

    go_object->alv_sflight( ).

  ENDIF.
