*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_224
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_224_yedek.

*Alıştırma – 5: Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. SFLIGHT tablosu ile ayni satır yapısına sahip yeni bir field sembol oluşturun ve field
*sembolü kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.

DATA: gt_sflight TYPE TABLE OF sflight.
DATA: gs_sflight TYPE sflight.

FIELD-SYMBOLS: <fs_sflight> TYPE sflight. "Sflight ile ayni satir yapisina sahip bir structure.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  LOOP AT gt_sflight ASSIGNING <fs_sflight>.

    "Write.

  ENDLOOP.
