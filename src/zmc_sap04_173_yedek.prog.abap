*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_173
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_173_yedek.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan select-options yardımıyla 1 adet CARRID alin.
*Ayrıca 3 adet checkbox olsun. Checkboxların isimleri sırasıyla “Scarr”, “Spfli” ve “Sflight” olsun. Yeni
*bir Class oluşturun. Class içerisinde 4 adet metot olsun. Birinci metot (Instance-Public), kullanıcının
*verdiği CARRID bilgisini ve seçilen checkbox bilgisini import etsin. Hangi checkboxlar seçildiyse o
*tablodan veri çeksin ve kullanıcıya export etsin. Her tablodan veri çekmek için ayrı (Instance-Protected)
*metotlar oluşturun ve ilk metot içerisinde kullanın.

DATA: gv_carrid  TYPE s_carr_id,
      go_object  TYPE REF TO zmc_cl_alistirma_4,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_carr FOR gv_carrid.

PARAMETERS: p_scarr AS CHECKBOX,
            p_spfli AS CHECKBOX,
            p_sflgt AS CHECKBOX.

START-OF-SELECTION.

  CREATE OBJECT go_object.

  go_object->get_data(
    EXPORTING
      it_carrid_range = so_carr[]
      iv_scarr        = p_scarr
      iv_spfli        = p_spfli
      iv_sflight      = p_sflgt
    IMPORTING
      et_scarr        = gt_scarr
      et_spfli        = gt_spfli
      et_sflight      = gt_sflight ).

  BREAK-POINT.
