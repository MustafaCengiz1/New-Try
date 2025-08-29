*&---------------------------------------------------------------------*
*&  Include           ZMC_SAP04_121_F01
*&---------------------------------------------------------------------*

FORM sum.

  DATA: lv_result_sum TYPE i.
  DATA: lv_result_sum_2 TYPE i.

  lv_result_sum = gv_1 + gv_2.

  lv_result_sum_2 = lv_result_sum * 2.

  PERFORM display USING lv_result_sum lv_result_sum_2 .

ENDFORM.


FORM display USING p_display_result p_display_result_2.
  WRITE: p_display_result.
ENDFORM.


FORM sub.

  DATA: lv_result_sub TYPE i.
  DATA: lv_result_sub_2 TYPE i.

  lv_result_sub = gv_1 - gv_2.

  lv_result_sub_2 = lv_result_sub / 2.

  PERFORM display USING lv_result_sub lv_result_sub_2.

ENDFORM.
