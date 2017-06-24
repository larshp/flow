class ZCL_FLOW_TEST_001 definition
  public
  create public .

public section.

  class-methods TEST01 .
  class-methods TEST02
    importing
      !IV_WHERE type STRING .
  class-methods TEST03
    importing
      !IV_WHERE type STRING .
  class-methods TEST04
    importing
      !IV_WHERE type STRING
      !IV_BAR type STRING .
  class-methods TEST05 .
  class-methods TEST06
    importing
      !IV_WHERE type STRING
      !IV_BAR type STRING .
  class-methods TEST07
    importing
      !IV_WHERE type STRING .
  class-methods TEST08
    importing
      value(IV_WHERE) type STRING .
  class-methods TEST09
    importing
      !IV_WHERE type STRING
      !IV_BAR type STRING .
  class-methods TEST10
    importing
      !IT_WHERE type STRING_TABLE .
  class-methods TEST11
    importing
      !IV_WHERE type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST_001 IMPLEMENTATION.


  METHOD test01.

    DATA(lo_sql) = NEW zcl_flow_test_sql( 'select * from foobar' ).

  ENDMETHOD.


  METHOD test02.

    DATA(lo_sql) = NEW zcl_flow_test_sql( iv_where ).

  ENDMETHOD.


  METHOD test03.

    DATA: lv_local TYPE string.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      iv_where  &&
      lv_local ).

  ENDMETHOD.


  METHOD test04.

    DATA: lv_local TYPE string.

    WRITE iv_bar.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      iv_where  &&
      lv_local ).

  ENDMETHOD.


  METHOD test05.

    DATA(lv_foo) = 2 + 2.

  ENDMETHOD.


  METHOD test06.

    DATA: lv_local TYPE string.

    lv_local = iv_bar.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      iv_where  &&
      lv_local ).

  ENDMETHOD.


  METHOD test07.

    DATA: lv_local TYPE string.

    lv_local = iv_where.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      lv_local ).

  ENDMETHOD.


  METHOD test08.

    iv_where = |foo { iv_where }|.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      iv_where ).

  ENDMETHOD.


  METHOD test09.

    DATA(lv_local) = |{ iv_bar }|.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      iv_where  &&
      lv_local ).

  ENDMETHOD.


  METHOD test10.

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      it_where[ 1 ] ).

  ENDMETHOD.


  METHOD test11.

    DATA(lv_foo) = cl_oo_classname_service=>get_prosec_name( CONV #( iv_where ) ).

    DATA(lo_sql) = NEW zcl_flow_test_sql(
      'select * from foobar where ' &&
      lv_foo ).

  ENDMETHOD.
ENDCLASS.
