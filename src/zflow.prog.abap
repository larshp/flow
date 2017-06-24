REPORT zflow.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  DATA(lt_flow) = NEW zcl_aoc_flow( 'ZCL_FLOW_TEST_001' )->get_result( ).

ENDFORM.
