
class ral_refmod extends uvm_component;
  `uvm_component_utils(ral_refmod)

  typedef ral_transaction tr_type_in;
  typedef ral_transaction tr_type_out;

  tr_type_in tr_in;
  tr_type_out tr_out;

  // block_reg_ral block_register;

  uvm_analysis_imp #(tr_type_in, ral_refmod) refmod_ral_i_tr_analysis_imp;
  uvm_analysis_port #(tr_type_out) refmod_ral_o_tr_analysis_port;
  
  event begin_record, end_record, begin_refmodtask;
  
//======================= Construtor =======================================
  function new(string name = "ral_refmod", uvm_component parent);
    super.new(name, parent);
    refmod_ral_i_tr_analysis_imp = new("refmod_ral_i_tr_analysis_imp", this);
    refmod_ral_o_tr_analysis_port = new("refmod_ral_o_tr_analysis_port", this);
  endfunction

//====================== Build Phase =======================================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // block_register = create_map( .name( "block_register"));
  endfunction: build_phase

//======================= Run Phase ========================================
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      // reset_funcion();
      refmod_task();
      record_tr_out();
    join
  endtask: run_phase

// //============ Função para reset ======================
//   virtual task reset_funcion();
//     forever begin
//       @(negedge vif.rst_n);
//       block_register.reset();
//       @(posedge vif.rst_n);
//       -> reset_feito;
//     end
//   endtask : reset_funcion


//============ Função para copiar transações do agent ======================
  virtual function write ( tr_type_in t);
    tr_in = tr_type_in::type_id::create("tr_in", this);
    tr_in.copy(t);
    $display("add_write: %h e data_write: %h",tr_in.add_i, tr_in.dt_i);
   -> begin_refmodtask;
  endfunction

//============ Função para analisar leitura/escrita ========================
  task refmod_task();
    forever 
    begin
      @begin_refmodtask;
      if (tr_in.r_w_i==0) begin
        tr_out = tr_type_out::type_id::create("tr_out", this);
        -> begin_record;
        // block_register.read_reg_by_name
        -> end_record;
        refmod_ral_o_tr_analysis_port.write(tr_out);
      end
    end
  endtask

//================= Função para gravar as transações ========================
  virtual task record_tr_out();
    forever begin
      @(begin_record);
      begin_tr(tr_out, "rfm");
      @(end_record);
      end_tr(tr_out);
    end
  endtask
endclass: ral_refmod
