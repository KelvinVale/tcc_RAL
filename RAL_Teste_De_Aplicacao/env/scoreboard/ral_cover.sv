
class ral_cover extends uvm_component;

  `uvm_component_utils(ral_cover)
  ral_transaction resp;
  uvm_analysis_imp#(ral_transaction, ral_cover) resp_port;

  int cont = 0;
  int limite;

 // ==========================  COBERTURA DAS RESPOSTAS =====================================
  covergroup resp_cover;
    option.per_instance = 1;
    option.at_least = 1;
    resp_saida:coverpoint resp.dt_o{
      bins pode[] = {[0:$]};
    }
  endgroup // resp_cover

  function new(string name = "subscriber", uvm_component parent= null);
    super.new(name, parent);
    resp_port   = new("resp_port", this);
    resp_cover  = new;
    resp        = new;

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    uvm_config_db#(int)::get(this, "", "min_trans", limite);
  endfunction

  protected uvm_phase running_phase;
  task run_phase(uvm_phase phase);
    running_phase = phase;
    running_phase.raise_objection(this);
  endtask: run_phase

  //============= Função para copiar transações do agent (Respostas) ========================
  function void write (ral_transaction t);
    cont ++;
    resp.copy(t);
    resp_cover.sample();

    $display("cobertura:%d",$get_coverage());
    if(($get_coverage() == 100) || (cont == limite))
    begin
      $display("\n\nCont = %d\n\n", cont);
      running_phase.drop_objection(this);
    end
  endfunction: write
endclass : ral_cover
