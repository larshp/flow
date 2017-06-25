
CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA: mo_flow TYPE REF TO zcl_flow_test_method.

    METHODS:
      setup,
      add_expected
        IMPORTING
          iv_output TYPE string
          it_input  TYPE string_table,
      assert
        IMPORTING iv_method TYPE string
        RAISING   zcx_flow,
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
      test13 FOR TESTING RAISING zcx_flow,
      test14 FOR TESTING RAISING zcx_flow.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW #( 'ZCL_FLOW_TEST_011' ).
  ENDMETHOD.

  METHOD add_expected.
    mo_flow->add_expected( iv_output = iv_output
                           it_input  = it_input ).
  ENDMETHOD.

  METHOD assert.
    mo_flow->run( iv_method ).
  ENDMETHOD.

**************

  METHOD test01.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ) ).
    assert( 'TEST01' ).
  ENDMETHOD.

  METHOD test02.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN| ) ) ).
    assert( 'TEST02' ).
  ENDMETHOD.

  METHOD test03.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN| ) ) ).
    assert( 'TEST03' ).
  ENDMETHOD.

  METHOD test04.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN| ) ) ).
    assert( 'TEST04' ).
  ENDMETHOD.

  METHOD test05.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN1| ) ( |IV_IN2| ) ) ).
    assert( 'TEST05' ).
  ENDMETHOD.

  METHOD test06.
    add_expected( iv_output = 'EV_OUT1'
                  it_input  = VALUE #( ( |IV_IN1| ) ) ).
    add_expected( iv_output = 'EV_OUT2'
                  it_input  = VALUE #( ( |IV_IN2| ) ) ).
    assert( 'TEST06' ).
  ENDMETHOD.

  METHOD test07.
    add_expected( iv_output = 'EV_OUT1'
                  it_input  = VALUE #( ( |IV_IN1| ) ( |IV_IN2| ) ) ).
    add_expected( iv_output = 'EV_OUT2'
                  it_input  = VALUE #( ( |IV_IN1| ) ( |IV_IN2| ) ) ).
    assert( 'TEST07' ).
  ENDMETHOD.

  METHOD test08.
    add_expected( iv_output = 'EV_OUT1'
                  it_input  = VALUE #( ) ).
    add_expected( iv_output = 'EV_OUT2'
                  it_input  = VALUE #( ) ).
    assert( 'TEST08' ).
  ENDMETHOD.

  METHOD test09.
    add_expected( iv_output = 'CV_FOO'
                  it_input  = VALUE #( ( |CV_FOO| ) ) ).
    assert( 'TEST09' ).
  ENDMETHOD.

  METHOD test10.
    assert( 'TEST10' ).
  ENDMETHOD.

  METHOD test11.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ) ).
    assert( 'TEST11' ).
  ENDMETHOD.

  METHOD test12.
    assert( 'TEST12' ).
  ENDMETHOD.

  METHOD test13.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN| ) ) ).
    assert( 'TEST13' ).
  ENDMETHOD.

  METHOD test14.
    add_expected( iv_output = 'RV_OUT'
                  it_input  = VALUE #( ( |IV_IN| ) ) ).
    assert( 'TEST14' ).
  ENDMETHOD.

ENDCLASS.
