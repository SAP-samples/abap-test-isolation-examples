class zati_th_injector definition
  public
  final
  for testing
  create private.

  public section.
    class-methods
      inject_code_under_test
        importing i_double type ref to zati_if_code_under_test.

    class-methods
      inject_depended_on_component
        importing i_double type ref to zati_if_depended_on_component.

    class-methods
      clear.
endclass.


class zati_th_injector implementation.
  method clear.
    clear zati_cl_factory=>g_code_under_test.
    clear zati_cl_factory=>g_depended_on_component.
  endmethod.

  method inject_code_under_test.
    zati_cl_factory=>g_code_under_test = i_double.
  endmethod.

  method inject_depended_on_component.
    zati_cl_factory=>g_depended_on_component = i_double.
  endmethod.
endclass.
