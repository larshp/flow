class ZCL_FLOW definition
  public
  create public .

public section.

  methods BUILD_OUTPUT
    returning
      value(RT_STRING) type STRING_TABLE .
  methods FOOBAR
    importing
      !IV_INCLUDE type PROGRAMM
      !IV_METHOD type STRING
    returning
      value(RO_USES) type ref to ZCL_FLOW_NAME_LIST
    raising
      ZCX_FLOW .
  methods CONSTRUCTOR
    importing
      !IV_CLASS type SEOCLSNAME .
protected section.

  data MO_INCLUDES type ref to ZCL_FLOW_INCLUDE_LIST .

  methods RUN_COMPILER
    importing
      !IV_CLASS type SEOCLSNAME
    returning
      value(RT_RESULT) type SCR_REFS .
  methods FIND_METHOD_USE .
  methods BUILD_INCLUDE_LIST
    importing
      !IV_CLASS type SEOCLSNAME .
private section.
ENDCLASS.



CLASS ZCL_FLOW IMPLEMENTATION.


  METHOD build_include_list.

    DATA(lt_result) = run_compiler( iv_class ).

    CREATE OBJECT mo_includes.

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).

      CASE <ls_result>-statement->source_info->name.
        WHEN cl_oo_classname_service=>get_ccau_name( iv_class )
            OR cl_oo_classname_service=>get_pubsec_name( iv_class )
            OR cl_oo_classname_service=>get_prisec_name( iv_class )
            OR cl_oo_classname_service=>get_prosec_name( iv_class ).
          CONTINUE.
      ENDCASE.

      DATA(lo_include) = mo_includes->find_or_append( CONV #( <ls_result>-statement->source_info->name ) ).

      DATA(lo_statement) = lo_include->get_statements( )->find_or_append( <ls_result>-statement ).

      lo_statement->get_refs( )->append(
        NEW zcl_flow_ref(
          iv_full_name = <ls_result>-full_name
          iv_tag       = <ls_result>-tag
          iv_mode2     = <ls_result>-mode2 ) ).

    ENDLOOP.

  ENDMETHOD.


  METHOD build_output.

    LOOP AT mo_includes->mt_includes INTO DATA(lo_include).
      APPEND |Include { lo_include->get_name( ) }| TO rt_string.
      LOOP AT lo_include->get_statements( )->mt_statements INTO DATA(lo_statement).
        APPEND |  { lo_statement->get_statement( )->start_line } to {
          lo_statement->get_statement( )->end_line }| TO rt_string.
        LOOP AT lo_statement->get_refs( )->mt_refs INTO DATA(lo_ref).
          APPEND |    { lo_ref->get_full_name( ) WIDTH = 60 } {
            lo_ref->get_tag( ) } {
            lo_ref->get_mode2( ) }| TO rt_string.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.


  METHOD constructor.

    build_include_list( iv_class ).

  ENDMETHOD.


  METHOD find_method_use.
* todo, change mt_flow to be object oriented? then this will be a method in the class

*    LOOP AT it_statements ASSIGNING FIELD-SYMBOL(<ls_statement>).
*      rv_index = sy-tabix.
*
*      READ TABLE <ls_statement>-refs WITH KEY
*        tag = cl_abap_compiler=>tag_method
*        full_name = iv_method
*        TRANSPORTING NO FIELDS.
*      IF sy-subrc = 0.
** todo, assumption: one usage of IV_METHOD per include
*        RETURN.
*      ENDIF.
*    ENDLOOP.
*
*    RAISE EXCEPTION TYPE zcx_flow_not_found.

  ENDMETHOD.


  METHOD foobar.
* find uses/inputs used for calling IV_METHOD

    TRY.
        DATA(lo_statement) = mo_includes->find( iv_include
          )->get_statements(
          )->find_method_use( iv_method ).
      CATCH zcx_flow_not_found.
        CREATE OBJECT ro_uses.
        RETURN.
    ENDTRY.

    ro_uses = lo_statement->list_reads( ).

    DO.
      lo_statement = lo_statement->get_previous( ).
      IF lo_statement IS INITIAL.
        EXIT. " current loop.
      ENDIF.

      IF lo_statement->contains_write_to( ro_uses ).
        ro_uses->append_list( lo_statement->list_reads( ) ).
      ENDIF.

      ro_uses = lo_statement->remove_if_definition( ro_uses ).

* todo
    ENDDO.

  ENDMETHOD.


  METHOD run_compiler.

    DATA(lo_compiler) = cl_abap_compiler=>create(
      p_name             = cl_oo_classname_service=>get_classpool_name( iv_class )
      p_no_package_check = abap_true ).

    lo_compiler->get_all(
      IMPORTING
        p_result = rt_result ).

    DELETE rt_result WHERE tag = cl_abap_compiler=>tag_enhancement_impl.
    DELETE rt_result WHERE tag = cl_abap_compiler=>tag_include.
    DELETE rt_result WHERE tag = cl_abap_compiler=>tag_type.
    DELETE rt_result WHERE tag = cl_abap_compiler=>tag_method
      AND grade = cl_abap_compiler=>grade_definition.
    DELETE rt_result WHERE name = ''. " intermediate results

  ENDMETHOD.
ENDCLASS.
