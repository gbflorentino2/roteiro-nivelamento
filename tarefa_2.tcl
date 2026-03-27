proc tarefa_2 {filename} {
    set primitivas [list "AND2" "XOR2"]
    set modulos [list "flipflop_D" "contador_4bits" "somador_4bits"]

    set relatorio [dict create]

    set fileId [open $filename r]
    set linhas [split [read $fileId] "\n"]
    close $fileId

    set i 0
    set total_lines [llength $linhas]

    while {$i < $total_lines} {
        set line [lindex $linhas $i]

        if {[regexp {^\s*module\s+(\w+)} $line -> nome_modulo]} {
            dict set relatorio $nome_modulo "qtd_primitivas" 0
            dict set relatorio $nome_modulo "qtd_submodulos" 0

            while {$i < $total_lines && ![regexp {\);} $line]} {
                incr i
                set line [lindex $linhas $i]
            }

            incr i
            set line [lindex $linhas $i]

            while {$i < $total_lines && ![regexp {^\s*endmodule\M} $line]} {
                set primeira_palavra [lindex $line 0]

                if {$primeira_palavra in $primitivas} {
                    set qtd_atual [dict get $relatorio $nome_modulo "qtd_primitivas"]
                    incr qtd_atual
                    dict set relatorio $nome_modulo "qtd_primitivas" $qtd_atual
                } elseif {$primeira_palavra in $modulos} {
                    set qtd_atual [dict get $relatorio $nome_modulo "qtd_submodulos"]
                    incr qtd_atual
                    dict set relatorio $nome_modulo "qtd_submodulos" $qtd_atual
                }

                incr i
                set line [lindex $linhas $i]
            }
        }
        incr i
    }

    return $relatorio
}
