class ral_test extends uvm_test;
  ral_env env;
  ral_sequence_padrao_i seq;
  // ral_reg_sequence seq;

  `uvm_component_utils(ral_test)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ral_env::type_id::create("env", this);
    seq = ral_sequence_padrao_i::type_id::create("seq", this);
    // seq = ral_reg_sequence::type_id::create("seq", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    // phase.raise_objection(this);
      // if ( !seq.randomize() ) `uvm_error("", "Randomize failed on ral_test")
      //Setting sequence in seq
      // seq.reg_model       = env.reg_model;
      // seq.starting_phase = phase;
      seq.start(env.agent_i.sequencer);
    // phase.drop_objection(this);
  endtask: run_phase

endclass : ral_test

