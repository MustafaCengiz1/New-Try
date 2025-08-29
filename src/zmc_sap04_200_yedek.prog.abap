*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_200
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_200_yedek.

*Alıştırma – 2: Kendinize ait STRAVELAG database tablosunun (Ör: ZCM_STRAVELAG) bütün kayıtlarını
*silin ve MANDT kolonundan hemen sonra gelecek şekilde yeni bir ID kolonu oluşturun. (Yeni bir Key
*Field) SNRO işlem kodunu kullanarak bir sayı aralığı objesi oluşturun. (4 haneli sayılar üretecek.) Yeni
*bir rapor oluşturun ve STRAVELAG tablosunun tüm satırlarını okuyun. Her satirin yeni ID hücresi için
*NUMBER_GET_NEXT fonksiyonu ve oluşturduğunuz sayı aralığı objesini kullanarak bir ID üretin ve ID
*hücresi içerisine kaydedin. Elde ettiğiniz satırı kendinize ait database tablosuna kaydedin.

DATA: gt_stravelag TYPE TABLE OF zmc_sap04_strav,
      gs_stravelag TYPE zmc_sap04_strav.

START-OF-SELECTION.

  SELECT * FROM stravelag
    INTO CORRESPONDING FIELDS OF TABLE gt_stravelag.


  LOOP AT gt_stravelag INTO gs_stravelag.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZMC_NR_ID'
      IMPORTING
        number                  = gs_stravelag-id
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE 'Sayi araligi obj hatasi' TYPE 'E'.
    ENDIF.

    MODIFY gt_stravelag FROM gs_stravelag TRANSPORTING id WHERE agencynum = gs_stravelag-agencynum.

  ENDLOOP.

  MODIFY ZMC_SAP04_STRAV FROM TABLE gt_stravelag.

  IF sy-subrc IS INITIAL.
    MESSAGE 'ID kolonu basariyla dolduruldu.' TYPE 'S'.
  ENDIF.

*  BREAK-POINT.
