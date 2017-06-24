class ZCL_FLOW_STATEMENT definition
  public
  create public

  global friends ZCL_FLOW_STATEMENT_LIST .

public section.

  methods CONSTRUCTOR
    importing
      !IO_STATEMENT type ref to CL_ABAP_STATEMENT_INFO
      !IO_PREVIOUS type ref to ZCL_FLOW_STATEMENT .
  methods CONTAINS_READ_OF
    importing
      value(IO_NAMES) type ref to ZCL_FLOW_NAME_LIST
    returning
      value(RV_CONTAINS) type ABAP_BOOL .
  methods CONTAINS_WRITE_TO
    importing
      value(IO_NAMES) type ref to ZCL_FLOW_NAME_LIST
    returning
      value(RV_CONTAINS) type ABAP_BOOL .
  methods GET_PREVIOUS
    returning
      value(RO_PREVIOUS) type ref to ZCL_FLOW_STATEMENT .
  methods GET_REFS
    returning
      value(RO_REFS) type ref to ZCL_FLOW_REF_LIST .
  methods GET_STATEMENT
    returning
      value(RO_STATEMENT) type ref to CL_ABAP_STATEMENT_INFO .
  methods LIST_READS
    returning
      value(RO_READS) type ref to ZCL_FLOW_NAME_LIST .
  methods REMOVE_IF_DEFINITION
    importing
      !IO_LIST type ref to ZCL_FLOW_NAME_LIST
    returning
      value(RO_LIST) type ref to ZCL_FLOW_NAME_LIST .
protected section.

  data MO_STATEMENT type ref to CL_ABAP_STATEMENT_INFO .
  data MO_REFS type ref to ZCL_FLOW_REF_LIST .
  data MO_PREVIOUS type ref to ZCL_FLOW_STATEMENT .
private section.
ENDCLASS.



CLASS ZCL_FLOW_STATEMENT IMPLEMENTATION.


  METHOD constructor.

    mo_statement = io_statement.
    mo_previous  = io_previous.

    CREATE OBJECT mo_refs.

  ENDMETHOD.


  METHOD contains_read_of.

    BREAK-POINT.

  ENDMETHOD.


  METHOD contains_write_to.

    LOOP AT get_refs( )->mt_refs INTO DATA(lo_ref).
      CASE lo_ref->get_mode2( ).
        WHEN cl_abap_compiler=>mode2_write
            OR cl_abap_compiler=>mode2_def_write
            OR cl_abap_compiler=>mode2_read_write.
          IF io_names->contains( lo_ref->get_full_name( ) ).
            rv_contains = abap_true.
            RETURN.
          ENDIF.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_previous.

    ro_previous = mo_previous.

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
      IF lo_ref->get_tag( ) = cl_abap_compiler=>tag_data.
        CASE lo_ref->get_mode2( ).
          WHEN cl_abap_compiler=>mode2_read
              OR cl_abap_compiler=>mode2_ref_read.
            ro_reads->append( lo_ref->get_full_name( ) ).
        ENDCASE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD remove_if_definition.

    ro_list = io_list->clone( ).

    LOOP AT get_refs( )->mt_refs INTO DATA(lo_ref).
      CASE lo_ref->get_mode2( ) .
        WHEN cl_abap_compiler=>mode2_def
            OR cl_abap_compiler=>mode2_def_write.
          ro_list->remove( lo_ref->get_full_name( ) ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
