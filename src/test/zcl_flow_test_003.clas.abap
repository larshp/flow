class ZCL_FLOW_TEST_003 definition
  public
  create public .

public section.

  methods TEST01 .
  methods TEST02 .
protected section.
private section.

  methods SEQUENTIAL
    importing
      !IV_FOO type STRING
      !IV_BAR type STRING .
  methods NESTED
    importing
      !IV_FOO type STRING .
  methods UTIL
    importing
      !IV_FOO type STRING
    returning
      value(RV_BAR) type STRING .
ENDCLASS.



CLASS ZCL_FLOW_TEST_003 IMPLEMENTATION.


  method NESTED.
  endmethod.


  method SEQUENTIAL.
  endmethod.


  METHOD test01.

    sequential( iv_foo = util( 'foo' )
                iv_bar = util( 'bar' ) ).

  ENDMETHOD.


  METHOD test02.

    nested( iv_foo = util( iv_foo = util( iv_foo = 'moo' ) ) ).

  ENDMETHOD.


  method UTIL.
  endmethod.
ENDCLASS.
