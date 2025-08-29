*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_207
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_207_yedek MESSAGE-ID ZMC_SAP04_1.

PARAMETERS: p_basari RADIOBUTTON GROUP abc,
            p_hata   RADIOBUTTON GROUP abc,
            p_uyari  RADIOBUTTON GROUP abc,
            p_bilgi  RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  IF p_basari = abap_true.

*    MESSAGE s000(zmc_sap04_1).
*    MESSAGE s001(zmc_sap04_1) WITH '1' 'basari'.
    MESSAGE s001 WITH '1' 'basari'.

  ELSEIF p_hata = abap_true.

*    MESSAGE e000(zmc_sap04_1).
*    MESSAGE e001(zmc_sap04_1) WITH '2' 'hata'.
    MESSAGE e001 WITH '2' 'hata'.

  ELSEIF p_uyari = abap_true.

*    MESSAGE w000(zmc_sap04_1).
*    MESSAGE w001(zmc_sap04_1) WITH '3' 'uyari'.
    MESSAGE w001 WITH '3' 'uyari'.

  ELSEIF p_bilgi = abap_true.

*    MESSAGE i000(zmc_sap04_1).
    MESSAGE i001 WITH '4' 'bilgi'.

  ENDIF.
