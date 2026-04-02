.PHONY: relatorio

relatorio:
	if [ ! -f ./relatorio.txt ]; then \
		tclsh relatorio.tcl > relatorio.txt; \
	fi

organizar-pastas:
	source ./shell_test/organizador.sh

clean:
	if [ -f ./relatorio.txt ]; then \
		rm relatorio.txt; \
	fi