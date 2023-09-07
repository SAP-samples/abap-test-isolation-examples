interface zati_if_depended_on_component public.

  methods add importing i_summand_1  type i
                        i_summand_2  type i
              returning value(r_sum) type i.

  methods subtract importing i_minuend           type i
                             i_subtrahend        type i
                   returning value(r_difference) type i.

endinterface.
