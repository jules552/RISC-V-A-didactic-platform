.PHONY: all clean build test artifacts

all: clean build test

clean:
	@rm -rf bin/
	@rm -rf vcd/

build: 
	@mkdir -p bin
	@for tb in $(shell find tb/ -name '*.v'); do \
		tb_base=`basename $$tb .v`; \
		v_files=`find verilog/ -name '*.v'`; \
		i_args=`find verilog/ -type d -exec echo -n "-I {} " \;`; \
		iverilog -g2005 -o "bin/$$tb_base" $$i_args $$tb $$v_files; \
	done

test: 
	@mkdir -p vcd
	@for tb in bin/*; do \
		if vvp $$tb | grep -v "WARNING\\|VCD\\|\$$finish called at" | tee /dev/fd/2 | grep -q "FAIL"; then \
			exit 1; \
		fi \
	done


