*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_183
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMC_SAP04_183_YEDEK.

*Alıştırma – 2: SE11 işlem koduna giderek ilk alıştırmadaki hücre isimlerinin aynisini kullanarak yeni bir
*structure tanımlayın. Ancak DERSLER hücresi öğrencinin aldığı dersleri isimlerini ve 3 sınavın
*sonuçlarını kaydedebilecek şekilde olsun. Satırı örnek raporda kullanarak içerisine veri atin.

DATA: gs_str   TYPE ZMC_S_SAP04_DEEP_2,
      gt_table TYPE TABLE OF ZMC_S_SAP04_DEEP_2.

gs_str-ogrenci_no = '0001'.
gs_str-ad         = 'Ayse'.
gs_str-soyad      = 'Özlem'.

gs_str-adres-mahalle     = 'Aktürk Mahallesi'.
gs_str-adres-cadde       = 'Yunus Emre Cad'.
gs_str-adres-apartman_no = '25'.
gs_str-adres-daire_no    = '10'.

gs_str-dersler-ders1-ders_adi = 'Edebiyat'.
gs_str-dersler-ders1-sinav_1 = 50.
gs_str-dersler-ders1-sinav_2 = 90.
gs_str-dersler-ders1-sinav_3 = 80.


gs_str-dersler-ders2-ders_adi = 'Ingilizce'.
gs_str-dersler-ders2-sinav_1 = 80.
gs_str-dersler-ders2-sinav_2 = 40.
gs_str-dersler-ders2-sinav_3 = 60.

gs_str-dersler-ders3-ders_adi = 'Matematik'.
gs_str-dersler-ders3-sinav_1 = 80.
gs_str-dersler-ders3-sinav_2 = 40.
gs_str-dersler-ders3-sinav_3 = 60.


gs_str-dersler-ders4-ders_adi = 'Fizik'.
gs_str-dersler-ders4-sinav_1 = 80.
gs_str-dersler-ders4-sinav_2 = 40.
gs_str-dersler-ders4-sinav_3 = 60.

gs_str-dersler-ders5-ders_adi = 'Cografya'.
gs_str-dersler-ders5-sinav_1 = 80.
gs_str-dersler-ders5-sinav_2 = 40.
gs_str-dersler-ders5-sinav_3 = 60.

APPEND gs_str TO gt_table.
CLEAR: gs_str.

gs_str-ogrenci_no = '0002'.
gs_str-ad         = 'Mehmet'.
gs_str-soyad      = 'Özlem'.

gs_str-adres-mahalle     = 'Aktürk Mahallesi'.
gs_str-adres-cadde       = 'Yunus Emre Cad'.
gs_str-adres-apartman_no = '25'.
gs_str-adres-daire_no    = '10'.

gs_str-dersler-ders1-ders_adi = 'Edebiyat'.
gs_str-dersler-ders1-sinav_1 = 50.
gs_str-dersler-ders1-sinav_2 = 90.
gs_str-dersler-ders1-sinav_3 = 80.


gs_str-dersler-ders2-ders_adi = 'Ingilizce'.
gs_str-dersler-ders2-sinav_1 = 80.
gs_str-dersler-ders2-sinav_2 = 40.
gs_str-dersler-ders2-sinav_3 = 60.

gs_str-dersler-ders3-ders_adi = 'Matematik'.
gs_str-dersler-ders3-sinav_1 = 80.
gs_str-dersler-ders3-sinav_2 = 40.
gs_str-dersler-ders3-sinav_3 = 60.


gs_str-dersler-ders4-ders_adi = 'Fizik'.
gs_str-dersler-ders4-sinav_1 = 80.
gs_str-dersler-ders4-sinav_2 = 40.
gs_str-dersler-ders4-sinav_3 = 60.

gs_str-dersler-ders5-ders_adi = 'Cografya'.
gs_str-dersler-ders5-sinav_1 = 80.
gs_str-dersler-ders5-sinav_2 = 40.
gs_str-dersler-ders5-sinav_3 = 60.

APPEND gs_str TO gt_table.
CLEAR: gs_str.


DATA: gs_str_2 TYPE ZMC_S_SAP04_DEEP_NEW_2,
      gs_dersler TYPE ZMC_S_DERS_SONUC.

gs_str_2-ogrenci_no = '0002'.
gs_str_2-ad         = 'Mehmet'.
gs_str_2-soyad      = 'Özlem'.

gs_str_2-adres-mahalle     = 'Aktürk Mahallesi'.
gs_str_2-adres-cadde       = 'Yunus Emre Cad'.
gs_str_2-adres-apartman_no = '25'.
gs_str_2-adres-daire_no    = '10'.

gs_dersler-ders_adi = 'Matematik'.
gs_dersler-sinav_1 = 100.
gs_dersler-sinav_2 = 90.
gs_dersler-sinav_3 = 80.

APPEND gs_dersler TO gs_str_2-dersler.

gs_dersler-ders_adi = 'FIZIK'.
gs_dersler-sinav_1 = 100.
gs_dersler-sinav_2 = 90.
gs_dersler-sinav_3 = 80.

APPEND gs_dersler TO gs_str_2-dersler.



BREAK-POINT.
