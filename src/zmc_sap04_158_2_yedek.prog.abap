*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_158_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_158_2_yedek.

DATA: gt_scarr_1 TYPE TABLE OF scarr, "Scarr ile ayni yapida bir int tablo.
      gt_scarr_2 TYPE zmc_test_tt_scarr. "Scarr ile ayni yapida bir int tablo.
