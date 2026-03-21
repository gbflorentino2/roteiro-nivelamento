set sample "flipflop_D U17 (.a(count0), .b(1'b1), .y(next_count0));\nAND2 U18 (.a(count0), .b(1'b1), .y(w_carry1));"

set result [regexp {([A-Za-z0-9\_]+) ([A-Za-z]+)\w+ \(.} $sample match sub1]

puts "Result: $result Match: $match 1: $sub1"
