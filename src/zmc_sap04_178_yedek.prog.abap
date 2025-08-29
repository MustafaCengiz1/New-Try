*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_178
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_178_YEDEK.

DATA: gs_str TYPE ZMC_S_SAP04_DEEP.

START-OF-SELECTION.


gs_str-id    = '123'.
gs_str-ad    = 'Ali'.
gs_str-soyad = 'Öztürk'.

gs_str-adres-adres_mah   = 'Cumhuriyet'.
gs_str-adres-adres_sokak = 'Nese Sokak'.
gs_str-adres-adres_ev_no = '20'.

gs_str-gsm   = '124121241'.

BREAK-POINT.
