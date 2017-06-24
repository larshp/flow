class ZCL_FLOW_TEST definition
  public
  create public
  for testing .

public section.

  methods RUN
    importing
      !IV_METHOD type SEOCPDNAME
    returning
      value(RT_USES) type ZCL_FLOW=>TY_USES .
  methods CONSTRUCTOR
    importing
      !IV_CLASS type SEOCLSNAME .
protected section.
PRIVATE SECTION.

  DATA mo_flow TYPE REF TO zcl_flow.
  DATA mv_class TYPE seoclsname.
ENDCLASS.



CLASS ZCL_FLOW_TEST IMPLEMENTATION.


  METHOD constructor.

    mo_flow  = NEW zcl_flow( iv_class ).
    mv_class = iv_class.

  ENDMETHOD.


  METHOD run.

    DATA(lv_include) = cl_oo_classname_service=>get_method_include( VALUE seocpdkey(
      clsname = mv_class
      cpdname = iv_method ) ).

    rt_uses = mo_flow->entry(
      iv_include = lv_include
      iv_method  = '\TY:ZCL_FLOW_TEST_SQL' ).

  ENDMETHOD.
ENDCLASS.
