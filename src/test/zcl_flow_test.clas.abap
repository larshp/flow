class ZCL_FLOW_TEST definition
  public
  create public
  for testing .

public section.

  methods RUN
    importing
      !IV_METHOD type SEOCPDNAME
    returning
      value(RO_USES) type ref to ZCL_FLOW_NAME_LIST
    raising
      ZCX_FLOW_NOT_FOUND .
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

    ro_uses = mo_flow->foobar(
      iv_include = lv_include
      iv_method  = '\TY:ZCL_FLOW_TEST_SQL' ).

  ENDMETHOD.
ENDCLASS.
