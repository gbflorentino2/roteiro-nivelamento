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
