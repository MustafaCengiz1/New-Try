*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_163
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_163_yedek.

PARAMETERS: p_agnum  TYPE s_agncynum,
            p_name   TYPE s_agncynam,
            p_street TYPE s_street,
            p_pbox   TYPE s_postbox,
            p_pcode  TYPE postcode,
            p_city   TYPE city,
            p_cntry	 TYPE s_country,
            p_region TYPE s_region,
            p_tphone TYPE s_phoneno,
            p_langu	 TYPE spras,
            p_curr   TYPE s_curr_ag,
            p_zebra  AS CHECKBOX,
            p_optim  AS CHECKBOX.

DATA: go_new_entry TYPE REF TO zmc_cl_sap04_new_entry,
      gt_fcat      TYPE slis_t_fieldcat_alv,
      gs_layout    TYPE slis_layout_alv,
      gt_stravelag TYPE zmc_tt_stravelag_2.

START-OF-SELECTION.

  CREATE OBJECT go_new_entry.

  go_new_entry->new_entry(
    EXPORTING
      iv_agencynum = p_agnum
      iv_name      = p_name
      iv_street    = p_street
      iv_postbox   = p_pbox
      iv_postcode  = p_pcode
      iv_city      = p_city
      iv_country   = p_cntry
      iv_region    = p_region
      iv_telephone = p_tphone
      iv_langu     = p_langu
      iv_currency  = p_curr ).

  go_new_entry->prep_data(
    IMPORTING
      et_stravelag = gt_stravelag ).

  go_new_entry->prep_fcat(
    IMPORTING
      et_fcat = gt_fcat ).

  go_new_entry->prep_layout(
    EXPORTING
      iv_zebra             = p_zebra
      iv_colwidth_optimize = p_optim
    IMPORTING
      es_layout            = gs_layout ).

  go_new_entry->display_data(
    EXPORTING
      is_layout    = gs_layout
      it_fcat      = gt_fcat
      it_stravelag = gt_stravelag ).




  "Satiri ekle
  "Datayi oku
  "Fcat olustur
  "Layout hazirla

  "ALV göster
