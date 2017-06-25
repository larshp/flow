CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA:
      mo_flow TYPE REF TO zcl_flow_test_entry.

    METHODS:
      setup,
      assert IMPORTING iv_entry TYPE string RAISING zcx_flow,
      add_expected IMPORTING iv_name TYPE string,
      test01 FOR TESTING RAISING zcx_flow,
      test02 FOR TESTING RAISING zcx_flow,
      test03 FOR TESTING RAISING zcx_flow,
      test04 FOR TESTING RAISING zcx_flow.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW #( 'ZCL_FLOW_TEST_030' ).
  ENDMETHOD.

  METHOD add_expected.
    mo_flow->add_expected( iv_name ).
  ENDMETHOD.

  METHOD assert.
    mo_flow->run( iv_entry ).
  ENDMETHOD.

************************

  METHOD test01.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST01' ).
  ENDMETHOD.

  METHOD test02.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST02' ).
  ENDMETHOD.

  METHOD test03.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST03' ).
  ENDMETHOD.

  METHOD test04.
    assert( 'TEST04' ).
  ENDMETHOD.

ENDCLASS.
