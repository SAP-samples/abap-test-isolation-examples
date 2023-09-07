class zati_cl_code_under_test definition
  public
  create private
  global friends zati_cl_factory.

  public section.
    interfaces zati_if_code_under_test.

  protected section.

  private section.
endclass.


class zati_cl_code_under_test implementation.
  method zati_if_code_under_test~call_other_object.
    final(doc) = zati_cl_factory=>get_depended_on_component( ).
    r_result = doc->add( i_summand_1 = 1
                         i_summand_2 = 2 ).
  endmethod.

  method zati_if_code_under_test~call_function_module.
    call function 'POPUP_TO_CONFIRM'
      exporting text_question = 'Do you want this?'
      importing answer        = r_result.
  endmethod.

  method zati_if_code_under_test~select_database_table.
    select from demo_sales_so_i
           fields parent_key as salesorder, count( so_item_key ) as itemcount
           group by parent_key
           into table @r_result.
  endmethod.

  method zati_if_code_under_test~select_cds_entity.
    select from zati_cds_entity
           fields salesorder, itemcount
           into table @r_result.
  endmethod.

  method zati_if_code_under_test~call_authority_check.
    authority-check object 'S_DEVELOP'
                    id 'ACTVT' field '02'.
    r_result = sy-subrc.
  endmethod.

  method zati_if_code_under_test~call_rap_business_object.
    modify entities of /dmo/i_travel_m
           entity travel
           create from value #( ( %cid                 = 'Travel_1'
                                  agency_id            = '000111'
                                  customer_id          = '000006'
                                  description          = 'Travel 1'
                                  %control-agency_id   = if_abap_behv=>mk-on
                                  %control-customer_id = if_abap_behv=>mk-on
                                  %control-description = if_abap_behv=>mk-on ) )
           reported e_reported
           failed e_failed
           mapped e_mapped.
  endmethod.
endclass.
