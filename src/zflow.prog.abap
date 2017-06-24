REPORT zflow.

PARAMETERS: p_class TYPE seoclsname OBLIGATORY DEFAULT 'ZCL_FLOW'.

START-OF-SELECTION.
  PERFORM run.

FORM run.

  DATA(lt_output) = NEW zcl_flow( p_class )->build_output( ).

  LOOP AT lt_output INTO DATA(lv_output).
    WRITE: / lv_output.
  ENDLOOP.

ENDFORM.
