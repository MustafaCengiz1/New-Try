*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_222
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_222_yedek.

*Alıştırma – 3: Yeni bir rapor oluşturun. İçinde C, N, D, T, I, P ve String tipinde 7 farklı değişken
*tanımlayın. Ayrıca her bir değişken için ayni tipte birer tane field sembol tanımlayın. Değişkenleri ilgili
*field sembollere assign edin ve ekrana yazdırın.

DATA: gv_text     TYPE c LENGTH 20 VALUE 'Ayrıca her bir deği',
      gv_string   TYPE string VALUE 'field sembollere assign edin ve ekrana yazdırın.',
      gv_number   TYPE i VALUE 100,
      gv_numeric  TYPE n LENGTH 5 VALUE 'A100',
      gv_decimals TYPE p DECIMALS 2 VALUE '0.7',
      gv_date     TYPE datum VALUE '20250815',
      gv_time     TYPE uzeit VALUE '192800'.

FIELD-SYMBOLS: <fs_text>     TYPE c,
               <fs_string>   TYPE string,
               <fs_number>   TYPE i,
               <fs_numeric>  TYPE n,
               <fs_decimals> TYPE p,
               <fs_date>     TYPE datum,
               <fs_time>     TYPE uzeit.

ASSIGN gv_text to <fs_text>.
ASSIGN gv_string to <fs_string>.
ASSIGN gv_number to <fs_number>.
ASSIGN gv_numeric to <fs_numeric>.
ASSIGN gv_decimals to <fs_decimals>.
ASSIGN gv_date to <fs_date>.
ASSIGN gv_time to <fs_time>.

BREAK-POINT.
