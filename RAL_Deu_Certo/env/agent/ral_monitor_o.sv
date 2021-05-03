class ral_monitor_o extends uvm_monitor;
	
	ral_transaction tr;
	interface_vif vif;
	
	event begin_record, end_record;
	
	uvm_analysis_port #(ral_transaction) mon_ral_o_tr_analysis_port; 
										// NomeDoModulo_NomeDaTransacao_tr_NomeDaPorta

	`uvm_component_utils(ral_monitor_o)

	function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_ral_o_tr_analysis_port = new("mon_ral_o_tr_analysis_port", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		assert (uvm_config_db#(interface_vif)::get(this, "", "vif", vif))
			else `uvm_fatal("NO_VIF", "ral_monitor_o: falha no get da interface_vif");

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
		forever
		begin
			@(posedge vif.clk iff(vif.r_w_i == 1'b0));
			->begin_record;
			tr.dt_o = vif.dt_o;
			->end_record;
			mon_ral_o_tr_analysis_port.write(tr);
		end
	endtask : monitoramento

	virtual task record_tr();
		forever 
		begin 	
			@begin_record;
			begin_tr(tr, "ral_monitor_o: tr");
			@end_record;
			end_tr(tr);
		end
	endtask : record_tr
	
endclass : ral_monitor_o

