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
protected section.
private section.
ENDCLASS.



CLASS ZCL_FLOW_NAME_LIST IMPLEMENTATION.


  METHOD append.

    APPEND iv_name TO mt_names.

  ENDMETHOD.


  METHOD clone.

    CREATE OBJECT ro_list.
    ro_list->mt_names = mt_names.

  ENDMETHOD.


  METHOD remove.

    DELETE mt_names WHERE table_line = iv_name.

  ENDMETHOD.
ENDCLASS.
