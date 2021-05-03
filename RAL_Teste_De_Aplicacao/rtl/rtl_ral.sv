module rtl_ral (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input [2:0] add_i,
	input [7:0] dt_i,
	input r_w_i, //R = 0, W = 1

	output logic [7:0] dt_o
);

logic [7:0] Banco [6:0];   //Endereço de 01 à ff
logic [7:0]reg_leitura;  //Endereço 00. PROIBIDA A ESCRITA!!!!!

logic [7:0] data;
logic [7:0] add;

logic [2:0] escrita_cont;


always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) 
		begin
			Banco <= '{default:'0};
			reg_leitura <= '0;
			dt_o <= '0;
			data <= '0;
			add <= '0;
			escrita_cont <= 3'd4;
		end 
	else 
		begin

			if (escrita_cont == 3'd4) begin
				if (r_w_i == '0) 
					begin
						if (add_i == '0) 
							begin
								dt_o <= reg_leitura;
								reg_leitura <= $urandom_range(0,200);
							end
						else 
							begin
								dt_o <= Banco[add_i - 1'b1];
							end
					end
				else
					begin
						if (add_i != '0) 
							begin
								escrita_cont <= '0;
								add <= add_i - 1'b1;
								data <= dt_i;
							end
					end
			end

			else
				begin
					escrita_cont <= escrita_cont + 1'b1;
					if (escrita_cont == 3'd3) begin
						Banco[add] <= data;
					end
				end

		end
end
endmodule

