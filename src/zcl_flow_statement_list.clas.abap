class ZCL_FLOW_STATEMENT_LIST definition
  public
  create public .

public section.

  data:
    mt_statements TYPE STANDARD TABLE OF REF TO zcl_flow_statement read-only .

  methods FIND_OR_APPEND
    importing
      !IO_STATEMENT type ref to CL_ABAP_STATEMENT_INFO
    returning
      value(RO_STATEMENT) type ref to ZCL_FLOW_STATEMENT .
  methods FIND_METHOD_USE
    importing
      !IV_METHOD type STRING
    returning
      value(RO_STATEMENT) type ref to ZCL_FLOW_STATEMENT
    raising
      ZCX_FLOW_NOT_FOUND .
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS ZCL_FLOW_STATEMENT_LIST IMPLEMENTATION.


  METHOD find_method_use.

* todo, add possibility to return list of statements

    LOOP AT mt_statements INTO ro_statement.
      IF ro_statement->get_refs( )->is_referenced(
          iv_tag       = cl_abap_compiler=>tag_method
          iv_full_name = iv_method ).
        RETURN.
      ENDIF.
    ENDLOOP.

    RAISE EXCEPTION TYPE zcx_flow_not_found.

  ENDMETHOD.


  METHOD find_or_append.

    LOOP AT mt_statements INTO ro_statement.
      IF ro_statement->get_statement( ) = io_statement.
        RETURN.
      ENDIF.
    ENDLOOP.

    CREATE OBJECT ro_statement
      EXPORTING
        io_statement = io_statement.

    APPEND ro_statement TO mt_statements.

  ENDMETHOD.
ENDCLASS.
