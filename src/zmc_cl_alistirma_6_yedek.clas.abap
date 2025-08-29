class ZMC_CL_ALISTIRMA_6_YEDEK definition
  public
  final
  create public .

public section.

  class-methods INFO
    importing
      !IV_DATE type DATUM
    exporting
      !EV_MSG_TEXT type STRING .
protected section.

  class-methods WEEKDAY
    importing
      !IV_DATE type DATUM
    exporting
      !EV_WEEKDAY type LANGT .
  class-methods NO_DAYS
    importing
      !IV_DATE type DATUM
    exporting
      !EV_NO_DAYS type I .
private section.
ENDCLASS.



CLASS ZMC_CL_ALISTIRMA_6_YEDEK IMPLEMENTATION.


  METHOD INFO.

    DATA: lv_weekday TYPE langt,
          lv_no_days TYPE i,
          lv_no      TYPE n LENGTH 5.

    weekday(
      EXPORTING
        iv_date    = iv_date
      IMPORTING
        ev_weekday =  lv_weekday ).

    no_days(
      EXPORTING
        iv_date    = iv_date
      IMPORTING
        ev_no_days = lv_no_days ).

    lv_no = lv_no_days.

    CONCATENATE 'Girilen'
                iv_date
                lv_weekday
                'ile bugün arasinda'
                lv_no
                'gün bulunmaktadir' INTO ev_msg_text SEPARATED BY space.

  ENDMETHOD.


  METHOD NO_DAYS.

    ev_no_days = sy-datum - iv_date.

  ENDMETHOD.


  METHOD WEEKDAY.

    CALL FUNCTION 'GET_WEEKDAY_NAME'
      EXPORTING
        date        = iv_date
        language    = 'T'
      IMPORTING
        longtext    = ev_weekday
      EXCEPTIONS
        calendar_id = 1
        date_error  = 2
        not_found   = 3
        wrong_input = 4
        OTHERS      = 5.

    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
