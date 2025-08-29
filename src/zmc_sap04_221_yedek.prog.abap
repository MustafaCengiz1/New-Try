*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_221
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_221_YEDEK.

*Alıştırma – 2: Yeni bir rapor oluşturun. Raporda 2 adet radiobutton 2 adet secim ekranı olsun. Birinci
*radiobutton seçilirse birinci seçim ekranı görünür hale gelsin. İkinci radiobutton seçilirse ikinci seçim
*ekranı görünür hale gelsin. Birinci secim ekranı kendinize ait STRAVELAG tablosundaki ilgili satirin
*şirket ismini değiştirebilmek için kullanıcıdan ID ve yeni isim alsın. İkinci secim ekranı ise ayni tablodaki
*ilgili satirin adres hücresini (STREET kolonu) değiştirebilmek için kullanıcıdan ID ve yeni adres alsın.
*Secim ekranından gelen veriye göre rapor içinde ilgili programı SUBMIT WITH komutu yardımıyla
*çağırın ve AND RETURN komutu ile geri dönün.

PARAMETERS: p_1 RADIOBUTTON GROUP abc USER-COMMAND cmd1 DEFAULT 'X',
            p_2 RADIOBUTTON GROUP abc.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE text-001 NO INTERVALS.
  PARAMETERS: p_agnum TYPE s_agncynum.
SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE text-002 NO INTERVALS.
  PARAMETERS: p_name TYPE s_agncynam MODIF ID sc1.
SELECTION-SCREEN END OF BLOCK a2.


SELECTION-SCREEN BEGIN OF BLOCK a3 WITH FRAME TITLE text-002 NO INTERVALS.
  PARAMETERS: p_street TYPE s_street MODIF ID sc2.
SELECTION-SCREEN END OF BLOCK a3.


at SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_1 = abap_true.
      IF screen-group1 = 'SC1'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.
      IF screen-group1 = 'SC2'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.
  ENDLOOP.

START-OF-SELECTION.

  IF p_1 = abap_true.
    "Submit komutuyla kullanilacak ve STREET hücresinde degisiklik yapacak bir rapor olusturun.
  ELSE.

    SUBMIT ZMC_SAP04_210 WITH p_agnum = p_agnum WITH p_name = p_name AND RETURN.
    MESSAGE 'Isim degisikligi ile ilgili log kayitlarina bakiniz' TYPE 'I'.

  ENDIF.
