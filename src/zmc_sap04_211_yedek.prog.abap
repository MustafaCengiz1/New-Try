*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_211
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_211_yedek.

PARAMETERS: p_table TYPE tabname,
            p_carrid TYPE s_carr_id.

START-OF-SELECTION.

CASE p_table.
  WHEN 'SCARR'.
    SUBMIT zmc_sap04_212 WITH p_carr1 = p_carrid AND RETURN.
  WHEN 'SPFLI'.
    SUBMIT zmc_sap04_213 WITH p_carr2 = p_carrid AND RETURN.
  WHEN 'SFLIGHT'.
    SUBMIT zmc_sap04_214 WITH p_carr3 = p_carrid AND RETURN.
ENDCASE.

MESSAGE 'Submit komutu basariyla kullanildi' TYPE 'S'.
