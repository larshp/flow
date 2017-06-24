class ZCL_FLOW_TEST_001 definition
  public
  final
  create public .

public section.

  class-methods FOOBAR
    importing
      !IV_WHERE type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_TEST_001 IMPLEMENTATION.


  METHOD FOOBAR.

    DATA: lv_local TYPE string.

    DATA(lo_sql) = NEW cl_sql_prepared_statement(
      'select * from usr02 where ' &&
      iv_where  &&
      lv_local ).

    lo_sql->execute_query( ).

  ENDMETHOD.
ENDCLASS.
