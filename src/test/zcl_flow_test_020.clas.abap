class ZCL_FLOW_TEST_020 definition
  public
  create public .

public section.

  methods TEST01
    importing
      !IV_FILTER type STRING .
protected section.
private section.

  methods BUILD_SQL
    importing
      !IV_FILTER type STRING
    returning
      value(RV_SQL) type STRING .
  methods EXECUTE_SQL
    importing
      !IV_SQL type STRING .
ENDCLASS.



CLASS ZCL_FLOW_TEST_020 IMPLEMENTATION.


  METHOD BUILD_SQL.

    rv_sql = iv_filter.

  ENDMETHOD.


  METHOD EXECUTE_SQL.

    NEW zcl_flow_test_sql( iv_sql ).

  ENDMETHOD.


  METHOD TEST01.

    DATA(lv_sql) = build_sql( iv_filter ).

    execute_sql( lv_sql ).

  ENDMETHOD.
ENDCLASS.
