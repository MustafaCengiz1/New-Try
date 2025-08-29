*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_251
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_251_yedek.

*Alıştırma – 3: Yeni bir rapor oluşturun. Raporda 5 hücreli bir internal tablo tanımlayın. (Örnek:
*PROJE_ID, PROJE_AD, PROJE_SORUMLUSU, PROJE_PLAN_GUN, PROJE_DEPARTMAN). APPEND
*INITIAL LINE TO komutunu kullanarak bu internal tabloya 5 adet yeni satir ekleyin. Daha sonra internal
*tabloda loop edin ve PROJE_PLAN_GUN kolonundaki her hücreye 5 ekleyin. Raporda inline declaration
*ile tanımlanmış field sembol kullanın.

TYPES: BEGIN OF gty_str,
         proje_id        TYPE n LENGTH 4,
         proje_ad        TYPE c LENGTH 20,
         proje_sorumlusu TYPE c LENGTH 20,
         proje_plan_gun  TYPE n LENGTH 3,
         proje_departman TYPE c LENGTH 20,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str.

START-OF-SELECTION.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).
  <gs_str>-proje_id        = 1000.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 5.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1001.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 10.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1002.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 15.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1003.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 20.
  <gs_str>-proje_departman = 'Departman A'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-proje_id        = 1004.
  <gs_str>-proje_ad        = 'Depo Proje 1'.
  <gs_str>-proje_sorumlusu = 'Mehmet Öztürk'.
  <gs_str>-proje_plan_gun  = 25.
  <gs_str>-proje_departman = 'Departman A'.

  LOOP AT gt_table ASSIGNING FIELD-SYMBOL(<gs_str_2>).

    ADD 5 TO <gs_str_2>-proje_plan_gun.

  ENDLOOP.

  BREAK-POINT.
