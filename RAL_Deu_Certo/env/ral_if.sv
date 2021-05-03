interface ral_if (input clk, rst_n);
	logic [2:0] add_i;
	logic [7:0] dt_i;
	logic r_w_i;
	logic [7:0] dt_o;

	modport DUT (
		input clk, rst_n,
		input	 add_i,
		input	 dt_i,
		input	 r_w_i,
		output	 dt_o);

	modport VERIF (
		input clk, rst_n,
		output	 add_i,
		output	 dt_i,
		output	 r_w_i,
		input	 dt_o);
endinterface : ral_if
