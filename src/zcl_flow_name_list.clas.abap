class ZCL_FLOW_NAME_LIST definition
  public
  create public .

public section.

  data MT_NAMES type STRING_TABLE read-only .

  methods APPEND
    importing
      !IV_NAME type STRING .
  methods CLONE
    returning
      value(RO_LIST) type ref to ZCL_FLOW_NAME_LIST .
  methods REMOVE
    importing
      !IV_NAME type STRING .
  methods APPEND_LIST
    importing
      !IO_LIST type ref to ZCL_FLOW_NAME_LIST .
  methods CONTAINS
    importing
      !IV_NAME type STRING
    returning
      value(RV_CONTAINS) type ABAP_BOOL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_NAME_LIST IMPLEMENTATION.


  METHOD append.

    APPEND iv_name TO mt_names.

  ENDMETHOD.


  METHOD append_list.

    APPEND LINES OF io_list->mt_names TO mt_names.

    SORT mt_names ASCENDING.
    DELETE ADJACENT DUPLICATES FROM mt_names.

  ENDMETHOD.


  METHOD clone.

    CREATE OBJECT ro_list.
    ro_list->mt_names = mt_names.

  ENDMETHOD.


  METHOD contains.

    READ TABLE mt_names WITH KEY table_line = iv_name TRANSPORTING NO FIELDS.
    rv_contains = boolc( sy-subrc = 0 ).

  ENDMETHOD.


  METHOD remove.

    DELETE mt_names WHERE table_line = iv_name.

  ENDMETHOD.
ENDCLASS.
