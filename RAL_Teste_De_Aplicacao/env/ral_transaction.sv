class ral_transaction extends uvm_sequence_item;
	rand logic unsigned [2:0] add_i;
	rand logic unsigned [7:0] dt_i;
	rand logic unsigned r_w_i;

	rand logic unsigned [7:0] dt_o;


	`uvm_object_utils_begin(ral_transaction)
		`uvm_field_int(add_i, UVM_ALL_ON|UVM_HEX)
		`uvm_field_int(dt_i, UVM_ALL_ON|UVM_HEX)
		`uvm_field_int(r_w_i, UVM_ALL_ON|UVM_HEX)
		`uvm_field_int(dt_o, UVM_ALL_ON|UVM_HEX)
	`uvm_object_utils_end

	function new(string name = "ral_transaction");
		super.new(name);	
	endfunction : new

	function string convert2string();
		return $sformatf("{add_i = %h, dt_i = %h, r_w_i = %h, dt_o = %h}", add_i, dt_i, r_w_i, dt_o);
	endfunction

	function void do_copy(uvm_object rhs);
        ral_transaction rhs_;

        if(!$cast(rhs_, rhs)) begin
          `uvm_fatal("do_copy", "cast of rhs object failed")
        end
        super.do_copy(rhs);
		add_i	= rhs_.add_i;
		dt_i	= rhs_.dt_i;
		r_w_i	= rhs_.r_w_i;
		dt_o	= rhs_.dt_o;
    endfunction : do_copy

endclass : ral_transaction
