.PHONY: all build test

# This is the default target, which will build and test
all: build test

# This target will build the .v files
build: 
	mkdir -p bin
	for tb in $(shell find tb/ -name '*.v'); do \
		tb_base=`basename $$tb .v`; \
		v_files=`find verilog/ -name '*.v'`; \
		i_args=`find verilog/ -type d -exec echo -n "-I {} " \;`; \
		iverilog -g2005 -o "bin/$$tb_base" $$i_args $$tb $$v_files; \
	done

# This target will test the built files
test: 
	mkdir -p vcd
	for tb in bin/*; do \
		if vvp $$tb | tee /dev/fd/2 | grep -q "FAIL"; then \
			exit 1; \
		fi \
	done

# This target will create the artifacts
artifacts: 
	cp vcd/* ./artifacts
