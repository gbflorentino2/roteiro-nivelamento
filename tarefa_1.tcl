proc tarefa_1 {filename} {
    set and2 0
    set xor2 0
    set flipflop_D 0

    set fileId [open $filename r]

    while {[gets $fileId line] >= 0} {
        if {[regexp "AND2" $line]} {
            incr and2
        } elseif {[regexp "XOR2" $line]} {
            incr xor2
        } elseif {[regexp "flipflop_D" $line] && ![regexp "module\\s+flipflop_D" $line]} {
            incr flipflop_D
        }
    }

    close $fileId

    return [dict create \
        AND2 $and2 \
        XOR2 $xor2 \
        flipflop_D $flipflop_D \
        TOTAL [expr {$and2 + $xor2 + $flipflop_D}] \
    ]
}
