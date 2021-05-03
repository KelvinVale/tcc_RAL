module ral_top;

	int x;
	string s;

  	initial begin
  		x = 10;
  		s = $sformatf("\n\nTestando\n\nteste[%3d]\n\nDeu bom\n\n", x);
  		$display("\n\n\n\noioi\n\n\n\n");
  		$display(s);
	end


endmodule

