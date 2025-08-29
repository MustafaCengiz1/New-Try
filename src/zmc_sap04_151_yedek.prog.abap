*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_151
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_151_YEDEK.

*Alıştırma – 1: Yeni bir database tablosu oluşturun. (Örneğin ZCM_STRAVELAG) Satir yapısı STRAVELAG
*database tablosu ile tamamen ayni olsun. Daha sonra yeni bir rapor oluşturun ve STRAVELAG
*tablosundaki bütün bilgileri okuyup oluşturduğunuz yeni database tablosu içine kaydedin.

DATA: gt_stravelag TYPE TABLE OF stravelag.

START-OF-SELECTION.

select * FROM stravelag
  INTO TABLE gt_stravelag.

*MODIFY ZMC_SAP04_STRAV FROM TABLE gt_stravelag.
