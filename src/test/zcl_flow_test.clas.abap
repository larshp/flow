class ZCL_FLOW_TEST definition
  public
  create public
  for testing .

public section.

  methods ADD_EXPECTED
    importing
      !IV_VARIABLE type STRING
      !IV_METHOD type STRING default '' .
  methods CONSTRUCTOR
    importing
      !IV_CLASS type SEOCLSNAME .
  methods RUN
    importing
      !IV_ENTRY type STRING
    returning
      value(RO_USES) type ref to ZCL_FLOW_NAME_LIST
    raising
      ZCX_FLOW .
  methods ASSERT
    importing
      !IO_USES type ref to ZCL_FLOW_NAME_LIST .
PROTECTED SECTION.

  DATA mv_entry TYPE string.
  DATA mo_flow TYPE REF TO zcl_flow.
  DATA mv_class TYPE seoclsname.

  TYPES: BEGIN OF ty_expected,
           method   TYPE string,
           variable TYPE string,
         END OF ty_expected.

  DATA mt_expected TYPE STANDARD TABLE OF ty_expected WITH DEFAULT KEY.
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST IMPLEMENTATION.


  METHOD add_expected.

    APPEND INITIAL LINE TO mt_expected ASSIGNING FIELD-SYMBOL(<ls_exp>).
    <ls_exp>-method = iv_method.
    <ls_exp>-variable = iv_variable.

  ENDMETHOD.


  METHOD assert.

    cl_abap_unit_assert=>assert_equals(
      act = lines( io_uses->mt_names )
      exp = lines( mt_expected )
      msg = |Number of variables differ| ).

    LOOP AT mt_expected ASSIGNING FIELD-SYMBOL(<ls_expected>) WHERE method IS INITIAL.
      <ls_expected>-method = mv_entry.
    ENDLOOP.

    LOOP AT mt_expected INTO DATA(ls_expected).

      ASSERT NOT ls_expected-method IS INITIAL.
      ASSERT NOT ls_expected-variable IS INITIAL.
      DATA(lv_pattern) = |\\TY:{ mv_class
        }\\ME:{ ls_expected-method
        }\\DA:{ ls_expected-variable }|.

      DATA(lv_msg) = ||.
      IF lines( mt_expected ) = 1.
        lv_msg = |Actual: { io_uses->mt_names[ 1 ] }|.
      ENDIF.

      cl_abap_unit_assert=>assert_table_contains(
        line  = lv_pattern
        table = io_uses->mt_names
        msg   = lv_msg ).
    ENDLOOP.

  ENDMETHOD.


  METHOD constructor.

    mo_flow  = NEW zcl_flow( iv_class ).
    mv_class = iv_class.

  ENDMETHOD.


  METHOD run.

    mv_entry = iv_entry.

    DATA(lv_include) = cl_oo_classname_service=>get_method_include( VALUE seocpdkey(
      clsname = mv_class
      cpdname = iv_entry ) ).

    ro_uses = mo_flow->foobar(
      iv_include = lv_include
      iv_method  = '\TY:ZCL_FLOW_TEST_SQL' ).

  ENDMETHOD.
ENDCLASS.
