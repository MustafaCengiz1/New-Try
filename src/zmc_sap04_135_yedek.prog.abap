*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_135
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_135_YEDEK.

*Alıştırma – 10: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet parametre alin. (1 adet sayı, 2 adet
*radiobutton). Radiobuttonlar “Karesi” ve “Küpü” seklinde isimlendirilsin. Kullanıcı hangi radiobuttonu
*seçtiyse sonucu hesaplayıp ekrana yazdırın. Gelen sayının karesini ve küpünü bulma işlemlerini ayrı
*ayrı performlar içerisinde gerçekleştirin.

PARAMETERS: p_number TYPE i,
            p_2 RADIOBUTTON GROUP abc,
            p_3 RADIOBUTTON GROUP abc.

DATA: gv_number TYPE i.

START-OF-SELECTION.

IF p_2 = abap_true.
  PERFORM square.
ELSE.
  PERFORM cube.
ENDIF.

WRITE: gv_number.


FORM square.
  gv_number = p_number * p_number.
ENDFORM.


FORM cube .
  gv_number = p_number * p_number * p_number.
ENDFORM.
