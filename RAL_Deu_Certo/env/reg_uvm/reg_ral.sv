class reg_ral extends  uvm_reg ; // Define-se os campos de uma única pastilha de registrador !!!!
	`uvm_object_utils( reg_ral )

	rand uvm_reg_field unique_field;
	
	function new( string name = "reg_ral" );
      super.new( .name( name ), .n_bits( 8 ), .has_coverage( UVM_NO_COVERAGE ) ); //Define-se o número de bits da pastilha !!!
   	endfunction: new

   	virtual function void build();
		
		unique_field  = uvm_reg_field::type_id::create( "unique_field" );
			unique_field.configure( 	.parent                 ( this ), 
										.size                   ( 8    ), 
										.lsb_pos                ( 1    ), // LSB ? 1-sim, 0-não
										.access                 ( "RW" ), // pode ser RO(Read Only), WO( Write Only) e RW
										.volatile               ( 0    ),
										.reset                  ( 0    ), // Se houver reset, qual o valor dele para ocorrer ?
										.has_reset              ( 1    ), // Tem reset ? 1-sim, 0-não
										.is_rand                ( 1    ), 
										.individually_accessible( 1    ) );
   endfunction: build

endclass : reg_ral

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