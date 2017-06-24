class ZCL_FLOW_REF_LIST definition
  public
  create public .

public section.

  data:
    mt_refs TYPE STANDARD TABLE OF REF TO zcl_flow_ref read-only .

  methods APPEND
    importing
      !IO_REF type ref to ZCL_FLOW_REF .
  methods IS_REFERENCED
    importing
      !IV_FULL_NAME type STRING
      !IV_TAG type SCR_TAG
    returning
      value(RV_USED) type ABAP_BOOL .
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS ZCL_FLOW_REF_LIST IMPLEMENTATION.


  METHOD append.

    APPEND io_ref TO mt_refs.

  ENDMETHOD.


  METHOD IS_REFERENCED.

    LOOP AT mt_refs INTO DATA(lo_ref).
      IF lo_ref->get_full_name( ) = iv_full_name
          AND lo_ref->get_tag( ) = iv_tag.
        rv_used = abap_true.
        RETURN.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
