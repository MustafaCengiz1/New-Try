*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_121
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_121_yedek.

INCLUDE ZMC_SAP04_121_TOP_YEDEK.
*INCLUDE zmc_sap04_121_top. "Selection screen tanimlamalari ve diger bütün degisken tanimlamalari.
INCLUDE ZMC_SAP04_121_F01_YEDEK.
*INCLUDE zmc_sap04_121_f01.


START-OF-SELECTION.

  PERFORM sum.
  PERFORM sub.
