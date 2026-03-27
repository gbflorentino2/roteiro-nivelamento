source tarefa_1.tcl
source tarefa_2.tcl
source estatisticas_conexoes.tcl

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
    set has_submodules 0
    
    puts $module

    if { [dict size $instances] > 0} {
        dict for {instance num} $instances {
            set result [regexp {([A-Z]+)} $instance match]
            
            if {$match in $primitives} {
                set has_primitive 1
            } else {
                set has_submodules 1
                puts "  |---- $instance ($num instâncias)"
            }
        }
        
    } else {
        puts "  |---- (Módulo primitivo - sem submódulos)"
    }

    if {$has_primitive} {
        if {$has_submodules} {
            puts "  |---- (Células primitivas)"
        } else {
            puts "  |---- (Somente células primitivas)"    
        }
    }

    puts ""
}

# ############################################################

set nets [read_nets_from_file "netlist.v"]

set ordered_nets [lsort -stride 2 -index 1 -integer -decreasing $nets]

puts "=== Top 10 Nets por FANOUT ==="

foreach {net num} [lrange $ordered_nets 0 19] {
    puts "$net: fanout = $num"
}

puts "\n=== Nets com FANOUT Zero (Possíveis Erros) ==="

dict for {net num} $ordered_nets {
    if {$num == 0} {
        puts $net
    }
}
