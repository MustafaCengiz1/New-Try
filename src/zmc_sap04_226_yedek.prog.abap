*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_226
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_226_yedek.

*Alıştırma – 7: Yeni bir rapor oluşturun. Raporda 3 adet radiobutton olsun. Rapor içinde STRAVELAG
*tablosunun tüm satırlarını okuyup internal tablo içine kaydedin. Kullanıcı ilk radiobuttonu seçerse
*tablonun ilk 3 kolonunu, ikinci radiobuttonu seçerse ilk 6 kolonunu, üçüncü radiobuttonu seçerse
*bütün kolonları ekrana yazdırın. Loop işlemini field sembol kullanarak yapın. Field sembol TYPE ANY
*TABLE komutu yardımıyla tanımlanmış olsun.

DATA: gt_stravelag TYPE TABLE OF stravelag,
      gv_number    TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_str>   TYPE any,
               <fs_field> TYPE any.

PARAMETERS: p_3     RADIOBUTTON GROUP abc,
            p_6     RADIOBUTTON GROUP abc,
            p_hepsi RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_stravelag.

  ASSIGN gt_stravelag TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.


    DO.

      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str> TO <fs_field>.
      IF sy-subrc IS INITIAL AND <fs_field> IS ASSIGNED.
        WRITE: <fs_field>.
        UNASSIGN: <fs_field>.
      ELSE.
        EXIT.
      ENDIF.

      ADD 1 TO gv_number.

      IF p_3 = abap_true.

        IF gv_number = 4.
          EXIT.
        ENDIF.

      ELSEIF p_6 = abap_true.

        IF gv_number = 7.
          EXIT.
        ENDIF.
      ENDIF.

    ENDDO.

    gv_number = 1.
    SKIP.

  ENDLOOP.
