package ral_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

`include "../env/ral_transaction.sv"

`include "../env/reg_uvm/ral_adapter.sv"
`include "../env/reg_uvm/reg_ral.sv"
`include "../env/reg_uvm/block_reg_ral.sv"

`include "../env/ral_sequence_padrao_i.sv"
`include "../env/reg_uvm/ral_reg_sequence.sv"

`include "../env/agent/ral_driver_i.sv"
`include "../env/agent/ral_driver_o.sv"
`include "../env/agent/ral_monitor_i.sv"
`include "../env/agent/ral_monitor_o.sv"
`include "../env/agent/ral_agent_i.sv"
`include "../env/agent/ral_agent_o.sv"

`include "../env/ral_refmod.sv"
`include "../env/scoreboard/ral_cover.sv"
`include "../env/scoreboard/ral_scoreboard.sv"
`include "../env/ral_env.sv"

`include "../env/reg_uvm/ral_test_2.sv"
`include "../env/ral_test.sv" //SE LIGUE SA SEQUÊNCIA QUE SÃO COLOCADOS !!!!!!!!! 
								  //SE ALGUEM CHAMA ALGO, ESSE ALGO DEVE ESTAR ACIMA DESSE ALGUEM !!!!!!

endpackage : ral_pkg