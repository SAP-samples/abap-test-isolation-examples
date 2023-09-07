class ltd_depended_on_component definition for testing.

  public section.
    interfaces zati_if_depended_on_component partially implemented.

    data m_result type i.

endclass.


class ltd_depended_on_component implementation.
  method zati_if_depended_on_component~add.
    r_sum = m_result.
  endmethod.
endclass.


class ltc_call_other_object definition for testing
  duration short risk level harmless.

  private section.
    data m_cut type ref to zati_if_code_under_test.

    methods setup                    raising cx_static_check.
    methods double_without_framework for testing raising cx_static_check.

endclass.


class ltc_call_other_object implementation.
  method setup.
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method double_without_framework.
    " Self-made Test Double
    " Given
    final(test_double) = new ltd_depended_on_component( ).
    test_double->m_result = 2.
    zati_th_injector=>inject_depended_on_component( test_double ).

    " When
    final(result) = m_cut->call_other_object( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 2 ).
  endmethod.
endclass.


class ltc_call_other_object_fw definition for testing
  duration short risk level harmless.

  private section.
    data m_cut type ref to zati_if_code_under_test.

    methods setup                 raising cx_static_check.
    methods double_with_framework for testing raising cx_static_check.

endclass.


class ltc_call_other_object_fw implementation.
  method setup.
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method double_with_framework.
    " ABAP Object Oriented Test Double Framework
    " Given
    final(test_double) = cast zati_if_depended_on_component( cl_abap_testdouble=>create( 'ZATI_if_depended_on_component' ) ).

    cl_abap_testdouble=>configure_call( test_double )->returning( 1 ).

    test_double->add( i_summand_1 = 1
                      i_summand_2 = 2 ).

    zati_th_injector=>inject_depended_on_component( test_double ).

    " When
    final(result) = m_cut->call_other_object( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 1 ).
  endmethod.
endclass.


class ltc_call_function_module definition for testing
  duration short risk level harmless.

  private section.
    class-data g_function_test_environment type ref to if_function_test_environment.

    class-methods class_setup.

    data m_cut type ref to zati_if_code_under_test.

    methods setup                raising cx_static_check.
    methods fm_answer_1_expect_1 for testing raising cx_static_check.
    methods fm_answer_2_expect_2 for testing raising cx_static_check.
    methods fm_answer_a_expect_a for testing raising cx_static_check.

endclass.


class ltc_call_function_module implementation.
  method class_setup.
    " Function Module Test Double Framework
    g_function_test_environment = cl_function_test_environment=>create( value #( ( 'POPUP_TO_CONFIRM' ) ) ).
  endmethod.

  method setup.
    g_function_test_environment->clear_doubles( ).
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method fm_answer_1_expect_1.
    " Given
    final(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    final(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 1 ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    final(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 1 ).
  endmethod.

  method fm_answer_2_expect_2.
    " Given
    final(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    final(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 2 ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    final(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 2 ).
  endmethod.

  method fm_answer_a_expect_a.
    " Given
    final(test_double) = g_function_test_environment->get_double( 'POPUP_TO_CONFIRM' ).
    final(test_double_output_config) = test_double->create_output_configuration(
                                         )->set_exporting_parameter( name  = 'ANSWER'
                                                                     value = 'A' ).
    test_double->configure_call( )->ignore_all_parameters(
        )->then_set_output( test_double_output_config ).

    " When
    final(result) = m_cut->call_function_module( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 'A' ).
  endmethod.
endclass.


class ltc_select_database_table definition for testing
  duration short risk level harmless.

  private section.
    types t_demo_sales_so_i type standard table of demo_sales_so_i with default key.

    class-data g_sql_environment type ref to if_osql_test_environment.

    class-methods class_setup.
    class-methods class_teardown.

    data m_cut type ref to zati_if_code_under_test.

    methods setup       raising cx_static_check.
    methods aggregation for testing raising cx_static_check.
    methods empty_table for testing raising cx_static_check.

endclass.


class ltc_select_database_table implementation.
  method class_setup.
    " ABAP SQL Test Double Framework
    g_sql_environment = cl_osql_test_environment=>create( value #( ( 'DEMO_SALES_SO_I' ) ) ).
  endmethod.

  method class_teardown.
    g_sql_environment->destroy( ).
  endmethod.

  method setup.
    g_sql_environment->clear_doubles( ).
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method aggregation.
    " Given
    g_sql_environment->insert_test_data( value t_demo_sales_so_i( ( so_item_key = '11' parent_key  = '1' )
                                                                  ( so_item_key = '12' parent_key  = '1' )
                                                                  ( so_item_key = '13' parent_key  = '1' )
                                                                  ( so_item_key = '21' parent_key  = '2' )
                                                                  ( so_item_key = '31' parent_key  = '3' ) ) ).

    " When
    final(result) = m_cut->select_database_table( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = lines( result )
                                        exp = 3 ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '1'
                                                                    itemcount  = 3 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '2'
                                                                    itemcount  = 1 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '3'
                                                                    itemcount  = 1 ] ) ) ).
  endmethod.

  method empty_table.
    " When
    final(result) = m_cut->select_database_table( ).

    " Then
    cl_abap_unit_assert=>assert_initial( result ).
  endmethod.
endclass.


class ltc_select_cds_entity definition for testing
  duration short risk level harmless.

  private section.
    types t_demo_sales_so_i type standard table of demo_sales_so_i with default key.

    class-data g_cds_environment type ref to if_cds_test_environment.

    class-methods class_setup.
    class-methods class_teardown.

    data m_cut type ref to zati_if_code_under_test.

    methods setup       raising cx_static_check.
    methods aggregation for testing raising cx_static_check.
    methods empty_table for testing raising cx_static_check.

endclass.


class ltc_select_cds_entity implementation.
  method class_setup.
    " ABAP CDS Test Double Framework
    g_cds_environment = cl_cds_test_environment=>create( 'ZATI_CDS_ENTITY' ).
  endmethod.

  method class_teardown.
    g_cds_environment->destroy( ).
  endmethod.

  method setup.
    g_cds_environment->clear_doubles( ).
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method aggregation.
    " Given
    g_cds_environment->insert_test_data( value t_demo_sales_so_i( ( so_item_key = '11' parent_key  = '1' )
                                                                  ( so_item_key = '12' parent_key  = '1' )
                                                                  ( so_item_key = '13' parent_key  = '1' )
                                                                  ( so_item_key = '21' parent_key  = '2' )
                                                                  ( so_item_key = '31' parent_key  = '3' ) ) ).

    " When
    final(result) = m_cut->select_cds_entity( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = lines( result )
                                        exp = 3 ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '1'
                                                                    itemcount  = 3 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '2'
                                                                    itemcount  = 1 ] ) ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( line_exists( result[ salesorder = '3'
                                                                    itemcount  = 1 ] ) ) ).
  endmethod.

  method empty_table.
    " When
    final(result) = m_cut->select_cds_entity( ).

    " Then
    cl_abap_unit_assert=>assert_initial( result ).
  endmethod.
endclass.


class ltc_call_authority_check definition for testing
  duration short risk level harmless.

  private section.
    data m_cut type ref to zati_if_code_under_test.

    methods setup                 raising cx_static_check.
    methods display_authorization for testing raising cx_static_check.
    methods edit_authorization    for testing raising cx_static_check.

endclass.


class ltc_call_authority_check implementation.
  method setup.
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method display_authorization.
    " Classic ABAP Authority Check Test Helper API
    " Given
    final(develop_authorization) = value cl_aunit_auth_check_types_def=>user_role_authorizations(
        ( role_authorizations = value #(
              ( object         = 'S_DEVELOP'
                authorizations = value #( ( value #( ( fieldname   = 'ACTVT'
                                                       fieldvalues = value #( ( lower_value = '03' ) ) ) ) ) ) ) ) ) ).

    final(authorization_object_set) = cl_aunit_authority_check=>create_auth_object_set( develop_authorization ).
    cl_aunit_authority_check=>get_controller( )->restrict_authorizations_to( authorization_object_set ).

    " When
    final(result) = m_cut->call_authority_check( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 4 ).
  endmethod.

  method edit_authorization.
    " Given
    final(develop_authorization) = value cl_aunit_auth_check_types_def=>user_role_authorizations(
        ( role_authorizations = value #(
              ( object         = 'S_DEVELOP'
                authorizations = value #( ( value #( ( fieldname   = 'ACTVT'
                                                       fieldvalues = value #( ( lower_value = '02' ) ) ) ) ) ) ) ) ) ).

    final(authorization_object_set) = cl_aunit_authority_check=>create_auth_object_set( develop_authorization ).
    cl_aunit_authority_check=>get_controller( )->restrict_authorizations_to( authorization_object_set ).

    " When
    final(result) = m_cut->call_authority_check( ).

    " Then
    cl_abap_unit_assert=>assert_equals( act = result
                                        exp = 0 ).
  endmethod.
endclass.


class ltd_fields_handler definition create public for testing.

  public section.
    interfaces if_botd_bufdbl_fields_handler.

  private section.
    data max_travel_id type /dmo/travel_id value 0.

endclass.


class ltd_fields_handler implementation.
  method if_botd_bufdbl_fields_handler~set_readonly_fields.
    types ty_create_instances type table for create /dmo/i_travel_m.

    field-symbols <create_instances> type ty_create_instances.

    case entity_name.
      when '/DMO/I_TRAVEL_M'.
        case operation.
          when if_abap_behv=>op-m-create.
            assign instances to <create_instances>.
            loop at <create_instances> assigning field-symbol(<instance>).
              max_travel_id += 1.
              <instance>-travel_id = max_travel_id.
            endloop.
        endcase.
    endcase.
  endmethod.
endclass.


class ltcl_call_rap_bo_tx_bf_dbl definition final for testing
  duration short
  risk level harmless.

  private section.
    class-data g_rap_buffer_environment type ref to if_botd_txbufdbl_bo_test_env.

    class-methods class_setup.
    class-methods class_teardown.

    data m_cut type ref to zati_if_code_under_test.

    methods setup.
    methods isolate_create_ba_to_pass for testing raising cx_static_check.

endclass.


class ltcl_call_rap_bo_tx_bf_dbl implementation.
  method class_setup.
    final(env_config) = cl_botd_txbufdbl_bo_test_env=>prepare_environment_config(
                            )->set_bdef_dependencies( value #( ( '/DMO/I_TRAVEL_M' ) ) ).
    g_rap_buffer_environment = cl_botd_txbufdbl_bo_test_env=>create( env_config ).
  endmethod.

  method class_teardown.
    g_rap_buffer_environment->destroy( ).
  endmethod.

  method setup.
    g_rap_buffer_environment->clear_doubles( ).
    final(double) = g_rap_buffer_environment->get_test_double( '/DMO/I_TRAVEL_M' ).
    double->configure_additional_behavior( )->set_fields_handler( new ltd_fields_handler( ) ).

    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method isolate_create_ba_to_pass.
    " When
    m_cut->call_rap_business_object( importing e_reported = final(reported)
                                               e_failed   = final(failed)
                                               e_mapped   = final(mapped) ).

    " Then
    cl_abap_unit_assert=>assert_initial( reported ).
    cl_abap_unit_assert=>assert_initial( failed ).
    cl_abap_unit_assert=>assert_not_initial( mapped ).
    cl_abap_unit_assert=>assert_initial( mapped-booking ).
    cl_abap_unit_assert=>assert_initial( mapped-booksuppl ).
    cl_abap_unit_assert=>assert_not_initial( mapped-travel ).
    cl_abap_unit_assert=>assert_equals( act = lines( mapped-travel ) exp = 1 ).
  endmethod.
endclass.


class ltcl_call_rap_bo_mock_eml_api definition final for testing
  duration short
  risk level harmless.

  private section.
    class-data g_mock_eml_api_environment type ref to if_botd_mockemlapi_bo_test_env.

    class-methods class_setup.
    class-methods class_teardown.

    data m_cut type ref to zati_if_code_under_test.

    methods setup.
    methods isolate_create_ba_to_pass for testing raising cx_static_check.

endclass.


class ltcl_call_rap_bo_mock_eml_api implementation.
  method class_setup.
    final(env_config) = cl_botd_mockemlapi_bo_test_env=>prepare_environment_config(
                            )->set_bdef_dependencies( value #( ( '/DMO/I_TRAVEL_M' ) ) ).
    g_mock_eml_api_environment = cl_botd_mockemlapi_bo_test_env=>create( env_config ).
  endmethod.

  method class_teardown.
    g_mock_eml_api_environment->destroy( ).
  endmethod.

  method setup.
    g_mock_eml_api_environment->clear_doubles( ).
    m_cut = zati_cl_factory=>get_code_under_test( ).
  endmethod.

  method isolate_create_ba_to_pass.
    data mapped_double type response for mapped /dmo/i_travel_m.

    " Given
    mapped_double-travel = value #( ( %cid = 'Travel_1' travel_id = '1' ) ).
    final(output_config_builder_4_modify) = cl_botd_mockemlapi_bldrfactory=>get_output_config_builder( )->for_modify( ).
    final(output) = output_config_builder_4_modify->build_output_for_eml( )->set_mapped( mapped_double ).
    final(double) = g_mock_eml_api_environment->get_test_double( '/DMO/I_TRAVEL_M' ).
    double->configure_call( )->for_modify( )->ignore_input( )->then_set_output( output ).

    " When
    m_cut->call_rap_business_object( importing e_reported = final(reported)
                                               e_failed   = final(failed)
                                               e_mapped   = final(mapped) ).
    " Then
    cl_abap_unit_assert=>assert_initial( reported ).
    cl_abap_unit_assert=>assert_initial( failed ).
    cl_abap_unit_assert=>assert_not_initial( mapped ).
    cl_abap_unit_assert=>assert_initial( mapped-booking ).
    cl_abap_unit_assert=>assert_initial( mapped-booksuppl ).
    cl_abap_unit_assert=>assert_not_initial( mapped-travel ).
    cl_abap_unit_assert=>assert_equals( act = lines( mapped-travel ) exp = 1 ).
  endmethod.
endclass.
