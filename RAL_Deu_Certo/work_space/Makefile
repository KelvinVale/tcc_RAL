IFS = ../env/ral_if.sv

PKGS = ../env/ral_pkg.sv

RTL = ../rtl/rtl_ral.sv 

MIN_TRANSA = 100

RUN_ARGS_COMMON = -access +r -input ./shm.tcl \
		  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite -access rw


teste_2: clean
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) ../env/ral_top.sv \
		+UVM_TESTNAME=ral_test_2 -covtest ral_test_2 $(RUN_ARGS_COMMON) \
		-defparam ral_top.min_trans=$(MIN_TRANSA)
# 	@g++ -g -fPIC -Wall -std=c++0x refmod_c.cpp -shared -o test.so

teste_1: clean
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) ../env/ral_top.sv \
		+UVM_TESTNAME=ral_test -covtest ral_test $(RUN_ARGS_COMMON) \
		-defparam ral_top.min_trans=$(MIN_TRANSA)
# 	@g++ -g -fPIC -Wall -std=c++0x refmod_c.cpp -shared -o test.so


clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ xcelium.d simv.daidir *.so *.o *.err

waves:
	simvision waves.shm &

kelvin:
	xrun teste_functions.sv