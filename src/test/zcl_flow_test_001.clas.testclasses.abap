CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA: mo_flow TYPE REF TO zcl_flow_test.

    METHODS:
      setup,
      expect IMPORTING io_uses TYPE REF TO zcl_flow_ref_list,
      test01 FOR TESTING,
      test02 FOR TESTING,
      test03 FOR TESTING,
      test04 FOR TESTING,
      test05 FOR TESTING,
      test06 FOR TESTING,
      test07 FOR TESTING.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW zcl_flow_test( 'ZCL_FLOW_TEST_001' ).
  ENDMETHOD.

  METHOD expect.
    cl_abap_unit_assert=>assert_equals(
      act = lines( io_uses->mt_refs )
      exp = 1 ).

    DATA(lo_ref) = io_uses->mt_refs[ 1 ].

    cl_abap_unit_assert=>assert_char_cp(
      act = lo_ref->get_full_name( )
      exp = '\TY:ZCL_FLOW_TEST_001\ME:TEST*\DA:IV_WHERE' ).
  ENDMETHOD.

  METHOD test01.
    cl_abap_unit_assert=>assert_equals(
      act = lines( mo_flow->run( 'TEST01' )->mt_refs )
      exp = 0 ).
  ENDMETHOD.

  METHOD test02.
    expect( mo_flow->run( 'TEST02' ) ).
  ENDMETHOD.

  METHOD test03.
*    expect( mo_flow->run( 'TEST03' ) ).
  ENDMETHOD.

  METHOD test04.
*    expect( mo_flow->run( 'TEST04' ) ).
  ENDMETHOD.

  METHOD test05.
*    cl_abap_unit_assert=>assert_initial( mo_flow->run( 'TEST05' ) ).
  ENDMETHOD.

  METHOD test06.
* expected: IV_WHERE and IV_BAR
  ENDMETHOD.

  METHOD test07.
*    cl_abap_unit_assert=>assert_initial( mo_flow->run( 'TEST05' ) ).
  ENDMETHOD.

ENDCLASS.
