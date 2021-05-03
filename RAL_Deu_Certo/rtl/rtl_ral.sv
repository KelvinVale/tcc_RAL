module rtl_ral (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input [2:0] add_i,
	input [7:0] dt_i,
	input r_w_i, //R = 0, W = 1

	output logic [7:0] dt_o
);

logic [7:0] Banco [7:0];

always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		Banco <= '{default:'0};
		dt_o <= '0;
	end else begin
		if (r_w_i == '0) 
			begin
				dt_o <= Banco[add_i];
			end
		else
			begin 
				Banco[add_i] <= dt_i;
			end
	end
end



endmodule