*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_234
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_234_yedek.

TYPES: BEGIN OF gty_str,
         id    TYPE n LENGTH 6,
         ad    TYPE c LENGTH 20,
         soyad TYPE c LENGTH 20,
         adres TYPE c LENGTH 60,
       END OF gty_str.

TYPES: gtt_table TYPE TABLE OF gty_str WITH NON-UNIQUE KEY id.

DATA: gt_table TYPE TABLE OF gty_str,
      gs_str TYPE gty_str,
      gs_str_2 TYPE gty_str.

START-OF-SELECTION.

  gs_str-id    = 123456.
  gs_str-ad    = 'Mehmet'.
  gs_str-soyad = 'Öztürk'.
  gs_str-adres = 'Örnek Adres satiri'.

  gs_str_2 = VALUE #( id = 123456
                      ad = 'Mehmet'
                      soyad = 'Öztürk'
                      adres = 'Örnek Adres satiri' ).

  gt_table = VALUE #( ( id = 123456 ad = 'Mehmet' soyad = 'Öztürk' adres = 'Örnek Adres satiri' )
                      ( id = 123457 ad = 'Ahmet'  soyad = 'Öztürk' adres = 'Örnek Adres satiri' )
                      ( id = 123458 ad = 'Nese'   soyad = 'Öztürk' adres = 'Örnek Adres satiri' ) ).

  DATA(gs_str_3) = VALUE gty_str( id = 123456
                                  ad = 'Mehmet'
                                  soyad = 'Öztürk'
                                  adres = 'Örnek Adres satiri').

  DATA(gt_table_2) = VALUE gtt_table( ( id = 123456 ad = 'Mehmet' soyad = 'Öztürk' adres = 'Örnek Adres satiri' )
                                      ( id = 123457 ad = 'Ahmet'  soyad = 'Öztürk' adres = 'Örnek Adres satiri' )
                                      ( id = 123458 ad = 'Nese'   soyad = 'Öztürk' adres = 'Örnek Adres satiri' ) ).

  BREAK-POINT.
