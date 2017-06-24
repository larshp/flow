CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    DATA: mt_expected TYPE string_table,
          mo_flow     TYPE REF TO zcl_flow_test.

    METHODS:
      setup,
      assert IMPORTING io_uses TYPE REF TO zcl_flow_name_list,
      add_expected IMPORTING iv_name TYPE string,
      test01 FOR TESTING RAISING zcx_flow,
      test02 FOR TESTING RAISING zcx_flow,
      test03 FOR TESTING RAISING zcx_flow,
      test04 FOR TESTING RAISING zcx_flow,
      test05 FOR TESTING RAISING zcx_flow,
      test06 FOR TESTING RAISING zcx_flow,
      test07 FOR TESTING RAISING zcx_flow,
      test08 FOR TESTING RAISING zcx_flow,
      test09 FOR TESTING RAISING zcx_flow.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    mo_flow = NEW zcl_flow_test( 'ZCL_FLOW_TEST_001' ).
    CLEAR mt_expected.
  ENDMETHOD.

  METHOD assert.
    cl_abap_unit_assert=>assert_equals(
      act = lines( io_uses->mt_names )
      exp = lines( mt_expected ) ).

    LOOP AT mt_expected INTO DATA(lv_expected).
      DATA(lv_found) = abap_false.
      DATA(lv_pattern) = |\\TY:ZCL_FLOW_TEST_001\\ME:TEST*\\DA:{ lv_expected }|.
      LOOP AT io_uses->mt_names INTO DATA(lv_name).
        IF lv_name CP lv_pattern.
          lv_found = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF lv_found = abap_false.
        cl_abap_unit_assert=>fail( |Expected { lv_expected }| ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD add_expected.
    APPEND iv_name TO mt_expected.
  ENDMETHOD.

  METHOD test01.
*    assert( mo_flow->run( 'TEST01' ) ).
  ENDMETHOD.

  METHOD test02.
    add_expected( 'IV_WHERE' ).
*    assert( mo_flow->run( 'TEST02' ) ).
  ENDMETHOD.

  METHOD test03.
    add_expected( 'IV_WHERE' ).
    assert( mo_flow->run( 'TEST03' ) ).
  ENDMETHOD.

  METHOD test04.
    add_expected( 'IV_WHERE' ).
*    assert( mo_flow->run( 'TEST04' ) ).
  ENDMETHOD.

  METHOD test05.
*    assert( mo_flow->run( 'TEST05' ) ).
  ENDMETHOD.

  METHOD test06.
    add_expected( 'IV_WHERE' ).
    add_expected( 'IV_BAR' ).
* assert( mo_flow->run( 'TEST06' ) ).
  ENDMETHOD.

  METHOD test07.
*    assert( mo_flow->run( 'TEST07' ) ).
  ENDMETHOD.

  METHOD test08.
    add_expected( 'IV_WHERE' ).
* assert( mo_flow->run( 'TEST08' ) ).
  ENDMETHOD.

  METHOD test09.
    add_expected( 'IV_WHERE' ).
    add_expected( 'IV_BAR' ).
* assert( mo_flow->run( 'TEST09' ) ).
  ENDMETHOD.

ENDCLASS.
