# Deciding on data structure for GameHistory

=begin
# Option 1
history[series_2][@human][2]

history = 
{:series_1=>{@human=>['rock', 'spock', 'lizard', 'rock', 'scissors'],
             @computer=>['paper', 'spock', 'paper', 'scissors', 'lizard']},
 :series_2=>{@human=>['rock', 'spock', 'lizard', 'rock', 'scissors'],
             @computer=>['paper', 'spock', 'paper', 'scissors', 'lizard']}}
=end

=begin
# Option 2
# history[series_2][round_3][@human] # Better access logic

p history =
{:series_1=>{1=>{@human=>'rock', @computer=>'paper'},
             2=>{@human=>'spock', @computer=>'spock'},
             3=>{@human=>'lizard', @computer=>'paper'},
             4=>{@human=>'rock', @computer=>'scissors'},},
 :series_2=>{1=>{@human=>'rock', @computer=>'paper'},
             2=>{@human=>'spock', @computer=>'spock'},
             3=>{@human=>'lizard', @computer=>'paper'},
             4=>{@human=>'rock', @computer=>'scissors'}}}
=end

hsh = {}
hsh[1]={}
hsh[1][1]={'Bob'=>'rock', 'Number 5'=>'scissors'}
hsh[1][2]={'Bob'=>'rock', 'Number 5'=>'rock'}
p hsh
