class zati_cl_depended_on_component definition
  public
  create private
  global friends zati_cl_factory.

  public section.
    interfaces zati_if_depended_on_component.

  protected section.

  private section.

endclass.


class zati_cl_depended_on_component implementation.
  method zati_if_depended_on_component~add.
    assert 1 = 0.
  endmethod.

  method zati_if_depended_on_component~subtract.
    r_difference = i_minuend - i_subtrahend.
  endmethod.
endclass.
