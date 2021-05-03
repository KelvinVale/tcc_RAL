//import uvm_pkg::*;//NUNCA MUDE
//`include "uvm_macros.svh"//NUNCA MUDE e nessa ordem !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//import ral_pkg::*;

module ral_top;
	import uvm_pkg::*;
	import ral_pkg::*;
	parameter freq_clk = 50000000;
	parameter baud_rate = 115200;
	parameter min_trans = 100;
	
	logic clk, rst;
	ral_if dut_if (.clk(clk), .rst_n(rst));
	
	rtl_ral dut
	(
		.clk(dut_if.clk),
		.rst_n(dut_if.rst_n),
		.add_i(dut_if.add_i),
		.dt_i(dut_if.dt_i),
		.r_w_i(dut_if.r_w_i),
		.dt_o(dut_if.dt_o)
	);

  	initial begin
  		clk = 0;
  		rst = 1;
  		#10 rst = 0;
  		#10 rst = 1;
  		$display("dut.Banco[0] = %0d",dut.Banco[0]);
  		$display("dut.Banco[1] = %0d",dut.Banco[1]);
  		$display("dut.Banco[2] = %0d",dut.Banco[2]);
  	end

  	always #3 clk = ~clk;

	initial begin
		`ifdef XCELIUM
			$recordvars();
		`endif
		`ifdef VCS
			$vcdpluson;
		`endif
		`ifdef QUESTA
			$wlfdumpvars();
			set_config_int("*", "recording_detail", 1);
		`endif

		uvm_config_db#(interface_vif)::set(uvm_root::get(), "*", "vif", dut_if);
		uvm_config_db#(int)::set(uvm_root::get(), "*", "min_trans", min_trans);

		run_test("ral_test_2");
	end

endmodule

