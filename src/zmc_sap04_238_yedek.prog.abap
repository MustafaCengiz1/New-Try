*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_238
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_238_YEDEK.

PARAMETERS: p_day TYPE i.

DATA: gv_day TYPE string.
DATA: gv_day_2 TYPE string.

START-OF-SELECTION.

CASE p_day.
  WHEN 1.
    gv_day = 'Ptesi'.
  WHEN 2.
    gv_day = 'Sali'.
  WHEN 3.
    gv_day = 'Carsamba'.
  WHEN 4.
    gv_day = 'Persembe'.
  WHEN 5.
    gv_day = 'Cuma'.
  WHEN 6.
    gv_day = 'Cumartesi'.
  WHEN 7.
    gv_day = 'Pazar'.
  WHEN OTHERS.
    gv_day = 'Gecersiz gün sayisi'.
ENDCASE.


gv_day_2 = COND #( WHEN p_day = 1 THEN 'Ptesi'
                   WHEN p_day = 2 THEN 'Sali'
                   WHEN p_day = 3 THEN 'Carsamba'
                   WHEN p_day = 4 THEN 'Persembe'
                   WHEN p_day = 5 THEN 'Cuma'
                   WHEN p_day = 6 THEN 'Cumartesi'
                   WHEN p_day = 7 THEN 'Pazar'
                   ELSE 'Gecersiz gün sayisi' ).

BREAK-POINT.
