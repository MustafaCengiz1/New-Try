*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_255
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_255_yedek.

*Alıştırma – 7: Yeni bir rapor oluşturun. Raporda 1 adet tip tanımlaması yapın ve tip içerisinde
*STRAVELAG tablosundan herhangi 5 kolon bulunsun. Inline declaration kullanarak bu tip tanımlaması
*ve VALUE komutu yardımıyla bir structure tanımlayın ve içerisini istediğiniz değerlerle doldurun. Ayni
*tip tanımlamasını kullanarak bir table type tanımlayın. Inline declaration kullanarak table type ve
*VALUE komutu yardımıyla yeni bir internal tablo oluşturun ve içine 3 adet satır ekleyin.


START-OF-SELECTION.

  DATA(gs_str) = VALUE zmc_sap04_7( agencynum = '00000055'
                                    name      = 'FLY HIGH'
                                    postbox   = 'PBX 1'
                                    postcode  = '12345'
                                    street    = 'Street 10' ).

  DATA(gt_table) = VALUE zmc_tt_sap04_7( ( agencynum = '00000055'
                                           name      = 'FLY HIGH'
                                           postbox   = 'PBX 1'
                                           postcode  = '12345'
                                           street    = 'Street 10' )

                                         ( agencynum = '00000056'
                                           name      = 'FLY HIGH'
                                           postbox   = 'PBX 1'
                                           postcode  = '12345'
                                           street    = 'Street 10' ) ).
