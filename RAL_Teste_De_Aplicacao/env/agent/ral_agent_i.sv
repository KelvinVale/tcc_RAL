typedef uvm_sequencer#(ral_transaction) sequencer_type;


class ral_agent_i extends uvm_agent;
	`uvm_component_param_utils(ral_agent_i)

	typedef ral_transaction transaction_type;
	typedef ral_driver_i driver_type;
	typedef ral_monitor_i monitor_type;

	uvm_analysis_port#(transaction_type) agt_ral_i_tr_analysis_port;

	sequencer_type sequencer;
	driver_type driver;
	monitor_type monitor;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt_ral_i_tr_analysis_port = new("agt_ral_i_tr_analysis_port", this);

		sequencer = sequencer_type::type_id::create("sequencer", this);
		driver = driver_type::type_id::create("driver", this);
		monitor = monitor_type::type_id::create("monitor", this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver.seq_item_port.connect(sequencer.seq_item_export);
		monitor.mon_ral_i_tr_analysis_port.connect(agt_ral_i_tr_analysis_port);

	endfunction

endclass: ral_agent_i
