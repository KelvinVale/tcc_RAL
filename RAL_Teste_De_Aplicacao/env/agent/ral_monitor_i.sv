class ral_monitor_i extends uvm_monitor;
	
	interface_vif vif;
	ral_transaction tr;
	
	event begin_record, end_record;
	
	uvm_analysis_port #(ral_transaction) mon_ral_i_tr_analysis_port; 
										// NomeDoModulo_NomeDaTransacao_tr_NomeDaPorta

	`uvm_component_utils(ral_monitor_i)

	function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_ral_i_tr_analysis_port = new("mon_ral_i_tr_analysis_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
			`uvm_fatal("NO_VIF", "ral_monitor_i: falha no get da interface_vif")
		end

		tr = ral_transaction::type_id::create("tr",this);	
	endfunction : build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase (phase);
		fork
			monitoramento();
			record_tr();
		join
	endtask : run_phase

	virtual task monitoramento();
		@(posedge vif.rst_n);
		forever
		begin
			@(posedge vif.clk iff(vif.r_w_i == 1'b1));
			-> begin_record;
				tr.add_i  	<= vif.add_i;
				tr.dt_i  	<= vif.dt_i;
			->end_record;
			mon_ral_i_tr_analysis_port.write(tr);
		end
	endtask : monitoramento

	virtual task record_tr();
		forever 
		begin 	
			@begin_record;
			begin_tr(tr, "ral_monitor_i: tr");
			@end_record;
			end_tr(tr);
		end
	endtask : record_tr
	
endclass : ral_monitor_i
