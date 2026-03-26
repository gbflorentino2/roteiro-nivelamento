set and2 0
set xor2 0
set flipflop_D 0


set fileId [open "netlist.v" r]

while {[gets $fileId line] >= 0} {
    
    if {[regexp "AND2" $line]} {
        incr and2
    } elseif {[regexp "XOR2" $line]} {
        incr xor2
    } elseif {[regexp "flipflop_D" $line] && ![regexp {module\s+flipflop_D} $line]} {
        incr flipflop_D
    }
}

close $fileId

puts "=== RELATÓRIO DE CÉLULAS ===\n
AND2: $and2 instâncias\n
XOR2: $xor2 instâncias\n
flipflop_D: $flipflop_D instâncias\n
TOTAL: [expr {$and2 + $xor2 + $flipflop_D}] instâncias
"

