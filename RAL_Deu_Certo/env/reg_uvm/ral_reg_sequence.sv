class ral_reg_sequence extends uvm_sequence#(ral_transaction);

	`uvm_object_param_utils(ral_reg_sequence)

	block_reg_ral reg_model;

	uvm_reg_item rw;


	typedef ral_transaction transaction_type;

	function new(string name = "");
		super.new(name);

		rw = uvm_reg_item::type_id::create("write_item",,get_full_name());
		rw.element      = this;
		rw.element_kind = UVM_REG;
		rw.kind         = UVM_WRITE;
		rw.value[0]     = 8'hCA;
		rw.path         = "ral_top.dut.Banco[4]";
		rw.map          = null;
		rw.parent       = null;
		rw.prior        = -1;
		rw.extension    = null;
		rw.fname        = "";
		rw.lineno       = 0;
	endfunction

	task body();
		uvm_status_e status;
		uvm_reg_data_t incoming;
		bit[7:0] rdata;

		// if (starting_phase != null) begin
		// 	starting_phase.raise_objection(this);
		// end

		reg_model.reg_field[0].write(status, 8'hA0);
		reg_model.reg_field[1].write(status, 8'h0A);
		reg_model.reg_field[7].write(status, 8'h30);
		reg_model.reg_field[4].write(status, 8'h04);
		reg_model.reg_field[6].write(status, 8'h70);
		reg_model.reg_field[3].write(status, 8'h24);
		reg_model.reg_field[5].write(status, 8'hf1);
		reg_model.reg_field[2].write(status, 8'h8A);

		forever 
		begin 
			reg_model.reg_field[0].read(status, rdata);
			reg_model.reg_field[1].read(status, rdata);
			reg_model.reg_field[7].read(status, rdata);
			reg_model.reg_field[4].read(status, rdata);
			reg_model.reg_field[4].backdoor_write(rw);
			reg_model.reg_field[6].read(status, rdata);
			reg_model.reg_field[3].read(status, rdata);
			reg_model.reg_field[5].read(status, rdata);
			reg_model.reg_field[2].read(status, rdata);
		end

		// if (starting_phase != null) begin
		// 	starting_phase.drop_objection(this);
		// end

	endtask
endclass : ral_reg_sequence

// backdoor_write