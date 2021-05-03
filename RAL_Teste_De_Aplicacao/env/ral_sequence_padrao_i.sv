class ral_sequence_padrao_i extends uvm_sequence#(ral_transaction);

	`uvm_object_param_utils(ral_sequence_padrao_i)

	typedef ral_transaction transaction_type;

	function new(string name = "");
		super.new(name);
	endfunction

	task body();
		transaction_type tr;
		forever begin
			tr = transaction_type::type_id::create("tr");
			`uvm_do(tr)
			// start_item(tr);
			// 	assert(tr.randomize());
			// finish_item(tr);
		end
	endtask
endclass : ral_sequence_padrao_i