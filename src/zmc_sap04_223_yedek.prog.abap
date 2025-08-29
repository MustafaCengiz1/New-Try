*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_223
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_223_yedek.

*Alıştırma – 4: Yeni bir rapor oluşturun. İçinde C, N, D, T, I, P ve String tipinde 7 farklı değişken
*tanımlayın. Daha sonra TYPE ANY komutu yardımıyla yeni bir field sembol tanımlayın. Değişkenleri
*sırayla field sembole assign edin ve ekrana yazdırın. Her yazdırma işleminden sonra unassign komutu
*ile field sembolü kendisine hiçbir değişken atanmamış hale getirin.

DATA: gv_text     TYPE c LENGTH 20 VALUE 'Ayrıca her bir deği',
      gv_string   TYPE string VALUE 'field sembollere assign edin ve ekrana yazdırın.',
      gv_number   TYPE i VALUE 100,
      gv_numeric  TYPE n LENGTH 5 VALUE 'A100',
      gv_decimals TYPE p DECIMALS 2 VALUE '0.7',
      gv_date     TYPE datum VALUE '20250815',
      gv_time     TYPE uzeit VALUE '192800'.

FIELD-SYMBOLS: <fs_1>.

START-OF-SELECTION.

  ASSIGN gv_text TO <fs_1>.
  ASSIGN gv_string TO <fs_1>.
  ASSIGN gv_number TO <fs_1>.
  ASSIGN gv_numeric TO <fs_1>.
  ASSIGN gv_decimals TO <fs_1>.
  ASSIGN gv_date TO <fs_1>.
  ASSIGN gv_time TO <fs_1>.

  BREAK-POINT.
