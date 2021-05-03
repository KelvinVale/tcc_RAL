import "DPI-C" context function int uvm_hdl_check_path (string path);

class block_reg_ral extends  uvm_reg_block ; // Define-se os campos de uma única pastilha de registrador !!!!
	`uvm_object_utils( block_reg_ral )

	rand reg_ral 	reg_field[7:0];
	string s;
	// uvm_reg_map		reg_map;
	

	function new( string name = "block_reg_ral" );
      super.new( .name( name ), .has_coverage( UVM_NO_COVERAGE ) ); //Define-se o número de bits da pastilha !!!
   	endfunction

   	virtual function void build();
   		// add_hdl_path	(.path("ral_top.dut.Banco"), .kind("RTL"));     //Nesse formato, o reg ficou com o endereço dobrado. Por isso irei fazer como abaixo, apenas colocando o "ral_top.dut"
   		add_hdl_path	(.path("ral_top.dut"), .kind("RTL"));

		default_map = create_map( .name( "default_map" ), .base_addr( 0 ), 
		                    .n_bytes( 1 ), .endian( UVM_LITTLE_ENDIAN ));

		for (int i = 0; i < 8; i++) begin
			s = $sformatf("reg_field[%0d]", i);
			reg_field[i] = reg_ral::type_id::create(s);

			// s = $sformatf("ral_top.dut.Banco");
			// s = $sformatf("ral_top.dut.Banco"); // Aqui tirei também, irei colocar só banco
			s = $sformatf("Banco[%0d]", i);

			if (uvm_hdl_check_path(s)) begin
		      `uvm_info("TEST", "existe o hdl path no uvm_reg_block", UVM_MEDIUM)
		    end
		    else begin 
		      `uvm_info("TEST", "NAO existe o hdl path", UVM_MEDIUM)
		    end
			$display(s);
			// s = $sformatf("rtl_ral.Banco[%0d]", i);
			reg_field[i].configure( .blk_parent( this ), .hdl_path( s ) );
			reg_field[i].build();
			default_map.add_reg( .rg( reg_field[i] ), .offset( i ), .rights( "RW" ) );
		end

		lock_model(); // finalize the address mapping
	endfunction: build

endclass : block_reg_ral




/* O código abaixo está incorreto !!!!!!!!! Pois estou definindo campos de uma "pastilha" de reg, não um banco de registradores.

class reg_ral extends  uvm_reg ;
	`uvm_object_utils( reg_ral )

	rand uvm_reg_field reg_config;
	rand uvm_reg_field reg_dado1;
	rand uvm_reg_field reg_dado2;
	rand uvm_reg_field reg_dado3;
	rand uvm_reg_field reg_outro_nome1;
	rand uvm_reg_field reg_outro_nome2;
	rand uvm_reg_field reg_outro_nome3;
	rand uvm_reg_field reg_outro_nome4;
	
	function new( string name = "reg_ral" );
      super.new( .name( name ), .n_bits( 8 ), .has_coverage( UVM_NO_COVERAGE ) );
   	endfunction: new

   	virtual function void build();
		
		reg_config  = uvm_reg_field::type_id::create( "reg_config" );
			reg_config.configure( 		.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_dado1  = uvm_reg_field::type_id::create( "reg_dado1" );
			reg_dado1.configure( 		.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_dado2  = uvm_reg_field::type_id::create( "reg_dado2" );
			reg_dado2.configure( 		.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_dado3  = uvm_reg_field::type_id::create( "reg_dado3" );
			reg_dado3.configure( 		.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_outro_nome1  = uvm_reg_field::type_id::create( "reg_outro_nome1" );
			reg_outro_nome1.configure( 	.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_outro_nome2  = uvm_reg_field::type_id::create( "reg_outro_nome2" );
			reg_outro_nome2.configure( 	.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_outro_nome3  = uvm_reg_field::type_id::create( "reg_outro_nome3" );
			reg_outro_nome3.configure( 	.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
		
		reg_outro_nome4  = uvm_reg_field::type_id::create( "reg_outro_nome4" );
			reg_outro_nome4.configure( 	.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), 
										.access                 ( "RW" ), 
										.volatile               ( 0    ),
										.reset                  ( 0    ), 
										.has_reset              ( 1    ), 
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );

   endfunction: build

endclass : reg_ral
*/