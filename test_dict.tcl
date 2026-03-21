#
# Create a dictionary:
# Two clients, known by their client number,
# with forenames, surname
#
dict set clients 1 forenames Joe
dict set clients 1 surname   Schmoe
dict set clients 2 forenames Anne
dict set clients 2 surname   Other

#
# Print a table
#
puts "Number of clients: [dict size $clients]"
dict for {id info} $clients {
    puts "Client $id:"
    dict with info {
       puts "   Name: $forenames $surname"
    }
}

