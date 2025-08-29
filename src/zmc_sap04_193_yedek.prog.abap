*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_193
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_193_YEDEK.

DATA: gv_1 TYPE c LENGTH 3 VALUE '100',
      gv_2 TYPE c LENGTH 3 VALUE '10A',
      gv_3 TYPE c LENGTH 3 VALUE '200',
      gv_4 TYPE c LENGTH 3 VALUE '/$&',
      gv_5 TYPE string VALUE 'Tükenmez Kalem',
      gv_6 TYPE string VALUE 'Dolma Kalem',
      gv_7 TYPE string VALUE 'abap Programlama Dili Ögreniyorum.',
      gv_8 TYPE string VALUE 'wro',
      gv_9 TYPE string VALUE 'www.google.com'.


IF gv_1 CO '0123456789'.
  WRITE: 'Metamatiksel islem mümkün.'.
ELSE.
  WRITE: 'Metamatiksel islem mümkün degil.'.
ENDIF.

IF gv_2 CO '0123456789'.
  WRITE: 'Metamatiksel islem mümkün.'.
ELSE.
  WRITE: 'Metamatiksel islem mümkün degil.'.
ENDIF.

IF gv_3 CN '0123456789'.
  WRITE: / 'Metamatiksel islem mümkün degil.'.
ELSE.
  WRITE: / 'Metamatiksel islem mümkün.'.
ENDIF.

IF gv_4 CN '0123456789'.
  WRITE: / 'Metamatiksel islem mümkün degil.'.
ELSE.
  WRITE: / 'Metamatiksel islem mümkün.'.
ENDIF.

IF gv_5 CA 'üÜöÖğĞşŞıİçÇ'.
  WRITE: / 'Metin icerisinde Türkce harfler var.'.
ELSE.
  WRITE: / 'Metin icerisinde Türkce harfler yok.'.
ENDIF.

IF gv_6 NA 'üÜöÖğĞşŞıİçÇ'.
  WRITE: / 'Metin icerisinde Ingilizce olmayan harfler yok.'.
ELSE.
  WRITE: / 'Metin icerisinde Ingilizce olmayan harfler var.'.
ENDIF.

IF gv_7 CS gv_8.
  WRITE: / 'Sagdaki metin soldaki metnin icerisinde bulunuyor.'.
ELSE.
  WRITE: / 'Sagdaki metin soldaki metnin icerisinde bulunmuyor.'.
ENDIF.

IF gv_7 NS gv_8.
  WRITE: / 'Sagdaki metin soldaki metnin icerisinde bulunmuyor.'.
ELSE.
  WRITE: / 'Sagdaki metin soldaki metnin icerisinde bulunuyor.'.
ENDIF.

IF gv_9 CP '*.com'.
  WRITE: / '.com ile bitiyor.'.
ELSE.
  WRITE: / '.com ile bitmiyor.'.
ENDIF.

IF gv_9 CP 'www*'.
  WRITE: / 'www ile basliyor.'.
ELSE.
  WRITE: / 'www ile baslamiyor.'.
ENDIF.

IF gv_9 NP '*.com'.
  WRITE: / '.com ile bitmiyor.'.
ELSE.
  WRITE: / '.com ile bitiyor.'.
ENDIF.

IF gv_9 NP 'www*'.
  WRITE: / 'www ile baslamiyor.'.
ELSE.
  WRITE: / 'www ile basliyor.'.
ENDIF.


BREAK-POINT.
