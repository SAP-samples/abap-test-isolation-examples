interface zati_if_code_under_test public.

  types t_items_per_sales_order type hashed table of zati_cds_entity with unique key salesorder.
  types t_failed                type response for failed /dmo/i_travel_m.
  types t_reported              type response for reported /dmo/i_travel_m.
  types t_mapped                type response for mapped /dmo/i_travel_m.

  methods call_other_object     returning value(r_result) type i.

  methods select_database_table returning value(r_result) type t_items_per_sales_order.

  methods select_cds_entity     returning value(r_result) type t_items_per_sales_order.

  methods call_function_module  returning value(r_result) type char1.

  methods call_authority_check  returning value(r_result) type i.

  methods call_rap_business_object exporting e_reported type t_reported
                                             e_failed   type t_failed
                                             e_mapped   type t_mapped.

endinterface.
