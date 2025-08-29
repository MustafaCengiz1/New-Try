*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_225
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_225_yedek.

*Alıştırma – 6: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. TYPE ANY TABLE komutu yardımıyla yeni bir field sembol oluşturun ve field sembolü
*kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.

DATA: gt_sflight TYPE TABLE OF sflight.

FIELD-SYMBOLS: <fs_table_sflight> TYPE ANY TABLE,
               <fs_structure_sflight> TYPE any. "TYPE sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_table_sflight>.

  LOOP AT <fs_table_sflight> ASSIGNING <fs_structure_sflight>.

    "WRITE.

  ENDLOOP.
