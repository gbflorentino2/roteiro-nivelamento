source tarefa_1.tcl
source tarefa_2.tcl

# Relatório
set filename "netlist.v"
set totals_full [tarefa_1 $filename]
set totals [dict remove $totals_full TOTAL]
set db_module_raw [tarefa_2 $filename]

set db_module [dict create]
dict for {module counts} $db_module_raw {
    set instances [dict create]
    set qtd_primitivas [dict get $counts "qtd_primitivas"]
    set qtd_submodulos [dict get $counts "qtd_submodulos"]

    if {$qtd_primitivas > 0} {
        dict set instances AND $qtd_primitivas
    }
    if {$qtd_submodulos > 0} {
        dict set instances SUBMODULO $qtd_submodulos
    }

    dict set db_module $module $instances
}

puts "=== Relatório de Células ==="

set total 0
dict for {instance num} $totals {
    set total [expr {$total + $num}]
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
