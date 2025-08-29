*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_182
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_182_yedek.

*Alıştırma – 1: SE11 işlem koduna giderek yeni bir structure tanımlayın. Hücre isimleri sırasıyla
*OGRENCI_NO, AD, SOYAD, ADRES, DERSLER. ADRES ve DERSLER hücreleri kendi başına birer structure
*olsun. ADRES satırı öğrencinin adres bilgilerini, DERSLER satırı ise aldığı derslerin isimlerini
*kaydedebilecek şekilde olsun. Satiri örnek raporda kullanarak içerisine veri atin.

DATA: gs_str   TYPE zmc_s_sap04_deep_new,
      gt_table TYPE TABLE OF zmc_s_sap04_deep_new.

gs_str-ogrenci_no = '0001'.
gs_str-ad         = 'Ayse'.
gs_str-soyad      = 'Özlem'.

gs_str-adres-mahalle     = 'Aktürk Mahallesi'.
gs_str-adres-cadde       = 'Yunus Emre Cad'.
gs_str-adres-apartman_no = '25'.
gs_str-adres-daire_no    = '10'.

gs_str-dersler-ders1 = 'Edebiyat'.
gs_str-dersler-ders2 = 'Ingilizce'.
gs_str-dersler-ders3 = 'Matematik'.
gs_str-dersler-ders4 = 'Fizik'.
gs_str-dersler-ders5 = 'Cografya'.

APPEND gs_str TO gt_table.
CLEAR: gs_str.

gs_str-ogrenci_no = '0002'.
gs_str-ad         = 'Mehmet'.
gs_str-soyad      = 'Özlem'.

gs_str-adres-mahalle     = 'Aktürk Mahallesi'.
gs_str-adres-cadde       = 'Yunus Emre Cad'.
gs_str-adres-apartman_no = '25'.
gs_str-adres-daire_no    = '10'.

gs_str-dersler-ders1 = 'Edebiyat'.
gs_str-dersler-ders2 = 'Ingilizce'.
gs_str-dersler-ders3 = 'Matematik'.
gs_str-dersler-ders4 = 'Fizik'.
gs_str-dersler-ders5 = 'Cografya'.

APPEND gs_str TO gt_table.
CLEAR: gs_str.

BREAK-POINT.
