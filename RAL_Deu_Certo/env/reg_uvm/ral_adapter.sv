class ral_adapter extends  uvm_reg_adapter;
	`uvm_object_utils (ral_adapter)

	function new (string name = "ral_adapter");
		super.new(name);
	endfunction : new

	function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
		ral_transaction tx;
		tx = ral_transaction::type_id::create("tx");

		tx.r_w_i = (rw.kind == UVM_WRITE);
		tx.add_i = rw.addr;
		if (tx.r_w_i) 
			tx.dt_i = rw.data;
		else
			begin 
				tx.dt_o = rw.data;
				tx.dt_i = '0;
			end

		return tx;
	endfunction : reg2bus

	function void bus2reg (uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		ral_transaction tx;

		assert($cast(tx, bus_item))
			else `uvm_fatal("","Erro no cast em ral_adapter.sv -> bus2reg()")

		rw.kind = tx.r_w_i ? UVM_WRITE : UVM_READ; //Se 1, UVM_WRITE. Se 0, UVM_READ.
		rw.addr = tx.add_i;
		rw.data = tx.dt_o;

		rw.status = UVM_IS_OK;
	endfunction : bus2reg

endclass : ral_adapter