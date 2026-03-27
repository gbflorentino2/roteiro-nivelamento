source tarefa_1_2.tcl

# Relatório
set db_module [read_cells_from_filename "netlist.v"]
set totals [calc_instances $db_module]

puts "=== Relatório de Células ==="

set total 0
dict for {instance num} $totals {
    if ($num) {
	set total [expr {$total + $num}]
    }
    puts "$instance: $num instâncias"
}
puts "Total: $total instâncias"

############################################################

puts "\n=== Hierárquia do Design === "

set primitives {AND OR NOT XOR XNOR NAND NOR}

dict for {module instances} $db_module {
    set has_primitive 0
    
    puts $module

    if { [dict size $instances] > 0} {
	dict for {instance num} $instances {
	    set result [regexp {([A-Z]+)} $instance match]
	    
	    if {$match in $primitives} {
		set has_primitive 1
	    } else {
		puts "  |---- $instance ($num instâncias)"
	    }
	}
	
    } else {
	puts "  |---- (Módulo primitivo - sem submódulos)"
    }

    if {$has_primitive == 1} {
	puts "  |---- (Células primitivas)"
    }

    puts ""
}

############################################################

