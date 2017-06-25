
CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    METHODS: test01 FOR TESTING RAISING zcx_flow.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD test01.

    DATA(lo_flow) = NEW zcl_flow_test_entry( 'ZCL_FLOW_TEST_020' ).

    lo_flow->add_expected( iv_variable = 'IV_WHERE'
                           iv_method   = 'TEST01' ).

    lo_flow->run( 'EXECUTE_SQL' ).

  ENDMETHOD.

ENDCLASS.
