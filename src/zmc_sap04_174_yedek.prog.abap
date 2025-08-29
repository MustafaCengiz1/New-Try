*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_174
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_174_YEDEK.

*Alıştırma – 5: Dördüncü alıştırmanın aynisini yapın ancak birinci metot, istenen tablolardan veri
*çektikten sonra bu tabloları export etmesin. Bu veriyi Class içerisinde oluşturulacak instance-public
*attributelar içerisine kaydetsin. Program içerisinde bu attributeları kullanarak veriyi ekrana yazdırın.

DATA: gv_carrid  TYPE s_carr_id,
      go_object  TYPE REF TO zmc_cl_alistirma_5,
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
      iv_sflight      = p_sflgt ).

  gt_scarr   =  go_object->mt_scarr.
  gt_spfli   =  go_object->mt_spfli.
  gt_sflight =  go_object->mt_sflight.

  BREAK-POINT.
