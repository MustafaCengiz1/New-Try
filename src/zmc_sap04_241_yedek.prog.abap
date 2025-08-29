*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_241
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_241_YEDEK.

DATA: gv_text TYPE string.

START-OF-SELECTION.

CONCATENATE 'TEXT_1' 'TEXT_2' INTO gv_text SEPARATED BY space.

DATA(gv_text_2) = |TEXT_1| & | | & |TEXT_2|.

DATA(gv_1) = 'Deneme 1'.
DATA(gv_2) = 'Deneme 2'.

DATA(gv_text_3) = | { cond string( WHEN sy-datum = '20250821' THEN gv_2 ELSE gv_1  ) }| & | | & |{ gv_2 }|.


BREAK-POINT.
