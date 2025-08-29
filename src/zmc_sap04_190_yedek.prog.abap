*&---------------------------------------------------------------------*
*& Report ZMC_SAP04_190
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmc_sap04_190_yedek.

*Alıştırma – 9: Dialog Screen programlama ile basit bir hesap makinesi oluşturun.

DATA: gv_field TYPE string,
      gv_1     TYPE string,
      gv_2     TYPE string.

START-OF-SELECTION.

  CALL SCREEN 0400 STARTING AT 5 5 ENDING AT 100 110.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0400  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0400 OUTPUT.
  SET PF-STATUS '190'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0400 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'BIR'.
      CONCATENATE gv_field '1' INTO gv_field.
    WHEN 'IKI'.
      CONCATENATE gv_field '2' INTO gv_field.
    WHEN 'UC'.
      CONCATENATE gv_field '3' INTO gv_field.
    WHEN 'DORT'.
      CONCATENATE gv_field '4' INTO gv_field.
    WHEN 'BES'.
      CONCATENATE gv_field '5' INTO gv_field.
    WHEN 'ALTI'.
      CONCATENATE gv_field '6' INTO gv_field.
    WHEN 'YEDI'.
      CONCATENATE gv_field '7' INTO gv_field.
    WHEN 'SEKIZ'.
      CONCATENATE gv_field '8' INTO gv_field.
    WHEN 'DOKUZ'.
      CONCATENATE gv_field '9' INTO gv_field.
    WHEN 'SIFIR'.
      CONCATENATE gv_field '0' INTO gv_field.
    WHEN 'CARP'.
      CONCATENATE gv_field '*' INTO gv_field.
    WHEN 'BOL'.
      CONCATENATE gv_field '/' INTO gv_field.
    WHEN 'EKSI'.
      CONCATENATE gv_field '-' INTO gv_field.
    WHEN 'ARTI'.
      CONCATENATE gv_field '+' INTO gv_field.
    WHEN 'ESITTIR'.

*      SEARCH gv_field FOR '*'.
      FIND '*' IN gv_field.

      IF sy-subrc IS INITIAL.
        SPLIT gv_field AT '*' INTO gv_1 gv_2.

        gv_field = gv_1 * gv_2.
      ENDIF.

      FIND '/' IN gv_field.

      IF sy-subrc IS INITIAL.
        SPLIT gv_field AT '/' INTO gv_1 gv_2.

        gv_field = gv_1 / gv_2.
      ENDIF.

      FIND '+' IN gv_field.

      IF sy-subrc IS INITIAL.
        SPLIT gv_field AT '+' INTO gv_1 gv_2.

        gv_field = gv_1 + gv_2.
      ENDIF.

      FIND '-' IN gv_field.

      IF sy-subrc IS INITIAL.
        SPLIT gv_field AT '-' INTO gv_1 gv_2.

        gv_field = gv_1 - gv_2.
      ENDIF.


    WHEN 'TEMIZLE'.
      CLEAR: gv_field.
  ENDCASE.
ENDMODULE.
