class ZCL_FLOW_REF definition
  public
  create public .

public section.

  methods GET_GRADE
    returning
      value(RV_GRADE) type SCR_GRADE .
  methods CONSTRUCTOR
    importing
      !IV_FULL_NAME type STRING
      !IV_TAG type SCR_TAG
      !IV_MODE2 type CHAR1
      !IV_MODE1 type CHAR1
      !IV_GRADE type SCR_GRADE .
  methods GET_FULL_NAME
    returning
      value(RV_FULL_NAME) type STRING .
  methods GET_TAG
    returning
      value(RV_TAG) type SCR_TAG .
  methods GET_MODE1
    returning
      value(RV_MODE1) type CHAR1 .
  methods GET_MODE2
    returning
      value(RV_MODE2) type CHAR1 .
protected section.

  data MV_FULL_NAME type STRING .
  data MV_TAG type SCR_TAG .
  data MV_MODE2 type CHAR1 .
  data MV_MODE1 type CHAR1 .
  data MV_GRADE type SCR_GRADE .
private section.
ENDCLASS.



CLASS ZCL_FLOW_REF IMPLEMENTATION.


  METHOD constructor.

    mv_full_name = iv_full_name.
    mv_tag       = iv_tag.
    mv_mode2     = iv_mode2.
    mv_mode1     = iv_mode1.
    mv_grade     = iv_grade.

  ENDMETHOD.


  METHOD get_full_name.

    rv_full_name = mv_full_name.

  ENDMETHOD.


  method GET_GRADE.
  endmethod.


  METHOD get_mode1.

    rv_mode1 = mv_mode1.

  ENDMETHOD.


  METHOD get_mode2.

    rv_mode2 = mv_mode2.

  ENDMETHOD.


  METHOD get_tag.

    rv_tag = mv_tag.

  ENDMETHOD.
ENDCLASS.
