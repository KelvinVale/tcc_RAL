// import "DPI-C" context function int uvm_hdl_check_path (string path);

class ral_test_2 extends uvm_test;
  ral_env env;
  ral_reg_sequence seq;

  `uvm_component_utils(ral_test_2)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (uvm_hdl_check_path("ral_top.dut.Banco[3]")) begin
      `uvm_info("TEST", "existe o hdl path", UVM_MEDIUM)
    end
    else begin 
      `uvm_info("TEST", "NAO existe o hdl path", UVM_MEDIUM)
    end

    env = ral_env::type_id::create("env", this);
    seq = ral_reg_sequence::type_id::create("seq", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      if ( !seq.randomize() ) `uvm_error("", "Randomize failed on ral_test_2")
      // Setting sequence in seq
      seq.reg_model      = env.reg_model;
      seq.starting_phase = phase;
    phase.drop_objection(this);
      seq.start(env.agent_i.sequencer);
  endtask: run_phase

endclass : ral_test_2

