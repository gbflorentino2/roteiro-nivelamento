proc read_nets_from_file {filename} {
    set infile [open $filename r]
    
    set nets [dict create]
    set inputs [list]

    # First pass - inputs and outputs extraction
    while { [gets $infile line] >= 0 } {
        # Regex Patterns
        set instance_inputs [regexp -all -inline {\.\w+\((\w+)[\'\w\[\]\d]*\)\,} $line]
        set instance_outputs [regexp {\.\w+\((\w+)[\'\w\[\]\d]*\)\)\;} $line match output_net]

        set module_ports [regexp {(?:\w+put|wire) [\[\d\:\d\]\s]*(?!reg)(\w+)} $line match mod_wire]
        set module_assigments [regexp {(?:<=|=) (\w+)\;} $line match signal]

        # Detect input and output wires in module definition
        if {$module_ports > 0} {
            if { ![dict exists $nets $mod_wire] } {
                dict set nets $mod_wire 0
            }
        }

        # Detect inputs and outputs from instances
        if {$instance_outputs > 0} {
            if { ![dict exists $nets $output_net] } {
                dict set nets $output_net 0
            } else {
                set count [dict get $nets $output_net]
                dict set nets $output_net [expr {$count + 1}]
            }

            foreach {match input_net} $instance_inputs {
                lappend inputs $input_net
            }
        }

        # Detect modules inputs and outputs in assignments
        if {$module_assigments > 0} {
            if { [dict exists $nets $signal] } {
                set count [dict get $nets $signal]
                dict set nets $signal [expr {$count + 1}]
            }
        }
    }
    close $infile

    # Second pass - relation of input and outputs
    foreach {input} $inputs {
        if { [dict exists $nets $input] } {
            set count [dict get $nets $input]
            dict set nets $input [expr {$count + 1}]
        }
    }
   
    return $nets
}


