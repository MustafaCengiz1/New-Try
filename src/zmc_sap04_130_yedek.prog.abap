*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_130
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_130_yedek.

*Alıştırma – 5: Yeni bir rapor oluşturun ve kullanıcıdan 4 adet parametre alin. (2 adet BOOKID (SBOOK
*tablosu BOOKID kolonu), 1 adet Radiobutton (Eşittir isminde), 1 adet Radiobutton (Arasında isminde)).
*Parametrelerden gelen veriyi Type Range komutu kullanarak oluşturacağınız Select-Options yapılarına
*aktarın ve SBOOK tablosundan satırları okuyarak ekrana yazdırın.

PARAMETERS: p_bkid_1 TYPE s_book_id,
            p_bkid_2 TYPE s_book_id,
            p_eq     RADIOBUTTON GROUP xyz,
            p_bt     RADIOBUTTON GROUP xyz.

TYPES: BEGIN OF gty_str,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_book_id,
         high   TYPE s_book_id,
       END OF gty_str.

DATA: gs_sbook_so TYPE gty_str,
      gt_sbook_so TYPE RANGE OF s_book_id,
      gt_sbook    TYPE TABLE OF sbook.

START-OF-SELECTION.

  IF p_eq = abap_true.

    gs_sbook_so-sign   = 'I'.
    gs_sbook_so-option = 'EQ'.
    gs_sbook_so-low    = p_bkid_1.

    APPEND gs_sbook_so TO gt_sbook_so.
    CLEAR: gs_sbook_so.

    gs_sbook_so-sign   = 'I'.
    gs_sbook_so-option = 'EQ'.
    gs_sbook_so-low    = p_bkid_2.

    APPEND gs_sbook_so TO gt_sbook_so.
    CLEAR: gs_sbook_so.

  ELSE.

    gs_sbook_so-sign   = 'I'.
    gs_sbook_so-option = 'BT'.
    gs_sbook_so-low    = p_bkid_1.
    gs_sbook_so-high   = p_bkid_2.

    APPEND gs_sbook_so TO gt_sbook_so.
    CLEAR: gs_sbook_so.

  ENDIF.

  SELECT * FROM sbook
    INTO TABLE gt_sbook
    WHERE bookid IN gt_sbook_so.

  BREAK-POINT.
