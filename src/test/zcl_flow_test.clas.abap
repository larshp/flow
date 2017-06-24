CLASS zcl_flow_test DEFINITION
  PUBLIC
  CREATE PUBLIC
  FOR TESTING .

  PUBLIC SECTION.

    METHODS run
      IMPORTING
        !iv_method     TYPE seocpdname
      RETURNING
        VALUE(ro_uses) TYPE REF TO zcl_flow_ref_list .
    METHODS constructor
      IMPORTING
        !iv_class TYPE seoclsname .
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

    ro_uses = mo_flow->entry(
      iv_include = lv_include
      iv_method  = '\TY:ZCL_FLOW_TEST_SQL' ).

  ENDMETHOD.
ENDCLASS.
