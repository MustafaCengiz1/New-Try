*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_202
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_202_yedek.

*Alıştırma – 4: Yeni bir rapor oluşturun ve kullanıcıdan tek bir hücre içerisinde bir şifre alın. Gelen verinin
*bir şifre olup olamayacağını kontrol edin. (Kurallar: içerisinde en az 1 sembol bulunacak. Boşluk
*olmayacak. En az 1 sayı, 1 büyük harf ve 1 de küçük harf bulunacak. En az 8 karakter olacak.)

PARAMETERS: p_sifre TYPE string LOWER CASE.

START-OF-SELECTION.

  IF p_sifre NA '!"§$%&/()=+*-'.
    MESSAGE 'Sembol eksik.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_sifre CA ' '.
    MESSAGE 'Bos karakter.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_sifre NA '1234567890'.
    MESSAGE 'Numara eksik.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_sifre NA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
    MESSAGE 'Büyük harf eksik.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_sifre NA 'abcdefghijklmnopqrstuvwxyz'.
    MESSAGE 'Kücük harf eksik.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF strlen( p_sifre ) < 8.
    MESSAGE 'En az 8 karakter!' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  MESSAGE 'Sifre basarili.' TYPE 'I'.
