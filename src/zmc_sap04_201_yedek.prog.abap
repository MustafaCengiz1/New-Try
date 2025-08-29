*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_201_yedek.

*Alıştırma – 3: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde bir e-mail adresi alın.
*Gelen verinin bir e-mail adresi olup olmadığını kontrol edin. (Kurallar: içerisinde “@” sembolü
*bulunacak. @ sembolünün sağı ve solu bos olmayacak. İngilizce olmayan karakter içermeyecek. Sonu
*“.com” ile bitecek.)

PARAMETERS: p_email TYPE string.

DATA: gv_email TYPE string,
      gv_1     TYPE string,
      gv_2     TYPE string.

START-OF-SELECTION.

  IF p_email NA '@'.
    MESSAGE 'Email adresinde @ sembolü bulunmuyor' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  gv_email = p_email.

  DO 2 TIMES.

    SPLIT gv_email AT '@' INTO gv_1 gv_2.

    IF gv_2 IS NOT INITIAL.
      gv_email = gv_2.
    ELSE.
      IF sy-index > 2.
        MESSAGE 'Birden fazla @ sembolü' TYPE 'E'.
      ENDIF.
      EXIT.
    ENDIF.

  ENDDO.

  FIND '@' IN gv_email.
  IF sy-subrc IS INITIAL.
    MESSAGE 'Birden fazla @ sembolü' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.


  IF p_email CA ' '.
    MESSAGE 'Email adresinde bosluk bulunuyor' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_email CA 'üÜöÖğĞşŞıİ'.
    MESSAGE 'Email adresinde ingilizce olmayan karakterler bulunuyor' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_email NP '*.com'.
    MESSAGE 'Email .com ile bitmek zorunda.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  MESSAGE 'E-mail adresi kurallara uygun.' TYPE 'I'.
