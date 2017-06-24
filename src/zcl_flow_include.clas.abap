class ZCL_FLOW_INCLUDE definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type PROGRAMM .
  methods GET_NAME
    returning
      value(RV_NAME) type PROGRAMM .
  methods GET_STATEMENTS
    returning
      value(RO_STATEMENTS) type ref to ZCL_FLOW_STATEMENT_LIST .
protected section.

  data MV_NAME type PROGRAMM .
  data MO_STATEMENTS type ref to ZCL_FLOW_STATEMENT_LIST .
private section.
ENDCLASS.



CLASS ZCL_FLOW_INCLUDE IMPLEMENTATION.


  METHOD constructor.

    mv_name = iv_name.

    CREATE OBJECT mo_statements.

  ENDMETHOD.


  METHOD get_name.
    rv_name = mv_name.
  ENDMETHOD.


  METHOD get_statements.

    ro_statements = mo_statements.

  ENDMETHOD.
ENDCLASS.
