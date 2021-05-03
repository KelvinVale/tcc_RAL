import "DPI-C" context function int uvm_hdl_check_path (string path);

class block_reg_ral extends  uvm_reg_block ; // Define-se os campos de uma única pastilha de registrador !!!!
	`uvm_object_utils( block_reg_ral )

	rand reg_banco 	reg_banco_field[6:0];
	rand reg_leitura 	reg_leitura_field;
	string s;
	// uvm_reg_map		reg_map;
	
 
	function new( string name = "block_reg_ral" );
      super.new( .name( name ), .has_coverage( UVM_NO_COVERAGE ) ); //Define-se o número de bits da pastilha !!!
   	endfunction

   	virtual function void build();
   		add_hdl_path	(.path("ral_top.dut"), .kind("RTL"));

		default_map = create_map( .name( "default_map" ), .base_addr( 0 ), 
		                    .n_bytes( 1 ), .endian( UVM_LITTLE_ENDIAN ));

		for (int i = 0; i < 7; i++) begin
			s = $sformatf("reg_banco_field[%0d]", i);
			reg_banco_field[i] = reg_banco::type_id::create(s);

			s = $sformatf("Banco[%0d]", i);
			reg_banco_field[i].configure( .blk_parent( this ), .hdl_path( s ) );
			reg_banco_field[i].build();
			default_map.add_reg( .rg( reg_banco_field[i] ), .offset( i + 1 ), .rights( "RW" ) );
		end
		
		reg_leitura_field = reg_leitura::type_id::create("reg_leitura_field");
		reg_leitura_field.configure( .blk_parent( this ), .hdl_path( "reg_leitura" ) );
		reg_leitura_field.build();
		default_map.add_reg( .rg( reg_leitura_field ), .offset( 0 ), .rights( "RO" ) );

		lock_model(); // finalize the address mapping
	endfunction: build

endclass : block_reg_ral

