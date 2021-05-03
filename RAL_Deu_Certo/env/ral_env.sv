class ral_env extends uvm_env;
	`uvm_component_utils(ral_env)

	block_reg_ral reg_model;
	ral_adapter reg_adapter;

	ral_agent_i agent_i;
	ral_agent_o agent_o;

	ral_scoreboard scoreboard;

	ral_cover cobertura;

	function new(string name, uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		reg_model = block_reg_ral::type_id::create("reg_model", this);
		reg_model.build();
		reg_adapter = ral_adapter::type_id::create("reg_adapter",, get_full_name());

		agent_i = ral_agent_i::type_id::create("agent_i", this);
		agent_o = ral_agent_o::type_id::create("agent_o", this);

		scoreboard = ral_scoreboard::type_id::create("scoreboard", this);

		cobertura = ral_cover::type_id::create("cobertura", this);
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		// reg_model e reg_adapter
		reg_model.default_map.set_sequencer(.sequencer(agent_i.sequencer), .adapter(reg_adapter));
		reg_model.default_map.set_base_addr('h0);

		//agent_i
		agent_i.agt_ral_i_tr_analysis_port.connect(scoreboard.to_rfm_analysis_port);

		//agent_o
		agent_o.agt_ral_o_tr_analysis_port.connect(cobertura.resp_port);
		agent_o.agt_ral_o_tr_analysis_port.connect(scoreboard.to_comp_analysis_port);
	endfunction : connect_phase

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
	endfunction : end_of_elaboration_phase

endclass : ral_env
