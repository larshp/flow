class ZCL_FLOW_TEST_METHOD definition
  public
  create public
  for testing .

public section.

  methods ADD_EXPECTED
    importing
      !IV_OUTPUT type STRING
      !IT_INPUT type STRING_TABLE .
  methods CONSTRUCTOR
    importing
      !IV_CLASS type SEOCLSNAME .
  methods RUN
    importing
      !IV_METHOD type STRING
    returning
      value(RO_USES) type ref to ZCL_FLOW_NAME_LIST
    raising
      ZCX_FLOW .
protected section.

  types:
    BEGIN OF ty_expected,
      output TYPE string,
      input  TYPE string_table,
    END OF ty_expected .

  data MO_FLOW type ref to ZCL_FLOW .
  data MV_CLASS type SEOCLSNAME .
  data:
    mt_expected TYPE STANDARD TABLE OF ty_expected WITH DEFAULT KEY .
  data MV_METHOD type STRING .

  methods ASSERT
    importing
      !IT_RESULT type ZCL_FLOW=>TY_METHOD_RESULT_TT
      !IV_METHOD type STRING .
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST_METHOD IMPLEMENTATION.


  METHOD add_expected.

    APPEND INITIAL LINE TO mt_expected ASSIGNING FIELD-SYMBOL(<ls_exp>).
    <ls_exp>-output = iv_output.
    <ls_exp>-input  = it_input.

  ENDMETHOD.


  METHOD assert.

    ASSERT NOT mv_class IS INITIAL.
    ASSERT NOT iv_method IS INITIAL.

    LOOP AT mt_expected INTO DATA(ls_expected).

      DATA(lv_name) = |\\TY:{ mv_class
        }\\ME:{ iv_method
        }\\DA:{ ls_expected-output }|.

      READ TABLE it_result INTO DATA(ls_result) WITH KEY output = lv_name.
      cl_abap_unit_assert=>assert_subrc(
        msg = |Output { ls_expected-output } not found in result| ).

      cl_abap_unit_assert=>assert_equals(
        act = lines( ls_result-input )
        exp = lines( ls_expected-input )
        msg = |Number of inputs differ for output { ls_expected-output }| ).

      LOOP AT ls_expected-input INTO DATA(lv_input).
        lv_name = |\\TY:{ mv_class
          }\\ME:{ iv_method
          }\\DA:{ lv_input }|.

        cl_abap_unit_assert=>assert_table_contains(
          line  = lv_name
          table = ls_result-input ).
      ENDLOOP.
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lines( it_result )
      exp = lines( mt_expected )
      msg = |Number of outputs differ| ).

  ENDMETHOD.


  METHOD constructor.

    mo_flow  = NEW zcl_flow( iv_class ).
    mv_class = iv_class.

  ENDMETHOD.


  METHOD run.

    DATA(lv_include) = cl_oo_classname_service=>get_method_include( VALUE seocpdkey(
      clsname = mv_class
      cpdname = iv_method ) ).

    assert( iv_method = iv_method
            it_result = mo_flow->analyze_method( lv_include ) ).

  ENDMETHOD.
ENDCLASS.
