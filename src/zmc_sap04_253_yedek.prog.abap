*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_253
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_253_YEDEK.

*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan sadece 1 sayı alın. Rapor içinde SPFLI
*tablosundan bütün satırları okuyun. Elde edilen internal tabloda bulunan ve kullanıcının girdiği sayı ile
*ayni index numarasına sahip satiri okuyun ve ekrana yazdırın. Bunu yaparken Abap 7.40 ile gelen yeni
*internal tablo okuma yöntemini kullanın.

PARAMETERS: p_index TYPE i.

START-OF-SELECTION.

select * FROM spfli INTO TABLE @DATA(gt_spfli).

READ TABLE gt_spfli INTO DATA(gs_spfli) INDEX p_index.

IF sy-subrc IS INITIAL.
  BREAK-POINT.
ENDIF.

DATA(gs_spfli_2) = gt_spfli[ p_index ].

BREAK-POINT.
