CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA: mo_flow TYPE REF TO zcl_flow_test.

    METHODS:
      setup,
      expect IMPORTING it_uses TYPE zcl_flow=>ty_uses,
      test01 FOR TESTING,
      test02 FOR TESTING,
      test03 FOR TESTING,
      test04 FOR TESTING.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW zcl_flow_test( 'ZCL_FLOW_TEST_001' ).
  ENDMETHOD.

  METHOD expect.
    cl_abap_unit_assert=>assert_equals(
      act = it_uses
      exp = VALUE zcl_flow=>ty_uses( ( |IV_WHERE| ) ) ).
  ENDMETHOD.

  METHOD test01.
    cl_abap_unit_assert=>assert_initial( mo_flow->run( 'TEST01' ) ).
  ENDMETHOD.

  METHOD test02.
    expect( mo_flow->run( 'TEST02' ) ).
  ENDMETHOD.

  METHOD test03.
    expect( mo_flow->run( 'TEST03' ) ).
  ENDMETHOD.

  METHOD test04.
    expect( mo_flow->run( 'TEST04' ) ).
  ENDMETHOD.

ENDCLASS.
