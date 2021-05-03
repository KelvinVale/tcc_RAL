
class ral_scoreboard extends uvm_scoreboard;

  typedef ral_transaction transa_o;
  typedef ral_transaction transa_i;
  typedef uvm_in_order_class_comparator #(transa_o) comp_type;
  ral_refmod rfm;
  comp_type comp;

  uvm_analysis_port #(transa_o) to_comp_analysis_port;
  uvm_analysis_port #(transa_i) to_rfm_analysis_port;

  `uvm_component_utils(ral_scoreboard)

  function new(string name = "translator", uvm_component parent = null);
    super.new(name, parent);
    to_comp_analysis_port = new("to_comp_analysis_port", this);
    to_rfm_analysis_port = new("to_rfm_analysis_port", this);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rfm = ral_refmod::type_id::create("rfm", this);
    comp = comp_type::type_id::create("comp", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    to_comp_analysis_port.connect(comp.before_export);
    to_rfm_analysis_port.connect(rfm.refmod_ral_i_tr_analysis_imp);
    rfm.refmod_ral_o_tr_analysis_port.connect(comp.after_export);
  endfunction
endclass : ral_scoreboard
