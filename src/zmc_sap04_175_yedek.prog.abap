*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_175
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_175_yedek.

*Alıştırma – 6: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet geçmiş tarih alın. Yeni bir Class oluşturun.
*Class içerisinde 3 adet metot olsun. (İlki Statuc-Public, diğerleri Static-Protected). İkinci metot verilen
*tarihteki günü bulsun. (Metot içerisinde GET_WEEKDAY_NAME veya DATE_COMPUTE_DAY
*fonksiyonlarından bir tanesini kullanabilirsiniz.) Üçüncü metot ise verilen tarih ile bugün arasında kaç
*gün olduğunu bulsun. Birinci metot, ikinci ve üçüncü metotlardan gelen veriyi kullanarak kullanıcıya
*anlamı bir text export etsin. (Örnek: 01.01.2024 tarihi girildi. Ekranda “Girilen 01.01.2024 Pazartesi ile
*bugün arasında 5 gün bulunmaktadır.”)

PARAMETERS: p_date TYPE sy-datum.

DATA: gv_msg_text TYPE string.

START-OF-SELECTION.

  zmc_cl_alistirma_6=>info(
    EXPORTING
      iv_date     = p_date
    IMPORTING
      ev_msg_text = gv_msg_text ).

MESSAGE gv_msg_text TYPE 'I'.
