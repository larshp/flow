class ZCL_FLOW_STATEMENT definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IO_STATEMENT type ref to CL_ABAP_STATEMENT_INFO .
  methods GET_STATEMENT
    returning
      value(RO_STATEMENT) type ref to CL_ABAP_STATEMENT_INFO .
  methods GET_REFS
    returning
      value(RO_REFS) type ref to ZCL_FLOW_REF_LIST .
  methods LIST_READS
    returning
      value(RO_READS) type ref to ZCL_FLOW_REF_LIST .
protected section.

  data MO_STATEMENT type ref to CL_ABAP_STATEMENT_INFO .
  data MO_REFS type ref to ZCL_FLOW_REF_LIST .
private section.
ENDCLASS.



CLASS ZCL_FLOW_STATEMENT IMPLEMENTATION.


  METHOD constructor.

    mo_statement = io_statement.

    CREATE OBJECT mo_refs.

  ENDMETHOD.


  METHOD get_refs.

    ro_refs = mo_refs.

  ENDMETHOD.


  METHOD get_statement.

    ro_statement = mo_statement.

  ENDMETHOD.


  METHOD list_reads.

    CREATE OBJECT ro_reads.

    LOOP AT get_refs( )->mt_refs INTO DATA(lo_ref).
      CASE lo_ref->get_mode2( ).
        WHEN cl_abap_compiler=>mode2_read
            OR cl_abap_compiler=>mode2_ref_read.
          ro_reads->append( lo_ref ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
