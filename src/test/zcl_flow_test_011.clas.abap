class ZCL_FLOW_TEST_011 definition
  public
  create public .

public section.

  methods TEST01
    returning
      value(RV_OUT) type STRING .
  methods TEST02
    importing
      !IV_IN type STRING
    returning
      value(RV_OUT) type STRING .
  methods TEST03
    importing
      !IV_IN type STRING
    returning
      value(RV_OUT) type STRING .
  methods TEST04
    importing
      !IV_IN type STRING
    returning
      value(RV_OUT) type STRING .
  methods TEST05
    importing
      !IV_IN1 type STRING
      !IV_IN2 type STRING
    returning
      value(RV_OUT) type STRING .
  methods TEST06
    importing
      !IV_IN1 type STRING
      !IV_IN2 type STRING
    exporting
      !EV_OUT1 type STRING
      !EV_OUT2 type STRING .
  methods TEST07
    importing
      !IV_IN1 type STRING
      !IV_IN2 type STRING
    exporting
      !EV_OUT1 type STRING
      !EV_OUT2 type STRING .
  methods TEST08
    importing
      !IV_IN1 type STRING
      !IV_IN2 type STRING
    exporting
      !EV_OUT1 type STRING
      !EV_OUT2 type STRING .
  methods TEST09
    changing
      !CV_FOO type STRING .
  methods TEST10
    importing
      !IV_IN type STRING .
  methods TEST11
    returning
      value(RV_OUT) type STRING .
  methods TEST12 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST_011 IMPLEMENTATION.


  METHOD test01.

    rv_out = 'sdf'.

  ENDMETHOD.


  METHOD test02.

    rv_out = iv_in.

  ENDMETHOD.


  METHOD test03.

    rv_out = 'sdf' && iv_in.

  ENDMETHOD.


  METHOD test04.

    DATA(lv_local) = iv_in.

    rv_out = 'sdf' && lv_local.

  ENDMETHOD.


  METHOD test05.

    rv_out = iv_in1 && iv_in2.

  ENDMETHOD.


  METHOD test06.

    ev_out1 = iv_in1.
    ev_out2 = iv_in2.

  ENDMETHOD.


  METHOD test07.

    ev_out1 = iv_in1 && iv_in2.
    ev_out2 = iv_in1 && iv_in2.

  ENDMETHOD.


  METHOD test08.

    ev_out1 = 'sdf'.
    ev_out2 = 'sdf'.

  ENDMETHOD.


  METHOD test09.

    cv_foo = cv_foo && 'sdf'.

  ENDMETHOD.


  METHOD test10.

    WRITE: iv_in.

  ENDMETHOD.


  METHOD test11.

* RV_OUT is not referenced

    WRITE: 'foobar'.

  ENDMETHOD.


  METHOD test12.

* empty, no data flow
    RETURN.

  ENDMETHOD.
ENDCLASS.
