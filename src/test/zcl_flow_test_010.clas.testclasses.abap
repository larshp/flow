CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA: mo_flow TYPE REF TO zcl_flow_test_entry.

    METHODS:
      setup,
      assert IMPORTING iv_entry TYPE string RAISING zcx_flow,
      add_expected IMPORTING iv_name TYPE string,
      test01 FOR TESTING RAISING zcx_flow,
      test02 FOR TESTING RAISING zcx_flow,
      test03 FOR TESTING RAISING zcx_flow,
      test04 FOR TESTING RAISING zcx_flow,
      test05 FOR TESTING RAISING zcx_flow,
      test06 FOR TESTING RAISING zcx_flow,
      test07 FOR TESTING RAISING zcx_flow,
      test08 FOR TESTING RAISING zcx_flow,
      test09 FOR TESTING RAISING zcx_flow,
      test10 FOR TESTING RAISING zcx_flow,
      test11 FOR TESTING RAISING zcx_flow,
      test12 FOR TESTING RAISING zcx_flow,
      test13 FOR TESTING RAISING zcx_flow.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW #( 'ZCL_FLOW_TEST_010' ).
  ENDMETHOD.

  METHOD add_expected.
    mo_flow->add_expected( iv_name ).
  ENDMETHOD.

  METHOD assert.
    mo_flow->run( iv_entry ).
  ENDMETHOD.

************************

  METHOD test01.
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
    add_expected( 'IV_WHERE' ).
    assert( 'TEST04' ).
  ENDMETHOD.

  METHOD test05.
    assert( 'TEST05' ).
  ENDMETHOD.

  METHOD test06.
    add_expected( 'IV_WHERE' ).
    add_expected( 'IV_BAR' ).
    assert( 'TEST06' ).
  ENDMETHOD.

  METHOD test07.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST07' ).
  ENDMETHOD.

  METHOD test08.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST08' ).
  ENDMETHOD.

  METHOD test09.
    add_expected( 'IV_WHERE' ).
    add_expected( 'IV_BAR' ).
    assert( 'TEST09' ).
  ENDMETHOD.

  METHOD test10.
    add_expected( 'IT_WHERE' ).
    assert( 'TEST10' ).
  ENDMETHOD.

  METHOD test11.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST11' ).
  ENDMETHOD.

  METHOD test12.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST12' ).
  ENDMETHOD.

  METHOD test13.
    add_expected( 'IV_WHERE' ).
    assert( 'TEST13' ).
  ENDMETHOD.

ENDCLASS.
