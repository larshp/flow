class ZCL_FLOW_TEST_002 definition
  public
  create public .

public section.

  class-methods BAR
    importing
      !IV_WHERE type STRING .
  class-methods FOO
    importing
      !IV_WHERE type STRING
      !IV_BAR type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST_002 IMPLEMENTATION.


  METHOD BAR.

    DATA: lv_foo TYPE string.

    lv_foo = 'sdf'.

    foo( iv_where = iv_where
         iv_bar   = lv_foo ).

  ENDMETHOD.


  METHOD foo.

    DATA: lv_local TYPE string.

    WRITE iv_bar.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from usr02 where ' &&
      iv_where  &&
      lv_local ).

  ENDMETHOD.
ENDCLASS.
