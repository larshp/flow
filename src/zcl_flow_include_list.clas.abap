CLASS zcl_flow_include_list DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:
      mt_includes TYPE STANDARD TABLE OF REF TO zcl_flow_include READ-ONLY.

    METHODS find
      IMPORTING
        !iv_name          TYPE programm
      RETURNING
        VALUE(ro_include) TYPE REF TO zcl_flow_include
      RAISING
        zcx_flow_not_found .
    METHODS find_or_append
      IMPORTING
        !iv_name          TYPE programm
      RETURNING
        VALUE(ro_include) TYPE REF TO zcl_flow_include .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FLOW_INCLUDE_LIST IMPLEMENTATION.


  METHOD find.

    LOOP AT mt_includes INTO ro_include.
      IF ro_include->get_name( ) = iv_name.
        RETURN.
      ENDIF.
    ENDLOOP.

    RAISE EXCEPTION TYPE zcx_flow_not_found.

  ENDMETHOD.


  METHOD find_or_append.

    LOOP AT mt_includes INTO ro_include.
      IF ro_include->get_name( ) = iv_name.
        RETURN.
      ENDIF.
    ENDLOOP.

    CREATE OBJECT ro_include
      EXPORTING
        iv_name = iv_name.

    APPEND ro_include TO mt_includes.

  ENDMETHOD.
ENDCLASS.
