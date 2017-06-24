CLASS zcl_flow DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_ref,
*        name      TYPE string,
        full_name TYPE string,
        tag       TYPE scr_tag,
        mode2     TYPE c LENGTH 1,
*        grade     TYPE scr_grade,
      END OF ty_ref .
    TYPES:
      ty_refs TYPE STANDARD TABLE OF ty_ref WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_statement,
        statement TYPE REF TO cl_abap_statement_info,
        refs      TYPE ty_refs,
      END OF ty_statement .
    TYPES:
      ty_statements TYPE STANDARD TABLE OF ty_statement WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_includes,
        include    TYPE programm,
        statements TYPE ty_statements,
      END OF ty_includes .
    TYPES:
      ty_result TYPE STANDARD TABLE OF ty_includes WITH DEFAULT KEY .
    TYPES:
      ty_uses TYPE STANDARD TABLE OF string WITH DEFAULT KEY .

    METHODS entry
      IMPORTING
        !iv_include    TYPE programm
        !iv_method     TYPE string
      RETURNING
        VALUE(rt_uses) TYPE ty_uses .
    METHODS constructor
      IMPORTING
        !iv_class TYPE seoclsname .
    METHODS get_result
      RETURNING
        VALUE(rt_flow) TYPE ty_result .
protected section.

  data MT_FLOW type TY_RESULT .

  methods FIND_METHOD_USE
    importing
      !IT_STATEMENTS type TY_STATEMENTS
      !IV_METHOD type STRING
    returning
      value(RV_INDEX) type I
    raising
      ZCX_FLOW_NOT_FOUND .
  methods BUILD_RESULT
    importing
      !IV_CLASS type SEOCLSNAME .
private section.
ENDCLASS.



CLASS ZCL_FLOW IMPLEMENTATION.


  METHOD build_result.

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
    DELETE lt_result WHERE tag = cl_abap_compiler=>tag_method AND grade = cl_abap_compiler=>grade_definition.
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
      <ls_ref>-full_name = <ls_result>-full_name.
      <ls_ref>-tag       = <ls_result>-tag.
      <ls_ref>-mode2     = <ls_result>-mode2.
*      <ls_ref>-grade     = <ls_result>-grade.
    ENDLOOP.

  ENDMETHOD.


  METHOD constructor.

    build_result( iv_class ).

  ENDMETHOD.


  METHOD entry.
* find uses/inputs used for calling IV_METHOD

* todo, rename this method?

    READ TABLE mt_flow ASSIGNING FIELD-SYMBOL(<ls_flow>) WITH KEY include = iv_include.
    ASSERT sy-subrc = 0.

    TRY.
        DATA(lv_index) = find_method_use(
          it_statements = <ls_flow>-statements
          iv_method     = iv_method ).
      CATCH zcx_flow_not_found.
        RETURN.
    ENDTRY.

    READ TABLE <ls_flow>-statements ASSIGNING FIELD-SYMBOL(<ls_statement>) INDEX lv_index.
    ASSERT sy-subrc = 0.
    LOOP AT <ls_statement>-refs ASSIGNING FIELD-SYMBOL(<ls_ref>)
        WHERE mode2 = cl_abap_compiler=>mode2_read
        OR mode2 = cl_abap_compiler=>mode2_ref_read.
      APPEND <ls_ref>-full_name TO rt_uses.
    ENDLOOP.
    lv_index = lv_index - 1.

    DO.
      IF lv_index = 0.
        EXIT. " current loop
      ENDIF.

      READ TABLE <ls_flow>-statements ASSIGNING <ls_statement> INDEX lv_index.
      ASSERT sy-subrc = 0.

      LOOP AT <ls_statement>-refs ASSIGNING <ls_ref>
         WHERE mode2 = cl_abap_compiler=>mode2_read
         OR mode2 = cl_abap_compiler=>mode2_def.
* make sure one of the variables is used
        READ TABLE rt_uses WITH KEY table_line = <ls_ref>-full_name TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.

        BREAK-POINT.

      ENDLOOP.

      lv_index = lv_index - 1.
    ENDDO.

  ENDMETHOD.


  METHOD find_method_use.
* todo, change mt_flow to be object oriented? then this will be a method in the class

    LOOP AT it_statements ASSIGNING FIELD-SYMBOL(<ls_statement>).
      rv_index = sy-tabix.

      READ TABLE <ls_statement>-refs WITH KEY
        tag = cl_abap_compiler=>tag_method
        full_name = iv_method
        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
* todo, assumption: one usage of IV_METHOD per include
        RETURN.
      ENDIF.
    ENDLOOP.

    RAISE EXCEPTION TYPE zcx_flow_not_found.

  ENDMETHOD.


  METHOD get_result.

    rt_flow = mt_flow.

  ENDMETHOD.
ENDCLASS.
