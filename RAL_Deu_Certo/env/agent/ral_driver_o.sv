//typedef virtual ral_if.mst interface_vif;

class ral_driver_o extends uvm_driver#(ral_transaction);
	`uvm_component_param_utils(ral_driver_o)
	
	typedef ral_transaction tr_type;

	interface_vif vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
			`uvm_fatal("NOVIF", "failed to get virtual interface")
		end
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	task run_phase (uvm_phase phase);
		super.run_phase (phase);
	endtask

	virtual task reset_funcion();
    endtask : reset_funcion

endclass: ral_driver_o