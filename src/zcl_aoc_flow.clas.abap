class ZCL_AOC_FLOW definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_ref,
        name      TYPE string,
        full_name TYPE string,
        tag       TYPE scr_tag,
        mode2     TYPE c LENGTH 1,
      END OF ty_ref .
  types:
    ty_refs TYPE STANDARD TABLE OF ty_ref WITH DEFAULT KEY .
  types:
    BEGIN OF ty_statement,
        statement TYPE REF TO cl_abap_statement_info,
        refs      TYPE ty_refs,
      END OF ty_statement .
  types:
    ty_statements TYPE STANDARD TABLE OF ty_statement WITH DEFAULT KEY .
  types:
    BEGIN OF ty_includes,
        include    TYPE programm,
        statements TYPE ty_statements,
      END OF ty_includes .
  types:
    ty_result TYPE STANDARD TABLE OF ty_includes WITH DEFAULT KEY .

  methods CONSTRUCTOR
    importing
      !IV_CLASS type SEOCLSNAME .
  methods GET_RESULT
    returning
      value(RT_FLOW) type TY_RESULT .
protected section.

  data MT_FLOW type TY_RESULT .

  methods BUILD_RESULT
    importing
      !IV_CLASS type SEOCLSNAME .
private section.
ENDCLASS.



CLASS ZCL_AOC_FLOW IMPLEMENTATION.


  METHOD BUILD_RESULT.

    DATA: lt_result TYPE scr_refs.

    DATA(lo_compiler) = cl_abap_compiler=>create(
      p_name             = cl_oo_classname_service=>get_classpool_name( iv_class )
      p_no_package_check = abap_true ).

    lo_compiler->get_all(
      IMPORTING
        p_result = lt_result ).

    DELETE lt_result WHERE tag = cl_abap_compiler=>tag_enhancement_impl.
    DELETE lt_result WHERE tag = cl_abap_compiler=>tag_include.
    DELETE lt_result WHERE tag = cl_abap_compiler=>tag_type.
    DELETE lt_result WHERE grade = cl_abap_compiler=>grade_definition.
    DELETE lt_result WHERE name = ''. " intermediate results

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
      READ TABLE mt_flow ASSIGNING FIELD-SYMBOL(<ls_include>)
        WITH KEY include = <ls_result>-statement->source_info->name.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO mt_flow ASSIGNING <ls_include>.
        <ls_include>-include = <ls_result>-statement->source_info->name.
      ENDIF.

      READ TABLE <ls_include>-statements ASSIGNING FIELD-SYMBOL(<ls_statement>)
        WITH KEY statement = <ls_result>-statement.
      IF sy-subrc <> 0.
        APPEND INITIAL LINE TO <ls_include>-statements ASSIGNING <ls_statement>.
        <ls_statement>-statement = <ls_result>-statement.
      ENDIF.

      APPEND INITIAL LINE TO <ls_statement>-refs ASSIGNING FIELD-SYMBOL(<ls_ref>).
      <ls_ref>-name      = <ls_result>-name.
      <ls_ref>-full_name = <ls_result>-full_name.
      <ls_ref>-tag       = <ls_result>-tag.
      <ls_ref>-mode2     = <ls_result>-mode2.
    ENDLOOP.

  ENDMETHOD.


  METHOD CONSTRUCTOR.

    build_result( iv_class ).

  ENDMETHOD.


  method GET_RESULT.
  endmethod.
ENDCLASS.
