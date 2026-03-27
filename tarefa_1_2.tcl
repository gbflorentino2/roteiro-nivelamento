proc calc_instances {db} {
    set totals [dict create]

    dict for {module instances} $db {
	dict for {instance num} $instances {
	    if {![dict exists $totals $instance]} {
		dict set totals $instance 0
	    }
	    
	    set sum_before [dict get $totals $instance]
	    set sum_after [expr {$sum_before + $num}]
	    
	    dict set totals $instance $sum_after
	}
	
    }
    
    return $totals 
}

proc read_cells_from_filename {filename} {
    # File to read 
    set infile [open $filename r]

    set last_module ""
    set db_module [dict create]

    while { [gets $infile line] >= 0 } {
	# Regex Patterns
	set result_modules [regexp {module (\w+)} $line match module]
	set result_instances [regexp {(\w+) \w+ \(\.} $line match instance]

	if {$result_modules > 0} {
	    if { ![dict exists $db_module $module] } {
		set last_module $module
		dict set db_module $last_module [dict create]
	    }
	}
	
	if {$result_instances > 0} {
	    if { ![dict exists $db_module $last_module $instance] } {
		dict set db_module $last_module $instance 1
		
	    } else {
		set num_instance_before [dict get $db_module $last_module $instance]
		set num_instance_after [expr {$num_instance_before + 1}]
		
		dict set db_module $last_module $instance $num_instance_after
	    }
	}
    }    
    close $infile

    return $db_module
}

