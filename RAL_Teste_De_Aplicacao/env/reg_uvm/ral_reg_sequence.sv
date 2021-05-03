class ral_reg_sequence extends uvm_sequence#(ral_transaction);

	`uvm_object_param_utils(ral_reg_sequence)

	block_reg_ral reg_model;

	uvm_reg_item rw;

	int val_lido;
	int val_lido_2;
	// uvm_reg_item val_lido;


	typedef ral_transaction transaction_type;

	function new(string name = "");
		super.new(name);

		rw = uvm_reg_item::type_id::create("write_item",,get_full_name());
		rw.element      = this;
		rw.element_kind = UVM_REG;
		rw.kind         = UVM_WRITE;
		rw.value[0]     = 8'hCA;
		rw.path         = "ral_top.dut.Banco[3]";
		rw.map          = null;
		rw.parent       = null;
		rw.prior        = -1;
		rw.extension    = null;
		rw.fname        = "";
		rw.lineno       = 0;

		// val_lido = uvm_reg_item::type_id::create("val_lido",,get_full_name());

	endfunction

	task body();
		uvm_status_e status;
		uvm_reg_data_t incoming;
		bit[7:0] rdata;

		// if (starting_phase != null) begin
		// 	starting_phase.raise_objection(this);
		// end

		reg_model.reg_leitura_field.write(status, 8'h30);
		reg_model.reg_banco_field[0].write(status, 8'hA0);
		reg_model.reg_banco_field[1].write(status, 8'h0A);
		reg_model.reg_banco_field[4].write(status, 8'h04);
		reg_model.reg_banco_field[6].write(status, 8'h70);
		reg_model.reg_banco_field[3].write(status, 8'h24);
		reg_model.reg_banco_field[5].write(status, 8'hf1);
		reg_model.reg_banco_field[2].write(status, 8'h8A);

		forever 
		begin 
			reg_model.reg_leitura_field.read(status, rdata);
			reg_model.reg_banco_field[0].read(status, rdata);
			reg_model.reg_banco_field[1].read(status, rdata);
			reg_model.reg_banco_field[4].read(status, rdata);
			
			rw.value[0]     = $urandom_range(0,200);
			rw.path         = "ral_top.dut.Banco[3]";
			reg_model.reg_banco_field[4].backdoor_write(rw);

			reg_model.reg_banco_field[6].read(status, rdata);
			reg_model.reg_banco_field[3].read(status, rdata);
			reg_model.reg_banco_field[5].read(status, rdata);
			reg_model.reg_banco_field[2].read(status, rdata);

			rw.value[0]     = $urandom_range(0,200);
			rw.path         = "ral_top.dut.reg_leitura";
			reg_model.reg_leitura_field.backdoor_write(rw);
			reg_model.reg_leitura_field.backdoor_read(rw);

			val_lido = int'(rw.value);

			reg_model.reg_banco_field[4].read(status, rdata);
			rw.path         = "ral_top.dut.Banco[3]";
			rw.value[0]     = $urandom_range(0,200);
			reg_model.reg_banco_field[4].backdoor_write(rw);
			
			rw.path         = "ral_top.dut.reg_leitura";
			reg_model.reg_leitura_field.backdoor_read(rw);
			$display("Leitura realizada, valor: %d", rw.value[0]);

			val_lido_2 = int'(rw.value);
			if ($urandom_range(0,5) == 3) 
				begin
					reg_model.reg_leitura_field.read(status, rdata);
				end

			while(val_lido == val_lido_2)
				begin 
					reg_model.reg_banco_field[4].read(status, rdata);
					rw.path         = "ral_top.dut.Banco[3]";
					rw.value[0]     = $urandom_range(0,200);
					reg_model.reg_banco_field[4].backdoor_write(rw);
					
					rw.path         = "ral_top.dut.reg_leitura";
					reg_model.reg_leitura_field.backdoor_read(rw);
					$display("Leitura realizada, valor: %d", rw.value[0]);

					val_lido_2 = int'(rw.value);
					if ($urandom_range(0,5) == 3) 
						begin
							reg_model.reg_leitura_field.read(status, rdata);
						end
				end

		end

		// if (starting_phase != null) begin
		// 	starting_phase.drop_objection(this);
		// end

	endtask
endclass : ral_reg_sequence

// backdoor_write