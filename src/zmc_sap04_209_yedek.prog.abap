*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_207
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_209_yedek.

PARAMETERS: p_basari RADIOBUTTON GROUP abc,
            p_hata   RADIOBUTTON GROUP abc,
            p_uyari  RADIOBUTTON GROUP abc,
            p_bilgi  RADIOBUTTON GROUP abc.



START-OF-SELECTION.

  CALL FUNCTION 'ZMC_FM_SAP04_18'
    EXPORTING
      iv_success = p_basari
      iv_error   = p_hata
      iv_warning = p_uyari
      iv_info    = p_bilgi.
