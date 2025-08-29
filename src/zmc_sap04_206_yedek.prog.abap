*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_206
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_206_yedek.

*Alıştırma – 8: ZCM_TABLO_1 ve ZCM_TABLO_2 tablosuna yeni veriler ekleyin. Yeni eklenen satırların
*bazılarının ID hücresi ayni bazılarınınki ise farklı olsun. JOIN komutuyla her iki tablodan veri çekin. Elde
*ettiğiniz internal tabloyu Container ALV olarak ekranda gösterin. Ekranda ayrıca 2 Container ALV daha
*olsun. Bu 2 Container ALV’den birincisinde ZCM_TABLO_1 database tablosunda olan ancak JOIN
*komutundan dolayı ilk oluşturulan ALV’de gösterilemeyen satırlar yer alsın. Ayni şekilde ALV’den
*ikincisinde de ZCM_TABLO_2 database tablosunda olan ancak JOIN komutundan dolayı ilk oluşturulan
*ALV’de gösterilemeyen satırlar yer alsın. (Sonradan oluşturulan 2 ALV’de, her iki tabloda birbirine
*karşılık gelmeyen satırlar yer alacaktır.) Ekranda yeni bir buton oluşturun. Bu butona basıldığında izin
*kullandığı halde çalışan listesinde kaydı olmayan kişiler hakkında kullanıcıyı bilgilendirin.

TYPES: BEGIN OF gty_str,
         id         TYPE zmc_de_empid,
         name       TYPE zmc_de_name,
         sname      TYPE zmc_de_sname,
         start_date TYPE zmc_de_start_dt,
         end_date   TYPE zmc_de_end_dt,
       END OF gty_str.

DATA: go_cont1   TYPE REF TO cl_gui_custom_container,
      go_grid1   TYPE REF TO cl_gui_alv_grid,
      go_cont2   TYPE REF TO cl_gui_custom_container,
      go_grid2   TYPE REF TO cl_gui_alv_grid,
      go_cont3   TYPE REF TO cl_gui_custom_container,
      go_grid3   TYPE REF TO cl_gui_alv_grid,
      gt_table   TYPE TABLE OF gty_str,
      gs_table   TYPE  gty_str,
      gt_fcat    TYPE lvc_t_fcat,
      gt_fcat_2  TYPE lvc_t_fcat,
      gt_fcat_3  TYPE lvc_t_fcat,
      gs_fcat    TYPE lvc_s_fcat,
      gs_layout  TYPE lvc_s_layo,
      gt_table_2 TYPE TABLE OF zmc_sap04_emp,
      gt_table_3 TYPE TABLE OF zmc_sap04_hld.

START-OF-SELECTION.

  CALL SCREEN 0200.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'STATUS_206'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv_join.
  PERFORM alv_2.
  PERFORM alv_3.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
*  	WHEN .
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Form  ALV_JOIN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_join .

  SELECT zmc_sap04_emp~id, zmc_sap04_emp~name, zmc_sap04_emp~sname,
         zmc_sap04_hld~start_date, zmc_sap04_hld~end_date
    INTO TABLE @gt_table
    FROM zmc_sap04_emp
    INNER JOIN zmc_sap04_hld
    ON zmc_sap04_emp~id = zmc_sap04_hld~id.

  gs_fcat-fieldname = 'ID'.
  gs_fcat-scrtext_m = 'ID'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'NAME'.
  gs_fcat-scrtext_m = 'NAME'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'SNAME'.
  gs_fcat-scrtext_m = 'SNAME'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'START_DATE'.
  gs_fcat-scrtext_m = 'START_DATE'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.

  gs_fcat-fieldname = 'END_DATE'.
  gs_fcat-scrtext_m = 'END_DATE'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR: gs_fcat.


  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  IF go_grid1 IS INITIAL.

    CREATE OBJECT go_cont1
      EXPORTING
        container_name              = 'CONT_1'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_grid1
      EXPORTING
        i_parent          = go_cont1
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_grid1->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ELSE.


    go_grid1->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_2 .

  SELECT * FROM zmc_sap04_emp INTO TABLE gt_table_2.

  LOOP AT gt_table INTO gs_table.
    DELETE gt_table_2 WHERE id = gs_table-id.
  ENDLOOP.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_EMP'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_2
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  IF go_grid2 IS INITIAL.

    CREATE OBJECT go_cont2
      EXPORTING
        container_name              = 'CONT_2'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_grid2
      EXPORTING
        i_parent          = go_cont2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_grid2->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table_2
        it_fieldcatalog               = gt_fcat_2
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ELSE.


    go_grid2->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_3 .

  SELECT * FROM zmc_sap04_hld INTO TABLE gt_table_3.

  LOOP AT gt_table INTO gs_table.
    DELETE gt_table_3 WHERE id = gs_table-id.
  ENDLOOP.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_SAP04_HLD'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_3
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  IF go_grid3 IS INITIAL.

    CREATE OBJECT go_cont3
      EXPORTING
        container_name              = 'CONT_3'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    CREATE OBJECT go_grid3
      EXPORTING
        i_parent          = go_cont3
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    go_grid3->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_table_3
        it_fieldcatalog               = gt_fcat_3
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ELSE.


    go_grid3->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.
